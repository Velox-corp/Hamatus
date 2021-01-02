/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MUsuarios.clases;

import ClasesSoporte.Conexion;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author maste
 */
@Entity
@Table(name = "cat-puestos", catalog = "hamatus", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CatPuestos.findAll", query = "SELECT c FROM CatPuestos c")})
public class CatPuestos implements Serializable {

    private static final long serialVersionUID = 1L;

    public static int traducirNombre(String division) {
        try{
            Connection con = Conexion.obtenerConexion();
            String q = "SELECT idprivilegio from privilegios_jerarquia_u where tit_permiso = ?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, division);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("idprivilegio");
            }else{
                return -1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CatPuestos.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID-Cat-Puestos")
    private Integer iDCatPuestos;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "Puesto")
    private String puesto;

    public CatPuestos() {
    }

    public CatPuestos(Integer iDCatPuestos) {
        this.iDCatPuestos = iDCatPuestos;
    }

    public CatPuestos(Integer iDCatPuestos, String puesto) {
        this.iDCatPuestos = iDCatPuestos;
        this.puesto = puesto;
    }

    public Integer getIDCatPuestos() {
        return iDCatPuestos;
    }

    public void setIDCatPuestos(Integer iDCatPuestos) {
        this.iDCatPuestos = iDCatPuestos;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDCatPuestos != null ? iDCatPuestos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CatPuestos)) {
            return false;
        }
        CatPuestos other = (CatPuestos) object;
        if ((this.iDCatPuestos == null && other.iDCatPuestos != null) || (this.iDCatPuestos != null && !this.iDCatPuestos.equals(other.iDCatPuestos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MUsuarios.clases.CatPuestos[ iDCatPuestos=" + iDCatPuestos + " ]";
    }
    
}
