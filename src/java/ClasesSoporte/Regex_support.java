/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesSoporte;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author taspi
 */
public class Regex_support {
    /**
     * Ok so... basicamente buscare la manera de hacer validaciones dentro del 
     * jsp vaya, este sera para numeros enteros
     * positivos vasicamente
     * @param num
     * @return boolean
     */
    public boolean isInteger(int num){
        Pattern pattern = Pattern.compile("^[0-9.]+$", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(String.valueOf(num));
        boolean matchFound = matcher.find();
        if(matchFound) {
          System.out.println("Match found");
          return true;
        } else {
          System.out.println("Match not found");
          return false;
        }
    }
    /*
    public boolean isString(int num, ){
        Pattern pattern = Pattern.compile("^[0-9.]+$", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(String.valueOf(num));
        boolean matchFound = matcher.find();
        if(matchFound) {
          System.out.println("Match found");
          return true;
        } else {
          System.out.println("Match not found");
          return false;
        }
    }*/
}
