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
        alert("Ingrese correctamente el correo eléctronico");
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
        alert("Ingrese correctamente la fecha");
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
        alert("Ingrese correctamente la contraseña");
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

function validar(){
    var nombre,apellido,correo,usuario,password,expresion,user,password1;
    nombre=document.getElementById("nombre").value;
    apellido=document.getElementById("apellido").value;
    correo=document.getElementById("correo").value;
    usuario=document.getElementById("usuario").value;
    password=document.getElementById("password").value;
    password=document.getElementById("password1").value;
    user=document.getElementById("user").value;
expresion = /\w+@\w+\.+[a-z]/;

    if(nombre==="" || apellido==="" || correo==="" || usuario==="" || password==="" || user==="" || password1===""){
        alert("Todos los campos son obligatorios");
        return false;
    }else if(nombre.length>45){
        alert("Nombre muy largo");
        return false;
    }else if(apellido.length>45){
        alert("Apellido muy largo");
        return false;
    }else if(correo.length>80){
        alert("Correo muy largo");
        return false;
    }else if(!expresion.test(correo)){
        alert("Correo invalido");
        return false;
    }else if(usuario.length>20){
        alert("Usuario muy largo");
        return false;
    }else if(password.length>20){
        alert("Contraseña muy larga");
        return false;
    }else if(password1.length>20){
        alert("Contraseña muy larga");
        return false;
    }else if(user.length>20){
        alert("Contraseña muy larga");
        return false;
    }
}

//AGREGADO
function valido(registro) {
	
	if (registro.nameEmpresa.value.length >20){
		alert("Escribe como máximo 30 letras en el campo del Nombre de la empresa");
		registro.txtnom.focus();
		return(false);
	}
        
        if (registro.razonSocial.value.length >20){
		alert("Escribe como máximo 20 letras en el campo de Razón Social");
		registro.txtnom.focus();
		return(false);
	}
        
        if (registro.nameUser.value.length >20){
		alert("Escribe como máximo 20 letras en el campo de Nombre");
		registro.txtnom.focus();
		return(false);
	}
        
        if (registro.appat.value.length >20){
		alert("Escribe como máximo 20 letras en el campo de Apellido Paterno");
		registro.txtappat.focus();
		return(false);
	}
        
        if (registro.apmat.value.length >20){
		alert("Escribe como máximo 20 letras en el campo de Apellido Materno");
		registro.txtapmat.focus();
		return(false);
	}
        
        if (registro.f_n.value.length <10){
		alert("Por favor revisa la fecha de tu nacimiento");
		registro.txtf.focus();
		return(false);
	}
        
        if (registro.f_n.value.length >10){
		alert("Por favor revisa la fecha de tu nacimiento");
		registro.txtf.focus();
		return(false);
	}
        
        if (registro.description.value.length >250){
		alert("Por favor, como máximo 250 carácteres en el campo de descripción de la empresa");
		registro.txtd.focus();
		return(false);
	}
        
        if (registro.pwd.value.length >30){
		alert("Tu contraseña no puede ser mayor a 30 carácteres");
		registro.txtcontra.focus();
		return(false);
	}
        
        if (registro.pwd.value.length <10){
		alert("Tu contraseña no puede ser menor a 10 carácteres");
		registro.txtcontra.focus();
		return(false);
	}
        
        if (registro.pwd2.value.length >30){
		alert("Tu contraseña no puede ser mayor a 30 carácteres");
		registro.txtcontra.focus();
		return(false);
	}
        
        if (registro.pwd2.value.length <10){
		alert("Tu contraseña no puede ser menor a 10 carácteres");
		registro.txtcontra.focus();
		return(false);
	}
        
        if (registro.nameUser.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.appat.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.apmat.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.f_n.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.email.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.pwd.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.pwd2.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.nameEmpresa.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.description.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
        if (registro.razonSocial.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
}

function validoIS(formulario) {
    
        if (formulario.email.value.length ==0 || formulario.pwd.value.length ==0) {
            alert("Por favor, Introduce todos los datos solicitados correctamente");
            return(false);
	}
        
}