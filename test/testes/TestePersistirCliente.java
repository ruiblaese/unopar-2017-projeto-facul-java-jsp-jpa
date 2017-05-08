package testes;

import jpa.EntityManagerUtil;
import modelo.Cliente;
import java.util.Calendar;
import javax.persistence.EntityManager;
import junit.framework.Assert;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 *
 * @author jorge
 */
public class TestePersistirCliente {
    
    EntityManager em;
    
    public TestePersistirCliente() {
    }
    
    @Before
    public void setUp() {
        em = EntityManagerUtil.getEntityManager();
    }
    
    @After
    public void tearDown() {        
        em.close();
    }
    
    @Test
    public void teste(){
        boolean exception = false;
        try {
            Cliente cliente = new Cliente();
            cliente.setNome("rui");
            cliente.setTelefone("47 88180000");
            cliente.setEndereco("rua tocantins");
            cliente.setPonto_referencia("aqui");            
            cliente.setNascimento(null);
            em.getTransaction().begin();
            em.persist(cliente);
            em.getTransaction().commit();
        } catch (Exception e){
            exception = true;
            e.printStackTrace();
        }
        Assert.assertEquals(false, exception);
        
    }
    
}

