package MChat.Clases;

import ClasesSoporte.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author roberto
 */
public class UsuarioSala {

    private static Connection con;
    private static String q = "";
    private static PreparedStatement ps;
    private static ResultSet rs;

    private int idsala_user;
    private int idSala_chat;
    private int idUsuario;

    public UsuarioSala(int idsala_user, int idSala_chat, int idUsuario) {
        this.idsala_user = idsala_user;
        this.idSala_chat = idSala_chat;
        this.idUsuario = idUsuario;
    }

    public UsuarioSala() {

    }
    
    private List<Integer> num_salas() {
        q="select idSala_chat from sala_chat;";
        Sala s=new Sala();
        List<Integer> sala_n = new ArrayList();
        try{
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();
            while (rs.next()) {
                sala_n.add(rs.getInt(1));;
            }
        }catch(Exception e){
            e.getMessage();
            e.printStackTrace();
        }
        System.out.println(sala_n);
        return sala_n;
        
    }

    private void insertSalaUser(int id_user) {
        int num_salas=num_salas().get(0);
        System.out.println(num_salas);
        q="insert into e_usuario_sala(id_usuario,id_sala) "
                + "values((Select ID_Usuario_E from usuario_empleado where ID_Usuario_E="+id_user+"),"
                + "(Select idSala_chat from sala_chat where idSala_chat="+num_salas+"));";
        try{
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(q);
            ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
            e.getMessage();
        }finally{
            try {
                con.close();
                ps.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuarioSala.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }
    }

    private void insertSalaContacto(int id_contacto) {
        int num_salas=num_salas().get(0);
        System.out.println(num_salas);
        q="insert into e_usuario_sala(id_usuario,id_sala) "
                + "values((Select ID_Usuario_E from usuario_empleado where ID_Usuario_E="+id_contacto+"),"
                + "(Select idSala_chat from sala_chat where idSala_chat="+num_salas+"));";
        try{
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(q);
            ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
            e.getMessage();
        }finally{
            try {
                ps.close();
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UsuarioSala.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public int existe(int id_user, int id_contacto, int id_sala_tipo) {
        int idsla=0;
        try {

            q = "SELECT IF(\n"
                    + "(Select count(u1.id_sala)\n"
                    + "from e_usuario_sala as u1\n"
                    + "inner join e_usuario_sala u2\n"
                    + "on u1.id_sala=u2.id_sala\n"
                    + "where u1.id_usuario="+id_user+" and u2.id_usuario="+id_contacto+"\n"
                    + ")=0,\n"
                    + "0,\n"
                    + "(Select s1.id_sala\n"
                    + "from e_usuario_sala as s1\n"
                    + "inner join sala_chat as s2\n"
                    + "on s1.id_sala=s2.idSala_chat\n"
                    + "where s1.id_usuario="+id_user+" and s2.id_tipo_sala="+id_sala_tipo+")\n"
                    + ");";
            List<Sala> anuncios = new ArrayList();
            int condicion = 0;
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();

            while (rs.next()) {
                condicion=rs.getInt(1);
            }

            if (condicion == 0) {

                Sala sala = new Sala();
                sala.crearSala(id_sala_tipo);
                insertSalaUser(id_user);
                insertSalaContacto(id_contacto);
                idsla=num_salas().get(0);

            } else if (condicion != 0) {
                idsla=condicion;
            }

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                con.close();
                ps.close();
                rs.close();
            } catch (SQLException | NullPointerException ex) {
                System.out.println(ex);
            }
        }
        System.out.println(idsla);
        return idsla;
    }

    public int getIdsala_user() {
        return idsala_user;
    }

    public void setIdsala_user(int idsala_user) {
        this.idsala_user = idsala_user;
    }

    public int getIdSala_chat() {
        return idSala_chat;
    }

    public void setIdSala_chat(int idSala_chat) {
        this.idSala_chat = idSala_chat;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }



}
