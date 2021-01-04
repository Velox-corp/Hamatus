/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MTablones.Clases;

import ClasesSoporte.Conexion;
import MTablones.Clases.Anuncio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
                p.setId(rs.getInt(1));
                p.setTitulo(rs.getString(2));
                p.setDescripcion(rs.getString(3));
                p.setFecha(rs.getString(5));
                anuncios.add(p);
            }
        } catch (Exception e) {

        }
        return anuncios;
    }
    
        public Anuncio listarTipo(int id) {
        String sql = "Select * from tablon where Id_division=" + id;
        Anuncio p = new Anuncio();
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                p.setId(rs.getInt(1));
                p.setTitulo(rs.getString(2));
                p.setDescripcion(rs.getString(3));
                p.setFecha(rs.getString(5));
            }
        } catch (Exception e) {

        }
        return p;
    }

    public List listar() {
        List<Anuncio> anuncios = new ArrayList();
        String sql = "Select * from tablon;";
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Anuncio p = new Anuncio();
                p.setId(rs.getInt(1));
                p.setTitulo(rs.getString(2));
                p.setDescripcion(rs.getString(3));
                p.setFecha(rs.getString(5));
                anuncios.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return anuncios;
    }
    
    public void delete(int id) {
        String sql = "delete from tablon where ID_Tablon=" + id;
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void agregar(Anuncio anuncio) {
        String sql = "insert into tablon(`Titulo_Anuncio`, `Contenido`,`fecha_publicacion`, Id_division) values (?,?,?,?)" ;
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, anuncio.getTitulo());
            ps.setString(2, anuncio.getDescripcion());
            ps.setString(3, anuncio.getFecha());
            ps.setInt(4,anuncio.getIdDivision());
            ps.executeUpdate();
            
        } catch (Exception e) {
        }
    }
    
        public void actualizar(int id, Anuncio anuncio) {
        String sql = "update tablon set Titulo_Anuncio=?, Contenido=?, fecha_publicacion=? where ID_Tablon="+id;
        
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, anuncio.getTitulo());
            ps.setString(2, anuncio.getDescripcion());
            ps.setString(3, anuncio.getFecha());
            ps.executeUpdate();
        } catch (Exception e) {
            
        }
        
    }
    
    
}
