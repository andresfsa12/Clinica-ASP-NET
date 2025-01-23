﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GestionarHorarioAtencion.aspx.cs" Inherits="CapaPresentacion.GestionarHorarioAtencion" ClientIDMode="Static" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section class="content-header" >
     <h1 style="text-align:center">GESTIONAR HORARIO ATENCIÓN</h1>
 </section>
 <section class="content">
     <div class="row">
         <div class="col-md-2">
             <div class="box box-primary">
                 <div class="box-header">
                     <h3 class="box-title">Datos del Médico</h3>
                 </div>
                 <div class="box-body">
                     <label>Nro. Documento de identidad</label>
                     <div class="input-group input-group-sm">
                         <asp:TextBox ID="txtDni" runat="server" CssClass="form-control"></asp:TextBox>
                         <span class="input-group-btn">
                             <asp:Button ID="btnBuscar" CssClass="btn btn-info btn-flat" runat="server" Text="Buscar" />
                         </span>
                       </div>
                     </div> 
                  <div class="box-footer">
                     <strong>Nombre: </strong>
                     <asp:Label ID="lblNombres" runat="server" Text=""></asp:Label>
                     <br />
                     <br />
                     <strong>Apellidos: </strong>
                     <asp:Label ID="lblApellidos" runat="server" Text=""></asp:Label>
                     <br />
                     <br />
                     <strong>Especialidad: </strong>
                     <asp:Label ID="lblEspecialidad" runat="server" Text=""></asp:Label>
                     <br />
                     <br />
                 </div>
                </div>
            </div>
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header"> 
                    <h3 class="box-title">Horario de Atención</h3>
                </div>
                <div class="box-body table table-responsive">
                     <table id="tbl_horarios" class="table table-bordered table-hover">
                         <thead>
                             <tr>
                                 <th></th>
                                 <th></th>
                                 <th>FECHA DE ATENCIÓN</th>
                                 <th>HORA DE ATENCIÓN</th>
                                 <th style="display: none">ESTADO</th>
                             </tr>
                         </thead>
                         <tbody id="tbl_body_table">
                             <!--DATA POR MEDIO DE AJAX-->
                             <tr>
                                 <td>boton-editar</td>
                                 <td>boton-eliminar</td>
                                 <td>boton-fecha</td>
                                 <td>boton-hora</td>
                                 <td style="display: none">Estado</td>
                             </tr>
                         </tbody>
                     </table>
                 </div>
                <div class="box-footer" style="text-align: center">
                <asp:Button ID="btnAgregarHorario" runat="server" CssClass="btn btn-primary" Text="Agregar Horario" />
                <asp:Button ID="btnGuardarHorario" runat="server" CssClass="btn btn-success" Text="Guarda Horario" />
            </div>
            </div>
       </div>          
                 
             
         </div>
         <div class="col-md-8">

         </div>
      <input type="hidden" id="txtMedico" />
      <input type="hidden" id="txtIdHorario" />
 </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="js/plugins/input-mask/jquery.inputmask.js"></script>
    <script src="js/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="js/plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="js/plugins/timepicker/bootstrap-timepicker.min.js"></script>
    <script src="js/plugins/moment/moment.min.js"></script>
    <script src="js/horariosmedico.js"></script>
</asp:Content>