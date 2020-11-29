/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesSoporte;

import java.sql.Connection;
import java.sql.DriverManager;

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
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String user = "root";
            String password = "n0m3l0";
            String url = "jdbc:mysql://localhost:3306/shiee";
            con =DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException ex) {
            System.out.println("Falló la conexión");
        }finally{
            return con;
        }
    }
}
