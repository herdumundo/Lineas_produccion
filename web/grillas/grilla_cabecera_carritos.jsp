
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
         
         
        <th style="background-color:green"><font color="black"><b>A</b></font></th>
            <th style="background-color:red"><font color="black"><b>A</b></font></th>
            <th style="background-color:green"><font color="black"><b>B</b></font></th>
            <th style="background-color:red"><font color="black"><b>B</b></font></th>
            <th style="background-color:green"><font color="black"><b>C</b></font></th>
            <th style="background-color:red"><font color="black"><b>C</b></font></th>
            <th style="background-color:green"><font color="black"><b>4TA</b></font></th>
            <th style="background-color:red"><font color="black"><b>4TA</b></font></th>
                   <th style="background-color:green"><font color="black"><b>J</b></font></th>
            <th style="background-color:red"><font color="black"><b>J</b></font></th>      
                       <th style="background-color:green"><font color="black"><b>G</b></font></th>
            <th style="background-color:red"><font color="black"><b>G</b></font></th>
                        <th style="background-color:green"><font color="black"><b>S</b></font></th>
            <th style="background-color:red"><font color="black"><b>S</b></font></th>
                      
                          
   
    </tr> 
   
   <%
      
      
      
    ResultSet liberados = fuente.obtenerDato("          exec [mae_cch_select_ptc_total_carros_por_tipos_liberados] @clasificadora='"+area+"' , @fecha='"+calendario+"'");
    ResultSet carros_retenidos = fuente.obtenerDato("	exec [mae_cch_select_ptc_total_carros_por_tipos_retenidos] @clasificadora='"+area+"' , @fecha='"+calendario+"' ");
     if(liberados.next()){
         

   a_liberado=liberados.getString("A") ;    
  b_liberado=liberados.getString("B") ;    
  c_liberado= liberados.getString("C");    
  d_liberado=liberados.getString("D") ;    
  j_liberado= liberados.getString("J");    
  s_liberado=liberados.getString("S") ;    
  g_liberado= liberados.getString("G"); } 



if (carros_retenidos.next()){
    
    
     a_retenido=carros_retenidos.getString("A") ;    
  b_retenido=carros_retenidos.getString("B") ;    
  c_retenido= carros_retenidos.getString("C");    
  d_retenido=carros_retenidos.getString("D") ;    
  j_retenido= carros_retenidos.getString("J");    
  s_retenido=carros_retenidos.getString("S") ;    
  g_retenido= carros_retenidos.getString("G"); } 

    
 
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

  
    
   
    

    