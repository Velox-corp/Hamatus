/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Validar el input cuando ocurra un chance drag, drop
 * @param {input} htmlElement
 * El elemento input del DOM a validar, usualmente mandando ingresando un "this"
 * @param {boolean} boolEspacios
 * Ingresar si se consideran espacios en la validación
 * @param {booean} boolPuntuaciones
 * Ingresar si se consideran signos de puntuación en la validación (usualemte para campos de descripción y así
 * @returns {boolean}
 * True si el ingreso es adecuado, false si el ingreso es innadecuado, aparte se manda la alerta.
 */
function validarString(htmlElement, boolEspacios, boolPuntuaciones){
    let string = htmlElement.value;
    let good = false;
    if(!boolEspacios && !boolPuntuaciones){
        let patronBasic = /[A-Za-z0-9áéíóúüâäàêëèïîìôöòûùã]/;
        good = patronBasic.test(string);
    }else if(boolEspacios && !boolPuntuaciones){
        let patronEsp = /[A-Za-z0-9áéíóúüâäàêëèïîìôöòûùã\s]/;
        good = patronEsp.test(string);
    }else if(!boolEspacios && boolPuntuaciones){
        let patronPunt = /[A-Za-z0-9áéíóúüâäàêëèïîìôöòûùã\.\,\:\;]/;
        good = patronPunt.test(string);
    }else if(boolEspacios && boolPuntuaciones){
        let patronFull = /[A-Za-z0-9áéíóúüâäàêëèïîìôöòûùã\s\.\,\:\;]/;
        good =  patronFull.test(string);
    }
    if(!good){
        alert("Ingreso inadecuado");
        htmlElement.focus();
    }
    return good;
}


/**
 * Metodo para validar el input de un correo
 * @param {input} htmlElement
 * El elemento input del DOM a validar, usualmente mandando ingresando un "this"
 * @returns {Boolean}
 * True si el ingreso es adecuado, false si es un ingreso innadecuado, aparte de lanzar la alerta
 */
function validarEmail (htmlElement){
    let email = htmlElement.value;
    let patronemail = /^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$/;
    
    if(!patronemail.test(email)){
        alert("Ingreso inadecuado");
        htmlElement.focus();
    }
    return patronemail.test(email);
}

/**
 * Metodo para validar elinput de una fecha
 * @param {input} htmlElement
 * El elemento input del DOM a validar, usualmente mandando ingresando un "this"
 * @returns {Boolean}
 * True si el ingreso es adecuado, false si es un ingreso innadecuado, aparte de lanzar la alerta
 */
function validarDate (htmlElement){
    let date = htmlElement.value;
    let patronfecha = /^\d{4}\-\d{1,2}\-\d{1,2}$/; //esta no valida que metan 30 de febrero
    if(!patronfecha.test(date)){
        alert("Ingreso inadecuado");
        htmlElement.focus();
    }
    return patronfecha.test(date);
}

/**
 * Metodo para validar elinput de una contraseña
 * @param {input} htmlElement
 * El elemento input del DOM a validar, usualmente mandando ingresando un "this"
 * @returns {Boolean}
 * True si el ingreso es adecuado, false si es un ingreso innadecuado, aparte de lanzar la alerta
 */
function validarPass(htmlElement){
    let pass = htmlElement.value;
    let patron_pass = /[A-Za-z0-9]{8,20}/;
    if(!patron_pass.test(pass)){
        alert("Ingreso inadecuado");
        htmlElement.focus();
    }
    return patron_pass.test(pass);
}
/**
 * Metodo para validar el input de un número entero
 * @param {input} htmlElement
 * El elemento input del DOM a validar, usualmente mandando ingresando un "this"
 * @param {int} max
 * El valor máximo que puede tener el entero
 * @param {int} min
 * El valor minimo que puede tener el entero
 * @returns {Boolean}
 * True si el ingreso es adecuado, false si es un ingreso innadecuado, aparte de lanzar la alerta
 */
function validarNumeroEntero(htmlElement, max, min){
    let int = htmlElement.value;
    if(int <min || int > max){
        alert("Ingreso fuera de los limites");
        htmlElement.focus();
    }
    let patronEntero = /[0-9]/;
    if(!patronEntero.test(int)){
        alert("Ingreso inadecuado");
        htmlElement.focus();
    }
    return patronEntero.test(int);
}
