
<%@page import="java.util.List"%>
<%@page import="modelo.Compra"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

        <%@include file="Componentes.jsp" %>
        <title>Mi Carrito</title>
    </head>
    <body>

        <%@include file="Cabecera.jsp" %>

        <main>
            <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 my-4 mx-auto text-center">
                <h1 class="display-4 mt-4">Mi Carrito</h1>
            </div>

            <div class="container">
                <%                    HttpSession sesion = request.getSession();
                    List<Compra> lista = (List<Compra>) sesion.getAttribute("carrito");
                    int valor = 0;

                    if (sesion.getAttribute("cliente") != null) {
                        valor = 1;

                    }
                %>
                <a href="javascript:ProcesarCompra(<%=valor%>)" class="btn btn-success">Procesar Compra</a><br><br>


                <table class="table table-bordered">
                    <tr>
                        <td>#</td>
                        <td>Imagen</td>
                        <td>Producto</td>
                        <td>Precio</td>
                        <td>Cantidad</td>
                        <td>Total</td>
                        <td>Quitar</td>
                    </tr>
                    <%
                        int contador = 0;
                        double impTotal = 0;
                        for (Compra c : lista) {
                    %>
                    <tr>
                        <td><%=contador + 1%></td>
                        <td>
                            <img src="img/<%=c.getImagen()%>" width="60" height="60">
                        </td>
                        <td><%=c.getNombre()%></td>
                        <td><%=c.getPrecio()%></td>
                        <td><%=c.getCantidad()%></td>
                        <td><%=Math.round(c.Total() * 100) / 100.00%></td>
                        <td>
                            <a  href="javascript:Confirmar(<%=contador%>)" class="btn btn-danger">Quitar</a>
                        </td>
                    </tr>

                    <%
                            contador++;
                            impTotal += c.Total();
                        }

                        if (lista.size() == 0) {
                            out.print("<td colspan='7' class='text-center'>Carrito Vacio.!!</td>");

                        } else {
                            out.print("<td colspan='5' class='text-right'>Importe Total<td colspan='2'><strong>" + Math.round(impTotal * 100) / 100.00);
                        }
                    %>
                </table>
            </div>
        </main>
    </body>
    <script>
        function ProcesarCompra(valor) {
            var cuenta = <%=contador%>

            if (cuenta === 0) {
                MensajeError("No se puede procesar compra el carrito se encuentra vacio.!!");
            } else {
                if (valor === 0) {
                    window.location.href = "Login.jsp";
                } else {
                    window.location.href = "ControlCarrito?accion=ProcesarCompra";
                }
            }
        }

        function Confirmar(contador) {
            swal({
                title: 'Confirmar',
                text: '¿Esta seguro que desea eliminar?',
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Si, deseo eliminar',
                cancelButtonText: 'Cancelar'
            }).then(function () {
                window.location.href = "ControlCarrito?accion=AnularProducto&fila=" + contador;
            })

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