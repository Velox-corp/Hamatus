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
    private static final String clavePrueba= "gurmnhorgvmeigdv";
    public AES(){
        
    }
    
     public static byte[] cifrar(String msj){
        byte cifrado[] = null;
         try {
            //conexión bd
            cifrador = Cipher.getInstance("AES");
            
            SecretKeySpec key = new SecretKeySpec(clavePrueba.getBytes(), "AES");
            
            cifrador.init(Cipher.ENCRYPT_MODE,key);
            
            
            cifrado = cifrador.doFinal(msj.getBytes());
             System.out.println(cifrado);
            //no se si tendría que luego tednría que convertir a String el cifrado
            
            //System.out.println("Encripacion finalizada de AES");
        } catch (InvalidKeyException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        } catch (BadPaddingException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalBlockSizeException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cifrado;
    }
     
    public static String descifrar(byte[] descifrado){
        String valor_descfirado = "";
        try {
            System.out.println(descifrado);
            cifrador = Cipher.getInstance("AES");
            SecretKeySpec key = new SecretKeySpec(clavePrueba.getBytes(), "AES");
            
            cifrador.init(Cipher.DECRYPT_MODE, key);
            
            valor_descfirado = new String (cifrador.doFinal(descifrado));
            
            //System.out.println("Desencriptación finalizada de AES");
        } catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(AES.class.getName()).log(Level.SEVERE, null, ex);
        }
        return valor_descfirado;
    }


}
