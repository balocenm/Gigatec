package controlador;

import dao.FacturaDAO;
import dao.ProductoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Cliente;
import modelo.Compra;
import modelo.Producto;

public class ControlCarrito extends HttpServlet {

    ProductoDAO prodDao = new ProductoDAO();
    FacturaDAO factDao = new FacturaDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        if (accion.equalsIgnoreCase("MiCarrito")) {
            MiCarrito(request, response);
        }

        if (accion.equalsIgnoreCase("AgregarCarrito")) {
            AgregarCarrito(request, response);
        }
        if (accion.equalsIgnoreCase("AnularProducto")) {
            AnularProducto(request, response);
        }

        if (accion.equalsIgnoreCase("ProcesarCompra")) {
            ProcesarCompra(request, response);
        }

        if (accion.equalsIgnoreCase("AgregarUnidad")) {
            AgregarUnidad(request, response);
        }
    }

    protected void AgregarUnidad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sesion = request.getSession();
        List<Compra> lista = ObtenerListaCarrito(request);

        int codigoProducto = Integer.parseInt(request.getParameter("producto"));

        Producto p = prodDao.DetalleProducto(codigoProducto);
        Compra c = null;

        int posicion = BuscarProducto(lista, codigoProducto);

        if (posicion == -1) {
            c = new Compra();
            c.setCodigo(codigoProducto);
            c.setImagen(p.getImagen());
            c.setNombre(p.getNombre());
            c.setPrecio(p.getPrecio());
            c.setCantidad(1);
            lista.add(c);
        } else {
            c = lista.get(posicion);
            c.setCantidad(c.getCantidad() + 1);

            lista.set(posicion, c);
        }

        sesion.setAttribute("carrito", lista);
        response.sendRedirect("MiCarrito.jsp");
    }

    protected void ProcesarCompra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        List<Compra> lista = ObtenerListaCarrito(request);
        Cliente c = (Cliente) sesion.getAttribute("cliente");
        double total = TotalCarrito(lista);
        int nroFactura = factDao.RegistroCompra(lista, c.getIdCliente(), total);

        if (nroFactura != 0) {
            lista.removeAll(lista); // Eliminar todo el carrito
            sesion.setAttribute("carrito", lista);
        }

        sesion.setAttribute("nroFactura", nroFactura);
        response.sendRedirect("MisPedidos.jsp");
    }

    protected void AgregarCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sesion = request.getSession();
        List<Compra> lista = ObtenerListaCarrito(request);

        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        int codigoProducto = Integer.parseInt(request.getParameter("producto"));

        Producto p = prodDao.DetalleProducto(codigoProducto);
        Compra c = null;

        int posicion = BuscarProducto(lista, codigoProducto);

        if (posicion == -1) {
            c = new Compra();
            c.setCodigo(codigoProducto);
            c.setImagen(p.getImagen());
            c.setNombre(p.getNombre());
            c.setPrecio(p.getPrecio());
            c.setCantidad(cantidad);
            lista.add(c);
        } else {
            c = lista.get(posicion);
            c.setCantidad(c.getCantidad() + cantidad);

            lista.set(posicion, c);
        }

        sesion.setAttribute("carrito", lista);
        response.sendRedirect("MiCarrito.jsp");
    }

    protected void AnularProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int fila = Integer.parseInt(request.getParameter("fila"));
        HttpSession sesion = request.getSession();
        List<Compra> lista = (ArrayList) sesion.getAttribute("carrito");
        lista.remove(fila);

        sesion.setAttribute("carrito", lista);
        response.sendRedirect("MiCarrito.jsp");
    }

    protected void MiCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession sesion = request.getSession();
        List<Compra> lista = ObtenerListaCarrito(request);

        sesion.setAttribute("carrito", lista);
        response.sendRedirect("MiCarrito.jsp");
    }

    public List<Compra> ObtenerListaCarrito(HttpServletRequest request) {
        List<Compra> lista;

        HttpSession sesion = request.getSession();
        if (sesion.getAttribute("carrito") == null) {
            lista = new ArrayList<>();
        } else {
            lista = (ArrayList<Compra>) sesion.getAttribute("carrito");
        }

        return lista;
    }

    public int BuscarProducto(List<Compra> lista, int codigo) {
        for (int i = 0; i < lista.size(); i++) {
            Compra c = lista.get(i);

            if (c.getCodigo() == codigo) {
                return i;
            }
        }

        return -1;
    }

    public double TotalCarrito(List<Compra> lista) {
        double total = 0;
        for (int i = 0; i < lista.size(); i++) {
            Compra c = lista.get(i);

            total += c.Total();
        }

        return total;
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
