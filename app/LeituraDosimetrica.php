<?php

namespace App;

use App\Mail\LeituraImediataAlerta;
use App\Services\CondutaMedtService;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class LeituraDosimetrica extends Model
{
    use SoftDeletes;

    protected $table = 'leituras_dosimetricas';

    protected $fillable = [
        'professional_id',
        'mes_referencia',
        'valor_msv',
        'tipo',
        'observacoes',
        'faixa',
        'conduta',
        'prazo',
    ];

    protected $dates = ['mes_referencia', 'deleted_at'];

    public function professional()
    {
        return $this->belongsTo(Professional::class, 'professional_id');
    }

    protected static function boot()
    {
        parent::boot();

        static::saving(function (self $leitura) {
            $leitura->aplicarClassificacao();
        });

        static::saved(function (self $leitura) {
            if ($leitura->prazo === 'Imediato') {
                $leitura->dispararAlertaImediato();
            }
        });
    }

    public function dispararAlertaImediato(): void
    {
        $recipients = collect(explode(',', (string) env('MEDT_ALERT_RECIPIENTS', '')))
            ->map(fn ($e) => trim($e))
            ->filter()
            ->values()
            ->all();

        if (empty($recipients)) {
            return;
        }

        try {
            Mail::to($recipients)->send(new LeituraImediataAlerta($this->loadMissing('professional')));
        } catch (\Throwable $e) {
            Log::warning('[MEDt] Falha ao enviar alerta de leitura imediata: ' . $e->getMessage(), [
                'leitura_id' => $this->id,
                'faixa'      => $this->faixa,
            ]);
        }
    }

    public function aplicarClassificacao(): void
    {
        $valorMes = (float) $this->valor_msv;
        $mes      = $this->mes_referencia instanceof \Carbon\Carbon
            ? $this->mes_referencia
            : \Carbon\Carbon::parse($this->mes_referencia);

        $ano = $mes->year;

        $query = static::query()
            ->where('professional_id', $this->professional_id)
            ->whereYear('mes_referencia', $ano);

        if ($this->exists) {
            $query->where('id', '!=', $this->id);
        }

        $acumuladoOutros = (float) $query->sum('valor_msv');
        $acumuladoAno    = $acumuladoOutros + $valorMes;

        $resultado = app(CondutaMedtService::class)
            ->classificar($valorMes, $acumuladoAno);

        $this->faixa   = $resultado['faixa'];
        $this->conduta = $resultado['conduta'];
        $this->prazo   = $resultado['prazo'];
    }
}
