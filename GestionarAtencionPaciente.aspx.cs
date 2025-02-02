using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CapaEntidades;
using CapaLogicaNegocio;

namespace CapaPresentacion
{
    public partial class GestionarAtencionPaciente : System.Web.UI.Page
    {
        private static String COMMAND_REGISTER = "Registrar";
        private static String COMMAND_CANCEL = "Cancelar";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    llenarDataList();
                    lblFechaAtencion.Text = DateTime.Now.ToShortDateString();
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al cargar la lista de citas: " + ex.Message);
                }
            }
        }

        private void llenarDataList()
        {
            try
            {
                List<Cita> ListaCitas = CitaLN.getInstance().ListarCitas();
                dlAtencionMedica.DataSource = ListaCitas;
                dlAtencionMedica.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensajeError("Error al llenar la lista de citas: " + ex.Message);
            }
        }

        protected void dlAtencionMedica_ItemCommand(object source, DataListCommandEventArgs e)
        {
            String IdCita = (e.Item.FindControl("hdIdCita") as HiddenField).Value;

            try
            {
                if (e.CommandName == COMMAND_REGISTER)
                {
                    // realizar el registro de la atención
                    bool response = CitaLN.getInstance().ActualizarCita(Convert.ToInt32(IdCita), "A");

                    if (response)
                    {
                        Response.Redirect("GestionarAtencionCita.aspx?idcita=" + IdCita);
                    }
                    else
                    {
                        MostrarMensajeError("No se puede realizar la atención de la cita.");
                    }
                }
                else if (e.CommandName == COMMAND_CANCEL)
                {
                    // realizar la cancelación de la reserva de cita
                    bool response = CitaLN.getInstance().ActualizarCita(Convert.ToInt32(IdCita), "E");

                    if (response)
                    {
                        // recargar la información
                        llenarDataList();
                    }
                    else
                    {
                        MostrarMensajeError("No se puede eliminar la cita.");
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensajeError("Error al procesar la solicitud: " + ex.Message);
            }
        }

        private void MostrarMensajeError(string mensaje)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + mensaje + "');", true);
        }
    }
}