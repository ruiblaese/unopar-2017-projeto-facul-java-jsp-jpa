<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Cliente"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
                                                <option value=""></option>
        <%
            EntityManager em;
            em = EntityManagerUtil.getEntityManager();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            CriteriaQuery<Cliente> criteria = em.getCriteriaBuilder().createQuery(Cliente.class);
            criteria.select(criteria.from(Cliente.class));
            List<Cliente> lista = em.createQuery(criteria).getResultList();
            
            Iterator<Cliente> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                Cliente cliente = aPessoa.next();
                
        %>
                                                <option value="<%out.print(cliente.getId());%>"><% out.print(cliente.getNome()); %></option>
        <%
            }
        %>

    </tbody>
</table>