/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testes;

import javax.persistence.EntityManager;
import jpa.EntityManagerUtil;
import modelo.Cliente;
import modelo.Empresa;
import modelo.Entregador;
import modelo.Pedido;
import modelo.Produto;
import modelo.SituacaoPedido;
import modelo.PedidoItem;
import modelo.Tamanho;

/**
 *
 * @author RUIBL
 */
public class PopularBaseInicial {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        EntityManager em;
        em = EntityManagerUtil.getEntityManager();
      
        Cliente cliente = new Cliente();
        cliente.setNome("Rui");
        cliente.setTelefone("47 88180000");
        cliente.setEndereco("Rua Tocantins,Brehmer, Rio do Sul-SC ");
        cliente.setPonto_referencia("casa");
        cliente.setNascimento(util.Funcoes.StringToCalendar("1989-03-03"));
        em.getTransaction().begin();
        em.persist(cliente);
        em.getTransaction().commit();
        
        cliente = new Cliente();
        cliente.setNome("Mateus");
        cliente.setTelefone("47 88990000");
        cliente.setEndereco("Rua XV,Centro, Rio do Sul-SC ");
        cliente.setNascimento(util.Funcoes.StringToCalendar("1990-06-06"));
        cliente.setPonto_referencia("casa");
        em.getTransaction().begin();
        em.persist(cliente);
        em.getTransaction().commit();

        Empresa empresa = new Empresa();
        empresa.setNome("Uber");
        empresa.setCnpj("99.999.999/9999-99");
        empresa.setEndereco("Al.Aristiliano Ramos, Centro, Rio do Sul-SC");
        empresa.setTelefone("47 3525 0000");
        empresa.setEmail("uber@servidor.com.br");
        em.getTransaction().begin();
        em.persist(empresa);
        em.getTransaction().commit();

        Entregador entregador = new Entregador();
        entregador.setNome("Michel Overflow");
        entregador.setCpf("000.000.000-00");
        entregador.setRg("1.234.567");
        entregador.setCelular("47 3521 0011");
        entregador.setEmpresa(empresa);
        em.getTransaction().begin();
        em.persist(entregador);
        em.getTransaction().commit();
        
        
        empresa = new Empresa();
        empresa.setNome("Moto Boy Power Express");
        empresa.setCnpj("99.999.999/9999-99");
        empresa.setEndereco("Al.Nereu Ramos, Centro, Rio do Sul-SC");
        empresa.setTelefone("47 3525 0000");
        empresa.setEmail("boypowerexpress@servidor.com.br");
        em.getTransaction().begin();
        em.persist(empresa);
        em.getTransaction().commit(); 
        
        entregador = new Entregador();
        entregador.setNome("Joao EhNos Silva");
        entregador.setCpf("000.000.000-00");
        entregador.setRg("9.234.567");
        entregador.setCelular("47 3521 7711");
        entregador.setEmpresa(empresa);
        em.getTransaction().begin();
        em.persist(entregador);
        em.getTransaction().commit();

        Tamanho tamanho;

        tamanho = new Tamanho();
        tamanho.setDescricao("Pequena");
        em.getTransaction().begin();
        em.persist(tamanho);
        em.getTransaction().commit();

        tamanho = new Tamanho();
        tamanho.setDescricao("Media");
        em.getTransaction().begin();
        em.persist(tamanho);
        em.getTransaction().commit();

        tamanho = new Tamanho();
        tamanho.setDescricao("Grande");
        em.getTransaction().begin();
        em.persist(tamanho);
        em.getTransaction().commit();

        tamanho = em.find(Tamanho.class, 2);

        Produto produto = new Produto();
        produto.setNome("Marmita1");
        produto.setDescricao("Arroz, feijão, bife e salada de tomate.");
        produto.setPreco(15.00);
        produto.setTamanho(tamanho);
        em.getTransaction().begin();
        em.persist(produto);
        em.getTransaction().commit();
        
        produto = new Produto();
        produto.setNome("Marmita2");
        produto.setDescricao("Arroz, feijão, bife e ovo frito.");
        produto.setPreco(18.00);
        produto.setTamanho(tamanho);
        em.getTransaction().begin();
        em.persist(produto);
        em.getTransaction().commit();
        
        produto = new Produto();
        produto.setNome("Marmita3");
        produto.setDescricao("Arroz, feijão, file de frango, creme de milho");
        produto.setPreco(14.00);
        produto.setTamanho(tamanho);
        em.getTransaction().begin();
        em.persist(produto);
        em.getTransaction().commit();
        
        produto = new Produto();
        produto.setNome("Marmita4");
        produto.setDescricao("Arroz, feijão, file de frango e salada de tomate.");
        produto.setPreco(10.00);
        produto.setTamanho(tamanho);
        em.getTransaction().begin();
        em.persist(produto);
        em.getTransaction().commit();        
        
        SituacaoPedido situacaoPedido = new SituacaoPedido();
        situacaoPedido.setDescricao("Pendente");
        em.getTransaction().begin();
        em.persist(situacaoPedido);
        em.getTransaction().commit();
        
        situacaoPedido = new SituacaoPedido();
        situacaoPedido.setDescricao("Em trânsito");
        em.getTransaction().begin();
        em.persist(situacaoPedido);
        em.getTransaction().commit();
        
        situacaoPedido = new SituacaoPedido();
        situacaoPedido.setDescricao("Cancelado");
        em.getTransaction().begin();
        em.persist(situacaoPedido);
        em.getTransaction().commit();
        
        situacaoPedido = new SituacaoPedido();
        situacaoPedido.setDescricao("Entregue");
        em.getTransaction().begin();
        em.persist(situacaoPedido);
        em.getTransaction().commit();


        Pedido pedido = new Pedido();
        pedido.setData(util.Funcoes.StringToCalendar("2016-10-30"));
        pedido.setCliente(cliente);
        pedido.setEntregador(entregador);
        pedido.setSituacaoPedido(situacaoPedido);
        pedido.setSub_total(24.0);
        pedido.setTotal(28.5);
        pedido.setValor_entrega(4.5);
        em.getTransaction().begin();
        em.persist(pedido);
        em.getTransaction().commit();
        
        produto = em.find(Produto.class, 3);
        PedidoItem itemPedido = new PedidoItem();
        itemPedido.setPedido(pedido);
        itemPedido.setProduto(produto);
        itemPedido.setQuantidade(1.00);
        itemPedido.setValorUnitario(produto.getPreco());
        itemPedido.setValorTotal(produto.getPreco() * itemPedido.getQuantidade());
        em.getTransaction().begin();
        em.persist(itemPedido);
        em.getTransaction().commit();
        
        produto = em.find(Produto.class, 4);
        itemPedido = new PedidoItem();
        itemPedido.setPedido(pedido);
        itemPedido.setProduto(produto);
        itemPedido.setQuantidade(1.00);
        itemPedido.setValorUnitario(produto.getPreco());
        itemPedido.setValorTotal(produto.getPreco() * itemPedido.getQuantidade());
        em.getTransaction().begin();
        em.persist(itemPedido);
        em.getTransaction().commit();        
  

    }

}
