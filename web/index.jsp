<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="estilos/login_estilo.css" rel="stylesheet" type="text/css"/>

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
      <input type="submit" class="fadeIn fourth" value="INGRESAR">
    </form>
  </div>
</div>