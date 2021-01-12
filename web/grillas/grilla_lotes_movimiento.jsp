<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page contentType="application/json; charset=utf-8" %>

<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../chequearsesion.jsp" %>
 
                  <%
                      
        JSONObject ob = new JSONObject();
    JSONArray jarray = new JSONArray();
        Connection cn = conexion.crearConexion();
        String hora_desde  = request.getParameter("inicio_retenido");
        String combo_estado=request.getParameter("combo_estado_retenido");
        String hora_fin  = request.getParameter("fin_retenido");
        String calendario=request.getParameter("fecha_retenido");
        String tipo_consulta    = request.getParameter("tipo");
        String clasificadora    = (String) sesionOk.getAttribute("clasificadora");
        String clasificadora_cch    = (String) sesionOk.getAttribute("area_cch");
          fuente.setConexion(cn); 
        try {
        ResultSet rs = fuente.obtenerDato(" exec [mae_cch_select_movimientos_ptc] @clasificadora='"+clasificadora+"',"
                + "@fecha='"+calendario+"',@hora_inicio='"+hora_desde+"',@hora_fin='"+hora_fin+"',@tipo_estado='"+combo_estado+"',"
                        + "@tipo_consulta='"+tipo_consulta+"',@clasificadora_cch='"+clasificadora_cch+"'"); 
       
    //   ResultSet rs = fuente.obtenerDato("exec [select_movimientos_ptc] @clasificadora='A',@clasificadora_cch='CCHA',@fecha='17/12/2020',@hora_inicio='00',@hora_fin='24',@tipo_estado='R',@tipo_consulta='P'");
                                                    // YA CONTIENE M_LOTES  
        
                                                    
         while(rs.next()){
         ob=new JSONObject();

          ob.put("0",  rs.getString("cod_interno"));        
          ob.put("1",  rs.getString("cod_interno"));        
          ob.put("2",  rs.getString("cod_lote"));        
          ob.put("3",  rs.getString("cod_carrito"));        
          ob.put("4",  rs.getString("tipo_huevo"));        
          ob.put("5",  rs.getString("estado_liberacion"));        
          ob.put("6",  rs.getString("tipo"));        
          ob.put("7",  rs.getString("disposicion"));        
          ob.put("8",  rs.getString("tipo_costeo"));        
            jarray.put(ob);        
                  
         }
         
         JSONObject mainObj = new JSONObject();
        mainObj.put("data", jarray);
            out.print(mainObj); 
                 } catch (Exception e) 
                    {
                        
                    }
        
          

                %>   
            