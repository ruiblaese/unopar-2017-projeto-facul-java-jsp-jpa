<%@page import="modelo.Tamanho"%>
<%@page import="java.util.Enumeration"%>
<%@page import="modelo.Produto"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    String nome = request.getParameter("nome");
    String descricao = request.getParameter("descricao");
    Double preco = Double.parseDouble(request.getParameter("preco"));

    int id = 0;
    int tamanhoId = 0;

    //verifica se eh edicao ( no caso se tem id para ser alterado )
    if (request.getParameterMap().containsKey("produtoId")) {
        if (!request.getParameter("produtoId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("produtoId"));
        } else if (!request.getParameter("tamanhoId").isEmpty()) {
            tamanhoId = Integer.valueOf(request.getParameter("tamanhoId"));
        }
    }

    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (!em.getTransaction().isActive()) {
        em.getTransaction().begin();
    }
    em.getTransaction().rollback();
    em.getTransaction().begin();

    Tamanho tamanho = null;
    if (tamanhoId > 0) {
        tamanho = em.find(Tamanho.class, tamanhoId);
    }

    //nao tem id \ id = 0 -> entra em cadastro
    if (id == 0) {
        Produto produto = new Produto();
        produto.setNome(nome);
        produto.setDescricao(descricao);
        produto.setPreco(preco);
        if (tamanho != null){
            produto.setTamanho(tamanho);
        }
        if (produto != null) {

            try {

                em.persist(produto);
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
        Produto produto = new Produto();
        produto.setDescricao(descricao);
        produto.setNome(nome);
        produto.setDescricao(descricao);
        produto.setPreco(preco);
        produto.setId(id);
        if (tamanho != null){
            produto.setTamanho(tamanho);
        }        

        em.find(Produto.class, id);

        try {

            em.merge(produto);
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