<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="conexion_vimar" class="clases.bdconexion2" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<jsp:useBean id="fuente_vimar" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
<%
    String linea = (String) sesionOk.getAttribute("linea");
    String linea_parte_final=linea.replace("LINEA0", "");
    Connection cn = conexion_vimar.crearConexion();
    // Asignar conexion al objeto manejador de datos
    fuente_vimar.setConexion(cn);    //CAMBIAR BASE DE DATOS   
    ResultSet rs2 = fuente_vimar.obtenerDato("select b.sysnumber, a.whscode, b.itemcode, b.distnumber, b.MnfSerial, "
    + "b.LotNumber,b.InDate,convert(numeric(12,0), a.onhandqty) as quantity,"
    + "c.SL1Code, c.AbsEntry,b.itemName "
    + "from  "
    + "obbq a with(nolock) "
    + "inner join obtn b with(nolock) on a.snbmdabs = b.absentry "
    + "inner join obin c with(nolock) on a.binabs = c.absentry "
    + "where "
    + "a.onhandqty >= 360 and a.whscode = 'CEN002' "
    + "and c.SL1Code='"+linea+"'  "
    + "and b.distnumber collate database_default not in (select cod_lote from GrupoMaehara.dbo.carros_asignados v with(nolock) where estado in ('A','C','F') "
    + "and linea='"+linea+"' and cantidad_actual<>0) ");
              

%>
 
        <div class="input-group">
            <input type="button" class="form-control btn btn-success"  data-toggle="modal" data-target="#modal_inicio_produccion"   value="Iniciar produccion">
            <span class="input-group-addon">-</span>
            <input type="button"  class="form-control btn btn-dark"  data-toggle="modal" data-target="#modal_fin_produccion" value="Finalizar produccion"  >
        </div>
 
<form id="form_asignar_carros"   method="POST"> 
    <br>
    <div id="div_cbox_carro"> 
        SELECCIONE CARRO
        <div id="combo" class="form-group">
            <select  name="cbox_carro"   id="cbox_carro" class="form-control"  multiple="multiple" required >
                     <% while(rs2.next())
                    {          
                %>        
                <option value="<%=rs2.getString(5)%>-<%=rs2.getString(8)%>-<%=rs2.getString(4)%>"><%=rs2.getString(5)%> - <%=rs2.getString(11)%>- Cantidad:<%=rs2.getString(8)%></option>
                <%  }
                %> 
            </select>
        </div>
    </div>
            <input type="submit" class="form-control" value="UTILIZAR CARROS" >
</form>
            
            
            
<form id="form_inicio_produccion"  method="POST">
    <div class="modal fade" id="modal_inicio_produccion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div id="div_cbox_op"> 
                        INICIAR ORDEN DE PRODUCCION
                        <div id="combo" class="form-group">            
                            <select  name="cbox_inicio"   id="cbox_inicio" class="form-control" required>
                                <%
                                    ResultSet rs = fuente_vimar.obtenerDato(" select o.docnum,o.itemcode, right(oi.codebars,3) as codebars from owor o,oitm oi "
                                            + "where  o.itemcode=oi.itemcode and  (convert(varchar,o.duedate,103)=convert(varchar,getdate(),103) or convert(varchar, o.duedate,103)=convert(varchar, dateadd(d, -1, getdate()),103)) "
                                            + "and U_MAQUINA ='L"+linea_parte_final+"' and o.status='R'   and o.docnum not in (select  nro_produccion "
                                            + "from GrupoMaehara.dbo.parada_produccion where linea='"+linea+"'  and estado in ('a','c','p'))  ");
                                    while(rs.next())
                                    {          
                                %>      
                                <option value="<%=rs.getString(1)%>-<%=rs.getString(3)%>"><%=rs.getString(1)%> ||TIPO:<%=rs.getString(2)%> ||  COD. BARRA: <%=rs.getString(3)%></option>
                                <%  }
                                %> 
                            </select>
                        </div>
                    </div> 
                </div>
                            <input type="submit" class=" form-control btn-success" value="Registrar"   >
            </div>
        </div>  
    </div>
</form> 
                            
<form id="form_prod_cierre"  method="POST">
    <div class="modal fade" id="modal_fin_produccion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div id="div_cbox_op"> 
                        FINALIZAR ORDEN DE PRODUCCION
                        <div id="combo" class="form-group">
                            <select  name="cbox_op_fin"   id="cbox_op_fin" class="form-control" required >
                                <%
                                    ResultSet rs3 = fuente_vimar.obtenerDato(" select  nro_produccion,paquete from GrupoMaehara.dbo.parada_produccion where linea='"+linea+"' and estado in ('a')");
                                    
                                    while(rs3.next())
                                    {      
                                %>    
                                <option value="<%=rs3.getString(1)%>"><%=rs3.getString(1)%> ||COD. BARRA:<%=rs3.getString(2)%></option>
                                <%}
                                %> 
                            </select>
                        </div>
                    </div>
                </div>
                            <input type="submit" class="form-control btn-success" value="Registrar"  >
            </div>
        </div>  
    </div>
</form> 