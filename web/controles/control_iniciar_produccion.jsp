<%-- 
    Document   : CERRARSESION
    Created on : 06/01/2021, 08:08:09 PM
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
    String linea = (String) sesionOk.getAttribute("linea");
    String usuario = (String) sesionOk.getAttribute("usuario");
    String cbox= request.getParameter("cbox_inicio");
    String [] partes= cbox.toString().split("-");
    int nro_prod=Integer.parseInt(partes[0].trim());
    String presentacion= partes[1].trim();
    int tipo_respuesta=0;
    String mensaje="";
        //NOTA: EL TRY CATCH Y LOS COMMITS ESTAN EN EL PROCEDIMIENTO ALMACENADOS.
                CallableStatement  callableStatement=null;   
                    callableStatement = cn.prepareCall("{call [vim_prod_fallas_inicio_produccion](?,?,?,?,?,? )}");
                    callableStatement .setInt(1,   nro_prod );
                    callableStatement .setString(2,   linea );
                    callableStatement .setString(3,   usuario );
                    callableStatement .setString(4,   presentacion );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo_respuesta = callableStatement.getInt("mensaje");
                    mensaje = callableStatement.getString("detalle_mensaje");

                    
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("mensaje",mensaje);
            out.print(ob);  %>  