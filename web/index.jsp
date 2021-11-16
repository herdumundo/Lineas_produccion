<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="estilos/login_estilo.css" rel="stylesheet" type="text/css"/>
<link
  rel="stylesheet" type="text/css"
  href="//cdn.jsdelivr.net/gh/loadingio/ldbutton@v1.0.1/dist/ldbtn.min.css"
/>

<meta name="viewport" content="width=device-width, user-scalable=no">
<div class="wrapper fadeInDown">
  <div id="formContent">
    <div class="fadeIn first">
        <img src="img/Yemita.png" alt=""/>
    </div>
    <form action="controles/logincontrol.jsp">
            <div class="form-group">
        <label class="">Lineas de producción</label>
            <select class="form-control" name="linea">
                <option value="LINEA01">Linea 1</option>
                <option value="LINEA02">Linea 2</option>
                <option value="LINEA03">Linea 3</option>
                <option value="LINEA04">Linea 4</option>
                <option value="LINEA05">Linea 5</option>
                <option value="LINEA06">Linea 6</option>
                <option value="LINEA07">Linea 7</option>
            </select>
          </div>
      <input type="text" id="usuario" class="fadeIn second" name="usuario" placeholder="Ingrese su usuario" required="required">
      <input type="password" id="pass" class="fadeIn fourth" name="pass" placeholder="Ingrese su contraseña" required="required">
       <br><br> <br><br><button   class="btn btn-primary btn-lg  ">INGRESAR</button>
    </form>
  </div>
   
</div>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <div>
  
</div>
<script> 
    
   $(document).ready(function() {
        $('.btn').on('click', function() {
  
       
       if($('#usuario').val()==""||$('#pass').val()==""){
           
       }
       else {
          var $this = $(this);
    var loadingText = '<i class="fa fa-circle-o-notch fa-spin"></i> Ingresando...';
    if ($(this).html() !== loadingText) {
      $this.data('original-text', $(this).html());
      $this.html(loadingText);
    }
    setTimeout(function() {
      $this.html($this.data('original-text'));
    }, 4000);   
       }
       
 
  });
  
  
})
</script>