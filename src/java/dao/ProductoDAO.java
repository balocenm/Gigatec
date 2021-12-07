package dao;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Producto;

public class ProductoDAO {
    
    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection cn = null;
    
    public ArrayList<Producto> ListaProductos() {
        ArrayList<Producto> lista = new ArrayList<>();
        
        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("select * from producto");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Producto p = new Producto();
                p.setCodigo(rs.getInt(1));
                p.setNombre(rs.getString(2));
                p.setPrecio(rs.getDouble(3));
                p.setStock(rs.getInt(4));
                p.setImagen(rs.getString(5));
                p.setDescripcion(rs.getString(6));
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
    
    public Producto DetalleProducto(int id) {
        Producto p = null;
        
        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("select * from producto where id_producto = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                p = new Producto();
                p.setCodigo(rs.getInt(1));
                p.setNombre(rs.getString(2));
                p.setPrecio(rs.getDouble(3));
                p.setStock(rs.getInt(4));
                p.setImagen(rs.getString(5));
                p.setDescripcion(rs.getString(6));
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
        
        return p;
    }
    
}
