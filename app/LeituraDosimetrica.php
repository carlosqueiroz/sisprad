<?php

namespace App;

use App\Services\CondutaMedtService;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

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
