<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.SituacaoPedido"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>

<table class="table">
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                Descrição
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

            CriteriaQuery<SituacaoPedido> criteria = em.getCriteriaBuilder().createQuery(SituacaoPedido.class);
            criteria.select(criteria.from(SituacaoPedido.class));
            List<SituacaoPedido> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<SituacaoPedido> aSituacaoPed = lista.iterator();
            while (aSituacaoPed.hasNext()) {
                SituacaoPedido situacaoPedido = aSituacaoPed.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(situacaoPedido.getId()); %>                
            </td>
            <td>
                <% out.println(situacaoPedido.getDescricao()); %>
            </td>
            <td class="min"><button onclick="<%out.print("editar(" + situacaoPedido.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + situacaoPedido.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>