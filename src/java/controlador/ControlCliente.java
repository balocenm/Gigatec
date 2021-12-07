package controlador;

import dao.ClienteDAO;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Cliente;

public class ControlCliente extends HttpServlet {

    ClienteDAO clienteDao = new ClienteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        if (accion.equalsIgnoreCase("registrarCliente")) {
            RegistrarCliente(request, response);
        }

        if (accion.equalsIgnoreCase("iniciarSesion")) {
            IniciarSesion(request, response);
        }

        if (accion.equalsIgnoreCase("cerrarSesion")) {
            CerrarSesion(request, response);
        }
    }

    protected void CerrarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = request.getSession();

        sesion.setAttribute("cliente", null);
        
        
        request.setAttribute("success", "Sesion cerrada correctamente");
        request.getRequestDispatcher("/Login.jsp").forward(request, response);

    }

    protected void IniciarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = request.getSession();

        String correo = request.getParameter("correo");
        String pass = request.getParameter("pass");

        Cliente c = clienteDao.DatosClientes(correo, pass);
        String pagina = "";

        if (c != null) {
            sesion.setAttribute("cliente", c);
            response.sendRedirect("MiCarrito.jsp");
        } else {
            request.setAttribute("error", "Correo y/o contraseña incorrecto");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }

    protected void RegistrarCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Cliente c = new Cliente();
        c.setNombres(request.getParameter("nombres"));
        c.setApellidos(request.getParameter("apellidos"));
        c.setDireccion(request.getParameter("direccion"));
        c.setFechaNacimiento(request.getParameter("fechaNacimiento"));
        c.setDni(request.getParameter("dni"));
        c.setTelefono(request.getParameter("telefono"));
        c.setCorreo(request.getParameter("correo"));
        c.setPass(request.getParameter("pass"));

        Cliente aux = clienteDao.BuscarPorCorreo(c.getCorreo());

        int res = 0;

        if (aux == null) {
            res = clienteDao.RegistrarCliente(c);
        }

        request.setAttribute("correo", c.getCorreo());
        request.setAttribute("respuesta", res);

        request.getRequestDispatcher("/Registrarse.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
