using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Windows.Forms;
using CapaEntidades;
using CapaLogicaNegocio;
using CapaAccesoDatos;


namespace CapaPresentacion
{
    public partial class frmGestionarPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                List<ListItem> items = new List<ListItem>();
                items.Add(new ListItem("Masculino", "M"));
                items.Add(new ListItem("Femenino", "F"));
                ddlSexo.DataSource = items;
                ddlSexo.DataTextField = "Text";
                ddlSexo.DataValueField = "Value";
                ddlSexo.DataBind();
            }
        }

        [WebMethod]
        public static List<Paciente> ListarPacientes()
        {
            try
            {
                return PacienteDAO.getInstance().ListarPacientes();
            }
            catch (Exception ex)
            {
                // Registrar el error para su posterior análisis
                System.Diagnostics.Debug.WriteLine("Error al listar pacientes: " + ex.Message);
                return new List<Paciente>();
            }
        }

        [WebMethod]
        public static bool ActualizarDatosPaciente(string id, string direccion)
        {
            if (int.TryParse(id, out int idPaciente))
            {
                Paciente objPaciente = new Paciente
                {
                    IdPaciente = idPaciente,
                    Direccion = direccion
                };

                try
                {
                    return PacienteDAO.getInstance().Actualizar(objPaciente);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error al actualizar paciente: " + ex.Message);
                    return false;
                }
            }
            return false;
        }

        [WebMethod]
        public static bool EliminarDatosPaciente(string id)
        {
            if (int.TryParse(id, out int idPaciente))
            {
                try
                {
                    return PacienteDAO.getInstance().Eliminar(idPaciente);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error al eliminar paciente: " + ex.Message);
                    return false;
                }
            }
            return false;
        }

        private Paciente GetEntity()
        {
            return new Paciente
            {
                IdPaciente = 0,
                Nombres = txtNombres.Text,
                ApPaterno = txtApPaterno.Text,
                ApMaterno = txtApMaterno.Text,
                Edad = txtEdad.Text,
                Sexo = ddlSexo.SelectedValue,
                NroDocumento = txtNroDocumento.Text,
                Direccion = txtDireccion.Text,
                Telefono = txtTelefono.Text,
                Estado = true
            };
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            Paciente objPaciente = GetEntity();
            try
            {
                bool response = PacienteDAO.getInstance().RegistrarPaciente(objPaciente);
                if (response)
                {
                    Response.Write("<script>alert('REGISTRO CORRECTO.')</script>");
                }
                else
                {
                    Response.Write("<script>alert('REGISTRO INCORRECTO.')</script>");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al registrar paciente: " + ex.Message);
                Response.Write("<script>alert('ERROR AL REGISTRAR.')</script>");
            }
        }
    }
}