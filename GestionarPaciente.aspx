<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GestionarPaciente.aspx.cs" Inherits="CapaPresentacion.frmGestionarPaciente" ClientIDMode="Static" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentBody" runat="server">
    <section class="content-header" >
        <h1 style="text-align:center">REGISTRO DE PACIENTES</h1>
    </section>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtNroDocumento">DOCUMENTO DE IDENTIDAD:</label>
                                <asp:TextBox ID="txtNroDocumento" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNroDocumento" runat="server" ControlToValidate="txtNroDocumento" ErrorMessage="El documento de identidad es obligatorio." CssClass="text-danger" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label for="txtNombres">NOMBRES:</label>
                                <asp:TextBox ID="txtNombres" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombres" runat="server" ControlToValidate="txtNombres" ErrorMessage="El nombre es obligatorio." CssClass="text-danger" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label for="txtApPaterno">APELLIDO PATERNO:</label>
                                <asp:TextBox ID="txtApPaterno" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvApPaterno" runat="server" ControlToValidate="txtApPaterno" ErrorMessage="El apellido paterno es obligatorio." CssClass="text-danger" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label for="txtApMaterno">APELLIDO MATERNO:</label>
                                <asp:TextBox ID="txtApMaterno" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvApMaterno" runat="server" ControlToValidate="txtApMaterno" ErrorMessage="El apellido materno es obligatorio." CssClass="text-danger" Display="Dynamic" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                     <div class="box box-primary">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="ddlSexo">SEXO:</label>
                            </div>
                             <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-control">
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" InitialValue="" ErrorMessage="El sexo es obligatorio." CssClass="text-danger" Display="Dynamic" />

                            <div class="form-group">
                                <label>EDAD:</label>
                             </div>
                            <div class="form-group">
                                <label for="txtEdad">EDAD:</label>
                                <asp:TextBox ID="txtEdad" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEdad" runat="server" ControlToValidate="txtEdad" ErrorMessage="La edad es obligatoria." CssClass="text-danger" Display="Dynamic" />
                                <asp:RangeValidator ID="rvEdad" runat="server" ControlToValidate="txtEdad" MinimumValue="0" MaximumValue="120" Type="Integer" ErrorMessage="La edad debe estar entre 0 y 120." CssClass="text-danger" Display="Dynamic" />
                            </div>
                           
                             <div class="form-group">
                                 <label for="txtTelefono">TELÉFONO:</label>
                                 <asp:TextBox ID="txtTelefono" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono es obligatorio." CssClass="text-danger" Display="Dynamic" />
                             </div>
                             <div class="form-group">
                                 <label for="txtDireccion">DIRECCIÓN:</label>
                                 <asp:TextBox ID="txtDireccion" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvDireccion" runat="server" ControlToValidate="txtDireccion" ErrorMessage="La dirección es obligatoria." CssClass="text-danger" Display="Dynamic" />
                             </div>
                        </div>
                      </div>
                    </div>
                </div>   
       
            <div align="center"  >
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnRegistrar" runat="server" CssClass="btn btn-primary" Text="Registrar" Width="200px" OnClick="btnRegistrar_Click"/>
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
        <br />
        <!--TABLA DE DATOS-->
         <div class="row">
             <div class="col-md-12">
                 <div class="box box-primary">
                     <div class="box-header">
                         <h3 class="box-title">Lista de Pacientes</h3>
                     </div>
                     <div class="box-body table-responsive">
                         <table id="tbl_pacientes" class="table table-bordered table-hover text-center"> 
                             <thead>
                                 <tr>
                                     <th>Código</th>
                                     <th>Nombres</th>
                                     <th>Apellidos</th>
                                     <th>Sexo</th>
                                     <th>Edad</th>
                                     <th>Direccion</th>
                                     <th>Acciones</th>
                                 </tr>
                             </thead>
                             <tbody id="tbl_body_table">
                                 <!--DATA POR MEDIO DE AJAX-->
                             </tbody>
                         </table>
                     </div>
                            
                </div>
            </div>
        </div>
      <!--END DATATABLE-->
    </section>
    <!--MODAL PARA ACTUALIZAR PACIENTE-->
    <div class="modal fade" id="imodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Actualizar registro</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>NOMBRES Y APELLIDOS</label>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtFullName" runat="server" Text="" CssClass="form-control" Enabled="false"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>DIRECCIÓN</label>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtModalDireccion" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnactualizar">Actualizar</button>
            </div>
        </div>
    </div>
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="js/paciente.js" type="text/javascript">
    
    </script>
</asp:Content>


