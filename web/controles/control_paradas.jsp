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
    String linea = (String) sesionOk.getAttribute("linea");     
    String usuario = (String) sesionOk.getAttribute("usuario");

    String nro_produccion= request.getParameter("cbox_op");
    String tipo_parada= request.getParameter("tipo_parada");
    String motivo_parada= request.getParameter("txt_motivo");
    
    String [] partes= nro_produccion.toString().split("-");
    int nro_prod=Integer.parseInt(partes[0].trim());
    String presentacion= partes[1].trim();
    int tipo_respuesta=0;
    String mensaje="";
        try {
                
            
            
            if(tipo_parada.equals("INICIO"))
            {
                cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                    callableStatement = cn.prepareCall("{call vim_prod_parada_lineas_inicio(?,?,?,?,?,?,?)}");
                    callableStatement .setString(1,   motivo_parada );
                    callableStatement .setString(2,  usuario);
                    callableStatement .setInt(3,  nro_prod);
                    callableStatement .setString(4,  linea);
                    callableStatement .setString(5,  presentacion);
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
            }
            
            else 
            {
                int nro_prod_fin= Integer.parseInt(request.getParameter("cbox_op_fin")); //SE COLOCA AQUI, PORQUE GENERA CONFLICTO SI EL TIPO DE PARADA ES INICIO.

                cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                callableStatement = cn.prepareCall("{call vim_prod_parada_lineas_fin(?,?,?)}");
                callableStatement .setInt(1,  nro_prod_fin);
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