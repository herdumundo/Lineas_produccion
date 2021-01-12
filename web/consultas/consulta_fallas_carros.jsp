
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%
         String id_carro = request.getParameter("id_carro");
         String nro_carro = request.getParameter("nro_carro");

        Connection cn = conexion.crearConexion();
	fuente.setConexion(cn);
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String filas="";
        String contenedor="";
         ResultSet rs = fuente.obtenerDato("select sum(f.cantidad) as cantidad,f.tipo_falla,f.nro_carro,t.desc_falla "
                    + "from fallas_carros f with(nolock) "
                    + "INNER JOIN tipo t with(nolock) ON f.tipo_falla=t.id_falla "
                    + "where f.id_carrito="+id_carro+" "
                    + " group by  f.tipo_falla,f.nro_carro, t.desc_falla");
         int c=0;
         int tipo=0;
            while (rs.next()){
               filas=filas+"<tr><td>"+rs.getString("cantidad") +"</td><td>"+rs.getString("desc_falla") +"</td></tr>";
            c++; 
            }
           
            if (c>0){
                
                   contenedor="<table data-row-style='rowStyle' data-toggle='table' class='table'data-click-to-select='true'> "
                +           "<thead> "
                +           "<tr> "
                +           "<th>Cantidad</th> "
                +           "<th>Tipo</th> "
                +           "</tr> "
                +           "</thead> "
                +           "<tbody> "
                +           ""+filas+" </tbody> </table> "; 
                 tipo=1;
            }
    
            else {
                
           contenedor=" <div class='alert alert-warning alert-dismissible fade show' role='alert'> SIN DESECHOS PARA EL CARRO NRO."+nro_carro+" </div>  ";
           tipo=0;
           
            
            }
            
        ob.put("contenido",contenedor);
        ob.put("tipo",tipo);
        out.print(ob);
       %>
       
       
       
