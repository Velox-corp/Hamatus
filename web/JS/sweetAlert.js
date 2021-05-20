/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function confirmation(){
    Swal.fire({
        position: 'top-end',
        title: "Documento correctamente guardado",
        icon:'success',
        showConfirmButton: false,
        timer: 1500
    });
}

function too_w(){
    var titulo = decode_utf8("Su archivo pesa más de 15Mb");
    Swal.fire({
        title: titulo,
        text:'Contacte al administrador',
        icon:'error'
    });
}

function file_sec(){
    var titulo = decode_utf8("Lamentablemente no se permiten archivos con esa nomenclatura");
    Swal.fire({
        title: titulo,
        text:'Por motivos de seguridad tampoco se aceptan archivos .sql .java .py .js .rar y .zip',
        icon:'error'
    });
}

function confirmation_del(){
    Swal.fire({
        position: 'top-end',
        title: "Documento correctamente borrado",
        icon:'success',
        showConfirmButton: false,
        timer: 1500
    });
}

function error(){
    Swal.fire({
        
        title: "Hubo un error",
        text:'Contacte al administrador',
        icon:'error'
    });
}

function wrong_pass(){
    var titulo = decode_utf8(encode_utf8("Contraseña incorrecta"));
    var text = decode_utf8(encode_utf8('Ingrese otra vez la contraseña'));
    Swal.fire({
        title: titulo,
        text:text,
        icon:'error'
    });
}

function true_pass(pass){
    var text = decode_utf8('La contraseña es: ');
    Swal.fire({
        title: "Documento correctamente guardado",
        text:text + pass ,
        icon:'success'
    });
}

function copy_link(id){
    const text = window.location.host + "/Hamatus/" + id;
    console.log(text);
    navigator.clipboard.writeText(text).then(function() {
    /* clipboard successfully set */
        Swal.fire({
            text:'Comparta el link para poder mostrar este archivo a otros colaboradores de la empresa',
            position: 'top-end',
            icon:'success',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true
        });
    }, function() {
      /* clipboard write failed */
      Swal.fire({
            text:'A sucedido un error contacte al administrador',
            position: 'top-end',
            icon:'error',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true
        });
    });
}

function deleteFile(id_m, fileName){
    var titulo = decode_utf8('¿Estas seguro de que quieres borrar el archivo?');
    var text = decode_utf8('La contraseña es: ');
    Swal.fire({
        title: titulo,
        text: "Recuerda que no podras recuperarlo",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#343a40',
        confirmButtonText: 'Si por favor',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
          window.location = "deleteFile?id_M="+id_m+"&fileName="+fileName;
        }
    });
}

function deleteFile_J(id_m, fileName, id_e){
    var titulo = decode_utf8('¿Estas seguro de que quieres borrar el archivo?');
    var text = decode_utf8('La contraseña es: ');
    Swal.fire({
        title: titulo,
        text: "Recuerda que no podras recuperarlo",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#343a40',
        confirmButtonText: 'Si por favor',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
          window.location = "deleteFile_J?id_M="+id_m+"&fileName="+fileName+"&id_e="+id_e;
        }
    });
}

async function createFol(){
    const { value: newName } = await Swal.fire({
        title: 'Escribe el nombre del folder',
        input: 'text',
        inputLabel: 'Escribe el nombre',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#343a40',
        confirmButtonText: 'Ok',
        cancelButtonText: 'Cancelar',
        inputValidator: (value) => {
          if (!value) {
            return 'Necesitas escribir algo!'
          }
        }
    });
    const q = getParameterByName('q');
    window.location = `makeDir?newDir=${newName}&q=${q}`;
}



window.onload = function(){
    if (getParameterByName('flag') == 'true') {
        confirmation();
    }else if(getParameterByName('flag') == 'false'){
        error();
    }else if(getParameterByName('flag_del') == 'false'){
        error();
    }else if(getParameterByName('flag_del') == 'true'){
        confirmation_del();
    }else if(getParameterByName('flag') == 'exist'){
        Swal.fire({
            title:"Lo sentimos, el archivo ya existe",
            icon:'warning'
        });
    }else if(getParameterByName('flag') == 'wrong_pass'){
        wrong_pass();
    }else if(getParameterByName('flag') == 'true_pass'){
        var pass = getParameterByName('pass');
        true_pass(pass);
    }
    else if(getParameterByName('flag') == 'too_w'){
        too_w();
    }
    else if(getParameterByName('flag') == 'file_sec'){
        file_sec();
    }
    else if(getParameterByName('flag') == 'exist_dir'){
        Swal.fire({
            title:"El nombre del folder ya esta ocupado",
            icon:'warning'
        });
    }
}

/**
 * @param String name
 * @return String
 */
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
    results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function encode_utf8(s) {
  return unescape(encodeURIComponent(s));
}

function decode_utf8(s) {
  return decodeURIComponent(escape(s));
}