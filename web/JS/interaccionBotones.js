
/**
 * Método para cambiar al atributo "readonly" de un <input>
 * @param {type} nombreInput
 * @param {type} nombrediv
 * @returns {Boolean}
 */
function cambiarEstado(nombreInput){
    let input = document.getElementById(nombreInput);
    try{
        input.readOnly = input.readOnly==false ? true : false;
    }catch (exception) {
        input.readOnly= true;
    } finally {
        return false;
    }
    return false;
}
/**
 * Método para cambiar al atributo "readonly" de un <input>
 * y la visibilidad o el "hidden" de un <div>
 * @param {type} nombreInput
 * @param {type} nombrediv
 * @returns {Boolean}
 */
function cambiarEstado(nombreInput, nombrediv){
    let input = document.getElementById(nombreInput);
    let div = document.getElementById(nombrediv);
    try{
        input.readOnly = input.readOnly==false ? true : false;
    }catch (exception) {
        input.readOnly= true;
    } finally {
        div.style.display = 'block';
        div.hidden = false;
    }
    return true;
}
