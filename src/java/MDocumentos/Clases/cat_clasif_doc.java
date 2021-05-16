/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Clases;

import ClasesSoporte.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author tenoria
 * Bueno no quiero hacer mas engorrosa la clase de docs
 */
public class cat_clasif_doc {
    
    private static Connection con = null;
    private String query = "";
    private static PreparedStatement ps = null;
    
    public cat_clasif_doc(){
        
    }
    
    /**
     * Este metodo es un update del doc para lograr clasificar a los docs
     * @param ID_doc
     * @param idcat_class
     * @return clasificacion exitosa
     */
    public boolean classify_docs(int ID_doc, int idcat_class){
        boolean result = false;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = "UPDATE d_documento SET id_cat_clasif_doc=?"
                    + " WHERE ID_Documento=?";
            ps = con.prepareCall(query);
            ps.setInt(1, idcat_class);
            ps.setInt(2, ID_doc);
            result = ps.execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            try {
               this.con.close();
            } catch (Exception e) {
               System.out.println("Mmmm... why?");
                System.out.println(e.getMessage());
            }
        }
        return result;
    }
    
}
