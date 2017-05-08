<%@page import="javax.persistence.Query"%>
<%@page import="modelo.Pedido"%>
<%@page import="javax.persistence.metamodel.EntityType"%>
<%@page import="javax.persistence.metamodel.Metamodel"%>
<%@page import="javax.persistence.criteria.Root"%>
<%@page import="javax.persistence.criteria.CriteriaBuilder"%>
<%@page import="javax.persistence.criteria.ParameterExpression"%>
<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.PedidoItem"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>

<table class="table" name="tabelaItens" id="tabelaItens">
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                Qtde
            </th>
            <th>
                # Produto
            </th>
            <th>
                Produto
            </th>                                        
            <th>
                Valor
            </th>         
            <th>
                Valor total
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
            String strSQL = "select pedido_item.* from pedido_item where pedido_id = " + request.getParameter("pedidoId");

            Query query = em.createNativeQuery(strSQL, PedidoItem.class);

            List<PedidoItem> lista = query.getResultList();

            String classTr = "class=\"active\"";
            Iterator<PedidoItem> oPedidoItem = lista.iterator();
            while (oPedidoItem.hasNext()) {
                PedidoItem pedidoItem = oPedidoItem.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(pedidoItem.getId()); %>                
            </td>
            <td>
                <% out.println(pedidoItem.getQuantidade().toString()); %>
            </td>
            <td>
                <% out.println(pedidoItem.getProduto().getId().toString()); %>
            </td>
            <td>
                <% out.println(pedidoItem.getProduto().getNome()); %>
            </td>
            <td>
                <% out.println(pedidoItem.getValorUnitario()); %>
            </td>            
            <td>
                <% out.println(pedidoItem.getValorTotal()); %>
            </td>                        
            <td class="min"><button class="btn btn-primary btn-xs disabled" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button class="btn btn-danger btn-xs disabled" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>