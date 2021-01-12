
 <%@page import="clases.variables"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
 
<% 
    Connection cn = conexion.crearConexion();
    // Asignar conexion al objeto manejador de datos
    fuente.setConexion(cn);
    //Parametros
    String calendario    = request.getParameter("calendario_informe");
    String area = (String) sesionOk.getAttribute("clasificadora");
    String cbox_estado_liberacion =request.getParameter("estado");
    String tipo_huevo ="";
   %>
   
    <table id="example" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>ACCION</th>      
                <th>Fecha clasifi</th>
                <th>Nro. carro</th>
                <th>Tipo</th>
                <th>Categoria</th>
                <th>Fecha puesta </th>
                <th>Hora</th>
                <th>Responsable clasificación</th>
                <th>U.medida</th> 
                <th>Cantidad</th> 
                <th>Aviario</th> 
                <th>Empacadora</th> 
                <th>T.almacenamiento</th>  
                <th>Liberado por</th> 
                <th>Comentario</th> 
                <th>Estado liberación</th> 
                <th>Disposicion</th> 
                <th>Costeo</th> 
            </tr>
        </thead>
 <%
    ResultSet rs = fuente.obtenerDato("  exec [mae_cch_select_ptc_registrados_por_fecha] @clasificadora='"+area+"', @fecha='"+calendario+"',@estado_liberacion='"+cbox_estado_liberacion+"'");
    while(rs.next()){ %>
        <tr>  
            <td><input type="button" value="Editar" class="btn btn-primary" data-toggle="modal" data-target="#modal_obs" onclick="$('#txt_comentario').val('<%=rs.getString("comentario")%>');$('#id_lote').val('<%=rs.getString("cod_lote")%>');$('#txt_liberado').val('<%=rs.getString("liberado_por")%>');"></td>
            <td><b><%=rs.getString("fecha")%></b>    </td>
            <td><b><%=rs.getString("cod_carrito")%>    </b></td>
            <td><b><%=rs.getString("tipo_huevo")%>    </b></td>
            <td><b><%=rs.getString("categoria")%>    </b></td>
            <td><b><%=rs.getString("fecha_puesta")%>    </b></td>
            <td><b><%=rs.getString("hora_clasificacion")%>    </b></td>
            <td><b><%=rs.getString("resp_clasificacion")%>    </b></td>  
            <td><b><%=rs.getString("u_medida")%>    </b></td>  
            <td><b><%=rs.getString("cantidad")%>   </b></td>  
            <td><b><%=rs.getString("aviario")%>   </b></td>  
            <td><b><%=rs.getString("empacadora")%>   </b></td> 
            <td><b><%=rs.getString("tipo_almacenamiento")%>   </b></td>  
            <td><b><%=rs.getString("liberado_por")%>   </b></td>  
            <td><b><%=rs.getString("comentario")%>   </b></td>  
            <td><b><%=rs.getString("estado_liberacion")%>  </b> </td> 
            <td><b><%=rs.getString("disposicion")%>   </b></td> 
            <td><b><%=rs.getString("estado")%>   </b></td> 
      </tr>
       <% } %>
     
    <tbody id="tbody_id"> 
             
    </tbody>
   
     </table>

   