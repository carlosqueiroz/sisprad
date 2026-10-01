<?php

namespace App\Services;

class CondutaMedtService
{
    public const FAIXA_NORMAL          = 'normal_mensal';
    public const FAIXA_LIMITROFE_1_4   = 'limitrofe_1_4';
    public const FAIXA_ALTERADO_4_20   = 'alterado_4_20';
    public const FAIXA_ACUM_20_50_ANO  = 'acumulado_20_50_ano';
    public const FAIXA_ACUM_50_ANO     = 'acumulado_50_ano';

    private const SEVERIDADE = [
        self::FAIXA_NORMAL         => 0,
        self::FAIXA_LIMITROFE_1_4  => 1,
        self::FAIXA_ALTERADO_4_20  => 2,
        self::FAIXA_ACUM_20_50_ANO => 3,
        self::FAIXA_ACUM_50_ANO    => 4,
    ];

    private const REGRAS = [
        self::FAIXA_NORMAL => [
            'conduta' => 'Consulta Médica Ocupacional + Exame Periódico Complementar',
            'prazo'   => 'Semestral',
        ],
        self::FAIXA_LIMITROFE_1_4 => [
            'conduta' => 'Consulta Médica Ocupacional; afastar funcionário (se necessário); exame complementar',
            'prazo'   => 'Imediato',
        ],
        self::FAIXA_ALTERADO_4_20 => [
            'conduta' => 'Consulta Médica Ocupacional; afastar funcionário (se necessário); exame complementar',
            'prazo'   => 'Imediato',
        ],
        self::FAIXA_ACUM_20_50_ANO => [
            'conduta' => 'Consulta Médica Ocupacional; afastar funcionário (se necessário); exame complementar (acumulado anual entre 20,0 e 50,0 mSv)',
            'prazo'   => 'Imediato',
        ],
        self::FAIXA_ACUM_50_ANO => [
            'conduta' => 'Consulta Médica Ocupacional; afastar funcionário; exames complementares (acumulado anual ≥ 50,0 mSv — limite legal atingido)',
            'prazo'   => 'Imediato',
        ],
    ];

    public function classificar(float $valorMes, float $acumuladoAno): array
    {
        $faixaMes  = $this->classificarMes($valorMes);
        $faixaAno  = $this->classificarAno($acumuladoAno);
        $faixa     = $this->maisGrave($faixaMes, $faixaAno);

        return [
            'faixa'   => $faixa,
            'conduta' => self::REGRAS[$faixa]['conduta'],
            'prazo'   => self::REGRAS[$faixa]['prazo'],
        ];
    }

    private function classificarMes(float $v): string
    {
        if ($v < 1.0)  return self::FAIXA_NORMAL;
        if ($v < 4.0)  return self::FAIXA_LIMITROFE_1_4;
        return self::FAIXA_ALTERADO_4_20;
    }

    private function classificarAno(float $acumulado): ?string
    {
        if ($acumulado >= 50.0) return self::FAIXA_ACUM_50_ANO;
        if ($acumulado >= 20.0) return self::FAIXA_ACUM_20_50_ANO;
        return null;
    }

    private function maisGrave(string $a, ?string $b): string
    {
        if ($b === null) return $a;
        return self::SEVERIDADE[$a] >= self::SEVERIDADE[$b] ? $a : $b;
    }
}
