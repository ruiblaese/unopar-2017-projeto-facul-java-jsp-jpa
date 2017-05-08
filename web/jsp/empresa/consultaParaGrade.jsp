<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Empresa"%>
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
                CNPJ
            </th>
            <th>
                Endereço
            </th>
            <th>
                Telefone
            </th>       
            <th>
                Email
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

            CriteriaQuery<Empresa> criteria = em.getCriteriaBuilder().createQuery(Empresa.class);
            criteria.select(criteria.from(Empresa.class));
            List<Empresa> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<Empresa> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                Empresa empresa = aPessoa.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(empresa.getId()); %>                
            </td>
            <td>
                <% out.println(empresa.getNome()); %>
            </td>
            <td>
                <% out.println(empresa.getCnpj()); %>
            </td>
            <td>
                <% out.println(empresa.getEndereco()); %>
            </td>
            <td>
                <% out.println(empresa.getTelefone()); %>
            </td>            
            <td>
                <% out.println(empresa.getEmail()); %>
            </td>                        
            <td class="min"><button onclick="<%out.print("editar(" + empresa.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + empresa.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>