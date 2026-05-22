<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Professional extends Model
{
    protected $table = 'professionals';

    public function leiturasDosimetricas()
    {
        return $this->hasMany(LeituraDosimetrica::class, 'professional_id');
    }

    public function acumuladoAno(int $ano): float
    {
        return (float) $this->leiturasDosimetricas()
            ->whereYear('mes_referencia', $ano)
            ->sum('valor_msv');
    }
}
