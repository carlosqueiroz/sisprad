$(document).ready(function() {
    var route = window.location.pathname;
    var readOnly = route.indexOf('/edit') === -1 && route.indexOf('/create') === -1;
    var baseUrl = window.location.protocol + '//' + window.location.host;
    var $doses = $('input[name="doses"]'); // Assume that input name="doses" is an input element
    var $tableContainer;

    // Create table dynamically and hide the 'doses' field
    $doses.before('<table id="tableContainer" class="table table-hover dataTable"></table>').hide();
    $tableContainer = $('#tableContainer');

    function saveChanges() {
        var data = [];
        $tableContainer.find('tr').each(function() {
            var $row = $(this);
            data.push({
                person_id: $row.children('td').eq(0).text(),
                person_name: $row.children('td').eq(1).text(),
                person_cpf: $row.children('td').eq(2).text(),
                dosimetro: $row.children('td').eq(3).text(),
                avental: $row.children('td').eq(4).text(),
                dose: $row.find('input[type="number"]').val(),
                nominal_value: $row.find('select').val()
            });
        });
        $doses.val(JSON.stringify(data));
    }

    function createTable(data) {
        $tableContainer.empty(); // Clear the existing table

        data.forEach(function(row, index) {
            var newRow = $('<tr></tr>');
            var $doseField = $('<input type="number" maxlength="6" name="doses' + index + '" value="' + (row.dose || '') + '" ' + (readOnly ? 'readonly' : '') + '>');
            var $selectField = $('<select name="nominal_value' + index + '" ' + (readOnly ? 'disabled' : '') + '></select>');

            $doseField.change(saveChanges);
            $selectField.change(function() {
                if ($(this).val() !== '') {
                    $doseField.val(0).prop('readonly', true);
                } else {
                    $doseField.prop('readonly', false);
                }
                saveChanges();
            });

            $selectField.append('<option value="">---</option>');
            $selectField.append('<option value="BG/AND/M - Dose menor que 0,1 mSv">BG/AND/M - Dose menor que 0,1 mSv</option>');
            $selectField.append('<option value="LI - Leitura impossível">LI - Leitura impossível</option>');
            $selectField.append('<option value="ND - Não devolvido/disponível">ND - Não devolvido/disponível</option>');
            $selectField.append('<option value="NU - Não utilizado">NU - Não utilizado</option>');
            $selectField.append('<option value="NE - Não enviado por não ser devolvido">NE - Não enviado por não ser devolvido</option>');

            // Set value of the select field and listen for changes
            $selectField.val(row.nominal_value || '');
            $selectField.change();

            newRow.append('<td>' + (row.person_id || '') + '</td>');
            newRow.append('<td>' + (row.person_name || '') + '</td>');
            newRow.append('<td>' + (row.person_cpf || '') + '</td>');
            newRow.append('<td>' + (row.dosimetro || '') + '</td>');
            newRow.append('<td>' + (row.avental || '') + '</td>');
            newRow.append('<td>').children('td:last').append($doseField);
            newRow.append('<td>').children('td:last').append($selectField);

            $tableContainer.append(newRow);
        });

        saveChanges();
    }

    $('[name="sector_id"]').change(function() {
        var setorId = $(this).val();

        $.get(baseUrl + '/professionals', { sector_id: setorId })
            .done(function(data) {
                if (data && Array.isArray(data)) {
                    createTable(data);
                }
            });
    });

    if (route.indexOf('/edit') !== -1) {
        var data = JSON.parse($doses.val());
        if (data && Array.isArray(data)) {
            createTable(data);
        }
    }

    if (route.indexOf('/create') !== -1) {
        $('[name="sector_id"]').change();
    }
});
