<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Pedido"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>

<table class="table">
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                Data
            </th>                                        
            <th>
                Pedido
            </th>
            <th>
                Entregador
            </th>
            <th>
                Sit.Pedido
            </th>         
            <th>
                Sub.Total
            </th>                   
            <th>
                Total
            </th>                    

            <th>

            </th>  
            <th>

            </th>
        </tr>
    </thead>
    <tbody>
        <%
            EntityManager em;
            em = EntityManagerUtil.getEntityManager();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            CriteriaQuery<Pedido> criteria = em.getCriteriaBuilder().createQuery(Pedido.class);
            criteria.select(criteria.from(Pedido.class));
            List<Pedido> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<Pedido> oPedido = lista.iterator();
            while (oPedido.hasNext()) {
                Pedido pedido = oPedido.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(pedido.getId()); %>                
            </td>
            <td>
                <% out.println(util.Funcoes.CalendarToString(pedido.getData())); %>
            </td>
            <td>
                <% out.println(pedido.getCliente().getNome()); %>
            </td>
            <td>
                <% out.println(pedido.getEntregador().getNome()); %>
            </td>
            <td>
                <% out.println(pedido.getSituacaoPedido().getDescricao()); %>
            </td>            
            <td>
                <% out.println(String.valueOf(Double.valueOf(pedido.getSub_total()))); %>
            </td>                        
            <td>
                <% out.println(String.valueOf(Double.valueOf(pedido.getTotal()))); %>
            </td>                                    
            <td class="min"><button onclick="<%out.print("editar(" + pedido.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + pedido.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>