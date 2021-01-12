
 <%@page import="clases.variables"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
 
<%
 Connection cn = conexion.crearConexion();
    fuente.setConexion(cn);
    String area = (String) sesionOk.getAttribute("clasificadora");
    %>
    <form >
   <table id="grilla_lotes_liberacion" class="table table-striped table-bordered" style="width:100%">
                     <thead>
    <tr>                
      
     
            <th>Cod interno</th>
            <th>Fecha clasificacion</th>
            <th>Fecha puesta</th>
            <th>Codigo</th>
            <th>Cantidad</th>
            <th>Tipo huevo </th>
            <th>Estado liberación</th> 
            <th>Disposicion</th> 
            <th>Estado Costeo</th> 
            <th>Accion</th> 
     </tr>
    </thead>
        <%
       ResultSet rs = fuente.obtenerDato("exec [mae_cch_select_lotes_pendientes_liberacion] @area='"+area+"'");
       
     while(rs.next()){
   %>
                <tr id="<%=rs.getString("cod_interno")%>">  
                    <td><b><%=rs.getString("cod_interno")%></b>    </td>
                    <td><b><%=rs.getString(1)%></b>    </td>
                    <td><b><%=rs.getString(2)%>    </b></td>
                    <td><b><%=rs.getString(3)%>    </b></td>
                    <td><b><%=rs.getString(4)%>    </b></td>
                    <td><b><%=rs.getString(5)%>    </b></td>
                    <td><b><%=rs.getString(6)%>    </b></td>
                    <td><b><%=rs.getString(7)%>    </b></td>
                    <td><b><%=rs.getString("tipo")%>    </b></td>
                    <td><input type="button" value="LIBERAR" class="form-control bg-success " onclick="liberar_retenidos_mensaje('<%=rs.getString("cod_Carrito")%>','<%=rs.getString("cod_lote")%>','<%=rs.getString("disposicion")%>','<%=rs.getString("cod_interno")%>','<%=rs.getString("tipo_registro")%>');" ></td>
                </tr>
       <% } %>
 
        <tbody id="tbody_id"> 
             
                 </tbody>
   
     </table>
       
       
  </form>