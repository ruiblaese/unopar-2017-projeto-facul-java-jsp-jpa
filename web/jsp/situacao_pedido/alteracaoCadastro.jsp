<%@page import="java.util.Enumeration"%>
<%@page import="modelo.SituacaoPedido"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    String descricao = request.getParameter("descricao");
    int id = 0;
    
    //verifica se eh edicao ( no caso se tem id para ser alterado )
    if (request.getParameterMap().containsKey("situacao_pedidoId")) {
        if (!request.getParameter("situacao_pedidoId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("situacao_pedidoId"));
        }
    }
    
    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (!em.getTransaction().isActive()) {
        em.getTransaction().begin();
    }
    em.getTransaction().rollback();
    em.getTransaction().begin();
    
    //nao tem id \ id = 0 -> entra em cadastro
    if (id == 0) {
        SituacaoPedido situacao_pedido = new SituacaoPedido();
        situacao_pedido.setDescricao(descricao);
        if (situacao_pedido != null) {

            try {

                em.persist(situacao_pedido);
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
    //tem id  -> entra em edicao 
    } else {
        SituacaoPedido situacao_pedido = new SituacaoPedido();
        situacao_pedido.setDescricao(descricao);
        situacao_pedido.setId(id);

        em.find(SituacaoPedido.class, id);

        try {

            em.merge(situacao_pedido);
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