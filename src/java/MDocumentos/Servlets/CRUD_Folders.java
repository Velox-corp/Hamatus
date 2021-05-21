/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDocumentos.Servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author taspi
 * 
 * Bueno, esta clase tendra metodos para hacer el crud de las carpetas hare unas
 * pruebas con esta clase y luego la implmentare en el resto del proyecto
 */
public class CRUD_Folders {
    
    private String name;
    
    public CRUD_Folders(){
        
    }
    
    /**
     * Este metodo crea el directorio archivos en caso de que no exista
     */
    public void crearFolderA(HttpServletRequest request) {
        //Creacion del directorio y del achivo
        try {
            String sCarpAct = request.getServletContext().getRealPath("/");
            File dir = new File(sCarpAct +"/archivos");//Primero creamos el directorio
            if (!dir.exists()) {
                dir.mkdirs();
            }            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Este es un metodo que crea un folder en la carpeta /archivos/ y luego le
     * con el atributo dirc le agregara 
     */
    public void crearFolder(String dirc, HttpServletRequest request){
        //Creacion del directorio y del achivo
        try {
            String sCarpAct = request.getRealPath("/archivos/");
            //String sCarpAct = ServletContext.getRealPath("/");
            System.out.println(sCarpAct +"/"+ dirc);
            File dir = new File(sCarpAct +"/"+ dirc);//Primero creamos el directorio
            if (!dir.exists()) {
                dir.mkdirs();
            }            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Este metodo tiene una funcionalidad en especifico
     */
    public void crearPersonalFolder(String name, String dirc,
            HttpServletRequest request){
        try {
            String sCarpAct = request.getRealPath("/archivos/");
            System.out.println(sCarpAct +"/"+ dirc);
            File dir = new File(sCarpAct +"/"+ dirc + "/" + name);//Primero accedemos a tal directorio
            if(!dir.exists()){//Verificamos que exista el directorio
                dir.mkdirs();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**Para borrar el folder con todo y contenidos o vaci
     * @param dirc es donde esta localizado el folder incluido el propio folder
     * @param request
     */
    public void deletePersonalFolder(String dirc,
            HttpServletRequest request){
        try {
            String directory = request.getRealPath("/archivos/") + dirc;
            File f = new File(directory);
            if(f.isDirectory()){           
                if(f.list().length == 0)
                    f.delete();
                else{
                    //Recorre cada archivo de la carpeta para borrarlo
                   for (String temp : f.list()) {
                       File fete = new File(f, temp);
                       //Borrado recursivo
                       deletePersonalFolder(fete);
                   }
                   //Chequea que sea un directorio correcto
                   if(f.list().length==0)
                       f.delete();
                }
            }else{
                //Si es un archivo, lo borra
                f.delete();           
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Para borrar un folder con contenido o solo pero con el argumento File
     */
    public boolean deletePersonalFolder(File file){
        boolean c = true;
        try {
            if(file.isDirectory()){           
                if(file.list().length == 0)
                    //Si el folder esta vacio
                    file.delete();
                else{//Si no lo esta
                    for (String temp : file.list()) {
                        File fete = new File(file, temp);
                        //Borrado recursivo
                        deletePersonalFolder(fete);
                    }
                    if(file.list().length==0)
                    file.delete();
                }
            }else{
                //Si es un archivo lo borra
                file.delete();           
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            c = false;
        }
        return c;
    }
    
    /**
     * Bueno los siguientes metodos se usuaran para copiar una carpeta 
     * y despues borrar su contenido
     * @param sourceLocation
     * @param targetLocation
     */
    public static void copy(File sourceLocation, File targetLocation){
        try {
            if (sourceLocation.isDirectory()) {
                copyDirectory(sourceLocation, targetLocation);
            } else {
                copyFile(sourceLocation, targetLocation);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 
     * @param sSourceLocation
     * @param stargetLocation
     */
    public static void copy(String sSourceLocation, String stargetLocation){   
        try {
            File sourceLocation = new File(sSourceLocation);
            File targetLocation = new File(stargetLocation);

            if (sourceLocation.isDirectory()) { //Es directorio.
                copyDirectory(sourceLocation, targetLocation);
            } else { //Es archivo.
                copyFile(sourceLocation, targetLocation);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private static void copyDirectory(File source, File target){
        try {
            if (!target.exists()) { 
                //No existe directorio destino, lo crea.
                target.mkdir();
            }
            for (String f : source.list()) {
                //Copia archivos de directorio fuente a destino.
                copy(new File(source, f), new File(target, f));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private static void copyFile(File source, File target){
        try (
            InputStream in = new FileInputStream(source);
            OutputStream out = new FileOutputStream(target)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }catch(Exception e){
            System.out.println("OH NO AQUI VAMOS DE NUEVO");
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
