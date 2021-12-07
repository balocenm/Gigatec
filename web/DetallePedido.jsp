
<%@page import="dao.FacturaDAO"%>
<%@page import="modelo.Factura"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Compra"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

        <%@include file="Componentes.jsp" %>
        <title>Detalle Pedido</title>
    </head>
    <body>

        <%@include file="Cabecera.jsp" %>

        <main>
            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">
                <h3 class="display-4 mt-4">Detalle Pedido</h3>
            </div>

            <div class="container">
                <a href="MisPedidos.jsp" class="btn btn-success">Ir a mis pedidos</a><br><br>
                <table class="table table-bordered">
                    <tr>
                        <th>#</th>
                        <th>Imagen</th>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Total</th>
                    </tr>
                    <%                        FacturaDAO factDao = new FacturaDAO();
                        int nroFactura = Integer.parseInt(request.getParameter("nro"));
                        int contador = 0;
                        double total = 0;
                        List<Compra> lista = factDao.ListaDetallePedido(nroFactura);

                        for (Compra c : lista) {
                            contador++;
                            total+= c.Total();
                    %>
                    <tr>
                        <td><%=contador%></td>
                        <td>
                            <img src="img/<%=c.getImagen()%>" width="60" height="60">
                        </td>
                        <td><%=c.getNombre()%></td>
                        <td><%=c.getPrecio()%></td>
                        <td><%=c.getCantidad()%></td>
                        <td><%=Math.round(c.Total() * 100) / 100.00%></td>
                    </tr>
                    <%

                        }
                    %>
                    <tr>
                        <td colspan="5" class='text-right'>Importe Total</td>
                        <td><%=Math.round(total * 100) / 100.00  %></td>
                    </tr>
                </table>
            </div>
        </main>
    </body>
</html>