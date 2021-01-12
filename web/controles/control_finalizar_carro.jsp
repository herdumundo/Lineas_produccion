 <%@page import="org.json.JSONObject"%>
<%-- 
    Document   : CERRARSESION
    Created on : 06/01/2021, 08:08:09 PM
    Author     : HERNAN VELAZQUEZ
--%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<%
    Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
      
    int id= Integer.parseInt(request.getParameter("id"));
    int tipo_respuesta=0;
    String mensaje="";
        try {
                
           
                cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                    callableStatement = cn.prepareCall("{call [vim_prod_fallas_finalizar_carro](?,?,? )}");
                    callableStatement .setInt(1,   id );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo_respuesta = callableStatement.getInt("mensaje");
                    mensaje = callableStatement.getString("detalle_mensaje");

                   if(tipo_respuesta==0){
                       cn.rollback();
                   } 

                   else{
                       //cn.rollback();
                       cn.commit();
                   }                    
           
       
                
            } catch (Exception e) {
                cn.rollback();
                mensaje=e.toString();
            }
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("mensaje",mensaje);
            out.print(ob);  %>  