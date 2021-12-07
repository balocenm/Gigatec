<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/FormEstilo.css" rel="stylesheet" type="text/css"/>
        <%@include file="Componentes.jsp" %>
        <title>Login</title>
    </head>
    <body>
        <%@include file="Cabecera.jsp" %>
        <main>

            <div class="container login-container">
                <div class="abs-center">
                    <div class="col-md-6 login-form-1">
                        <h3>Iniciar Sesion</h3>

                        <form action="ControlCliente" method="post">
                            <%                                if (request.getAttribute("error") != null) {
                            %>
                            <div class="alert alert-danger" role="alert">
                                Correo y/o contraseña incorrecto
                            </div>
                            <%
                                }
                            %>

                            <%
                                if (request.getAttribute("success") != null) {
                            %>
                            <div class="alert alert-success" role="alert">
                                Sesion Cerrada correctamente
                            </div>
                            <%
                                }
                            %>

                            <div class="form-group">
                                <label>Correo Electronico</label>
                                <input type="email" class="form-control" name="correo" placeholder="Ingresa tu correo electronico "/>
                            </div>
                            <div class="form-group">
                                <label>Contraseña</label>
                                <input type="password" class="form-control"  name="pass"  placeholder="Ingresa tu contraseña *" value="" />
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="accion" value="iniciarSesion">
                                <input type="submit" class="btnSubmit" value="Iniciar" />
                            </div>
                            <div class="form-group">
                                <p>¿No tienes una cuenta?</p>
                                <a href="Registrarse.jsp" class="ForgetPwd">Registrarse</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </body>

</html>