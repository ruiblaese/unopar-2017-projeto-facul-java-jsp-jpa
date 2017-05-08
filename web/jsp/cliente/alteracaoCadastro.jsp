<%@page import="java.util.Calendar"%>
<%@page import="java.util.Enumeration"%>
<%@page import="modelo.Cliente"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    String nome = request.getParameter("nome");
    String telefone = request.getParameter("telefone");
    String endereco = request.getParameter("endereco");
    String ponto_referencia = request.getParameter("ponto_referencia");
    int id = 0;
    Calendar nascimento = null;
    
    //verifica se eh edicao ( no caso se tem id para ser alterado )
    if (request.getParameterMap().containsKey("clienteId")) {
        if (!request.getParameter("clienteId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("clienteId"));
        } else if (!request.getParameter("nascimento").isEmpty()) {
            nascimento = util.Funcoes.StringToCalendar(request.getParameter("nascimento"));
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
        Cliente cliente = new Cliente();
        cliente.setNome(nome);
        cliente.setTelefone(telefone);
        cliente.setEndereco(endereco);
        cliente.setPonto_referencia(ponto_referencia);
        if (nascimento != null){
            cliente.setNascimento(nascimento);
        };
        
        if (cliente != null) {

            try {

                em.persist(cliente);
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
        Cliente cliente = new Cliente();        
        cliente.setId(id);
        cliente.setNome(nome);
        cliente.setTelefone(telefone);
        cliente.setEndereco(endereco);
        cliente.setPonto_referencia(ponto_referencia);
        if (nascimento != null){
            cliente.setNascimento(nascimento);
        };        

        em.find(Cliente.class, id);

        try {

            em.merge(cliente);
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