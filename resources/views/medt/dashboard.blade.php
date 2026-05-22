@extends('voyager::master')

@php
    use App\Services\CondutaMedtService;

    $coresFaixa = [
        CondutaMedtService::FAIXA_NORMAL          => ['bg' => '#5cb85c', 'rotulo' => 'Normal (< 1 mSv/mês)'],
        CondutaMedtService::FAIXA_LIMITROFE_1_4   => ['bg' => '#f0ad4e', 'rotulo' => 'Limítrofe (1–<4 mSv/mês)'],
        CondutaMedtService::FAIXA_ALTERADO_4_20   => ['bg' => '#d9534f', 'rotulo' => 'Alterado (4–<20 mSv/mês)'],
        CondutaMedtService::FAIXA_ACUM_20_50_ANO  => ['bg' => '#d9534f', 'rotulo' => 'Acumulado anual 20–<50 mSv'],
        CondutaMedtService::FAIXA_ACUM_50_ANO    => ['bg' => '#a94442', 'rotulo' => 'Acumulado anual ≥ 50 mSv (limite legal)'],
    ];
@endphp

@section('page_title', 'Dashboard MEDt')

@section('page_header')
    <h1 class="page-title"><i class="voyager-activity"></i> Medicina do Trabalho — Dashboard</h1>
    <form method="GET" class="form-inline pull-right" style="margin-top:-44px;">
        <label>Ano:</label>
        <select name="ano" class="form-control" onchange="this.form.submit()">
            @foreach([now()->year, now()->year - 1] as $a)
                <option value="{{ $a }}" {{ $a == $ano ? 'selected' : '' }}>{{ $a }}</option>
            @endforeach
        </select>
    </form>
@stop

