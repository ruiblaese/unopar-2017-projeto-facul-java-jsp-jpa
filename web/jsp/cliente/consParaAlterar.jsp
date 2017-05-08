<%@page import="com.google.gson.Gson"%>
<%@page import="modelo.Cliente"%>
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

    Cliente cliente = em.find(Cliente.class, id);
    String retorno = "erro";
    if (cliente != null) {

        try {
            retorno = "";
            Gson gson = new Gson();
            retorno = gson.toJson(cliente);;
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