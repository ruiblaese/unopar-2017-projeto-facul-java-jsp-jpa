<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Entregador"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
                                                <option value=""></option>
        <%
            EntityManager em;
            em = EntityManagerUtil.getEntityManager();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            CriteriaQuery<Entregador> criteria = em.getCriteriaBuilder().createQuery(Entregador.class);
            criteria.select(criteria.from(Entregador.class));
            List<Entregador> lista = em.createQuery(criteria).getResultList();
            
            Iterator<Entregador> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                Entregador cliente = aPessoa.next();
                
        %>
                                                <option value="<%out.print(cliente.getId());%>"><% out.print(cliente.getNome()); %></option>
        <%
            }
        %>

    </tbody>
</table>