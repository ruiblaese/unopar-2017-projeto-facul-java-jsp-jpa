<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Entregador"%>
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
                CPF
            </th>                                        
            <th>
                RG
            </th>               
            <th>
                Celular
            </th>                
            <th>
                Empresa
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

            CriteriaQuery<Entregador> criteria = em.getCriteriaBuilder().createQuery(Entregador.class);
            criteria.select(criteria.from(Entregador.class));
            List<Entregador> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<Entregador> aSituacaoPed = lista.iterator();
            while (aSituacaoPed.hasNext()) {
                Entregador entregador = aSituacaoPed.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(entregador.getId()); %>                
            </td>
            <td>
                <% out.println(entregador.getNome()); %>
            </td>
            <td>
                <% out.println(entregador.getCpf()); %>
            </td>
            <td>
                <% out.println(entregador.getRg()); %>
            </td>
            <td>
                <% out.println(entregador.getEmpresa().getNome()); %>
            </td>            
            <td class="min"><button onclick="<%out.print("editar(" + entregador.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + entregador.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>