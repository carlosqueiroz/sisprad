@extends('voyager::master')

@section('page_title', 'Importar Leituras Dosimétricas (CSV)')

@section('page_header')
    <h1 class="page-title"><i class="voyager-upload"></i> Importar Leituras Dosimétricas</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-bordered">
                <div class="panel-heading">
                    <h3 class="panel-title">Upload de planilha CSV</h3>
                </div>
                <div class="panel-body">
                    <p>
                        Faça upload de um arquivo CSV no formato:
                        <code>cpf;mes_referencia;valor_msv;tipo</code> (a coluna <code>tipo</code> é opcional).
                        Linhas com cabeçalho <code>cpf;mes;valor</code> são ignoradas automaticamente.
                    </p>
                    <p>
                        O CPF deve coincidir com um profissional já cadastrado (<code>professionals.person_cpf</code>).
                        Leituras com o mesmo <em>profissional + mês</em> são <strong>atualizadas</strong> em vez de duplicadas.
                    </p>

                    <form method="POST" action="{{ route('medt.import.submit') }}" enctype="multipart/form-data">
                        @csrf
                        <div class="form-group">
                            <label>Arquivo CSV</label>
                            <input type="file" name="arquivo" accept=".csv,text/csv,text/plain" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Delimitador</label>
                            <select name="delimitador" class="form-control" style="width:200px;">
                                <option value=";" selected>Ponto-e-vírgula ( ; )</option>
                                <option value=",">Vírgula ( , )</option>
                                <option value="\t">Tabulação</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="voyager-upload"></i> Importar
                        </button>
                        <a href="{{ route('voyager.leituras-dosimetricas.index') }}" class="btn btn-default">Cancelar</a>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="panel panel-bordered">
                <div class="panel-heading"><h3 class="panel-title">Exemplo de CSV</h3></div>
                <div class="panel-body">
<pre style="font-size:12px;">cpf;mes_referencia;valor_msv;tipo
111.222.333-44;2026-05-01;0.42;tórax
222.333.444-55;2026-05-01;2.85;tórax
333.444.555-66;2026-05-01;9.40;tórax
</pre>
                </div>
            </div>
        </div>
    </div>
</div>
@stop
