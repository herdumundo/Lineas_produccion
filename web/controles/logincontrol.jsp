<%-- 
    Document   : CERRARSESION
    Created on : 26/01/2016, 08:08:09 PM
    Author     : HERNAN VELAZQUEZ
--%>
<%@ page session="true" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp"%>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%
  // Crear objeto de conexion al DB
  Connection cn = conexion.crearConexion();
  fuente.setConexion(cn);
    String usu = request.getParameter("usuario") != null?request.getParameter("usuario"): "";
    String cla = request.getParameter("pass") != null?request.getParameter("pass"): "";
   String linea = request.getParameter("linea");

    ResultSet rs = fuente.obtenerDato("select * from usuarios where usuario = '"+usu+"' and password = '"+cla+"' and clasificadora not in ('A','B','O')");
    if(rs.next())
    {
        HttpSession sesionOk = request.getSession();
        sesionOk.setAttribute("usuario",rs.getString("usuario"));
        sesionOk.setAttribute("user_name",rs.getString("nombre"));
        sesionOk.setAttribute("id_usuario",rs.getString("password"));
        sesionOk.setAttribute("clasificadora",rs.getString("clasificadora"));
        sesionOk.setAttribute("linea",linea);
    
        if(rs.getString("rol").equals("A"))
        {
            response.sendRedirect("../menu.jsp"); 
        }   
        else if(rs.getString("rol").equals("U"))
        { 
            response.sendRedirect("../menu.jsp");
        } 
    }
    else
        {   response.sendRedirect("../index.jsp");
        
        }%>