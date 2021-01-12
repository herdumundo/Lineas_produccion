
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%
         String linea = (String) sesionOk.getAttribute("linea");

        Connection cn = conexion.crearConexion();
	fuente.setConexion(cn);
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contenedor=""; 
            ResultSet rs_nro = fuente.obtenerDato("select * from parada_produccion with(nolock) where linea='"+linea+"' and estado='a' "
            + "and (convert(varchar,fecha,103)=convert(varchar,getdate(),103) or convert(varchar, fecha, 103) ="
            + " convert(varchar, DATEADD(d, -1, getdate()), 103))");
            if (rs_nro.next()){
         
           contenedor="PRODUCCION ACTIVA NRO."+rs_nro.getString("nro_produccion")+ ", CODIGO BARRA:"+ rs_nro.getString("paquete");  
            }
            else {
             contenedor="NO CUENTA CON PRODUCCION ACTIVA";
            }
        ob.put("contenido","<strong><center>"+contenedor+"</center></strong> ");
        out.print(ob);
       %>