@section('content')
<div class="page-content container-fluid">

    {{-- Cards de contagem por faixa --}}
    <div class="row">
        @php
            $contagemMap = $contagemPorFaixa->pluck('total', 'faixa')->all();
        @endphp
        @foreach($coresFaixa as $faixa => $info)
            @php $n = $contagemMap[$faixa] ?? 0; @endphp
            <div class="col-md-2 col-sm-4 col-xs-6">
                <div style="background:#fff; border:1px solid #eee; border-top:5px solid {{ $info['bg'] }}; padding:14px; margin-bottom:16px;">
                    <div style="font-size:11px; color:#777; min-height:32px;">{{ $info['rotulo'] }}</div>
                    <div style="font-size:32px; font-weight:bold; color:{{ $info['bg'] }};">{{ $n }}</div>
                    <small class="text-muted">leituras em {{ $ano }}</small>
                </div>
            </div>
        @endforeach
        <div class="col-md-2 col-sm-4 col-xs-6">
            <div style="background:#fff; border:1px solid #eee; border-top:5px solid #5bc0de; padding:14px; margin-bottom:16px;">
                <div style="font-size:11px; color:#777; min-height:32px;">Profissionais sem leitura em {{ $mes->format('m/Y') }}</div>
                <div style="font-size:32px; font-weight:bold; color:#5bc0de;">{{ $sem_leitura_mes->count() }}</div>
                <small class="text-muted">pendentes</small>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-bordered">
                <div class="panel-heading">
                    <h3 class="panel-title">Top 10 — Acumulado anual {{ $ano }}</h3>
                </div>
                <div class="panel-body" style="padding:0;">
                    <table class="table table-striped" style="margin-bottom:0;">
                        <thead>
                            <tr>
                                <th>Profissional</th>
                                <th>Função</th>
                                <th style="text-align:right;">mSv</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($topAcumulado as $p)
                            @php
                                $cor = $p->total >= 50 ? '#a94442' : ($p->total >= 20 ? '#d9534f' : ($p->total >= 4 ? '#f0ad4e' : '#5cb85c'));
                            @endphp
                            <tr>
                                <td>{{ $p->person_name }}</td>
                                <td>{{ $p->service_person_link_role }}</td>
                                <td style="text-align:right; color:{{ $cor }}; font-weight:bold;">
                                    {{ number_format((float)$p->total, 3, ',', '.') }}
                                </td>
                                <td>
                                    <a href="{{ url('admin/professionals/'.$p->id) }}" class="btn btn-xs btn-default">ver</a>
                                </td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="panel panel-bordered">
                <div class="panel-heading">
                    <h3 class="panel-title">Leituras do mês atual ({{ $mes->format('m/Y') }})</h3>
                </div>
                <div class="panel-body" style="padding:0; max-height:380px; overflow:auto;">
                    @if($leiturasMesAtual->isEmpty())
                        <p class="text-muted" style="padding:14px;">Nenhuma leitura registrada para {{ $mes->format('m/Y') }}.</p>
                    @else
                    <table class="table table-striped" style="margin-bottom:0;">
                        <thead>
                            <tr>
                                <th>Profissional</th>
                                <th style="text-align:right;">mSv</th>
                                <th>Faixa</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($leiturasMesAtual as $l)
                            @php $cor = $coresFaixa[$l->faixa]['bg'] ?? '#777'; @endphp
                            <tr>
                                <td>{{ optional($l->professional)->person_name }}</td>
                                <td style="text-align:right;">{{ number_format((float)$l->valor_msv, 3, ',', '.') }}</td>
                                <td>
                                    <span style="background:{{ $cor }}; color:#fff; padding:2px 8px; border-radius:3px; font-size:11px;">{{ $l->faixa }}</span>
                                </td>
                                <td>
                                    <a href="{{ url('admin/leituras-dosimetricas/'.$l->id) }}" class="btn btn-xs btn-default">ver</a>
                                </td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                    @endif
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-7">
            <div class="panel panel-bordered" style="border-top:4px solid #a94442;">
                <div class="panel-heading">
                    <h3 class="panel-title">Alertas com conduta imediata ({{ $ano }})</h3>
                </div>
                <div class="panel-body" style="padding:0; max-height:400px; overflow:auto;">
                    @if($alertasImediatos->isEmpty())
                        <p class="text-muted" style="padding:14px;">Nenhum alerta imediato no período.</p>
                    @else
                    <table class="table table-striped" style="margin-bottom:0;">
                        <thead>
                            <tr>
                                <th>Mês</th>
                                <th>Profissional</th>
                                <th style="text-align:right;">mSv</th>
                                <th>Faixa</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        @foreach($alertasImediatos as $l)
                            @php $cor = $coresFaixa[$l->faixa]['bg'] ?? '#777'; @endphp
                            <tr>
                                <td>{{ \Carbon\Carbon::parse($l->mes_referencia)->format('m/Y') }}</td>
                                <td>{{ optional($l->professional)->person_name }}</td>
                                <td style="text-align:right;">{{ number_format((float)$l->valor_msv, 3, ',', '.') }}</td>
                                <td>
                                    <span style="background:{{ $cor }}; color:#fff; padding:2px 8px; border-radius:3px; font-size:11px;">{{ $l->faixa }}</span>
                                </td>
                                <td><a href="{{ url('admin/leituras-dosimetricas/'.$l->id) }}" class="btn btn-xs btn-default">ver</a></td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                    @endif
                </div>
            </div>
        </div>

        <div class="col-md-5">
            <div class="panel panel-bordered">
                <div class="panel-heading">
                    <h3 class="panel-title">Pendentes — sem leitura em {{ $mes->format('m/Y') }}</h3>
                </div>
                <div class="panel-body" style="padding:0; max-height:400px; overflow:auto;">
                    @if($sem_leitura_mes->isEmpty())
                        <p class="text-muted" style="padding:14px;">Todos os profissionais têm leitura registrada para {{ $mes->format('m/Y') }}.</p>
                    @else
                    <table class="table table-striped" style="margin-bottom:0;">
                        <thead><tr><th>Profissional</th><th>Função</th><th></th></tr></thead>
                        <tbody>
                        @foreach($sem_leitura_mes as $p)
                            <tr>
                                <td>{{ $p->person_name }}</td>
                                <td>{{ $p->service_person_link_role }}</td>
                                <td><a href="{{ url('admin/professionals/'.$p->id) }}" class="btn btn-xs btn-default">ver</a></td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>
@stop
