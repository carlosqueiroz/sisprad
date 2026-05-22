<?php

namespace Tests\Unit;

use App\Services\CondutaMedtService;
use PHPUnit\Framework\TestCase;

class CondutaMedtServiceTest extends TestCase
{
    private CondutaMedtService $service;

    protected function setUp(): void
    {
        parent::setUp();
        $this->service = new CondutaMedtService();
    }

    public function test_faixa_normal_quando_mes_abaixo_de_1_e_acumulado_baixo(): void
    {
        $r = $this->service->classificar(0.5, 0.5);

        $this->assertSame(CondutaMedtService::FAIXA_NORMAL, $r['faixa']);
        $this->assertSame('Semestral', $r['prazo']);
    }

    public function test_faixa_limitrofe_entre_1_e_4(): void
    {
        $r = $this->service->classificar(2.5, 2.5);

        $this->assertSame(CondutaMedtService::FAIXA_LIMITROFE_1_4, $r['faixa']);
        $this->assertSame('Imediato', $r['prazo']);
    }

    public function test_faixa_alterado_entre_4_e_20(): void
    {
        $r = $this->service->classificar(10.0, 10.0);

        $this->assertSame(CondutaMedtService::FAIXA_ALTERADO_4_20, $r['faixa']);
        $this->assertSame('Imediato', $r['prazo']);
    }

    public function test_acumulado_anual_20_a_50_ganha_de_mes_normal(): void
    {
        $r = $this->service->classificar(0.1, 25.0);

        $this->assertSame(CondutaMedtService::FAIXA_ACUM_20_50_ANO, $r['faixa']);
        $this->assertSame('Imediato', $r['prazo']);
    }

    public function test_acumulado_anual_acima_de_50_ganha_de_tudo(): void
    {
        $r = $this->service->classificar(0.1, 55.0);

        $this->assertSame(CondutaMedtService::FAIXA_ACUM_50_ANO, $r['faixa']);
        $this->assertSame('Imediato', $r['prazo']);
        $this->assertStringContainsString('limite legal', $r['conduta']);
    }

    public function test_mais_grave_vence_quando_mes_e_ano_concorrem(): void
    {
        $r = $this->service->classificar(5.0, 55.0);

        $this->assertSame(CondutaMedtService::FAIXA_ACUM_50_ANO, $r['faixa']);
    }

    public function test_limite_exato_de_1_msv_cai_em_limitrofe(): void
    {
        $r = $this->service->classificar(1.0, 1.0);

        $this->assertSame(CondutaMedtService::FAIXA_LIMITROFE_1_4, $r['faixa']);
    }

    public function test_limite_exato_de_4_msv_cai_em_alterado(): void
    {
        $r = $this->service->classificar(4.0, 4.0);

        $this->assertSame(CondutaMedtService::FAIXA_ALTERADO_4_20, $r['faixa']);
    }

    public function test_limite_exato_de_50_msv_anual_cai_em_50_ano(): void
    {
        $r = $this->service->classificar(0.0, 50.0);

        $this->assertSame(CondutaMedtService::FAIXA_ACUM_50_ANO, $r['faixa']);
    }
}
