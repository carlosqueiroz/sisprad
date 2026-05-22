<?php

namespace Database\Seeders;

use App\LeituraDosimetrica;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

/**
 * Dataset sintético para demonstração do módulo MEDt.
 * 18 profissionais × 16 meses de leitura (jan/2025 — abr/2026)
 * cobrindo 10 perfis distintos de exposição ocupacional.
 *
 * Execução: php artisan db:seed --class=MedtDemoDataSeeder
 *
 * AVISO: este seeder REMOVE leituras e profissionais (preserva id=1).
 * Use apenas em ambiente de demonstração / dev / staging.
 */
class MedtDemoDataSeeder extends Seeder
{
    public function run(): void
    {
        mt_srand(20260522);

        $this->command->info('Limpando leituras e profissionais (preserva id=1)…');
        DB::table('leituras_dosimetricas')->delete();
        DB::table('professionals')->where('id', '>', 1)->delete();

        $setores = $this->criarSetores();
        $profs   = $this->criarProfissionais($setores);
        $total   = $this->gerarLeituras($profs);

        $this->command->info("Gerou {$total} leituras de " . count($profs) . " profissionais.");

        $dist = DB::table('leituras_dosimetricas')
            ->select('faixa', DB::raw('COUNT(*) as n'))
            ->groupBy('faixa')->get();
        foreach ($dist as $r) {
            $this->command->info("  faixa {$r->faixa}: {$r->n}");
        }
    }

    private function criarSetores(): array
    {
        $defs = [
            'Radiodiagnóstico — Bloco A' => ['Edifício Anexo, 2º andar', 'Sapra Landauer', '32', 'CNEN-25-XYZ-2024', '2027-12-31'],
            'Hemodinâmica e Intervencionismo' => ['Bloco Cirúrgico, 4º andar', 'Sapra Landauer', '18', 'CNEN-25-HEM-2024', '2027-06-30'],
            'Medicina Nuclear e Radioterapia' => ['Centro Oncológico', 'Pro-Rad', '24', 'CNEN-25-MNR-2024', '2028-03-15'],
        ];

        $out = [];
        foreach ($defs as $tipo => [$local, $fornecedor, $qtd, $alvara, $venc]) {
            DB::table('sectors')->where('service_type', $tipo)->delete();
            $out[$tipo] = DB::table('sectors')->insertGetId([
                'service_type'           => $tipo,
                'location_name'          => $local,
                'fornecedor_dosimetro'   => $fornecedor,
                'numero_total_dosimetros'=> $qtd,
                'numero_alvara'          => $alvara,
                'vencimento_alvara'      => $venc,
                'created_at' => now(), 'updated_at' => now(),
            ]);
        }
        return $out;
    }

