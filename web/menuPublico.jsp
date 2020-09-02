<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
    <div class="navbar-header">

        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
        </button> <a class="navbar-brand" href="#">Unopar Choco</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li class="active">
                <a href="index.jsp">Home</a>
            </li>                                            
        </ul>                            

        <form id="signin" class="navbar-form navbar-right" role="form" method="POST" action="index.jsp">
            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                <input id="email" type="text" class="form-control" name="login" value="" placeholder="Login">                                        
            </div>

            <div class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input id="password" type="password" class="form-control" name="senha" value="" placeholder="Senha">                                        
            </div>

            <button type="submit" class="btn btn-primary">Login</button>
        </form>

    </div>

</nav>