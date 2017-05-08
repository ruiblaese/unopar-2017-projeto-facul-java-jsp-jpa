/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package testes;

import java.util.Map;
import java.util.TreeMap;
import com.google.gson.Gson;
import java.util.Iterator;
import java.util.Map.Entry;

/**
 *
 * @author RUIBL
 */
public class testeJson {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        String json = "{\"0\": [\"#\",\"Qtde\",\"# Produto\",\"Produto\",\"Valor\",\"Valor total\",\"\",\"\"],\"1\": [\"1\",\"1.0\",\"1\",\"marmita1\",\"\",\"\",\"\",\"\"]}";

        Map mapaItens = new com.google.gson.Gson().fromJson(json, TreeMap.class);

        Iterator linhas = mapaItens.entrySet().iterator();
        while (linhas.hasNext()) {
            Entry linhaAtual = (Entry) linhas.next();
            String seqLinha = linhaAtual.getKey().toString();
            String valorLinhas = linhaAtual.getValue().toString();

            if (Integer.parseInt(seqLinha) > 0) {                                
                valorLinhas = valorLinhas.substring(1, valorLinhas.length() - 2);
                String[] colunas = valorLinhas.split(",");
                
                System.out.print("id: " + colunas[0]);
                System.out.print("qtde: " + colunas[1]);
                System.out.print("produtoId: " + colunas[2]);
                System.out.print("descricao: " + colunas[3]);
                System.out.print("valor: " + colunas[4]);
                System.out.print("total: " + colunas[5]);
                                
            }

            // ...
        }

    }

}
