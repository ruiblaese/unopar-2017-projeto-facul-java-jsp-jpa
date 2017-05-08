<%@page import="modelo.PedidoItem"%>
<%@page import="modelo.Produto"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="modelo.SituacaoPedido"%>
<%@page import="modelo.Entregador"%>
<%@page import="modelo.Cliente"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Enumeration"%>
<%@page import="modelo.Pedido"%>
<%@page import="jpa.EntityManagerUtil"%>
<%@page import="javax.persistence.EntityManager"%>
<%
    String retorno = "erro";
    int clienteId = Integer.valueOf(request.getParameter("clienteId"));
    int entregadorId = Integer.valueOf(request.getParameter("entregadorId"));
    int situacao_pedidoId = Integer.valueOf(request.getParameter("situacao_pedidoId"));
    Double subtotal = Double.valueOf(request.getParameter("subtotal"));
    Double valor_entrega = Double.valueOf(request.getParameter("entrega"));
    Double total = Double.valueOf(request.getParameter("total"));
    int id = 0;
    Calendar data = null;
    String jsonItens = "";

    //verifica se eh edicao ( no caso se tem id para ser alterado )
    if (request.getParameterMap().containsKey("pedidoId")) {
        if (!request.getParameter("pedidoId").isEmpty()) {
            id = Integer.valueOf(request.getParameter("pedidoId"));
        };
    }
    if (request.getParameterMap().containsKey("data")) {
        if (!request.getParameter("data").isEmpty()) {
            data = util.Funcoes.StringToCalendar(request.getParameter("data"));
        }
    }
    if (request.getParameterMap().containsKey("itens")) {
        if (!request.getParameter("itens").isEmpty()) {
            jsonItens = request.getParameter("itens");
        }
    }

    EntityManager em;
    em = EntityManagerUtil.getEntityManager();
    if (!em.getTransaction().isActive()) {
        em.getTransaction().begin();
    }
    em.getTransaction().rollback();
    em.getTransaction().begin();

    Cliente cliente = em.find(Cliente.class, clienteId);
    Entregador entregador = em.find(Entregador.class, entregadorId);
    SituacaoPedido situacaoPedido = em.find(SituacaoPedido.class, situacao_pedidoId);

    //nao tem id \ id = 0 -> entra em cadastro
    if (id == 0) {
        Pedido pedido = new Pedido();
        if (data != null) {
            pedido.setData(data);
        };
        pedido.setCliente(cliente);
        pedido.setEntregador(entregador);
        pedido.setSituacaoPedido(situacaoPedido);
        pedido.setSub_total(subtotal);
        pedido.setValor_entrega(valor_entrega);
        pedido.setTotal(total);

        if (pedido != null) {

            try {

                em.persist(pedido);
                em.flush();
                em.getTransaction().commit();

                Map mapaItens = new com.google.gson.Gson().fromJson(jsonItens, TreeMap.class);
                Iterator linhas = mapaItens.entrySet().iterator();
                while (linhas.hasNext()) {
                    Entry linhaAtual = (Entry) linhas.next();
                    String seqLinha = linhaAtual.getKey().toString();
                    String valorLinhas = linhaAtual.getValue().toString();

                    if (Integer.parseInt(seqLinha) > 0) {
                        valorLinhas = valorLinhas.substring(1, valorLinhas.length() - 2);
                        String[] colunas = valorLinhas.split(",");

                        Produto produto = em.find(Produto.class, Integer.parseInt(colunas[2].trim()));
                        PedidoItem pedidoItem = new PedidoItem();
                        pedidoItem.setPedido(pedido);
                        pedidoItem.setQuantidade(Double.parseDouble(colunas[1].trim()));
                        pedidoItem.setProduto(produto);
                        pedidoItem.setValorUnitario(Double.parseDouble(colunas[4].trim()));
                        pedidoItem.setValorTotal(Double.parseDouble(colunas[5].trim()));

                        em = EntityManagerUtil.getEntityManager();
                        if (!em.getTransaction().isActive()) {
                            em.getTransaction().begin();
                        }
                        em.persist(pedidoItem);
                        em.flush();
                        em.getTransaction().commit();
                    };
                };

                retorno = "success";
            } catch (Exception e) {
                retorno = "Não foi possivel cadastrar esse registro. (" + e.getMessage() + "\n" + e.getLocalizedMessage() + "\n" + e.toString() + ")";
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
        Pedido pedido = new Pedido();
        pedido.setId(id);
        if (data != null) {
            pedido.setData(data);
        };
        pedido.setCliente(cliente);
        pedido.setEntregador(entregador);
        pedido.setSituacaoPedido(situacaoPedido);
        pedido.setSub_total(subtotal);
        pedido.setValor_entrega(valor_entrega);
        pedido.setTotal(total);

        em.find(Pedido.class, id);

        try {

            em.merge(pedido);
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