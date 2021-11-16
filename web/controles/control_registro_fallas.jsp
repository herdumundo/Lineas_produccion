<%-- 
    Document   : CERRARSESION
    Created on : 05/01/2021, 08:08:09 PM
    Author     : HERNAN VELAZQUEZ
--%>
<%@page import="org.json.JSONObject"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<%
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    String linea =          (String) sesionOk.getAttribute("linea"); 
    String nro_carro    =   request.getParameter("numero_carro");
    String id_carrito  =    request.getParameter("id_carro");
    String contenido_grilla  =    request.getParameter("contenido");
    int tipo_respuesta=1;
    int tipo=1;
    String mensaje="";
    String[] txt_contenido_grilla_array = contenido_grilla.split(","); 
    String valores_coma="";
    int cantidad=0;
    int tipo_falla=0;
    try {
        for(int i=0; i<txt_contenido_grilla_array.length; i++)
            {
            valores_coma=txt_contenido_grilla_array[i];
            String[] sub_valores_array = valores_coma.split("_");   
            tipo_falla=Integer.parseInt(sub_valores_array[0]);   
            cantidad=Integer.parseInt(sub_valores_array[1]);
            cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                callableStatement = cn.prepareCall("{call vim_prod_fallas_alta(?,?,?,?,?,?,?)}");
                callableStatement .setString(1,  linea );
                callableStatement .setInt(2,  Integer.parseInt(nro_carro.trim()));
                callableStatement .setInt(3,  cantidad);
                callableStatement .setInt(4,  Integer.parseInt(id_carrito));
                callableStatement .setInt(5,  tipo_falla);
                callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                callableStatement.execute();
                tipo_respuesta = callableStatement.getInt("mensaje");
                mensaje = callableStatement.getString("detalle_mensaje");
                tipo=tipo*tipo_respuesta; 
        
                }
                
                if(tipo==0){
                cn.rollback();
                //mensaje="HA OCURRIDO UN ERROR, FAVOR VERIFIQUE DATOS INGRESADOS.";
                }

                else{
               cn.commit();
             //       cn.rollback();
                }


            } catch (Exception e) {
                tipo=0;
                mensaje=e.toString();
                cn.rollback();
            }
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        ob.put("tipo", tipo);
        ob.put("mensaje",mensaje);
        out.print(ob);  %>  