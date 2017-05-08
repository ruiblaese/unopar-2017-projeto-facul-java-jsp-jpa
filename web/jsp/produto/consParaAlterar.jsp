<%@page import="com.google.gson.Gson"%>
<%@page import="modelo.Produto"%>
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

    Produto produto = em.find(Produto.class, id);
    String retorno = "erro";
    if (produto != null) {

        try {
            retorno = "";
            Gson gson = new Gson();
            retorno = gson.toJson(produto);;
        } catch (Exception e) {
            retorno = "Não foi possivel remover esse registro. (" + e.getMessage() + "\n" + e.getLocalizedMessage() + "\n" + e.toString() + ")";
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