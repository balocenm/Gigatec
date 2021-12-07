<%@page import="modelo.Cliente"%>
<header>
    <div class="container">
        <div class="row align-items-stretch justify-content-between">
            <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
                <img src="img/logo.png"  height="50px"
                     width="50px" href="#" >
                <a class="navbar-brand" href="index.jsp">GigaTec</a>
                
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
                        aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item dropdown">
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link" href="Producto.jsp" >Mis productos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ControlCarrito?accion=MiCarrito">Mi Carrito</a>
                        </li>
                        <%
                            HttpSession sesionCliente = request.getSession();
                            Cliente cCliente = null;
                            if (sesionCliente.getAttribute("cliente") == null) {
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="Login.jsp">Iniciar Sesion</a>
                        </li>
                        <%
                        } else {
                                cCliente = (Cliente) sesionCliente.getAttribute("cliente");
                        %>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Mi Perfil
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="MisPedidos.jsp">Mis Pedidos</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="ControlCliente?accion=cerrarSesion">Cerrar Sesion</a>
                            </div>
                        </li>


                        <%
                            }
                        %>

                    </ul>
                    <%
                        if (cCliente != null) {
                    %>
                    <span class="navbar-text text-white">
                        <%=cCliente.getNombres() + " " + cCliente.getApellidos()%> 
                    </span>

                    <%
                        }
                    %>

                </div>
            </nav>
        </div>
    </div>
</header>