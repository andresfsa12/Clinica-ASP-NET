<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GestionarPaciente.aspx.cs" Inherits="CapaPresentacion.frmGestionarPaciente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header" >
        <h1 style="text-align:center">REGISTRO DE PACIENTES</h1>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                        <div class="box-body">
                        <div class="form-group">
                            <label>DOCUMENTO DE IDENTIDAD:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtNroDocumento" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                        <div class="form-group">
                            <label>NOMBRES:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtNombres" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                        <div class="form-group">
                            <label>APELLIDO PATERNO:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtApellidoPaterno" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                        <div class="form-group">
                            <label>APELLIDO MATERNO:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtApellidoMaterno" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                     </div>
                    </div>
                </div>
            <div class="col-md-6">
             <div class="box box-primary">
                        <div class="box-body">
                        <div class="form-group">
                            <label>EDAD:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtEdad" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                        <div class="form-group">
                            <label>SEXO:</label>
                         </div>
                        <div class="form-group">
                           <asp:DropDownList ID="ddlSexo" runat="server"  CssClass="form-control"></asp:DropDownList>  
                        </div>
                        <div class="form-group">
                            <label>DIRECCION:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtDireccion" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                        <div class="form-group">
                            <label>TELEFONO:</label>
                         </div>
                        <div class="form-group">
                           <asp:TextBox ID="txtTelefono" runat="server" Text="" CssClass="form-control"></asp:TextBox>  
                        </div>
                 </div>
                </div>
                </div>
               
           
        </div>
       
            <div align="center"  >
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnRegistrar" runat="server" CssClass="btn btn-primary" Text="Registrar" Width="200px" />
                        </td>
                        <td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-danger" Text="Cancelar" Width="200px"/>
                        </td>
                    </tr>
                </table>
            </div>
      
    </section>
</asp:Content>
