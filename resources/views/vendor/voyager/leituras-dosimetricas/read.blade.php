@extends('voyager::master')

@php
    use App\Services\CondutaMedtService;

    $cores = [
        CondutaMedtService::FAIXA_NORMAL          => ['bg' => '#5cb85c', 'label' => 'Normal'],
        CondutaMedtService::FAIXA_LIMITROFE_1_4   => ['bg' => '#f0ad4e', 'label' => 'Limítrofe (1–<4 mSv/mês)'],
        CondutaMedtService::FAIXA_ALTERADO_4_20   => ['bg' => '#d9534f', 'label' => 'Alterado (4–<20 mSv/mês)'],
        CondutaMedtService::FAIXA_ACUM_20_50_ANO  => ['bg' => '#d9534f', 'label' => 'Acumulado anual 20–<50 mSv'],
        CondutaMedtService::FAIXA_ACUM_50_ANO    => ['bg' => '#a94442', 'label' => 'Acumulado anual ≥ 50 mSv (limite legal)'],
    ];
    $faixa  = $dataTypeContent->faixa;
    $info   = $cores[$faixa] ?? ['bg' => '#777', 'label' => $faixa];
@endphp

@section('page_title', 'Leitura Dosimétrica — Conduta Médica')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-activity"></i> Leitura Dosimétrica &nbsp;
        @can('edit', $dataTypeContent)
            <a href="{{ route('voyager.'.$dataType->slug.'.edit', $dataTypeContent->getKey()) }}" class="btn btn-info">
                <i class="glyphicon glyphicon-pencil"></i> Editar
            </a>
        @endcan
        @can('browse', $dataTypeContent)
            <a href="{{ route('voyager.'.$dataType->slug.'.index') }}" class="btn btn-warning">
                <i class="glyphicon glyphicon-list"></i> Voltar à lista
            </a>
        @endcan
    </h1>
@stop

@section('content')
<div class="page-content read container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel" style="border-top: 6px solid {{ $info['bg'] }};">
                <div class="panel-body">
                    <div style="display:flex; align-items:center; gap:16px; flex-wrap:wrap;">
                        <span style="background:{{ $info['bg'] }}; color:#fff; padding:8px 14px; border-radius:4px; font-weight:bold; font-size:14px;">
                            {{ $info['label'] }}
                        </span>
                        <span style="font-size:18px;">
                            <strong>Prazo:</strong>
                            <span style="color:{{ $dataTypeContent->prazo === 'Imediato' ? '#d9534f' : '#5cb85c' }}; font-weight:bold;">
                                {{ $dataTypeContent->prazo }}
                            </span>
                        </span>
                    </div>
                    <h3 style="margin-top:18px; margin-bottom:6px;">Conduta recomendada</h3>
                    <p style="font-size:15px; line-height:1.5;">{{ $dataTypeContent->conduta }}</p>
                </div>
            </div>

            <div class="panel panel-bordered">
                <div class="panel-heading"><h3 class="panel-title">Detalhes da Leitura</h3></div>
                <div class="panel-body">
                    <table class="table table-striped" style="margin-bottom:0;">
                        <tbody>
                            <tr>
                                <th style="width:220px;">Profissional</th>
                                <td>{{ optional($dataTypeContent->professional)->person_name ?? '—' }}
                                    @if($dataTypeContent->professional && $dataTypeContent->professional->person_cpf)
                                        <small class="text-muted">(CPF {{ $dataTypeContent->professional->person_cpf }})</small>
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <th>Mês de referência</th>
                                <td>{{ \Carbon\Carbon::parse($dataTypeContent->mes_referencia)->format('m/Y') }}</td>
                            </tr>
                            <tr>
                                <th>Valor lido</th>
                                <td><strong>{{ number_format($dataTypeContent->valor_msv, 3, ',', '.') }} mSv</strong></td>
                            </tr>
                            <tr>
                                <th>Acumulado no ano ({{ \Carbon\Carbon::parse($dataTypeContent->mes_referencia)->year }})</th>
                                <td>
                                    @php
                                        $ano = \Carbon\Carbon::parse($dataTypeContent->mes_referencia)->year;
                                        $acum = optional($dataTypeContent->professional)->acumuladoAno($ano) ?? 0;
                                    @endphp
                                    <strong>{{ number_format($acum, 3, ',', '.') }} mSv</strong>
                                </td>
                            </tr>
                            <tr>
                                <th>Tipo de dosímetro</th>
                                <td>{{ $dataTypeContent->tipo ?: '—' }}</td>
                            </tr>
                            <tr>
                                <th>Observações</th>
                                <td>{{ $dataTypeContent->observacoes ?: '—' }}</td>
                            </tr>
                            <tr>
                                <th>Registrado em</th>
                                <td>{{ $dataTypeContent->created_at }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
@stop
