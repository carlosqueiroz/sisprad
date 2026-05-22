<?php

namespace App\Http\Controllers;

use App\LeituraDosimetrica;
use App\Professional;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class MedtController extends Controller
{
    public function __construct()
    {
        $this->middleware('admin.user');
    }

    public function dashboard(Request $request)
    {
        $mes = Carbon::now()->startOfMonth();
        $ano = (int) $request->input('ano', $mes->year);

        $contagemPorFaixa = LeituraDosimetrica::query()
            ->select('faixa', DB::raw('COUNT(*) as total'))
            ->whereYear('mes_referencia', $ano)
            ->groupBy('faixa')
            ->orderByRaw("FIELD(faixa,'acumulado_50_ano','acumulado_20_50_ano','alterado_4_20','limitrofe_1_4','normal_mensal')")
            ->get();

        $leiturasMesAtual = LeituraDosimetrica::query()
            ->where('mes_referencia', $mes->toDateString())
            ->with('professional')
            ->orderByDesc('valor_msv')
            ->get();

        $topAcumulado = Professional::query()
            ->select(
                'professionals.id',
                'professionals.person_name',
                'professionals.service_person_link_role',
                DB::raw('COALESCE(SUM(l.valor_msv), 0) as total')
            )
            ->leftJoin('leituras_dosimetricas as l', function ($j) use ($ano) {
                $j->on('l.professional_id', '=', 'professionals.id')
                    ->whereNull('l.deleted_at')
                    ->whereYear('l.mes_referencia', $ano);
            })
            ->groupBy('professionals.id', 'professionals.person_name', 'professionals.service_person_link_role')
            ->orderByDesc('total')
            ->limit(10)
            ->get();

        $sem_leitura_mes = Professional::query()
            ->whereDoesntHave('leiturasDosimetricas', function ($q) use ($mes) {
                $q->where('mes_referencia', $mes->toDateString());
            })
            ->orderBy('person_name')
            ->get(['id', 'person_name', 'service_person_link_role']);

        $alertasImediatos = LeituraDosimetrica::query()
            ->where('prazo', 'Imediato')
            ->whereYear('mes_referencia', $ano)
            ->with('professional')
            ->orderByDesc('mes_referencia')
            ->limit(20)
            ->get();

        return view('medt.dashboard', compact(
            'ano',
            'mes',
            'contagemPorFaixa',
            'leiturasMesAtual',
            'topAcumulado',
            'sem_leitura_mes',
            'alertasImediatos'
        ));
    }

    public function importForm()
    {
        return view('medt.import');
    }

    public function importSubmit(Request $request)
    {
        $request->validate([
            'arquivo' => 'required|file|mimes:csv,txt',
        ]);

        $delimitador = $request->input('delimitador', ';');
        if ($delimitador === '\\t' || $delimitador === '\t') {
            $delimitador = "\t";
        }
        $delimitador = substr($delimitador, 0, 1) ?: ';';
        $path        = $request->file('arquivo')->getRealPath();

        $handle = fopen($path, 'r');
        if ($handle === false) {
            return back()->with('error', 'Não foi possível ler o arquivo.');
        }

        $criadas    = 0;
        $atualizadas = 0;
        $erros      = [];
        $linha      = 0;

        while (($cols = fgetcsv($handle, 0, $delimitador)) !== false) {
            $linha++;
            // pula cabeçalho
            if ($linha === 1 && stripos((string) $cols[0], 'cpf') !== false) {
                continue;
            }
            if (count($cols) < 3) {
                $erros[] = "Linha {$linha}: colunas insuficientes (esperado: cpf;mes;valor[;tipo]).";
                continue;
            }
            [$cpf, $mes, $valor] = array_map('trim', array_slice($cols, 0, 3));
            $tipo = isset($cols[3]) ? trim($cols[3]) : 'tórax';

            $prof = Professional::where('person_cpf', $cpf)->first();
            if (! $prof) {
                $erros[] = "Linha {$linha}: profissional com CPF {$cpf} não encontrado.";
                continue;
            }

            try {
                $mesData = Carbon::parse($mes)->startOfMonth();
            } catch (\Throwable $e) {
                $erros[] = "Linha {$linha}: data inválida '{$mes}'.";
                continue;
            }

            $valorFloat = (float) str_replace(',', '.', $valor);
            if ($valorFloat < 0) {
                $erros[] = "Linha {$linha}: valor negativo ({$valor}).";
                continue;
            }

            $leitura = LeituraDosimetrica::where('professional_id', $prof->id)
                ->where('mes_referencia', $mesData->toDateString())
                ->first();

            if ($leitura) {
                $leitura->update([
                    'valor_msv' => $valorFloat,
                    'tipo'      => $tipo,
                ]);
                $atualizadas++;
            } else {
                LeituraDosimetrica::create([
                    'professional_id' => $prof->id,
                    'mes_referencia'  => $mesData->toDateString(),
                    'valor_msv'       => $valorFloat,
                    'tipo'            => $tipo,
                    'observacoes'     => 'Importado via CSV em ' . now()->format('d/m/Y H:i'),
                ]);
                $criadas++;
            }
        }
        fclose($handle);

        $msg = "Import concluído: {$criadas} nova(s), {$atualizadas} atualizada(s).";
        if (! empty($erros)) {
            $msg .= ' Avisos: ' . implode(' | ', array_slice($erros, 0, 5));
            if (count($erros) > 5) {
                $msg .= ' (… +' . (count($erros) - 5) . ' linhas com erro)';
            }
        }

        return redirect()->route('voyager.leituras-dosimetricas.index')
            ->with('message', $msg)
            ->with('alert-type', empty($erros) ? 'success' : 'warning');
    }
}
