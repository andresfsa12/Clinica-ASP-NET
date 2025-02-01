$("[data-mask]").inputmask();

$("#btnBuscar").on('click', function (e) {
    e.preventDefault();

    var dni = $("#txtDNI").val();

    searchPacienteDni(dni);

});

function searchPacienteDni(dni) {

    var data = JSON.stringify({ dni: dni });
    $.ajax({
        type: "POST",
        url: "GestionarReservaCitas.aspx/BuscarPacienteDNI",
        data: data,
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + " \n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            if (data.d == null) {
                alert('No existe el paciente con dni' + dni);
                limpiarDatosPaciente();
            } else {
                llenarDatosPaciente(data.d);
            }

        }
    });
}


function llenarDatosPaciente(obj) {
    $("#idPaciente").val(obj.IdPaciente);
    $("#txtNombres").val(obj.Nombres);
    $("#txtApellidos").val(obj.ApPaterno + " " + obj.ApMaterno);
    $("#txtTelefono").val(obj.Telefono);
    $("#txtEdad").val(obj.Edad);
    $("#txtSexo").val((obj.Sexo == 'M') ? 'Masculino' : 'Femenino');
}

function limpiarDatosPaciente() {
    $("#idPaciente").val("0");
    $("#txtNombres").val("");
    $("#txtApellidos").val("");
    $("#txtTelefono").val("");
    $("#txtEdad").val("");
    $("#txtSexo").val("");
}
/////////////////////////////////////////////////////////////////

$("#btnReservarCita").on('click', function (e) {
    e.preventDefault();

    // Obtener el ID del paciente seleccionado (asumiendo que está almacenado en algún lugar)
    var idPaciente = $("#idPaciente").val(); // Ajustar según tu implementación

    if (idPaciente === "") {
        alert("Debe seleccionar un paciente.");
        return;
    }

    // Obtener el horario seleccionado (asumiendo que está almacenado en algún lugar)
    var horarioSeleccionado = obtenerHorarioSeleccionado(); // Implementar esta función

    if (!horarioSeleccionado) {
        alert("Debe seleccionar un horario.");
        return;
    }

    // Construir el objeto de la cita
    var cita = {
        PacienteId: parseInt(idPaciente),
        Hora: horarioSeleccionado.Hora,
        FechaReserva: horarioSeleccionado.Fecha,
        MedicoId: horarioSeleccionado.MedicoId
    };

    // Enviar la solicitud AJAX
    $.ajax({
        type: "POST",
        url: "GestionarReservaCitas.aspx/RegistrarCita",
        data: JSON.stringify(cita),
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            if (result.d) {
                alert("Cita registrada correctamente.");
                // Limpiar o redireccionar según sea necesario
            } else {
                alert("Error al registrar la cita.");
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.error("Error en la solicitud AJAX:", xhr.status, thrownError);
        }
    });
});

// Función para obtener el horario seleccionado (implementación a ajustar)
function obtenerHorarioSeleccionado() {
    // Lógica para obtener el horario seleccionado 
    // (por ejemplo, a partir de un elemento seleccionado en un gridview, 
    // un input radio, etc.)

    // Ejemplo: Suponiendo que el horario está almacenado en un input oculto
    var hora = $("#horaSeleccionada").val();
    var fecha = $("#fechaSeleccionada").val();
    var medicoId = $("#medicoIdSeleccionado").val();

    if (hora && fecha && medicoId) {
        return {
            Hora: hora,
            Fecha: fecha,
            MedicoId: parseInt(medicoId)
        };
    } else {
        return null;
    }
}