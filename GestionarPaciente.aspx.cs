using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using CapaEntidades;
using CapaLogicaNegocio;

namespace CapaPresentacion
{
    public partial class frmGestionarPaciente : System.Web.UI.Page
    {
        public void Page_Load(object sender, EventArgs e)
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
        public Paciente GetEntity()
        {
            Paciente objPaciente = new Paciente();
            objPaciente.IdPaciente = 0;
            objPaciente.Nombres = txtNombres.Text;
            objPaciente.ApPaterno = txtApPaterno.Text;
            objPaciente.ApMaterno = txtApMaterno.Text;

            int edad;
            if (int.TryParse(txtEdad.Text.Trim(), out edad))
            {
                objPaciente.Edad = edad;
            }
            else
            {
                // Mostrar un mensaje de error al usuario
                MessageBox.Show("Por favor, ingrese un número válido para la edad.");
            }
            objPaciente.Sexo = Convert.ToChar(ddlSexo.SelectedValue); 
            objPaciente.NroDocumento = txtNroDocumento.Text;
            objPaciente.Direccion = txtDireccion.Text;
            objPaciente.Telefono = txtTelefono.Text;
            objPaciente.Estado = true;
            objPaciente.Imagen = null;

            return objPaciente;
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            
                //Registro del paciente
                Paciente objPaciente = GetEntity();
                //Enviar a capa logica  de negocio
                bool response = PacienteLN.getInstance().RegistrarPaciente(objPaciente);
                if (response == true)
                {
                    Response.Write("<script>alert('REGISTRO CORRECTO.')</script>");
                }
                else
                {
                    Response.Write("<script>alert('REGISTRO INCORRECTO.')</script>");
                }
            
        }
     }
}