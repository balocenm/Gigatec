<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/FormEstilo.css" rel="stylesheet" type="text/css"/>
        <%@include file="Componentes.jsp" %>
        <title>Registro</title>
    </head>
    <body>

        <%@include file="Cabecera.jsp" %>
        <main>

            <div class="container">
                <br><br>
                <div class="abs-center">

                    <div class="col-md-12 login-form-1">

                        <h3>Nuevo Regsitro</h3><br>

                        <%
                            if (request.getAttribute("respuesta") != null) {
                                String res = request.getAttribute("respuesta").toString();
                                String correo = request.getAttribute("correo").toString();

                                if (res.equals("0")) {
                        %>
                        <div class="alert alert-danger" role="alert">
                            No se ha podido procesar el registro del cliente.El correo <%=correo%> no se encuentra disponible , o algunos datos fueron incorrectos al momento de procesar la informacion.
                        </div>
                        <%
                        } else {
                        %>
                        <div class="alert alert-success" role="alert">
                            Los datos se han registrado correctamente.Recuerde que para ingresar a nuestra aplicacion debe ingresar el correo  <%=correo%> y con su contraseña que ha registrado al momento de procesar la informacion.

                        </div>
                        <%
                                }
                            }
                        %>
                        <form method="post" action="ControlCliente">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label>Nombres</label>
                                    <input type="text" class="form-control" id="nombres" name="nombres" placeholder="Nombres Completos" required="" maxlength="40">
                                </div>
                                <div class="form-group col-md-6">
                                    <label >Apellidos</label>
                                    <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos Completos" required="" maxlength="50">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label>Direccion</label>
                                    <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Ingrese su direccion" required="" maxlength="80">
                                </div>
                                <div class="form-group col-md-6">
                                    <label >Fecha Nacimiento</label>
                                    <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento"  required="">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label>DNI</label>
                                    <input type="number" class="form-control" id="dni" name="dni" placeholder="Ingrese su nro de DNI" required="" onKeyPress="if(this.value.length===8) return false;">
                                </div>
                                <div class="form-group col-md-6">
                                    <label >Telefono y/o Celular</label>
                                    <input type="number" class="form-control" id="telefono" name="telefono"  placeholder="Ingrese su numero de telefono o celular" required="" onKeyPress="if(this.value.length===9) return false;">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label>Correo Electronico</label>
                                    <input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese su correo electronico" required="" maxlength="40">
                                </div>
                                <div class="form-group col-md-6">
                                    <label >Contraseña</label>
                                    <input type="password" class="form-control" id="pass" name="pass"  placeholder="Ingrese su contraseña" required="" maxlength="40">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <input type="hidden" name="accion" value="registrarCliente">
                                    <input type="submit" value="Registrarse" class="btn btn-primary" style="background-color: #0062cc;">
                                    <input type="reset" value="Cancelar" class="btn btn-danger">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </body>

</html>