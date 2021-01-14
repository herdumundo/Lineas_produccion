  var ruta_contenedores="./contenedores/";
  var ruta_controles="./controles/";
  var ruta_grillas="./grillas/";
  var ruta_consultas="./consultas/";
  $(document).ready(function(){
     no_volver_atras();
     traer_menu();
  
    });
    function no_volver_atras(){
 
    (function (global) { 

    if(typeof (global) === "undefined") {
        throw new Error("window is undefined");
    }

    var _hash = "!";
    var noBackPlease = function () {
        global.location.href += "#";

        // making sure we have the fruit available for juice (^__^)
        global.setTimeout(function () {
            global.location.href += "!";
        }, 50);
    };

    global.onhashchange = function () {
        if (global.location.hash !== _hash) {
            global.location.hash = _hash;
        }
    };

    global.onload = function () {            
        noBackPlease();

        // disables backspace on page except on input fields and textarea..
        document.body.onkeydown = function (e) {
            var elm = e.target.nodeName.toLowerCase();
            if (e.which === 8 && (elm !== 'input' && elm  !== 'textarea')) {
                e.preventDefault();
            }
            // stopping event bubbling up the DOM tree..
            e.stopPropagation();
        };          
    }; })(window);
} 
         
    function traer_menu()
    {
            $.ajax(
                    {
                        type: "POST",
                        url: ruta_contenedores+'contenedor_menu.jsp',
                        beforeSend: function() 
                        {  
                            $('#div_cargar_menu').show();
                            $('#contenido_reporte').hide();
                            $('#contenido').html('');                            
                            $('#loading').show();
                        },           
                        success: function (res) 
                        {   $('#loading').hide();
                            ir_notificacion();
                            $('#div_cargar_menu').hide();
                            $("#contenido").html(res);
                            $('#contenido').show();
                            $('#table').DataTable( { "language": { "sUrl": "js/Spanish.txt" },scrollY:        "500px",
                            scrollX:        true,"bPaginate": false,
                            "bLengthChange": false, "bInfo": false,}  );
                         $.get(ruta_consultas+'consulta_produccion_activa.jsp',function(res){
                            $("#div_prod_activa").html(res.contenido);
                            
                            } );
                            $('#formulario_parada_inicial').on('submit', function(e){ e.preventDefault(); registrar_parada();});   

                        }       
                    }
                );  
    }
    
    function ir_asignacion()
    {
            $.ajax(
                    {
                        type: "POST",
                        url: ruta_contenedores+'contenedor_asignacion.jsp',
                        beforeSend: function() 
                        {   $('#loading').show();
                            $('#div_cargar_menu').show();
                            $('#contenido').html('');
                         
                        },           
                        success: function (res) 
                        {   $('#loading').hide();
                            ir_notificacion();
                            $('#div_cargar_menu').hide();
                            $("#contenido").html(res);
                            $('#contenido').show();
                             $('#form_asignar_carros').on('submit', function(e){ e.preventDefault(); registrar_asignacion();}); 
                             $('#form_prod_cierre').on('submit', function(e){ e.preventDefault(); finalizar_produccion();}); 
                             $('#form_inicio_produccion').on('submit', function(e){ e.preventDefault(); iniciar_produccion();}); 
                         
                        
                        }       
                    }
                );  
    }
    function cuadro_fallas(tipo,nro_carro,id_carrito){
  
   var tabla='';
   var fillas='';
   
   
    if(tipo=="1"){
    fillas='    <tr>   <td>1</td>   <td>Fisurados                       </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>2</td>   <td>Cascara fragil                  </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>3</td>   <td>Arrugados                       </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>4</td>   <td>Deformados                      </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>5</td>   <td>Grasa                           </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>6</td>   <td>Decolorados y blancos           </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>20</td>  <td>Moho                            </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> ';    
   }
    else if(tipo=="2"){
    fillas='    <tr>   <td>7</td>   <td>Sangre                          </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>8</td>   <td>Materia fecal                   </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>9</td>   <td>Plumas                          </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>10</td>   <td>Manchas de yema                </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>11</td>   <td>Manchas de clara               </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>12</td>   <td>Polvo                          </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> ';    
   }
    else if(tipo=="3"){
    fillas='    <tr>   <td>13</td>   <td>Falta/Error de codificacion    </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>14</td>   <td>Mezclados                      </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>15</td>   <td>Punta para arriba              </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>16</td>   <td>Inclinados                     </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>17</td>   <td>Cartones manchados             </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> \n\
                <tr>   <td>18</td>   <td>Espacio vacio                  </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr> ';  
   }
    else if(tipo=="4"){
    fillas='    <tr>   <td>19</td>   <td>Huevos rotos                   </td>   <td><input min="0"  value="0"   type="number" required  class="select"></td></tr>  ';   
   }
    tabla=' <form id="form_fallas_input"> <div id="aviso_val"></div> \n\
                            <table   class="table" id="grilla_carga">\n\
                                <thead> \n\
                                    <tr> \n\
                                        <th class="fallas1">ID</th>  \n\
                                        <th>Descripcion</th> \n\
                                        <th>Cantidad</th> \n\
                                    </tr> \n\
                                </thead> \n\
                                <tbody> \n\
                                     '+fillas+' \n\
                                </tbody> \n\
                            </table> <input type="submit" class="form-control bg-success" value="REGISTRAR" id="btn_reg">\n\
                        </form>';   
   
        Swal.fire
    (
            {
                title: 'FALLAS CARRO NRO. '+ nro_carro,
                type: 'warning',
                html:  tabla,
                showCancelButton: false,
                showConfirmButton: false
            }
    );
  
    $(".select").click(function ()   { $(this).select(); });
    $('#form_fallas_input').on('submit', function(e){ e.preventDefault(); obtener_datos_grilla(id_carrito,nro_carro); });   
    


}
    
    function seleccionar(){

      return (event.charCode === 8 || event.charCode === 0) ? null : event.charCode >= 48 && event.charCode <= 57;  
    }

    function obtener_datos_grilla(id_carrito,nro_carro){
        
        var contenido="";
        var table = document.getElementById("grilla_carga");  
        var rowLength = table.rows.length;
        var c=0;  
        for(var i=1; i<rowLength;)
        {
        
            var oCells = table.rows.item(i).cells;
            var id_falla = oCells.item(0).innerHTML;
            var cantidad= table.rows[i].cells[2].firstChild.value;// ESTA LINEA LA USO PARA OBTENER EL VALOR DEL INPUT DENTRO DEL TD
       
            if(cantidad>0)
            {
                
                if(c==0)
                {
                    contenido=id_falla +"_"+cantidad;  
                }
                else 
                {
                    contenido=contenido+","+id_falla +"_"+cantidad;
                }
                c++;
            }  
             
        i++;
        }
        if(contenido.length==0)
        {
           $('#aviso_val').html('<div class="alert alert-danger alert-dismissible fade show" role="alert">  <center>FAVOR, DEBE INGRESAR CANTIDAD.</center> \n\
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"> <span aria-hidden="true">&times;</span> </button> </div>');     
        }
        else 
        {
           
           Swal.fire({
            title: 'Registro',
            type: 'warning',
            text: "  Desea registrar los datos ingresados? ",
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'REGISTRAR',
                cancelButtonText: 'CANCELAR'
        }).then((result) => {
            if (result.value) {
      
        $.ajax({
        type: "POST",
         url: ruta_controles+'control_registro_fallas.jsp',
       data: ({ contenido: contenido,id_carro:id_carrito,numero_carro:nro_carro}),
        beforeSend: function () {
            Swal.fire({
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                            .textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });  },
        success: function (data) {
              
              if(data.tipo==1){
                    Swal.fire ( {
                    type: 'success',
                    title:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );  
                    
                            traer_menu();
              }
              
              else {
                  Swal.fire ( {
                    type: 'error',
                    title:'Error, no se ha podido registrar.',
                    html:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );     
              }
              
            }   });
                  }
        });
        }
          
    }
    
    function detalle_fallas(id_carro,nro_carro){
          $.ajax({
        type: "POST",
         url: ruta_consultas+'consulta_fallas_carros.jsp',
       data: ({id_carro:id_carro,nro_carro:nro_carro}),
        beforeSend: function () {
            Swal.fire({
                title: 'CONSULTANDO FALLAS CARGADAS.!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                            .textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });  },
        success: function (data) {
              
                if(data.tipo==1)
      {
       Swal.fire
    (
            {
                title: 'Detalle de desechos carro nro.'+nro_carro,
                type: 'info',
                html:  data.contenido,
                showCancelButton: false,
                showConfirmButton: false
            }
    );     
      }
      
      else {
          
           Swal.fire
    (
            {
                type: 'error',
                html:  data.contenido ,
                showCancelButton: false,
                showConfirmButton: false
            }
    ); 
      }
              
            }   });
    
  
    
}

    function ir_notificacion(){
    
        $.get(ruta_consultas+'consulta_notificacion.jsp',function(res){
            
            if (res.tipo==1){
               $('#notificacion').show();
            }
            else{
                
               $('#notificacion').hide();
            }
        });
 
}
  
    function registrar_parada(){
    $.ajax
    (
        {                        
           type: "POST",                 
           url: ruta_controles+"control_paradas.jsp",                    
           data: ({cbox_op:$('#cbox_op').val(),tipo_parada:'INICIO',txt_motivo:$('#txt_motivo').val()}),
           
            beforeSend: function(){
                 Swal.fire({
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                            .textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });
            },
            
            success: function(data)
           {
               
               if(data.tipo===1){
                 
                $('.modal-backdrop').hide();
                Swal.fire ( {
                    type: 'success',
                    title:data.mensaje,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );
                traer_menu();
                               
               }
               
               else {
                   
                  Swal.fire ( {
                    type: 'error',
                    title:'Error, no se ha podido registrar.'+data.tipo,
                    html:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );  
               }
              
              
           }
        }
    );    
    }
    
    function registrar_fin_parada(){
         $.ajax
    (
        {                        
           type: "POST",                 
           url: ruta_controles+"control_paradas.jsp",                    
           data: ({combo_op_fin:$('#combo_op_fin').val(),tipo_parada:'FIN'}),
           
            beforeSend: function(){
                 Swal.fire({
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });
            },
            
            success: function(data)
           {
               
               if(data.tipo===1){
                 
                $('.modal-backdrop').hide();
                Swal.fire ( {
                    type: 'success',
                    title:data.mensaje,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );
                traer_menu();
                               
               }
               
               else {
                   
                  Swal.fire ( {
                    type: 'error',
                    title:'Error, no se ha podido registrar.'+data.tipo,
                    html:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );  
               }
            }
        }
    );  
    } 
    
    function finalizar_fallas(id,nro_carro){
        
        Swal.fire({
            title: 'Finalizacion',
            type: 'warning',
            text: "  Desea finalizar la carga de desechos para el carro nro. "+nro_carro+"? ",
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'REGISTRAR',
                cancelButtonText: 'CANCELAR'
        }).then((result) => {
            if (result.value) {
      
        $.ajax({
        type: "POST",
         url: ruta_controles+'control_finalizar_carro.jsp',
       data: ({ id: id}),
        beforeSend: function () {
            Swal.fire({
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                            .textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });  },
        success: function (data) {
              
              if(data.tipo==1){
                    Swal.fire ( {
                    type: 'success',
                    title:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );  
                  
                 $('#'+id).fadeOut();
                sleep(1000).then(() => {
                   $('#table').DataTable().row('#'+id).remove().draw( false );
                });   //SLEEP ES UNA FUNCION PARA QUE EJECUTE DESPUES DE UN TIEMPO DETERMINADO. PRIMERO REALIZO EL FADEOUT, LUEGO 2 SEGUNDOS EJECUTA LA ELIMINACION DE LA FILA PERMANENTE.               

              }
              
              else {
                  Swal.fire ( {
                    type: 'error',
                    title:'Error, no se ha podido registrar.',
                    html:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );     
              }
              
            }   });
                  }
        }); 
    }
    
 function sleep (time) {
  return new Promise((resolve) => setTimeout(resolve, time));
}

function registrar_asignacion(){
    
     $.ajax
    (
        {                        
           type: "POST",                 
           url: ruta_controles+'control_asignar_carros.jsp',                    
           data: $("#form_asignar_carros").serialize(),
           success: function(data)            
           {
                if(data.tipo==1)
                {
                Swal.fire ( {
                    type: 'success',
                    title:data.mensaje,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );    
                    traer_menu();
                }
                
                else {
                 Swal.fire ( {
                    type: 'error',
                    html:data.mensaje,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );    
                }
           }
        }
    );
}


function finalizar_produccion (){
    
      $.ajax
    (
        {                        
           type: "POST",                 
           url: ruta_controles+"control_finalizar_produccion.jsp",                    
           data: ({cbox_op_fin:$('#cbox_op_fin').val()}),
           
            beforeSend: function(){
                 Swal.fire({
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });
            },
            
            success: function(data)
           {
               
               if(data.tipo===1){
                 
                $('.modal-backdrop').hide();
                Swal.fire ( {
                    type: 'success',
                    title:data.mensaje,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );
                traer_menu();
                               
               }
               
               else {
                   
                  Swal.fire ( {
                    type: 'error',
                    title:'Error, no se ha podido registrar.'+data.tipo,
                    html:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );  
               }
            }
        }
    );  
}

function iniciar_produccion (){
    
      $.ajax
    (
        {                        
           type: "POST",                 
           url: ruta_controles+"control_iniciar_produccion.jsp",                    
           data: ({cbox_inicio:$('#cbox_inicio').val()}),
           
            beforeSend: function(){
                 Swal.fire({
                title: 'PROCESANDO!',
                html: '<strong>ESPERE</strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                    Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                    }, 1000); }
                        });
            },
            
            success: function(data)
           {
               
               if(data.tipo===1){
                 
                $('.modal-backdrop').hide();
                Swal.fire ( {
                    type: 'success',
                    title:data.mensaje,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );
                traer_menu();
                               
               }
               
               else {
                   
                  Swal.fire ( {
                    type: 'error',
                    title:'Error, no se ha podido registrar.',
                    html:  data.mensaje ,
                    showCancelButton: false,
                    showConfirmButton: false
                    } );  
               }
            }
        }
    );  
}