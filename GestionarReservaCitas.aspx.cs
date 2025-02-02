using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaAccesoDatos;
using CapaEntidades;
using CapaLogicaNegocio;

namespace CapaPresentacion
{
    public partial class GestionarReservasCitas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)    
        {
            if (!IsPostBack)
            {
                LlenarEspecialidades();
            }

        }

        private void LlenarGridViewHorariosAtencion()
        {
            if (String.IsNullOrEmpty(txtFechaAtencion.Text))
            {
                MostrarMensaje("No ha ingresado una fecha válida");
                return;
            }

            if (!DateTime.TryParse(txtFechaAtencion.Text, out DateTime fechaBusqueda))
            {
                MostrarMensaje("Formato de fecha no válido");
                return;
            }

            if (!Int32.TryParse(ddlEspecialidad.SelectedValue, out int idEspecialidad))
            {
                MostrarMensaje("Especialidad no válida");
                return;
            }

            try
            {
                List<HorarioAtencion> Lista = HorarioAtencionLN.getInstance().ListarHorarioReservas(idEspecialidad, fechaBusqueda);
                grdHorariosAtencion.DataSource = Lista;
                grdHorariosAtencion.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar los horarios de atención: " + ex.Message);
            }
        }


        private void LlenarEspecialidades()
        {
            try
            {
                List<Especialidad> Lista = EspecialidadLN.getInstance().Listar();
                ddlEspecialidad.DataSource = Lista;
                ddlEspecialidad.DataValueField = "IdEspecialidad";
                ddlEspecialidad.DataTextField = "Descripcion";
                ddlEspecialidad.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar las especialidades: " + ex.Message);
            }
        }

        [WebMethod]
        public static Paciente BuscarPacienteDNI(String dni)
        {
            return PacienteDAO.getInstance().BuscarPacienteDNI(dni);
        }

        protected void btnBuscarHorario_Click(object sender, EventArgs e)
        {
            LlenarGridViewHorariosAtencion();
        }

        protected void btnReservarCita_Click(object sender, EventArgs e)
        {
            {
                if (String.IsNullOrEmpty(idPaciente.Value) || !HorarioAtencionSelccionado())
                {
                    MostrarMensaje("Debe seleccionar un horario y un paciente válido");
                    return;
                }

                try
                {
                    Cita objCita = ObtenerCitaSeleccionada();
                    bool response = CitaLN.getInstance().RegistrarCita(objCita);

                    if (response)
                    {
                        MostrarMensaje("Cita registrada correctamente.");
                    }
                    else
                    {
                        MostrarMensaje("Error al registrar la cita.");
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al registrar la cita: " + ex.Message);
                }
            }
        }

        private bool HorarioAtencionSelccionado()
        {
            foreach (GridViewRow row in grdHorariosAtencion.Rows)
            {
                CheckBox chkHorario = (row.FindControl("chkSeleccionar") as CheckBox);
                if (chkHorario != null && chkHorario.Checked)
                {
                    return true;
                }
            }
            return false;
        }

        private Cita ObtenerCitaSeleccionada()
        {
            Cita objCita = new Cita();

            foreach (GridViewRow row in grdHorariosAtencion.Rows)
            {
                CheckBox chkHorario = (row.FindControl("chkSeleccionar") as CheckBox);

                if (chkHorario != null && chkHorario.Checked)
                {
                    objCita.Hora = (row.FindControl("lblHora") as Label)?.Text;
                    objCita.FechaReserva = DateTime.Now;
                    objCita.Paciente.IdPaciente = Convert.ToInt32(idPaciente.Value);

                    string idMedico = (row.FindControl("hfIdMedico") as HiddenField)?.Value;
                    objCita.Medico.IdMedico = Convert.ToInt32(idMedico);

                    break;
                }
            }
            return objCita;
        }

        private void MostrarMensaje(string mensaje)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alerta", $"<script>alert('{mensaje}')</script>", false);
        }
    }
}