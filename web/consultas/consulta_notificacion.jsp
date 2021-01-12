 <%@ page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="conexion" class="clases.bdconexion1" scope="page" />
<jsp:useBean id="conexion_vimar" class="clases.bdconexion2" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<jsp:useBean id="fuente2" class="clases.fuentedato" scope="page"/>
 <%@include  file="../chequearsesion.jsp" %>
 <%@page import="org.json.JSONObject"%>
  <% 
 
    String linea = (String) sesionOk.getAttribute("clasificadora");
    JSONObject ob = new JSONObject();
    ob=new JSONObject();  
    int tipo=0;
    Connection cn_vimar = conexion_vimar.crearConexion();
    Connection cn_grupomaehara = conexion.crearConexion();
    fuente.setConexion(cn_vimar);
    fuente2.setConexion(cn_grupomaehara);
     
    char ultimo = linea.charAt(linea.length()-1);
    
    
    
    if(linea.equals("LINEA07")){
        tipo=0 ;
    }
    else {
     int minutos=0;
    String sql_tiempo="";
    String sql="select count(*) as cantidad from owor o with(nolock),oitm oi with(nolock) "
            + "where  o.itemcode=oi.itemcode and "
            + "(convert(varchar,o.duedate,103)=convert(varchar,getdate(),103) "
            + "or convert(varchar, o.duedate,103)=convert(varchar, dateadd(d, -1, getdate()),103)) "
            + "and U_MAQUINA ='L"+ultimo+"' and o.status='R'  and o.docnum not in "
            + "(select  nro_produccion from GrupoMaehara.dbo.parada_produccion with(nolock) where linea='"+linea+"'  and estado in ('a','c','p')) ";
    
    ResultSet consulta_disponibles = fuente.obtenerDato(sql);   
  
    if(consulta_disponibles.next()){
    
        sql_tiempo=" select  DATEDIFF(minute, fecha,  GETDATE()) as tiempo  from parada_produccion with(nolock) where linea='"+linea+"'  and estado in ('a')";
         
        ResultSet consulta_minutos = fuente2.obtenerDato(sql_tiempo);   
        
        while (consulta_minutos.next())
        {
            
            minutos=consulta_minutos.getInt("tiempo");
        }
    
    
    if (minutos>60){
      tipo=1;
    }
    
    else {
        
         tipo=0;
    }
    }
    
    else
    {
          tipo=0;
            
   }   
        
    }
    
        ob.put("tipo", tipo);
        out.print(ob);

%>