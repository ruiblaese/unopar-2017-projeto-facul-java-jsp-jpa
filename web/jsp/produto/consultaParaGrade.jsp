<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Produto"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>

<table class="table">
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                Nome
            </th>     
            <th>
                Descrição
            </th>                                        
            <th>
                Preço
            </th>               
            <th>
                Tamanho
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

            CriteriaQuery<Produto> criteria = em.getCriteriaBuilder().createQuery(Produto.class);
            criteria.select(criteria.from(Produto.class));
            List<Produto> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<Produto> aSituacaoPed = lista.iterator();
            while (aSituacaoPed.hasNext()) {
                Produto produto = aSituacaoPed.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(produto.getId()); %>                
            </td>
            <td>
                <% out.println(produto.getNome()); %>
            </td>
            <td>
                <% out.println(produto.getDescricao()); %>
            </td>
            <td>
                <% out.println(String.valueOf(produto.getPreco())); %>
            </td>
            <td>
                <% out.println(produto.getTamanho().getDescricao()); %>
            </td>            
            <td class="min"><button onclick="<%out.print("editar(" + produto.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + produto.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>