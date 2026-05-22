@extends('voyager::bread.browse')

@section('page_header')
    @parent

    @php
        $current = [
            's'      => request('s'),
            'key'    => request('key'),
            'filter' => request('filter'),
        ];
        $faixas = [
            ['normal_mensal',        'Normal',           '#5cb85c'],
            ['limitrofe_1_4',        'Limítrofe',        '#f0ad4e'],
            ['alterado_4_20',        'Alterado',         '#d9534f'],
            ['acumulado_20_50_ano',  '20–50 ano',        '#d9534f'],
            ['acumulado_50_ano',     '≥50 ano',          '#a94442'],
        ];
        $base = url()->current();
    @endphp

    <div style="margin-top: 14px; padding: 12px; background:#fff; border:1px solid #eee;">
        <strong style="margin-right:8px;">Atalhos:</strong>
        <a href="{{ route('medt.dashboard') }}" class="btn btn-sm btn-info">
            <i class="voyager-dashboard"></i> Dashboard MEDt
        </a>
        <a href="{{ route('medt.import.form') }}" class="btn btn-sm btn-success">
            <i class="voyager-upload"></i> Importar CSV
        </a>

        <span style="margin-left:20px;"><strong>Filtros rápidos:</strong></span>

        <a href="{{ $base }}" class="btn btn-sm {{ !$current['s'] ? 'btn-primary' : 'btn-default' }}">
            Todas
        </a>

        <a href="{{ $base }}?s=Imediato&key=prazo&filter=equals"
           class="btn btn-sm {{ ($current['key'] === 'prazo' && $current['s'] === 'Imediato') ? 'btn-danger' : 'btn-default' }}">
            ⚠ Apenas Imediato
        </a>

        <a href="{{ $base }}?s=Semestral&key=prazo&filter=equals"
           class="btn btn-sm {{ ($current['key'] === 'prazo' && $current['s'] === 'Semestral') ? 'btn-success' : 'btn-default' }}">
            Semestral (normais)
        </a>

        <span style="margin-left:14px; color:#777;">Por faixa:</span>
        @foreach($faixas as [$slug, $rotulo, $cor])
            <a href="{{ $base }}?s={{ $slug }}&key=faixa&filter=equals"
               style="background:{{ $cor }}; color:#fff; padding:4px 10px; border-radius:3px; font-size:11px; text-decoration:none; margin-right:4px;
                      {{ ($current['key'] === 'faixa' && $current['s'] === $slug) ? 'box-shadow:0 0 0 3px rgba(0,0,0,0.25);' : '' }}">
                {{ $rotulo }}
            </a>
        @endforeach
    </div>
@stop
