/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function cambiarEstado(nombreInput){
    let input = document.getElementById(nombreInput);
    try{
        input.readOnly = input.readOnly==false ? true : false;
    }catch (exception) {
        input.readOnly= true;
    } finally {
        return true;
    }
}
