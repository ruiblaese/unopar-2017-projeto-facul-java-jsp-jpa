<%@page import="java.util.Enumeration"%>
<%@page import="modelo.Empresa"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    String nome = request.getParameter("nome");
    String cnpj = request.getParameter("cnpj");
    String endereco = request.getParameter("endereco");
    String telefone = request.getParameter("telefone");
    String email = request.getParameter("email");
    int id = 0;

    if (request.getParameterMap().containsKey("empresaId")) {
        if (!request.getParameter("empresaId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("empresaId"));
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
        Empresa empresa = new Empresa();
        empresa.setNome(nome);
        empresa.setCnpj(cnpj);
        empresa.setEndereco(endereco);
        empresa.setTelefone(telefone);
        empresa.setEmail(email);
        
        if (empresa != null) {

            try {

                em.persist(empresa);
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
        Empresa empresa = new Empresa();        
        empresa.setId(id);
        empresa.setNome(nome);
        empresa.setCnpj(cnpj);
        empresa.setEndereco(endereco);
        empresa.setTelefone(telefone);
        empresa.setEmail(email);        

        em.find(Empresa.class, id);

        try {

            em.merge(empresa);
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