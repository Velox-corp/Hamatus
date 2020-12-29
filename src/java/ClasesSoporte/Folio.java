/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesSoporte;

import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * Clase de soporte para la generación de foliso de documento
 * @author maste
 */
public class Folio {
    
    /**
     * Metodó para generar un folio, tu solo metes datos y el lo genera
     * @param tipoDoc Un char direccionando si el documento es digital (D) o fisico (F)
     * @param tipoAcceso Un char que direcciona si el documento es accesble por el equipo de trabajo (E) o por contraseña (C)
     * @param anno El año de subida deo documento
     * @param mes El mes de subida del documento
     * @param dia El día de subida del documento
     * @param hora La hora de subida del documento
     * @param minutos El minuto de subida del documento
     * @return El folio filtrado a partir de los datos
     */
    public static String generarFolio(char tipoDoc, char tipoAcceso, int anno, int mes, int dia, int hora, int minutos){
        String folio = "";
        folio += String.valueOf(tipoDoc);
        folio += String.valueOf(tipoAcceso);
        String annoOperable = String.valueOf(anno);
        char decada = annoOperable.charAt(2);
        char anio = annoOperable.charAt(annoOperable.length()-1);
        folio += String.valueOf(decada);
        folio += String.valueOf(anio);
        
        folio += llenarCero(mes);
        folio += llenarCero(dia);
        folio += llenarCero(hora);
        folio += llenarCero(minutos);
        return folio;
        
    }
    
    /**
     * metodo para llenar los ceros de ingreos menos a 10
     * @param valorComparar El parametro a verificar
     * @return el número a comparar en formato string, con un cero a la izquiera si el valor es menor a díez
     */
    public static String llenarCero(int valorComparar){
        if(valorComparar <10){
            return "0"+String.valueOf(valorComparar);
        }else{
            return String.valueOf(valorComparar);
        }
    }
}