    private function criarProfissionais(array $setores): array
    {
        $now = now();
        $defs = [
            // [setor, cpf, nome, sexo, nasc, função, vínculo, carga, conselho, registro, perfil, descrição]
            [$setores['Radiodiagnóstico — Bloco A'], '111.222.333-44', 'Dra. Ana Carolina Silva', 'Feminino', '1985-03-12', 'Médica Radiologista — TC', 'CLT', '40 horas semanais', 'CRM', '12345-SC', 'baixo', 'Atua em TC; exposição rotineira baixa.'],
            [$setores['Radiodiagnóstico — Bloco A'], '222.333.444-55', 'Marco Antônio Santos', 'Masculino', '1979-11-20', 'Técnico em Radiologia — RX', 'CLT', '36 horas semanais', 'CRTR', '54321-SC', 'medio', 'Plantonista 24h RX convencional.'],
            [$setores['Hemodinâmica e Intervencionismo'], '333.444.555-66', 'Patrícia Helena Oliveira', 'Feminino', '1982-07-04', 'Enfermeira de Hemodinâmica', 'CLT', '40 horas semanais', 'COREN', '987654-SC', 'alto_continuo', 'Procedimentos guiados por fluoroscopia.'],
            [$setores['Hemodinâmica e Intervencionismo'], '444.555.666-77', 'Dr. Roberto Carlos Lima', 'Masculino', '1972-01-29', 'Médico Hemodinamicista', 'CLT', '40 horas semanais', 'CRM', '67890-SC', 'alto_continuo', 'Procedimentos vasculares complexos.'],
            [$setores['Medicina Nuclear e Radioterapia'], '555.666.777-88', 'Fernanda Souza', 'Feminino', '1990-09-15', 'Biomédica — Medicina Nuclear', 'CLT', '30 horas semanais', 'CRBM', '13579-SC', 'incidente', 'Incidente com extravasamento de F-18 em mar/2026.'],
            [$setores['Medicina Nuclear e Radioterapia'], '666.777.888-99', 'Dr. José Henrique Ferreira', 'Masculino', '1968-06-08', 'Médico Nuclear', 'CLT', '40 horas semanais', 'CRM', '23456-SC', 'medio', 'Coordena estudos com I-131 e Tc-99m.'],
            [$setores['Medicina Nuclear e Radioterapia'], '777.888.999-00', 'Dra. Larissa Mendes Costa', 'Feminino', '1987-04-23', 'Médica Radio-oncologista', 'CLT', '40 horas semanais', 'CRM', '34567-SC', 'medio_baixo', 'Planejamento de teleterapia e braquiterapia HDR.'],
            [$setores['Radiodiagnóstico — Bloco A'], '888.999.000-11', 'João Pedro Almeida', 'Masculino', '1995-02-17', 'Técnico em TC', 'CLT', '36 horas semanais', 'CRTR', '11122-SC', 'baixo', 'Operação de TC multislice.'],
            [$setores['Radiodiagnóstico — Bloco A'], '999.000.111-22', 'Camila Rodrigues Pinto', 'Feminino', '1992-12-05', 'Recepcionista de Área Controlada', 'CLT', '40 horas semanais', '—', '—', 'muito_baixo', 'Atendimento e triagem; exposição residual.'],
            [$setores['Hemodinâmica e Intervencionismo'], '101.202.303-44', 'Téc. Marcelo dos Santos', 'Masculino', '1981-10-30', 'Técnico em Hemodinâmica', 'CLT', '36 horas semanais', 'CRTR', '22233-SC', 'alto_pico', 'Plantão noturno; pico de exposição em mar/2026.'],
            [$setores['Hemodinâmica e Intervencionismo'], '202.303.404-55', 'Dr. Felipe Castro Andrade', 'Masculino', '1976-08-14', 'Anestesiologista (Hemodinâmica)', 'CLT', '40 horas semanais', 'CRM', '45678-SC', 'medio', 'Anestesia em procedimentos prolongados.'],
            [$setores['Medicina Nuclear e Radioterapia'], '303.404.505-66', 'Téc. Vanessa Aparecida', 'Feminino', '1989-05-19', 'Técnica em Medicina Nuclear', 'CLT', '30 horas semanais', 'CRTR', '33344-SC', 'alto_continuo', 'Manipulação de radiofármacos.'],
            [$setores['Medicina Nuclear e Radioterapia'], '404.505.606-77', 'Eng. Bruno Tavares', 'Masculino', '1984-09-09', 'Físico Médico', 'CLT', '40 horas semanais', 'CRF', '55566-SC', 'baixo', 'Comissionamento e QA.'],
            [$setores['Radiodiagnóstico — Bloco A'], '505.606.707-88', 'Dra. Isabela Marques', 'Feminino', '1991-03-27', 'Residente de Radiologia (R2)', 'Residência', '60 horas semanais', 'CRM', '66677-SC', 'novato', 'Iniciou em dezembro/2025.'],
            [$setores['Radiodiagnóstico — Bloco A'], '606.707.808-99', 'Téc. Eduardo Nogueira', 'Masculino', '1970-07-11', 'Técnico em Radiologia (sênior)', 'CLT', '36 horas semanais', 'CRTR', '77788-SC', 'afastado_meio', 'Licença saúde desde jun/2025.'],
            [$setores['Hemodinâmica e Intervencionismo'], '707.808.909-00', 'Enf. Tatiane Lopes', 'Feminino', '1986-11-02', 'Enfermeira de Hemodinâmica (plantonista)', 'CLT', '36 horas semanais', 'COREN', '88899-SC', 'ferias_meio_ano', 'Férias em jul/2025 e dez/2025.'],
            [$setores['Medicina Nuclear e Radioterapia'], '808.909.010-11', 'Dr. Ricardo Furlan', 'Masculino', '1965-02-28', 'Médico Radio-oncologista (chefe)', 'CLT', '40 horas semanais', 'CRM', '99900-SC', 'medio_baixo', 'Coordenador do serviço.'],
            [$setores['Radiodiagnóstico — Bloco A'], '909.010.111-22', 'Auxiliar de Transporte — MN', 'Masculino', '1993-06-21', 'Auxiliar de Transporte de Pacientes Injetados', 'CLT', '40 horas semanais', '—', '—', 'medio_baixo', 'Acompanha pacientes injetados de MN.'],
        ];

        $out = [];
        foreach ($defs as $d) {
            [$setorId, $cpf, $nome, $sexo, $nasc, $funcao, $vinc, $carga, $cons, $reg, $perfil, $desc] = $d;
            $id = DB::table('professionals')->insertGetId([
                'person_cpf'                          => $cpf,
                'person_name'                         => $nome,
                'person_gender'                       => $sexo,
                'person_birthdate'                    => $nasc,
                'service_person_link_role'            => $funcao,
                'service_person_link_description'     => $desc,
                'service_person_link_work_start_date' => '2020-01-01',
                'service_person_link_employment_bond' => $vinc,
                'service_person_link_workload'        => $carga,
                'person_doc_name'                     => $cons,
                'person_doc_number'                   => $reg,
                'created_at' => $now, 'updated_at' => $now,
            ]);
            $out[$id] = $perfil;
        }
        return $out;
    }

