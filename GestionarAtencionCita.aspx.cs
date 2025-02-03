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
    public partial class GestionarAtencionCita : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Int32 IdCita = Convert.ToInt32(Request.QueryString["idcita"]);

                LlenarDatosPaciente(IdCita);
            }
        }

        private void LlenarDatosPaciente(Int32 IdCita)
        {
            try
            {
                Paciente objPaciente = PacienteLN.Instance.BuscarPacienteIdCita(IdCita);
                if (objPaciente != null)
                {
                    hfIdPaciente.Value = objPaciente.IdPaciente.ToString();
                    lblNombres.Text = objPaciente.Nombres;
                    lblApellidos.Text = $"{objPaciente.ApPaterno} {objPaciente.ApMaterno}";
                    lblEdad.Text = objPaciente.Edad.ToString();
                    lblSexo.Text = objPaciente.Sexo == "F" ? "Femenino" : "Masculino";
                }
                else
                {
                    lblError.Text = "No se encontró información del paciente.";
                }
            }
            catch (Exception ex)
            {
                // Manejar el error (por ejemplo, mostrar un mensaje de error)
                lblError.Text = "Ocurrió un error al cargar los datos del paciente.";
                // Loguear el error si es necesario
            }
        }
        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            Diagnostico objDiagnostico = new Diagnostico();
            objDiagnostico.HistoriaClinica.IDPaciente = Convert.ToInt32(hfIdPaciente.Value);
            objDiagnostico.Observacion = txtObservaciones.Text;
            objDiagnostico.SDiagnostico = txtDiagnostico.Text;

            bool ok = DiagnosticoLN.getInstance().RegistrarDiagnostico(objDiagnostico);

            if (ok)
            {
                Response.Write("<script>alert('Diagnóstico registrado correctamente.')</script>");
                //Response.Redirect("PanelGeneral.aspx");
                btnRegistrar.Enabled = false;
            }
            else
            {
                Response.Write("<script>alert('No se pudo registrar el diagnóstico.')</script>");
            }
        }
    }
}