
package MChat.Servlets;

import MChat.Clases.Message;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ClasesSoporte.Conexion;
import MSeguridad.Clases.AES;
import java.sql.Connection;

public class MessageModel {
    Connection con;
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    
    public ArrayList<Message> get(int idsala, int id_user){
        
        ArrayList<Message> messages = new ArrayList<>();
        
        
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement
            
            //("SELECT idMensaje, contenido, id_usuario, id_sala, DATE_FORMAT(fecha_envio, '%d-%m-%y a las %h:%i:%s %p') as date FROM mensaje where id_sala="+idsala+" ORDER BY fecha_envio ASC LIMIT 100 ");
            ("SELECT idMensaje, "
                    + "contenido, "
                    + "id_usuario,"
                    + "(Select Nombre from usuario_empleado where ID_Usuario_E="+id_user+") as usuarioname,"
                    + " id_sala,"
                    + " DATE_FORMAT(fecha_envio, '%d-%m-%y a las %h:%i:%s %p') as date "
                    + "FROM mensaje where id_sala="+idsala+" ORDER BY fecha_envio ASC LIMIT 100 ;");
            
            rs = ps.executeQuery();
            
            while (rs.next()) {                
                messages.add(new Message(rs.getInt("idMensaje"),AES.descifrar(rs.getBytes("contenido"),7)/*,AES.descifrar(rs.getBytes("usuarioname"),2)*/,rs.getInt("id_usuario"), rs.getInt("id_sala"), rs.getString("date")));
            }
            
            con.close();
            rs.close();
            ps.close();
            
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
        }
        
        return messages;
    }
    
    public boolean create(Message m){
        
        boolean flag = false;
        
        try {
            con = Conexion.obtenerConexion();
            ps = con.prepareStatement
            ("INSERT INTO mensaje "
            + "(contenido, id_usuario, id_sala, fecha_envio) "
            + "VALUES(?,?,?,?)");
            
            ps.setBytes(1, AES.cifrar(m.getMessage(),7));
            ps.setInt(2, m.getId_user());
            ps.setInt(3, m.getSala());
            ps.setString(4, m.getCreated_at());
            
            flag = ps.executeUpdate() == 1;
            
            con.close();
            ps.close();
            
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
            System.out.println(e);
        }
        
        return flag;
        
    }
    
/*    public static void main(String[] args) {
        MessageModel mm = new MessageModel();
        mm.create(new Message("Hola...",1,1,"2017-02-11 7:40:25"));
        
        for (Message m : mm.get()) {
            System.out.println(m.getMessage());
        }
        
    }*/
    
}
