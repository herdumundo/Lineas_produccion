  var ruta_contenedores="./contenedores/";
  var ruta_controles="./controles/";
  var ruta_grillas="./grillas/";
  var ruta_consultas="./consultas/";
function ocultar_div_fecha(disposicion) {
    
     $('#div_calendario').val("");
     $('#calendario_registro').val("");
    
    if (disposicion=="7"||disposicion=="6"){
        $('#div_calendario').show();
    }
        else {
            $('#div_calendario').hide();
     }
 }

    function enviar_datos_lotes(tipo_registro)
    {
        var url = ruta_controles+tipo_registro+".jsp";                                      
        $.ajax({                        
           type: "POST",                 
           url: url,                    
           data: $("#formulario").serialize(),
           success: function(data)            
           {
            if(tipo_registro=="control_registro")
                {
                resultado_aviso_registro(data.tipo_respuesta,data.mensaje,'LIBERADO',data.cajones_cargados);
                }
            
            else if (tipo_registro=="control_registro_costeado") 
                {
                resultado_aviso_registro(data.tipo_respuesta,data.mensaje,'LIBERADO_COSTEADO',data.cajones_cargados);
                } 
            else if (tipo_registro=="control_retenidos") 
                {
                resultado_aviso_registro(data.tipo_respuesta,data.mensaje,'RETENIDO',data.cajones_cargados);
                }
            else 
                {
                resultado_aviso_registro(data.tipo_respuesta,data.mensaje,'RETENIDO_COSTEADO',data.cajones_cargados);
                }
            }
                });
      }
    
    
                    
    function enviar_datos_carromesa() {

        $.ajax({
          type: "POST",
          url:  ruta_controles+"control_carro_mesa.jsp",
          data: $("#formulario_carro_mesa").serialize(),
          success: function(data) {
                                     }
        });

       };  
     
    function enviar_datos_carromesa() {

        $.ajax({
          type: "POST",
          url:  ruta_controles+"control_carro_mesa.jsp",
          data: $("#formulario_carro_mesa").serialize(),
          success: function(data) {
         //   $('#contenido_reporte').html(data);
                                    }
        });

       };  
      
    function enviar_datos_correccion() {

        $.ajax({
          type: "POST",
          url:  ruta_controles+"control_correccion.jsp",
          data: $("#formulario_correccion").serialize(),
          success: function(data) {
          $('#mensaje_correccion').html(data);
                                    }
        });

       }; 
  
    function insert(lote,comentario,liberado_por){
              
                $.get( ruta_controles+'control_editar_comentario.jsp',{lote:lote,comentario:comentario,liberado_por:liberado_por},
                function(res){
                    
                     $("#container").html(res);
                   principal_grilla($('#calendario_informe').val(),$('#estado').val());
                });
               
            }
            
            
              function principal_grilla(calendario_informe,estado){
          $.get( ruta_grillas+'grilla_normal.jsp',{calendario_informe:calendario_informe,estado:estado},
                function(res){
                      $("#mi_id").html(res);
                        
                        $('#example').DataTable( {
        "scrollX": true
    } );
                });
                    $('#divid').show();           
                  
                
              
              
              }
                
                function limpiar_datos(){
                    
                    $('#txt_cod_lote').val('');
                    //$('#cantidad_huevos').val('');
                    $('#fecha_involucrada').val('');
                    
                    
                }
                
                
                
                
                 
            function grilla_cajones(){
	 var id_informe = document.getElementById("calendario_informe").value   
         var actualiza_parte = new XMLHttpRequest();
	    actualiza_parte.onreadystatechange = function(){
	    if(this.readyState === 4 && this.status === 200){
	    var response = this.responseText;
            document.getElementById("tabla2").innerHTML=response;  } };
            actualiza_parte.open("GET",  ruta_grillas+"grilla_cabecera.jsp?calendario_informe="+id_informe+"", true);
	    actualiza_parte.send();
         }
         
            function grilla_carritos(){
	 var id_informe = document.getElementById("calendario_informe").value   
         var actualiza_parte = new XMLHttpRequest();
	    actualiza_parte.onreadystatechange = function(){
	    if(this.readyState === 4 && this.status === 200){
	    var response = this.responseText;
            document.getElementById("tabla3").innerHTML=response;  } };
            actualiza_parte.open("GET",  ruta_grillas+"grilla_cabecera_carritos.jsp?calendario_informe="+id_informe+"", true);
	    actualiza_parte.send();
         }
  
         
         
   function grilla_cantidad_liberacion(){
	 var id_informe = document.getElementById("calendario_informe").value ;
          var tipo_huevo =  $("#tipo_huevo").val();  

         var actualiza_parte = new XMLHttpRequest();
	    actualiza_parte.onreadystatechange = function(){
	    if(this.readyState === 4 && this.status === 200){
	    var response = this.responseText;
            document.getElementById("cantidad_rl").innerHTML=response;  } };
            actualiza_parte.open("GET",  ruta_grillas+"grilla_cantidad_rl.jsp?calendario_informe="+id_informe+"&tipo_huevo="+tipo_huevo+"", true);
	    actualiza_parte.send();
         }
         