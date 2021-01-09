/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MTablones.Clases;

import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import MTablones.Clases.Anuncio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AnuncioDAO {
    Connection con;
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    int r;

    public List listarId(int id) {
        String sql = "Select * from tablon where ID_Tablon=" + id;
        Anuncio p = new Anuncio();
        List<Anuncio> anuncios = new ArrayList();
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                p.setId(rs.getInt("ID_Tablon"));
                p.setTitulo(AES.descifrar(rs.getBytes("Titulo_Anuncio")));
                p.setDescripcion(AES.descifrar(rs.getBytes("Contenido")));
                p.setFecha(AES.descifrar(rs.getBytes("fecha_publicacion")));
                p.setIdDivision(rs.getInt("Id_division"));
                anuncios.add(p);
            }
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
        }finally{
            try {
                con.close();
                ps.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(AnuncioDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return anuncios;
    }
    
        public List listarTipo(int id) {
        String sql = "Select * from tablon where Id_division=" + id+" ORDER BY fecha_publicacion DESC";
        List<Anuncio> anuncios = new ArrayList();
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Anuncio p = new Anuncio();
                p.setId(rs.getInt("ID_Tablon"));
                p.setTitulo(AES.descifrar(rs.getBytes("Titulo_Anuncio")));
                p.setDescripcion(AES.descifrar(rs.getBytes("Contenido")));
                p.setFecha(AES.descifrar(rs.getBytes("fecha_publicacion")));
                p.setIdDivision(rs.getInt("Id_division"));
                anuncios.add(p);
            }
        } catch (Exception e) {

        }
        return anuncios;
    }

    public List listar(int idE, int idDiv) {
        List<Anuncio> anuncios = new ArrayList();
        String sql = "{call obtenerAnuncios(?, ?)}";
        CallableStatement cs = null;
        try {
            con = Conexion.obtenerConexion();
            cs = con.prepareCall(sql);
            cs.setInt(1, idE);
            cs.setInt(2, idDiv);
            rs = cs.executeQuery();
            while (rs.next()) {
                Anuncio p = new Anuncio();
                p.setId(rs.getInt("ID_Tablon"));
                p.setTitulo(AES.descifrar(rs.getBytes("Titulo_Anuncio")));
                p.setDescripcion(AES.descifrar(rs.getBytes("Contenido")));
                p.setFecha(AES.descifrar(rs.getBytes("fecha_publicacion")));
                p.setVectorTipoTablon(rs.getString(1));
                p.setIdDivision(rs.getInt("Id_division"));
                anuncios.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }finally{
            try {
                con.close();
                cs.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(AnuncioDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return anuncios;
    }
    
    public void delete(int id) {
        String sql = "delete from tablon where ID_Tablon = " + id;
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
        }finally{
            try {
                con.close();
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(AnuncioDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public void agregar(Anuncio anuncio) {
        String sql = "insert into tablon(`Titulo_Anuncio`, `Contenido`,`fecha_publicacion`, Id_division) values (?,?,?,?)" ;
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            
            ps.setBytes(1, AES.cifrar(anuncio.getTitulo()));
            ps.setBytes(2, AES.cifrar(anuncio.getDescripcion()));
            ps.setBytes(3, AES.cifrar(anuncio.getFecha()));
            ps.setInt(4,anuncio.getIdDivision());
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
        }finally{
            try {
                con.close();
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(AnuncioDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
        public void actualizar(int id, Anuncio anuncio) {
        String sql = "update tablon set Titulo_Anuncio=?, Contenido=?, fecha_publicacion=? where ID_Tablon="+id;
        
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            
            ps.setBytes(1, AES.cifrar(anuncio.getTitulo()));
            ps.setBytes(2, AES.cifrar(anuncio.getDescripcion()));
            ps.setBytes(3, AES.cifrar(anuncio.getFecha()));
            ps.executeUpdate();
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
        }
        
    }
    
    
}
