package dao;

import conexion.Conexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.Compra;
import modelo.Factura;
import modelo.Producto;

public class FacturaDAO {

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection cn = null;
    CallableStatement cs = null;

    public int RegistroCompra(List<Compra> lista, int codigoCliente, double total) {
        int nroFactura = 0;

        try {
            cn = Conexion.conectar();
            cs = cn.prepareCall("{call SP_GENERAR_FACTURA(?,?)}");
            cs.setInt(1, codigoCliente);
            cs.setDouble(2, total);
            rs = cs.executeQuery();

            if (rs.next()) {
                nroFactura = rs.getInt(1);
            }

            cs = cn.prepareCall("{call SP_GENERAR_DETALLE(?,?,?,?)}");

            for (Compra c : lista) {
                cs.setInt(1, nroFactura);
                cs.setInt(2, c.getCodigo());
                cs.setDouble(3, c.getPrecio());
                cs.setInt(4, c.getCantidad());
                cs.executeUpdate();
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }

                if (cs != null) {
                    cs.close();
                }

            } catch (Exception ex) {
            }
        }

        return nroFactura;
    }

    public ArrayList<Factura> ListaDePedidos(int codigoCliente) {
        ArrayList<Factura> lista = new ArrayList<>();

        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("select NRO_FACTURA , FECHA , TOTAL , ESTADO "
                    + " FROM FACTURA "
                    + " where ID_CLIENTE = ? order by fecha desc");
            ps.setInt(1, codigoCliente);
            rs = ps.executeQuery();

            while (rs.next()) {
                Factura p = new Factura();
                p.setNroFactura(rs.getInt(1));
                p.setFecha(rs.getString(2));
                p.setTotal(rs.getDouble(3));
                p.setEstado(rs.getString(4));
                lista.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }

                if (ps != null) {
                    ps.close();
                }

                if (rs != null) {
                    rs.close();
                }

            } catch (Exception ex) {
            }
        }

        return lista;
    }

    public ArrayList<Compra> ListaDetallePedido(int nroFactura) {
        ArrayList<Compra> lista = new ArrayList<>();

        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("select nom_producto ,imagen , d.precio , cantidad "
                    + " from producto p inner join detalle_factura d on p.id_producto = d.id_producto "
                    + " where nro_factura = ?");
            ps.setInt(1, nroFactura);
            rs = ps.executeQuery();

            while (rs.next()) {
                Compra p = new Compra();
                p.setNombre(rs.getString(1));
                p.setImagen(rs.getString(2));
                p.setPrecio(rs.getDouble(3));
                p.setCantidad(rs.getInt(4));
                lista.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }

                if (ps != null) {
                    ps.close();
                }

                if (rs != null) {
                    rs.close();
                }

            } catch (Exception ex) {
            }
        }

        return lista;
    }
}
