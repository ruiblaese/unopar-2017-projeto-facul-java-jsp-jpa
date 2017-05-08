<%@page import="modelo.Empresa"%>
<%@page import="java.util.Enumeration"%>
<%@page import="modelo.Entregador"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    String nome = request.getParameter("nome");
    String cpf = request.getParameter("cpf");
    String rg = request.getParameter("rg");
    String celular = request.getParameter("celular");    

    int id = 0;
    int empresaId = 0;

    //verifica se eh edicao ( no caso se tem id para ser alterado )
    if (request.getParameterMap().containsKey("entregadorId")) {
        if (!request.getParameter("entregadorId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("entregadorId"));
        } else if (!request.getParameter("empresaId").isEmpty()) {
            empresaId = Integer.valueOf(request.getParameter("empresaId"));
        }
    }

    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (!em.getTransaction().isActive()) {
        em.getTransaction().begin();
    }
    em.getTransaction().rollback();
    em.getTransaction().begin();

    Empresa tamanho = null;
    if (empresaId > 0) {
        tamanho = em.find(Empresa.class, empresaId);
    }

    //nao tem id \ id = 0 -> entra em cadastro
    if (id == 0) {
        Entregador entregador = new Entregador();
        entregador.setNome(nome);
        entregador.setCpf(cpf);
        entregador.setRg(rg);
        entregador.setCelular(celular);        
        if (tamanho != null){
            entregador.setEmpresa(tamanho);
        }
        if (entregador != null) {

            try {

                em.persist(entregador);
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
        Entregador entregador = new Entregador();
        entregador.setNome(nome);        
        entregador.setCpf(cpf);
        entregador.setRg(rg);
        entregador.setCelular(celular);        
        if (tamanho != null){
            entregador.setEmpresa(tamanho);
        }

        em.find(Entregador.class, id);

        try {

            em.merge(entregador);
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