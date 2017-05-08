<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Tamanho"%>
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
            if (em.getTransaction().isActive()){
                em.getTransaction().rollback();
            }
            

            CriteriaQuery<Tamanho> criteria = em.getCriteriaBuilder().createQuery(Tamanho.class);
            criteria.select(criteria.from(Tamanho.class));
            List<Tamanho> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<Tamanho> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                Tamanho tamanho = aPessoa.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(tamanho.getId()); %>                
            </td>
            <td>
                <% out.println(tamanho.getDescricao()); %>
            </td>
            <td class="min"><button onclick="<%out.print("editar(" + tamanho.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + tamanho.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }            
        %>

    </tbody>
</table>