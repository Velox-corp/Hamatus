package MChat.Clases;

import ClasesSoporte.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Sala {
    
    private static Connection con;
    private static String q = "";
    private static PreparedStatement ps;
    private static ResultSet rs;
    
    private int idSala_chat;
    private int idSala_tipo;
    
    public Sala() {
    }

    public Sala(int idSala_chat, int idSala_tipo) {
        this.idSala_chat = idSala_chat;
        this.idSala_tipo = idSala_tipo;
    }

    public Sala(int idSala_tipo) {
        this.idSala_tipo = idSala_tipo;
    }

    public boolean crearSala(int relSala) {
        boolean proceso_correcto = true;
        System.out.println("Un saludo");
        try {
            con = Conexion.obtenerConexion();
            q = "INSERT INTO sala_chat(id_tipo_sala) values (?)";
            
            ps = con.prepareStatement(q);
            ps.setInt(1, relSala);
            
            if (1 == ps.executeUpdate()) {
                proceso_correcto = true;
            } else {
                System.out.println("No jaló");
            }
        } catch (SQLException ex) {
            
            proceso_correcto = false;
        } finally {
            try {
                con.close();
                ps.close();
                q = "";
            } catch (SQLException ex) {
                
                proceso_correcto = false;
            }
        }
        return proceso_correcto;
    }

    public int getIdSala_chat() {
        return idSala_chat;
    }

    public void setIdSala_chat(int idSala_chat) {
        this.idSala_chat = idSala_chat;
    }

    public int getIdSala_tipo() {
        return idSala_tipo;
    }

    public void setIdSala_tipo(int idSala_tipo) {
        this.idSala_tipo = idSala_tipo;
    }

}
