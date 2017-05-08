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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "pedido")
public class Pedido implements Serializable {

    @Id
    @SequenceGenerator(name = "seq_pedido", sequenceName = "seq_pedido_id", allocationSize = 1)
    @GeneratedValue(generator = "seq_pedido", strategy = GenerationType.SEQUENCE)
    private Integer id;
    @Temporal(TemporalType.DATE)
    @Column(name = "data", nullable = true)
    private Calendar data;
    @ManyToOne
    @JoinColumn(name = "cliente_id", referencedColumnName = "id", nullable = true)
    private Cliente cliente;
    @ManyToOne
    @JoinColumn(name = "entregador_id", referencedColumnName = "id", nullable = true)
    private Entregador entregador;
    @ManyToOne
    @JoinColumn(name = "situacao_pedido_id", referencedColumnName = "id", nullable = true)
    private SituacaoPedido situacaoPedido;
    @NotNull(message = "O Subtotal deve ser informado")    
    @Column(name = "sub_total", nullable = false, columnDefinition = "decimal(12,2)")
    private Double sub_total;
    @NotNull(message = "O valor entrega deve ser informado")    
    @Column(name = "valor_entrega", nullable = false, columnDefinition = "decimal(12,2)")
    private Double valor_entrega;    
    @NotNull(message = "O total deve ser informado")    
    @Column(name = "total", nullable = false, columnDefinition = "decimal(12,2)")
    private Double total;    

    public Pedido() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Calendar getData() {
        return data;
    }

    public void setData(Calendar data) {
        this.data = data;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Entregador getEntregador() {
        return entregador;
    }

    public void setEntregador(Entregador entregador) {
        this.entregador = entregador;
    }

    public SituacaoPedido getSituacaoPedido() {
        return situacaoPedido;
    }

    public void setSituacaoPedido(SituacaoPedido situacaoPedido) {
        this.situacaoPedido = situacaoPedido;
    }

    public Double getSub_total() {
        return sub_total;
    }

    public void setSub_total(Double sub_total) {
        this.sub_total = sub_total;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getValor_entrega() {
        return valor_entrega;
    }

    public void setValor_entrega(Double valor_entrega) {
        this.valor_entrega = valor_entrega;
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
        final Pedido other = (Pedido) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

}
