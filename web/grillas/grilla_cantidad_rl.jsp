
<%@page import="clases.variables"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
 
<% Connection cn = conexion.crearConexion();
	// Asignar conexion al objeto manejador de datos
	fuente.setConexion(cn);
       //Parametros
        String calendario    = request.getParameter("calendario_informe");
        String area = (String) sesionOk.getAttribute("clasificadora");
       
    %>
   
    <tr>
    <th style="background-color:green"><b>LIBERADOS CARROS</b></th>
    <th style="background-color:red"><b>RETENIDOS CARROS</b></th>
    <th style="background-color:green"><b>LIBERADOS CAJONES</b></th>
    <th style="background-color:red"><b>RETENIDOS CAJONES</b></th>
    </tr> 
   
   <%
        
   String consulta_final=  "  exec [mae_cch_select_lotes_retenidos_total_cantidad] @fecha='"+calendario+"',@area='"+area+"'";
     
     
     
     
     
     try {
             
       
     ResultSet rs1 = fuente.obtenerDato(consulta_final);
     while(rs1.next()){
       
 %>
                        <tr>  
                            <td><b><%=rs1.getString(1)%></b></td>
                        <td><b><%=rs1.getString(2)%></b></td>
                         <td><b><%=rs1.getString(3)%></b></td>
                        <td><b><%=rs1.getString(4)%></b></td>
                       
                        </tr>         

       <% }

       
         } catch (Exception e) {
         }%>
    
     
    
    </tbody>
    