
 <%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
 
<%
        Connection cn = conexion.crearConexion();
	// Asignar conexion al objeto manejador de datos
	fuente.setConexion(cn);
       //Parametros
        String area = (String) sesionOk.getAttribute("clasificadora");
  %>
   
   <table id="example" class="table table-striped table-bordered" style="width:100%">
                     <thead>

    <tr>
                        <th>EMPACADORA</th>      
                        <th>TIPO HUEVO</th>
                        <th>ACCION</th>
                        
    </tr>
    </thead>
        <%
        ResultSet rs = fuente.obtenerDato(" select id,empacadora,replace(tipo_huevo,'D','4TA') as tipo_huevo"
                + " from huevos_empacadoras where estado='A' and clasificadora='"+area+"' order by empacadora  ");
            while(rs.next()){
        %>
            <tr>  
                <td><b><%=rs.getString("empacadora")%>           </b></td>
                <td><b><%=rs.getString("tipo_huevo")%>     </b></td>
                <td><input type="button" value="CERRAR" class="form-control" onclick="cerrar_empacadora(<%=rs.getString("id")%>)"></td>
            </tr>
       <% } %>
     
       
         
        <tbody id="tbody_id"> 
             
                 </tbody>
   
     </table>

   