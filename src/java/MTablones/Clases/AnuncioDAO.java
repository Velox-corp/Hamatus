/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MTablones.clases;

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

    public Anuncio buscar(int id) {
        Anuncio p = new Anuncio();
        String sql = "select * from tablon where ID_Tablon=" + id;
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
     
   
    
    public Anuncio listarId(int id) {
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
}
