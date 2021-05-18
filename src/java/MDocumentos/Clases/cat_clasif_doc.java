/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Clases;

import ClasesSoporte.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
     * 1-Fav
     * 2-normal
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
    
    /**
     * Consultaremos el estado de un documento con el fin de que podamos 
     * actualizarlo de manera rapida
     * @param ID_doc el id del doc que buscamos
     * @return devoldera el estado del documento si es un favorito o no
     */
    public int query_doc_state(int ID_doc){
        int state = 1;
        try {
            this.con = Conexion.obtenerConexion();
            this.query = "";
            ps = con.prepareCall(query);
            ps.setInt(1, ID_doc);
            ResultSet res = ps.executeQuery();
            while(res.next()){
                System.out.println("Bravo documento encontrado");
                state = res.getInt("id_cat_clasif_doc");
            }
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
        return state;
    }
}
