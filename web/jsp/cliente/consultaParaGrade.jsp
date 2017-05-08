<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Cliente"%>
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
                Telefone
            </th>
            <th>
                Endereco
            </th>
            <th>
                Ponto Ref.
            </th>         
            <th>
                Nascimento
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

            CriteriaQuery<Cliente> criteria = em.getCriteriaBuilder().createQuery(Cliente.class);
            criteria.select(criteria.from(Cliente.class));
            List<Cliente> lista = em.createQuery(criteria).getResultList();

            String classTr = "class=\"active\"";
            Iterator<Cliente> oCliente = lista.iterator();
            while (oCliente.hasNext()) {
                Cliente cliente = oCliente.next();
                if (classTr.isEmpty()) {
                    classTr = "class=\"active\"";
                } else {
                    classTr = "";
                }
        %>
        <tr<% out.print(" " + classTr);%>>
            <td>
                <% out.println(cliente.getId()); %>                
            </td>
            <td>
                <% out.println(cliente.getNome()); %>
            </td>
            <td>
                <% out.println(cliente.getTelefone()); %>
            </td>
            <td>
                <% out.println(cliente.getEndereco()); %>
            </td>
            <td>
                <% out.println(cliente.getPonto_referencia()); %>
            </td>            
            <td>
                <% out.println(util.Funcoes.CalendarToString(cliente.getNascimento())); %>
            </td>                        
            <td class="min"><button onclick="<%out.print("editar(" + cliente.getId() + ");");%>" class="btn btn-primary btn-xs" data-title="Edit" data-toggle="modal" data-target="#edit" ><span class="glyphicon glyphicon-pencil"></span></button></td>
            <td class="min"><button onclick="<%out.print("excluir(" + cliente.getId() + ");");%>" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>