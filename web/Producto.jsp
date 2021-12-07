<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

        <%@include file="Componentes.jsp" %>
        <title>Productos</title>
    </head>
    <body>

        <%@include file="Cabecera.jsp" %>

        <main>
            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">
                <h1 class="display-4 mt-4">Lista de Productos</h1>
                <hr>
            </div>

            <div class="container" >
                <div class="row">
                    <%                    ProductoDAO prodDao = new ProductoDAO();
                        List<Producto> lista = prodDao.ListaProductos();
                        for (Producto p : lista) {
                    %>

                    <div class="col-sm-4">
                        <div class="card mb-4 text-center" >
                            <div class="card-header">
                                <h5 class="my-0 font-weight-bold" style="font-size: 16px;"><%=p.getNombre()%></h5>
                            </div>
                            <div class="card-body">
                                <img src="img/<%=p.getImagen()%>" width="200" height="200">
                                <h2 class="card-title pricing-card-title precio">S/. <span class=""><%=p.getPrecio()%></span></h2>

                                <a href="DetalleProducto.jsp?id=<%=p.getCodigo()%>" class="btn btn-block btn-success agregar-carrito" >Ver Detalle</a>
                                <%
                                    if (p.getStock() <= 0) {
                                %>
                                <a href="DetalleProducto.jsp?id=<%=p.getCodigo()%>" class="btn btn-block btn-primary disabled "  >No disponible</a>

                                <%
                                } else {
                                %>
                                <a href="ControlCarrito?accion=AgregarUnidad&producto=<%=p.getCodigo()%>" class="btn btn-block btn-primary "  >Agregar al carrito</a>

                                <%
                                    }
                                %>

                            </div>
                        </div>
                    </div>


                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </main>

</body>

</html>