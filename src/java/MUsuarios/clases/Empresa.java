/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.clases;

import ClasesSoporte.Conexion;
import java.io.Serializable;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author maste
 * Clase correspondiente a la entidad empresa
 */
@Entity
@Table(name = "empresa")
@NamedQueries({
    @NamedQuery(name = "Empresa.findAll", query = "SELECT e FROM Empresa e")})
public class Empresa implements Serializable {

    static Connection con = null;
    static String query = "";
    static PreparedStatement ps = null;
    static ResultSet rs = null;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID-Empresa")
    private Integer iDEmpresa;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 16777215)
    @Column(name = "Descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "Logo")
    private Blob logo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Raz\u00f3n social")
    private String razónsocial;

    public Empresa() {
    }

    public Empresa(Integer iDEmpresa) {
        this.iDEmpresa = iDEmpresa;
    }

    public Empresa(Integer iDEmpresa, String nombre, String descripcion, Blob logo, String razónsocial) {
        this.iDEmpresa = iDEmpresa;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.logo = logo;
        this.razónsocial = razónsocial;
    }
    
    public Empresa( String nombre, String descripcion, Blob logo, String razónsocial) {
        
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.logo = logo;
        this.razónsocial = razónsocial;
    }

    public static boolean crearEmpresa(Empresa emp){
        boolean procesoCorrecto = true;
        try{
            con = Conexion.obtenerConexion();
            query = ("INSERT INTO Empresa (Nombre, Descripción, Logo, Razón social) values = ?, ?, ?, ?");
            ps = con.prepareStatement(query);
            ps.setString(0, emp.getNombre());
            ps.setString(1, emp.getDescripcion());
            ps.setBlob(2, emp.getLogo());
            ps.setString(3, emp.getRazónsocial());
            
           if(ps.executeUpdate()==1) procesoCorrecto = true;
           else procesoCorrecto = false;
        }catch(Exception e){
            procesoCorrecto = false;
            e.getMessage();
            e.printStackTrace();
        }
        finally{
            try {
                ps.close();
                con.close();
                
            } catch (SQLException ex) {
                Logger.getLogger(Empresa.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return procesoCorrecto;
    }
    
    
    public Integer getIDEmpresa() {
        return iDEmpresa;
    }

    public void setIDEmpresa(Integer iDEmpresa) {
        this.iDEmpresa = iDEmpresa;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Blob getLogo() {
        return logo;
    }

    public void setLogo(Blob logo) {
        this.logo = logo;
    }

    public String getRazónsocial() {
        return razónsocial;
    }

    public void setRazónsocial(String razónsocial) {
        this.razónsocial = razónsocial;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDEmpresa != null ? iDEmpresa.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Empresa)) {
            return false;
        }
        Empresa other = (Empresa) object;
        if ((this.iDEmpresa == null && other.iDEmpresa != null) || (this.iDEmpresa != null && !this.iDEmpresa.equals(other.iDEmpresa))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MUsuarios.clases.Empresa[ iDEmpresa=" + iDEmpresa + " ]";
    }
    
}
