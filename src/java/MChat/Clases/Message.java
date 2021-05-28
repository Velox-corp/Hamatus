/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MChat.Clases;

import com.google.gson.JsonObject;

/**
 *
 * @author roberto
 */
public class Message {

    private int id;
    private int id_user;
    private String name;
    private String message;
    private String created_at;
    private int sala;

    public Message(int id, String message, int id_user, int sala, String created_at) {
        this.id = id;
        this.message = message;
        this.id_user = id_user;
        this.sala = sala;
        this.created_at = created_at;

    }

    public Message(String message, int id_user, int sala, String created_at) {

        this.message = message;
        this.id_user = id_user;
        this.sala = sala;
        this.created_at = created_at;
    }
    

    
/*
    public Message(int id, String message, String name, int sala, String created_at) {
        this.id = id;
        this.message = message;
        this.name = name;
        this.sala = sala;
        this.created_at = created_at;

    }*/

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public int getSala() {
        return sala;
    }

    public void setSala(int sala) {
        this.sala = sala;
    }
    
    
        public JsonObject getJsonObject(){
        JsonObject jo = new JsonObject();
        
        jo.addProperty("id", this.getId());
        jo.addProperty("id_sala", this.getSala());
        jo.addProperty("id_usuario", this.getId_user());
        jo.addProperty("message", this.getMessage());
        jo.addProperty("created_at", this.getCreated_at());
        
        return jo;
    }
    
    

}
