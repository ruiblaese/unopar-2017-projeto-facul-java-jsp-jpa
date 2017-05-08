<%@page import="java.util.Enumeration"%>
<%@page import="modelo.Tamanho"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    String descricao = request.getParameter("descricao");
    int id = 0;

    if (request.getParameterMap().containsKey("tamanhoId")) {
        if (!request.getParameter("tamanhoId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("tamanhoId"));
        }
    }
    
    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (!em.getTransaction().isActive()) {
        em.getTransaction().begin();
    }
    em.getTransaction().rollback();
    em.getTransaction().begin();

    if (id == 0) {
        Tamanho tamanho = new Tamanho();
        tamanho.setDescricao(descricao);
        if (tamanho != null) {

            try {

                em.persist(tamanho);
                em.flush();
                em.getTransaction().commit();

                retorno = "success";
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
    } else {
        Tamanho tamanho = new Tamanho();
        tamanho.setDescricao(descricao);
        tamanho.setId(id);

        em.find(Tamanho.class, id);

        try {

            em.merge(tamanho);
            em.flush();
            em.getTransaction().commit();

            retorno = "success";
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