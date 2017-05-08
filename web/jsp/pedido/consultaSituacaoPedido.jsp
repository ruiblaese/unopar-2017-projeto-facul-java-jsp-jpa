<%@page import="javax.persistence.criteria.CriteriaQuery"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="modelo.SituacaoPedido"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
                                                <option value=""></option>
        <%
            EntityManager em;
            em = EntityManagerUtil.getEntityManager();
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }

            CriteriaQuery<SituacaoPedido> criteria = em.getCriteriaBuilder().createQuery(SituacaoPedido.class);
            criteria.select(criteria.from(SituacaoPedido.class));
            List<SituacaoPedido> lista = em.createQuery(criteria).getResultList();
            
            Iterator<SituacaoPedido> aPessoa = lista.iterator();
            while (aPessoa.hasNext()) {
                SituacaoPedido situacaoPedido = aPessoa.next();
                
        %>
                                                <option value="<%out.print(situacaoPedido.getId());%>"><% out.print(situacaoPedido.getDescricao()); %></option>
        <%
            }
        %>

    </tbody>
</table>