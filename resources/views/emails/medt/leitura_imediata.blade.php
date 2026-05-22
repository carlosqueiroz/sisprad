<!doctype html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <title>Alerta MEDt — Conduta Imediata</title>
</head>
<body style="font-family: Arial, sans-serif; max-width: 640px; margin: 0 auto; color: #333;">
    <div style="background:#a94442; color:#fff; padding:16px;">
        <h2 style="margin:0;">⚠ Alerta MEDt — Conduta Imediata</h2>
    </div>

    <div style="padding:16px; border:1px solid #ddd; border-top:0;">
        <p>Uma leitura dosimétrica do SisPRad foi classificada com prazo
            <strong style="color:#a94442;">{{ $leitura->prazo }}</strong>.</p>

        <table style="width:100%; border-collapse:collapse;">
            <tr><th align="left" style="padding:6px; background:#f5f5f5;">Profissional</th>
                <td style="padding:6px;">{{ $professional?->person_name ?? '—' }}
                    @if($professional?->person_cpf)
                        <small>(CPF {{ $professional->person_cpf }})</small>
                    @endif
                </td></tr>
            <tr><th align="left" style="padding:6px; background:#f5f5f5;">Função</th>
                <td style="padding:6px;">{{ $professional?->service_person_link_role ?? '—' }}</td></tr>
            <tr><th align="left" style="padding:6px; background:#f5f5f5;">Mês de referência</th>
                <td style="padding:6px;">{{ \Carbon\Carbon::parse($leitura->mes_referencia)->format('m/Y') }}</td></tr>
            <tr><th align="left" style="padding:6px; background:#f5f5f5;">Valor lido</th>
                <td style="padding:6px;"><strong>{{ number_format((float)$leitura->valor_msv, 3, ',', '.') }} mSv</strong></td></tr>
            <tr><th align="left" style="padding:6px; background:#f5f5f5;">Faixa</th>
                <td style="padding:6px;">{{ $leitura->faixa }}</td></tr>
            <tr><th align="left" style="padding:6px; background:#f5f5f5;">Prazo</th>
                <td style="padding:6px; color:#a94442;"><strong>{{ $leitura->prazo }}</strong></td></tr>
        </table>

        <h3 style="margin-top:20px;">Conduta recomendada</h3>
        <p style="background:#fff5f5; padding:12px; border-left:4px solid #a94442;">
            {{ $leitura->conduta }}
        </p>

        @if($leitura->observacoes)
            <h3>Observações</h3>
            <p>{{ $leitura->observacoes }}</p>
        @endif

        <p style="margin-top:20px; font-size:12px; color:#777;">
            Mensagem gerada automaticamente pelo módulo Medicina do Trabalho (MEDt) do SisPRad.
        </p>
    </div>
</body>
</html>
