<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Language" content="pt-br">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <%@page import="util.Funcoes"%>

        <title><% out.print(util.Funcoes.TITULOHTML); %></title>

        <!--
            Bibiografia:
                http://getfuelux.com/formbuilder.html
                www.layoutit.com/build
                w3school
        -->

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/scripts.js"></script>
    </head>
    <body>
        <%
            String login = null;
            String senha = null;
            
            if (request.getParameterMap().containsKey("login") && (request.getParameterMap().containsKey("senha"))) {
                login = request.getParameter("login");
                senha = request.getParameter("senha");                
                if ((login != null)&&(senha != null) && (login.equalsIgnoreCase("admin")) && (senha.equalsIgnoreCase("admin"))){ 
                    session.setAttribute("logado", true);
                    session.setAttribute("adm", true);
                } else{
                    session.setAttribute("logado", false);
                    session.setAttribute("adm", false);                    
                }
            }


        %>

        <div class="container-fluid">
            <div class="row">                
                <div class="col-md-12">
                    <%@ include file="menu.jsp"%>
                    <center>
                        </br>   
                        </br>   
                        </br>   
                        </br>   
                        <img src="img/chocolates.jpg" class="img-rounded" alt="Cinque Terre">
                    </center>
                </div>
            </div>
        </div>
    </body>
</html>