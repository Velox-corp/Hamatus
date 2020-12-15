/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MDistribucion.Clases;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author maste
 */
@Entity
@Table(name = "equipo", catalog = "hamatus", schema = "")
@NamedQueries({
    @NamedQuery(name = "Equipo.findAll", query = "SELECT e FROM Equipo e")})
public class Equipo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Equipo")
    private Integer iDEquipo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_Division")
    private int iDDivision;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "iDEquipo")
    private Collection<EUsuarioEquipo> eUsuarioEquipoCollection;

    public Equipo() {
    }

    public Equipo(Integer iDEquipo) {
        this.iDEquipo = iDEquipo;
    }

    public Equipo(Integer iDEquipo, String nombre, int iDDivision) {
        this.iDEquipo = iDEquipo;
        this.nombre = nombre;
        this.iDDivision = iDDivision;
    }

    public Integer getIDEquipo() {
        return iDEquipo;
    }

    public void setIDEquipo(Integer iDEquipo) {
        this.iDEquipo = iDEquipo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getIDDivision() {
        return iDDivision;
    }

    public void setIDDivision(int iDDivision) {
        this.iDDivision = iDDivision;
    }

    public Collection<EUsuarioEquipo> getEUsuarioEquipoCollection() {
        return eUsuarioEquipoCollection;
    }

    public void setEUsuarioEquipoCollection(Collection<EUsuarioEquipo> eUsuarioEquipoCollection) {
        this.eUsuarioEquipoCollection = eUsuarioEquipoCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iDEquipo != null ? iDEquipo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Equipo)) {
            return false;
        }
        Equipo other = (Equipo) object;
        if ((this.iDEquipo == null && other.iDEquipo != null) || (this.iDEquipo != null && !this.iDEquipo.equals(other.iDEquipo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MDistribucion.Clases.Equipo[ iDEquipo=" + iDEquipo + " ]";
    }
    
}
