﻿//Configuracion de timepicker y date
$("[data-mask]").inputmask();
$(".timepicker").timepicker({ showInputs: false, showMeridian: false, minuteStep: 30 });

var tabla;

function initDataTable() {

    tabla = $("#tbl_horarios").DataTable({
        "aaSorting": [[0, 'desc']],
        "bSort": true,
        "aoColumns": [
            { "bSortable": false },
            { "bSortable": false },
            { "bSortable": false },
            null,
            null
        ]
    });

    tabla.fnSetColumnVis(2, false);
}

$("#btnBuscar").on("click", function (event) {

    event.preventDefault();

    // obtener los datos del texto de dni
    var dni = $("#txtDni").val();

    var obj = JSON.stringify({ dni: dni });

    if (dni.length > 0) {
        // llamada a ajax
        $.ajax({
            type: "POST",
            url: "GestionarHorarioAtencion.aspx/BuscarMedico",
            data: obj,
            contentType: 'application/json; charset=utf-8',
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
            },
            success: function (data) {
                //console.log("éxito", data);
                if (data.d !== null) {
                    llenarDatosMedico(data.d);
                    listHorarios(data.d.IdMedico);
                } else {
                    llenarDatosMedicoDefault(data.d);
                }
            }
        });
    } else {
        console.log("No ha ingresado un dni.");
    }
});

function llenarDatosMedico(obj) {
    $("#lblNombres").text(obj.Nombres);
    $("#lblApellidos").text(obj.ApPaterno.concat(" ".concat(obj.ApMaterno)));
    $("#lblEspecialidad").text(obj.Especialidad.Descripcion);
    $("#txtMedico").val(obj.IdMedico);
}

function llenarDatosMedicoDefault() {
    alert("No existe médico con documento " + $("#txtDni").val());
    $("#lblNombres").text("");
    $("#lblApellidos").text("");
    $("#lblEspecialidad").text("");
    $("#txtMedico").val("0");
    $("#txtDni").val("");
}