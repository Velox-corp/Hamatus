/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MSeguridad.Clases;

/**
 *
 * @author maste
 */

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Cipher;

import javax.crypto.spec.SecretKeySpec;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import sun.misc.BASE64Encoder;

public class AES implements Serializable{

    private static Cipher cifrador;
    //private static final String clavePrueba= "gurmnhorgvmeigdv";
    
    private static final String[] diccionario_de_claves = new String[]
    {"gurmnhorgvmeigdv", //0 - Empresa
        "vckfnclfmzbcfhmd", // 1 - Division
        "mgjcxkaojfhnvghf", // 2 - Usuario
        "phfujkmnvbhjtfhg", // 3 - Equipo de Trabajo
        "anfjglcxcjsjamvl", // 4 - Documentos
        "sjcnmfoeuahkckdi", // 5 - Anuncios
        "mugzapkchhskmdvj", // 6 - Flujos de trabajo
        "xiqyfmxxpudfkmod", // 7 - Chat (Mensajes)
        "fjaovmhrqgpncuem"};// 8 - Registros de entrada
    
    public AES(){
        
    }
    
    /**
     * Método para cifrar un mensaje
     * @param msj el mensaje a cifrar
     * @param ic el indice de la llave del mensaje
     * @return el mensaje cifrado
     */
    public static byte[] cifrar(String msj, int ic){
        byte cifrado[] = null;
         try {
            //conexión bd
            cifrador = Cipher.getInstance("AES");
            
            SecretKeySpec key = new SecretKeySpec(diccionario_de_claves[ic].getBytes(), "AES");
            
            cifrador.init(Cipher.ENCRYPT_MODE,key);
            
            
            cifrado = cifrador.doFinal(msj.getBytes());
             System.out.println(cifrado);
            //no se si tendría que luego tednría que convertir a String el cifrado
            
            //System.out.println("Encripacion finalizada de AES");
        } catch (InvalidKeyException | BadPaddingException | IllegalBlockSizeException | NoSuchAlgorithmException | NoSuchPaddingException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cifrado;
    }
    
    /**
     * Método par adescifrar un mensaje
     * @param descifrado bytes del texto cifrado
     * @param ic indice de la llave 
     * @return el texto descifrado
     */
    public static String descifrar(byte[] descifrado, int ic){
        String valor_descfirado = "";
        try {
            System.out.println(descifrado);
            cifrador = Cipher.getInstance("AES");
            SecretKeySpec key = new SecretKeySpec(diccionario_de_claves[ic].getBytes(), "AES");
            
            cifrador.init(Cipher.DECRYPT_MODE, key);
            
            valor_descfirado = new String (cifrador.doFinal(descifrado));
            
            //System.out.println("Desencriptación finalizada de AES");
        } catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException | NoSuchAlgorithmException | NoSuchPaddingException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        }
        return valor_descfirado;
    }


}
