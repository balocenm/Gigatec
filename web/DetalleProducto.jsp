<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

        <%@include file="Componentes.jsp" %>
        <title>Detalle Producto</title>
    </head>
    <body>

        <%@include file="Cabecera.jsp" %>

        <main>
            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">
                <h1 class="display-4 mt-4">Detalle Producto</h1>
            </div>

            <div class="container" >
                <%                    ProductoDAO prodDao = new ProductoDAO();
                    int id = Integer.parseInt(request.getParameter("id"));
                    Producto p = prodDao.DetalleProducto(id);
                %>
                <div class="row">
                    <div class="col-sm-6">
                        <img src="img/<%=p.getImagen()%>" class="card-img-top">
                    </div>
                    <div class="col-sm-6">
                        <form action="ControlCarrito" name="FrmAgregar">
                            <div class="card mb-4 shadow-sm">
                                <div class="card-header">
                                    <h5 class="my-0 font-weight-bold text-center"><%=p.getNombre()%></h5>
                                </div>
                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Precio S/.</label>
                                                <div class="col-sm-6">
                                                    <label class="form-control"><%=p.getPrecio()%></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Stock Disponible.</label>
                                                <div class="col-sm-6">
                                                    <label class="form-control"><%=p.getStock()%></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label">Cantidad.</label>
                                                <div class="col-sm-6">
                                                    <input type="number" min="1" placeholder="Ingrese cantidad" id="cantidad" name="cantidad" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group row">
                                                <label class="col-sm-4 col-form-label"></label>
                                                <div class="col-sm-6">
                                                    <input type="hidden" name="producto" value="<%=p.getCodigo()%>">
                                                    <input  type="hidden" name="accion" value="AgregarCarrito">
                                                    <%
                                                        if (p.getStock() <= 0) {
                                                    %>
                                                    <a  href="#" class="btn btn-success disabled">No disponible</a>
                                                    <%
                                                    } else {
                                                    %>
                                                    <a  href="javascript:ProcesarDatos()" class="btn btn-success">Comprar</a>        
                                                    <%
                                                        }
                                                    %>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
                <div class="col-sm-12">
                    <h3>Caracteristicas </h3>
                    <hr>
                    <p><%=p.getDescripcion()%></p>
                </div>
            </div>
        </main>

    </body>
    <script>
        function ProcesarDatos() {

            var cantidad = document.getElementById("cantidad").value;
            var stock = <%=p.getStock()%>;

            if (cantidad === "") {
                MensajeError("El campo de la cantidad es requerido");
            } else if (cantidad > stock) {
                MensajeError("Stock no disponible");
            } else {
                FrmAgregar.submit();
            }
        }

        function MensajeError(mensaje) {
            swal({
                title: "¡ERROR!",
                text: mensaje,
                type: "error",
            });
        }
    </script>

</html>