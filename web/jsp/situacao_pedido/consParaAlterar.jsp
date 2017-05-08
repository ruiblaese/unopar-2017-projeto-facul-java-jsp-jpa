<%@page import="com.google.gson.Gson"%>
<%@page import="modelo.SituacaoPedido"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (!em.getTransaction().isActive()) {
        em.getTransaction().begin();
    }
    em.getTransaction().rollback();
    em.getTransaction().begin();

    SituacaoPedido sitPedido = em.find(SituacaoPedido.class, id);
    String retorno = "erro";
    if (sitPedido != null) {

        try {
            retorno = "";
            Gson gson = new Gson();
            retorno = gson.toJson(sitPedido);;
        } catch (Exception e) {
            retorno = "N�o foi possivel remover esse registro. (" + e.getMessage() + "\n" + e.getLocalizedMessage() + "\n" + e.toString() + ")";
            retorno = retorno.trim();
        } finally {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            em.close();
        }
    }
    out.print(retorno);
%>