
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

String a_liberado="0";    
String b_liberado="0";    
String c_liberado="0";    
String d_liberado="0";    
String j_liberado="0";    
String s_liberado="0";    
String g_liberado="0";    

String a_retenido="0";    
String b_retenido="0";    
String c_retenido="0";    
String d_retenido="0";    
String j_retenido="0";    
String s_retenido="0";    
String g_retenido="0"; 
    %>
   
  
           
       
  
    <tr>
         
         
                        <th style="background-color:green"><b>A</b></th>
                        <th style="background-color:red"><b>A</b></th>
                        <th style="background-color:green"><b>B</b></th>
                        <th style="background-color:red"><b>B</b></th>
                        <th style="background-color:green"><b>C</b></th>
                        <th style="background-color:red"><b>C</b></th>
                        <th style="background-color:green"><b>4TA</b></th>
                        <th style="background-color:red"><b>4TA</b></th>
                        <th style="background-color:green"><b>J </b></th>
                        <th style="background-color:red"><b>J </b></th>
                        <th style="background-color:green"><b>G</b></th>
                        <th style="background-color:red"><b>G</b></th>
                        <th style="background-color:green"><b>S</b></th>
                        <th style="background-color:red"><b>S</b></th>
                          
   
    </tr> 
   
   <%
       
        ResultSet cajones_liberados = fuente.obtenerDato("exec [mae_cch_select_cajones_disponibles]  @clasificadora='"+area+"', @fecha='"+calendario+"', @tipo='L'");
       
        
        ResultSet retenidos = fuente.obtenerDato("exec [mae_cch_select_cajones_disponibles]  @clasificadora='"+area+"', @fecha='"+calendario+"', @tipo='R'");
        
     while(cajones_liberados.next() ){
         
         
      
   a_liberado=cajones_liberados.getString("A") ;    
  b_liberado=cajones_liberados.getString("B") ;    
  c_liberado= cajones_liberados.getString("C");    
  d_liberado=cajones_liberados.getString("D") ;    
  j_liberado= cajones_liberados.getString("J");    
  s_liberado=cajones_liberados.getString("S") ;    
  g_liberado= cajones_liberados.getString("G");    
         
     }
     

 while(retenidos.next() ){
     
  a_retenido=retenidos.getString("A") ;    
  b_retenido=retenidos.getString("B") ;    
  c_retenido= retenidos.getString("C");    
  d_retenido=retenidos.getString("D") ;    
  j_retenido= retenidos.getString("J");    
  s_retenido=retenidos.getString("S") ;    
  g_retenido= retenidos.getString("G"); 
     
 }
       
 %>
                        <tr>  
                                 <td><font color="green"> <b><%=a_liberado %></b></font></td>
                        <td><font color="red"><b><%=a_retenido%></b></font></td>
                        <td><font color="green"><b><%=b_liberado%></b></font></td>
                        <td><font color="red"><b><%=b_retenido%></b></font></td>
                        <td ><font color="green"><b><%=c_liberado%></b></font></td>
                        <td><font color="red"><b><%=c_retenido%></b></font></td>
                        <td><font color="green"><b><%=d_liberado%></b></font></td>
                        <td><font color="red"><b><%=d_retenido%></b></font></td>
                         <td><font color="green"><b><%=j_liberado%></b></font></td>
                        <td><font color="red"><b><%=j_retenido%></b></font></td>
                         <td><font color="green"><b><%=g_liberado%></b></font></td>
                        <td><font color="red"><b><%=g_retenido%></b></font></td>
                         <td><font color="green"><b><%=s_liberado%></b></font></td>
                        <td><font color="red"><b><%=s_retenido%></b></font></td>
                        
                        </tr>         

        
    
   
    
    </tbody>
    