/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesSoporte;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;

/**
 *
 * @author maste
 */
public class Conexion {
    
    /**
     *
     * @return La conexión a la bd
     */
    public static Connection obtenerConexion(){
        Connection con = null;
        String user = "root";
        String password = "n0m3l0";
        String url = "jdbc:mysql://localhost:3306/hamatus";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            if (con != null) {
                System.out.println("Conexion a la BD exitosa");
            }else{
                System.out.println("Fallo conexion BD UnU");
            }
        } catch (ClassNotFoundException ex) {
            System.out.println("Falló la conexión");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }finally{
            return con;
        }
    }
}
