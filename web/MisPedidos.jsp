
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
        <title>Mis Pedidos</title>
    </head>
    <body>

        <%@include file="Cabecera.jsp" %>

        <main>
            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">
                <h3 class="display-4 mt-4">Mis Pedidos</h3>
            </div>

            <div class="container">
                <%                    int nroFactura = 0;
                    if (request.getSession().getAttribute("nroFactura") != null) {
                        nroFactura = Integer.parseInt(request.getSession().getAttribute("nroFactura").toString());
                        request.getSession().setAttribute("nroFactura", null);

                        if (nroFactura == 0) {
                %>
                <div class="alert alert-danger" role="alert">
                    No se ha podido generar la factura. A ocurrido un error
                </div>

                <%
                } else {
                %>
                <div class="alert alert-success" role="alert">
                    Se ha generado correctamente su pedido, su numero de factura es el #<%=nroFactura%>
                </div>
                <%
                        }
                    }
                %>

                <table class="table table-bordered">
                    <tr>
                        <th># Factura</th>
                        <th>Fecha</th>
                        <th>Importe Total</th>
                        <th>Estado</th>
                        <th>Detalle</th>
                    </tr>
                    <%                        FacturaDAO factDao = new FacturaDAO();

                        List<Factura> lista = factDao.ListaDePedidos(cCliente.getIdCliente());
                        for (Factura f : lista) {
                    %>
                    <tr>
                        <th scope="row"><%=f.getNroFactura()%></th>
                        <td><%=f.getFecha()%></td>
                        <td><%=f.getTotal()%></td>
                        <td><%=f.getEstado()%></td>
                        <td>
                            <a href="DetallePedido.jsp?nro=<%=f.getNroFactura()%>" class="btn btn-success">Ver Detalle</a>
                        </td>
                    </tr>
                    <%
                        }

                        if (lista.size() == 0) {
                            out.print("<td colspan='5' class='text-center'>No se encontraron pedidos realizados.</td>");
                        }
                    %>
                </table>
            </div>
        </main>
    </body>
</html>