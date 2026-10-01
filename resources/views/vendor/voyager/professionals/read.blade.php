@extends('voyager::bread.read')

@php
    use App\Services\CondutaMedtService;
    $ano        = now()->year;
    $acumulado  = method_exists($dataTypeContent, 'acumuladoAno')
        ? $dataTypeContent->acumuladoAno($ano)
        : 0;
    $ultimas = method_exists($dataTypeContent, 'leiturasDosimetricas')
        ? $dataTypeContent->leiturasDosimetricas()
            ->orderBy('mes_referencia', 'desc')
            ->limit(12)
            ->get()
        : collect();

    $cores = [
        CondutaMedtService::FAIXA_NORMAL          => '#5cb85c',
        CondutaMedtService::FAIXA_LIMITROFE_1_4   => '#f0ad4e',
        CondutaMedtService::FAIXA_ALTERADO_4_20   => '#d9534f',
        CondutaMedtService::FAIXA_ACUM_20_50_ANO  => '#d9534f',
        CondutaMedtService::FAIXA_ACUM_50_ANO    => '#a94442',
    ];
@endphp

@section('content')
    @parent

    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="border-top: 6px solid #5bc0de;">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <i class="voyager-activity"></i> Medicina do Trabalho (MEDt) — Histórico Dosimétrico
                        </h3>
                    </div>
                    <div class="panel-body">
                        <p>
                            <strong>Acumulado no ano de {{ $ano }}:</strong>
                            <span style="font-size:18px; color:{{ $acumulado >= 50 ? '#a94442' : ($acumulado >= 20 ? '#d9534f' : '#333') }};">
                                {{ number_format($acumulado, 3, ',', '.') }} mSv
                            </span>
                            <small class="text-muted">(limite legal anual: 50 mSv)</small>
                        </p>

                        @if($ultimas->isEmpty())
                            <p class="text-muted">Nenhuma leitura dosimétrica registrada para este profissional.</p>
                        @else
                            <table class="table table-striped" style="margin-bottom:0;">
                                <thead>
                                    <tr>
                                        <th>Mês</th>
                                        <th>Valor (mSv)</th>
                                        <th>Faixa</th>
                                        <th>Prazo</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                @foreach($ultimas as $l)
                                    <tr>
                                        <td>{{ \Carbon\Carbon::parse($l->mes_referencia)->format('m/Y') }}</td>
                                        <td>{{ number_format((float)$l->valor_msv, 3, ',', '.') }}</td>
                                        <td>
                                            <span style="background:{{ $cores[$l->faixa] ?? '#777' }}; color:#fff; padding:2px 8px; border-radius:3px; font-size:11px;">
                                                {{ $l->faixa }}
                                            </span>
                                        </td>
                                        <td>
                                            <span style="color:{{ $l->prazo === 'Imediato' ? '#d9534f' : '#5cb85c' }}; font-weight:bold;">
                                                {{ $l->prazo }}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="{{ route('voyager.leituras-dosimetricas.show', $l->id) }}" class="btn btn-xs btn-default">ver</a>
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
    </div>
@endsection
