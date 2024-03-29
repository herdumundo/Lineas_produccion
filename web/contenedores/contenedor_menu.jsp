<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="conexion_vimar" class="clases.bdconexion2" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<jsp:useBean id="fuente_vimar" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
    <%    
    String linea = (String) sesionOk.getAttribute("linea");
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn); 
    ResultSet rs2 = fuente.obtenerDato("select nro_produccion,paquete from parada_produccion where linea='"+linea+"' and estado='a'");
    ResultSet rs_parada = fuente.obtenerDato("select *  from vim_motivos where  id_estado=1 and tipo=1");
                                       %>
<html>  
 
    <div class="alert alert-warning alert-dismissible fade show" role="alert" id="div_prod_activa" data-toggle="modal" data-target="#modal_produccion" >
    <strong><center></center></strong> 
    </div>    
  
    <div id="div_grilla">
        
         <div class="spinner"  >
  <div class="rect1"></div>
  <div class="rect2"></div>
  <div class="rect3"></div>
  <div class="rect4"></div>
  <div class="rect5"></div>
</div>
        
    </div>
        
       
               
                <div class="modal fade" id="modal_parada" tabindex="1" role="dialog">
                    <div class="modal-dialog" role="document">
                         <div class="modal-content">
                              
                </div>
                </div> 
                </div>           
        
        <div class="modal fade" id="cuadro1" tabindex="1" role="dialog">
            <input type="hidden" value="" id="cod_carrito" >
            <input type="hidden" value="" id="id_carrito" >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-footer">
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center bg-success"  data-dismiss="modal"  onclick="cuadro_fallas('1',$('#cod_carrito').val(),$('#id_carrito').val())">
                            <i class=""></i>Huevos no comercializables en unidades<br>---Fallas de origen--- 
                        </div> 
                        <br> 
                    </div>
                    <div class="modal-footer " >
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range  text-center bg-success" data-dismiss="modal" onclick="cuadro_fallas('2',$('#cod_carrito').val(),$('#id_carrito').val())"  >
                            Huevos no comercializables en unidades<br>---Sucios--- 
                        </div> 
                    </div>
                    <div class="modal-footer "  data-toggle="modal" data-target="#3">
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center bg-success" data-dismiss="modal" onclick="cuadro_fallas('3',$('#cod_carrito').val(),$('#id_carrito').val())"  >
                            Huevos no comercializables en unidades <br>---Fallas tolerables--- 
                        </div>  
                    </div>  
                    <div class="modal-footer " >
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center bg-success" data-dismiss="modal" onclick="cuadro_fallas('4',$('#cod_carrito').val(),$('#id_carrito').val())"  >
                         --------------------Mermas----------------- <br>--------------Huevos rotos--------------  
                        </div>  
                    </div>   
                </div>
            </div> 
        </div>          
        
   <div class="modal fade" id="modal_produccion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
             
           
  
        </div>
           <div class="modal-footer">
               <input type="button"  data-toggle="modal" data-target="#modal_prod" value="INICIAR PARADA" class="form-control btn-primary" data-dismiss="modal">
               <input type="button"  data-toggle="modal" data-target="#modal_prod_final" value="FINALIZAR PARADA" class="form-control btn-danger" data-dismiss="modal">
                 </div>
                </div>
                </div>
                </div> 
        
        
    
        <form id="formulario_parada_inicial" action="post">
        <div class="modal fade" id="modal_prod" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div id="div_cbox_op"> 
                            INICIAR PARADA
                            <div id="combo" class="form-group">                 
                                <select  name="cbox_op"   id="cbox_op" class="form-control" >
                                    <%   while(rs2.next()){ %>        
                                    <option value="<%=rs2.getString(1)%>-<%=rs2.getString(2)%>"><%=rs2.getString(1)%>|| COD. BARRA: <%=rs2.getString(2)%></option> <%} rs2.close(); %> 
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <select  name="txt_motivo"   id="txt_motivo" class="form-control" required >
                            <option value="" selected > SELECCIONAR MOTIVO DE PARADA</option>
                            <% while(rs_parada.next()){ %>
                            <option value="<%=rs_parada.getString("descripcion")%>"><%=rs_parada.getString("descripcion")%></option><% }  rs_parada.close(); %>
                       </select>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                        <input type="submit" value="Registrar" class="form-control btn-primary">
                    </div>
                </div>
            </div>
        </div>
        <div id="aviso_inicial"></div>
    </form>
     
    <form id="formulario_parada_final"  method="post">
        <div class="modal fade" id="modal_prod_final" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <div id="div_cbox_op"> 
                            FINALIZAR PARADA
                            <div  class="form-group">                 
                                <select  name="combo_op_fin"   id="combo_op_fin" class="form-control" >
                                    <% ResultSet rs3 = fuente.obtenerDato("select nro_produccion,paquete from parada_produccion where linea='"+linea+"' and estado='PA'");
                                    while(rs3.next()){%>          
                                    <option value="<%=rs3.getString(1)%>"><%=rs3.getString(1)%>|| COD. BARRA: <%=rs3.getString(2)%></option><%}%>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                    <input type="button" value="Registrar" class="form-control btn-primary" data-dismiss="modal" onclick="registrar_fin_parada()" >
                    </div>
                </div>
            </div>
        </div>
    </form>
</html>
       