<%@page import="modelo.Produto"%>
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



<%
    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (em.getTransaction().isActive()) {
        em.getTransaction().rollback();
    }

    String retorno = "";
    try {
        int qtdeItens = Integer.parseInt(request.getParameter("qtdeItens"));
        int produtoId = Integer.parseInt(request.getParameter("produtoId"));
        double qtde = Double.parseDouble(request.getParameter("qtde"));

        Produto produto = em.find(Produto.class, produtoId);

        if (produto != null) {
            if (qtdeItens == 0) {


%>

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
        <tr>
            <td>
                <% out.println(""); %>
            </td>                        
            <td>
                <% out.println(String.valueOf(qtde)); %>                
            </td>
            <td>
                <% out.println(produto.getId()); %>
            </td>
            <td>
                <% out.println(produto.getNome()); %>
            </td>
            <td>
                <% out.println(produto.getPreco()); %>
            </td>
            <td>
                <% out.println(String.valueOf(produto.getPreco() * qtde)); %>
            </td>            

            <td class="min"><button class="btn btn-primary btn-xs disabled" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button class="btn btn-danger btn-xs disabled" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
    </tbody>
</table>
<%            } else {
%>
<tr>
    <td>
        <% out.println(""); %>
    </td>                        
    <td>
        <% out.println(String.valueOf(qtde)); %>                
    </td>
    <td>
        <% out.println(produto.getId()); %>
    </td>
    <td>
        <% out.println(produto.getNome()); %>
    </td>
    <td>
        <% out.println(produto.getPreco()); %>
    </td>
    <td>
        <% out.println(String.valueOf(produto.getPreco() * qtde)); %>
    </td>                   
    <td class="min"><button class="btn btn-primary btn-xs disabled" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
    <td class="min"><button class="btn btn-danger btn-xs disabled" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
</tr>

<%
            };
        } else {
            out.print("Erro! Produto não encontrado.");
        }

    } catch (Exception e) {
        out.print("Erro!");
        out.print(e.getMessage() + "\n" + e.getLocalizedMessage() + "\n" + e.toString());
    } finally {
        if (em.getTransaction().isActive()) {
            em.getTransaction().rollback();
        }
        em.close();
    }

%>            