/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesSoporte;

import java.util.regex.Pattern;

/**
 *
 * @author maste
 * Esta clase servirá para realizar validaciones por parte del controlador amnera de llamada de metodos
 */



public class Validaciones {
    
    /**
     * @param numeroTest El número a verificar que sea un entero positivo
     * @return El boleano que comprueba que sea un número entero.
     */
    public static boolean esNumeroEntero(int numeroTest){
        boolean esNumeroEntero = true;
        String numeros = "0123456789";
        String numToString = String.valueOf(numeroTest);
        for (int i = 0; i < numToString.length(); i++) {
            boolean bufferNumEntero = true;
            char num = numToString.charAt(i);
            for (int j = 0; j < numeros.length(); j++) {
                char numComp = numeros.charAt(j);
                if(num == numComp){
                    bufferNumEntero = true;
                    break;
                }else{
                    bufferNumEntero = false;
                }
            }
            if(!bufferNumEntero){
                esNumeroEntero = false;
                break;
            }
        }
        return esNumeroEntero;
    }
    
    /**
     * @param numeroTest El número a verificar que sea un entero positivo
     * @param maximo El valor máximo que puede  tener el número a probar.
     * @param minimo El valor Minimo que puede tener el número a probar.
     * @return El boleano que comprueba que sea un número entero y esté dentro del rago especificado.
     */
    public static boolean esNumeroEntero(int numeroTest, int maximo, int minimo){
        
        if(numeroTest < minimo || numeroTest > maximo){
            return false;
        }
        
        boolean esNumeroEntero = true;
        String numeros = "0123456789";
        String numToString = String.valueOf(numeroTest);
        for (int i = 0; i < numToString.length(); i++) {
            boolean bufferNumEntero = true;
            char num = numToString.charAt(i);
            for (int j = 0; j < numeros.length(); j++) {
                char numComp = numeros.charAt(j);
                if(num == numComp){
                    bufferNumEntero = true;
                    break;
                }else{
                    bufferNumEntero = false;
                }
            }
            if(!bufferNumEntero){
                esNumeroEntero = false;
                break;
            }
        }
        return esNumeroEntero;
    }
    
    /**
     * @param stringTest La cadena a comparar de que sean solo letras.
     * @param considerarEspacios Indicar si se quieren considerar los espacios en la comparación o no.
     * @return El boleano que comprueba que sea una cadena.
     */
    public static boolean esString(String stringTest, boolean considerarEspacios){
        boolean esString = true;
        String letras = "abcdefghijklmnñopqrstuvwxyzáéíóú";
        if(considerarEspacios) letras += " ";
        for (int i = 0; i < stringTest.length(); i++) {
            boolean bufferEsString = true;
            char caracter = letras.charAt(i);
            for (int j = 0; j < letras.length(); j++) {
                char caracterComparar = letras.charAt(j);
                if(caracter == caracterComparar){
                    bufferEsString = true;
                    break;
                }else{
                    bufferEsString = false;
                }
                if(!bufferEsString){
                    esString = false;
                    break;
                }
            }
        }
        return esString;
    }
    
    /**
     * @param fecha la fecha a comparar en formato de cadena
     * @return El boleano que comprueba que sea una fecha valida
     */
    public static boolean esFecha(String fecha){ //no me acuerdo como se obtenía
        String []fechadiv =  fecha.split("-");
        int año= Integer.parseInt(fechadiv[0]);
	int mes = Integer.parseInt(fechadiv[1]);
	int dia = Integer.parseInt(fechadiv[2]);
        
        //De que sale sale
        
        if( ( dia>31 && ( mes==1 || mes ==3 || mes==5 || mes==5||mes==7 || mes==8 || mes==10 || mes==12) ) 
		|| (dia >30) && ( mes !=2 && !( mes==1 || mes ==3 || mes==5 || mes==5||mes==7 || mes==8 || mes==10 || mes==12) ) 
		|| (dia >28 && mes==2 && (año % 4 !=0) )
		|| (dia >29 && mes==2 && (año % 4 ==0))){
            return false;
	}
        
        Pattern patronFecha = Pattern.compile("^\\d{4}\\-\\d{1,2}\\-\\d{1,2}$");
        return patronFecha.matcher(fecha).find();
    }
    
}