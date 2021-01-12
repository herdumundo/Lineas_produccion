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
    String[] cbox_carro=request.getParameterValues("cbox_carro"); 
    int tipo_respuesta=1;
    int nro_carro=0;
    int cantidad=0;
    int tipo=1;
    String cod_lote="";
    String contenido="";
    String mensaje="";
        try {
                
            for(int i=0; i<cbox_carro.length; i++)
            {

                contenido=cbox_carro[i];
                String[] textElements = contenido.split("-");  

                nro_carro= Integer.parseInt(textElements[0].trim());
                cantidad  = Integer.parseInt(textElements[1].trim());
                cod_lote= textElements[2].trim();
                cn.setAutoCommit(false);
                    CallableStatement  callableStatement=null;   
                    callableStatement = cn.prepareCall("{call [vim_prod_fallas_asignacion_carros](?,?,?,?,?,?,? )}");
                    callableStatement.setString(1, linea );
                    callableStatement.setInt(2,    nro_carro );
                    callableStatement.setInt(3,    cantidad );
                    callableStatement.setString(4, cod_lote );
                    callableStatement.setString(5, usuario );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo    =   callableStatement.getInt("mensaje");
                    mensaje =   callableStatement.getString("detalle_mensaje");
                    tipo_respuesta=tipo_respuesta*tipo;
            }
                   if(tipo_respuesta==0){
                       cn.rollback();
                   } 

                   else{
                          //  cn.rollback();
                    cn.commit();
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