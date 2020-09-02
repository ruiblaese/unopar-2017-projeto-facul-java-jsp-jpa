package modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Objects;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "cliente")
public class Cliente implements Serializable {

    @Id
    @SequenceGenerator(name = "seq_cliente", sequenceName = "seq_cliente_id", allocationSize = 1)
    @GeneratedValue(generator = "seq_cliente", strategy = GenerationType.SEQUENCE)
    private Integer id;
    
    @NotNull(message = "O nome não pode ser nulo")
    @NotBlank(message = "O nome não ser em branco")
    @Length(max = 50, message = "O nome não pode ter mais de {max} caracteres")
    @Column(name = "nome", length = 50, nullable = false) 
    private String nome;
    
    @Length(max = 50, message = "O login não pode ter mais de {max} caracteres")
    @Column(name = "login", length = 50)    
    private String login;
        
    @Length(max = 10, message = "O senha não pode ter mais de {max} caracteres")
    @Column(name = "senha", length = 50)    
    private String senha;
    
    @NotNull(message = "O telefone não pode ser nulo")
    @NotBlank(message = "O telefone não ser em branco")
    @Length(max = 14, message = "O telefone não pode ter mais de {max} caracteres")
    @Column(name = "telefone", length = 14, nullable = false)
    private String telefone;
    
    @Length(max = 50, message = "O endereco não pode ter mais de {max} caracteres")
    @Column(name = "endereco", length = 100, nullable = false)
    private String endereco;
    
    @Length(max = 50, message = "O ponto referencia não pode ter mais de {max} caracteres")
    @Column(name = "ponto_referencia", length = 100, nullable = false)
    private String ponto_referencia;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "nascimento", nullable = true)
    private Calendar nascimento;

    public Cliente() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getPonto_referencia() {
        return ponto_referencia;
    }

    public void setPonto_referencia(String ponto_referencia) {
        this.ponto_referencia = ponto_referencia;
    }

    public Calendar getNascimento() {        
            return nascimento;        
    }

    public void setNascimento(Calendar nascimento) {
        this.nascimento = nascimento;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 73 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Cliente other = (Cliente) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

}
