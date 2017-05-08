<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.Tamanho"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
                                                <option value=""></option>
        <%
            EntityManager em;
            em = EntityManagerUtil.getEntityManager();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            CriteriaQuery<Tamanho> criteria = em.getCriteriaBuilder().createQuery(Tamanho.class);
            criteria.select(criteria.from(Tamanho.class));
            List<Tamanho> lista = em.createQuery(criteria).getResultList();
            
            Iterator<Tamanho> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                Tamanho tamanho = aPessoa.next();
                
        %>
                                                <option value="<%out.print(tamanho.getId());%>"><% out.print(tamanho.getDescricao()); %></option>
        <%
            }
        %>

    </tbody>
</table>