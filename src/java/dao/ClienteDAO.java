package dao;

import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import modelo.Cliente;
import modelo.Producto;

public class ClienteDAO {

    PreparedStatement ps = null;
    ResultSet rs = null;
    Connection cn = null;

    public Cliente DatosClientes(String correo, String pass) {
        Cliente c = null;

        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("select * from cliente where correo = ? and pass = ?");
            ps.setString(1, correo);
            ps.setString(2, pass);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Cliente();
                c.setIdCliente(rs.getInt(1));
                c.setDni(rs.getString(2));
                c.setNombres(rs.getString(3));
                c.setApellidos(rs.getString(4));
                c.setDireccion(rs.getString(5));
                c.setFechaNacimiento(rs.getString(6));
                c.setTelefono(rs.getString(7));
                c.setCorreo(rs.getString(8));
                c.setPass(rs.getString(9));

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

        return c;
    }

    public int RegistrarCliente(Cliente c) {
        int res = 0;
        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("insert into cliente values(null , ?,?,?,?,?,?,?,?)");
            ps.setString(1, c.getDni());
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setString(4, c.getDireccion());
            ps.setString(5, c.getFechaNacimiento());
            ps.setString(6, c.getTelefono());
            ps.setString(7, c.getCorreo());
            ps.setString(8, c.getPass());
            res = ps.executeUpdate();

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

        return res;
    }
    
    public Cliente BuscarPorCorreo(String correo) {
        Cliente c = null;

        try {
            cn = Conexion.conectar();
            ps = cn.prepareStatement("select * from cliente where correo = ?");
            ps.setString(1, correo);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Cliente();
                c.setIdCliente(rs.getInt(1));
                c.setDni(rs.getString(2));
                c.setNombres(rs.getString(3));
                c.setApellidos(rs.getString(4));
                c.setDireccion(rs.getString(5));
                c.setFechaNacimiento(rs.getString(6));
                c.setTelefono(rs.getString(7));
                c.setCorreo(rs.getString(8));
                c.setPass(rs.getString(9));

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

        return c;
    }
}
