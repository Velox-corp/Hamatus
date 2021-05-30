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
     * UnU la conexion con clever cloud ya no va a ser posible
     */
    public static Connection obtenerConexion(){
        Connection con = null;
        String user = "root";//"b91a29fdd9a704";//"uhltze43t3xnfmyw";
        String password = "n0m3l0";//"06b37c4a";//"nomelohamatus";//UTAkwoJYjaUHpVttdWlv";
        String url = "jdbc:mysql://localhost:3306/heroku_9ad0f74b62bb348";//"jdbc:mysql://us-cdbr-east-02.cleardb.com:3306/heroku_9ad0f74b62bb348?characterEncoding=utf8";//"jdbc:mysql://bn0u7lmchdieamnqsf74-mysql.services.clever-cloud.com";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            if (con != null) {
                System.out.println("Conexion a la BD exitosa");
            }else{
                System.out.println("Fallo conexion BD UnU");
            }
        } catch (Exception ex) {
            System.out.println("Falló la conexión");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }finally{
            return con;
        }
    }
}