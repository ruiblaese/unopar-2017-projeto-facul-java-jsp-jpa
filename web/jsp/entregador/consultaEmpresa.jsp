<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Empresa"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
                                                <option value=""></option>
        <%
            EntityManager em;
            em = EntityManagerUtil.getEntityManager();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            CriteriaQuery<Empresa> criteria = em.getCriteriaBuilder().createQuery(Empresa.class);
            criteria.select(criteria.from(Empresa.class));
            List<Empresa> lista = em.createQuery(criteria).getResultList();
            
            Iterator<Empresa> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                Empresa empresa = aPessoa.next();
                
        %>
                                                <option value="<%out.print(empresa.getId());%>"><% out.print(empresa.getNome()); %></option>
        <%
            }
        %>

    </tbody>
</table>