    private function gerarLeituras(array $profs): int
    {
        $inicio = Carbon::create(2025, 1, 1);
        $total  = 0;

        foreach ($profs as $profId => $perfil) {
            foreach (range(0, 15) as $mesIdx) {
                $valor = $this->valorPerfil($perfil, $mesIdx);
                if ($valor === null) continue;

                $obs = null;
                if ($perfil === 'incidente' && $mesIdx === 14) {
                    $obs = 'INCIDENTE: extravasamento de F-18 durante manipulação em 14/03/2026. Trabalhador afastado em 15/03.';
                } elseif ($perfil === 'afastado_meio' && $mesIdx === 6) {
                    $obs = 'Início de licença saúde em 01/07/2025 — sem exposição ocupacional.';
                } elseif ($perfil === 'novato' && $mesIdx === 11) {
                    $obs = 'Primeira leitura — admissão em dezembro/2025.';
                }

                LeituraDosimetrica::create([
                    'professional_id' => $profId,
                    'mes_referencia'  => $inicio->copy()->addMonths($mesIdx)->toDateString(),
                    'valor_msv'       => $valor,
                    'tipo'            => 'tórax',
                    'observacoes'     => $obs,
                ]);
                $total++;
            }
        }
        return $total;
    }

    private function valorPerfil(string $perfil, int $mesIdx): ?float
    {
        switch ($perfil) {
            case 'muito_baixo':     return $this->noise(0.10, 0.08);
            case 'baixo':           return $this->noise(0.55, 0.18);
            case 'medio_baixo':     return $this->noise(1.05, 0.22);
            case 'medio':           return $this->noise(2.40, 0.55);
            case 'alto_continuo':   return $this->noise(7.50, 1.80);
            case 'alto_pico':       return $mesIdx === 14 ? $this->noise(18.0, 2.0) : $this->noise(4.50, 1.20);
            case 'incidente':
                if ($mesIdx < 14)  return $this->noise(0.80, 0.30);
                if ($mesIdx === 14) return $this->noise(34.0, 3.0);
                return 0.000;
            case 'novato':          return $mesIdx < 11 ? null : $this->noise(1.20, 0.35);
            case 'afastado_meio':   return $mesIdx < 6  ? $this->noise(2.80, 0.60) : 0.000;
            case 'ferias_meio_ano': return in_array($mesIdx, [6, 11], true) ? 0.000 : $this->noise(1.40, 0.40);
            default:                return $this->noise(1.0, 0.3);
        }
    }

    private function noise(float $base, float $sigma): float
    {
        $u1 = max(mt_rand() / mt_getrandmax(), 1e-9);
        $u2 = mt_rand() / mt_getrandmax();
        $g  = sqrt(-2 * log($u1)) * cos(2 * M_PI * $u2);
        return round(max(0, $base + $sigma * $g), 3);
    }
}
