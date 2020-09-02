<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Language" content="pt-br">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title><% out.print(util.Funcoes.TITULOHTML); %></title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
            $(function () {
                $('#formCad').submit(function (event) {
                    event.preventDefault(); // Prevent the form from submitting via the browser
                    var form = $(this);
                    $.ajax({
                        type: form.attr('method'),
                        url: form.attr('action'),
                        data: form.serialize()
                    }).done(function (data) {
                        if (data.trim() == "success") {
                            atualizaGrade();
                            cancelarEdicao();
                            $("#msgSucesso").text("Registro cadastrado!");
                            $("#alertaSucesso").show(1000, function () {
                                setTimeout(function () {
                                    $("#alertaSucesso").hide(1000)
                                }, 2000);

                            });
                        } else {
                            $("#msgErro").text(data);
                            $("#alertaErro").show(2000);
                            alert(data);
                        }
                    }).fail(function (data) {
                        // Optionally alert the user of an error here...
                        $("#msgErro").text(data);
                        $("#alertaErro").show(2000);
                        alert(data);
                    });
                });
            });

            function cancelarEdicao() {
                $("#clienteId").val("");
                $("#nome").val("");
                $("#telefone").val("");
                $("#endereco").val("");
                $("#ponto_referencia").val("");
                $("#nascimento").val("");
            }

            $(function () {
                $('#cancelar').click(function (event) {
                    cancelarEdicao();

                })
            });
            function atualizaGrade() {
                $.get("jsp/cliente/consultaParaGrade.jsp", function (data, status) {
                    $("#consClientes").html(data);
                });
            }
            atualizaGrade();
            function excluir(id) {
                if (id > 0) {
                    $.post("jsp/cliente/excluir.jsp", {id: id},
                            function (data, status) {
                                if (status == "success") {
                                    if (data.trim() == "success") {
                                        atualizaGrade();
                                        $("#msgSucesso").text("Registro excluido!");
                                        $("#alertaSucesso").show(1000, function () {
                                            setTimeout(function () {
                                                $("#alertaSucesso").hide(1000)
                                            }, 2000);
                                        });
                                    } else {
                                        $("#msgErro").text(data);
                                        $("#alertaErro").show(1000, function () {
                                            setTimeout(function () {
                                                $("#alertaSucesso").hide(1000)
                                            }, 2000);
                                        });
                                    }
                                }
                            })
                }
            }
            function addChar(str, tamanho, char) {
                var str2 = str + '';
                while (str2.length < tamanho) {
                    str2 = '' + char + '' + str2 + '';
                }
                return str2;
            }
            function editar(id) {
                $.post("jsp/cliente/consParaAlterar.jsp", {id: id},
                        function (data, status) {
                            if (status == "success") {
                                var obj = JSON.parse(data);

                                $('#clienteId').val(obj.id);
                                $('#nome').val(obj.nome);
                                $('#telefone').val(obj.telefone);
                                $('#endereco').val(obj.endereco);
                                $('#ponto_referencia').val(obj.ponto_referencia);
                                if (obj.nascimento) {
                                    $('#nascimento').val(obj.nascimento.year + "-" + addChar((obj.nascimento.month + 1), 2, '0') + "-" + addChar(obj.nascimento.dayOfMonth, 2, '0'));
                                }
                            }
                        });
            }
        </script>
    </head>
    <body>

        <div class="container-fluid">
            <div class="row">                
                <div class="col-md-12">
                    <jsp:include page="menu.jsp" />
                    <br>
                    <br>
                    <br>                        
                    <div class="alert alert-dismissable alert-success" id="alertaSucesso" name="alertaSucesso" hidden>                                                
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                            ×
                        </button>
                        <h4>
                            Sucesso!
                        </h4><p id="msgSucesso"> <!--<strong>Warning!</strong>--> msg <!--<a href="#" class="alert-link">alert link</a> --></p>
                    </div>
                    <div class="alert alert-dismissable alert-danger" id="alertaErro" name="alertaErro" hidden>                                                
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                            ×
                        </button>
                        <h4>
                            Erro!
                        </h4><p id="msgErro"> <!--<strong>Warning!</strong>--> msg <!--<a href="#" class="alert-link">alert link</a> --></p>
                    </div>                    
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <form class="form-horizontal" id="formCad" name="formCad" action="jsp/cliente/alteracaoCadastro.jsp">
                                <fieldset>
                                    <!-- Form Name -->
                                    <legend>Cadastro de Cliente</legend>

                                    <div class="form-group form-group-sm">
                                        <label for="clienteId" class="control-label col-sm-2">Id</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="clienteId" name="clienteId" placeholder="0" readonly="">

                                        </div>
                                    </div>

                                    <div class="form-group form-group-sm">
                                        <label for="nome" class="control-label col-sm-2">Nome</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="nome" name="nome" placeholder="" required="">

                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="telefone" class="control-label col-sm-2">Telefone</label>
                                        <div class="col-sm-5">
                                            <input type="text" class="form-control" id="telefone" name="telefone" placeholder="" required="">
                                        </div>
                                    </div>                                    
                                    <div class="form-group form-group-sm">
                                        <label for="endereco" class="control-label col-sm-2">Endereço</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="endereco" name="endereco" placeholder="" required="">
                                        </div>
                                    </div>                                                                        
                                    <div class="form-group form-group-sm">
                                        <label for="ponto_referencia" class="control-label col-sm-2">Ponto Ref.</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" id="ponto_referencia" name="ponto_referencia" placeholder="" required="">
                                        </div>
                                    </div>                                    
                                    <div class="form-group form-group-sm">
                                        <label for="nascimento" class="control-label col-sm-2">Nascimento</label>
                                        <div class="col-sm-4">
                                            <input type="date" class="form-control" id="nascimento" name="nascimento" placeholder="">
                                        </div>
                                    </div>                                           

                                    <div class="form-group">
                                        <label class="control-label col-sm-2"></label>
                                        <div class="text-right col-sm-10">
                                            <div id="salvarGroup" class="btn-group" role="group" aria-label="">
                                                <button type="submit" id="salvar" name="salvar" class="btn btn-success btn-sm" aria-label="Salvar">Salvar</button>
                                                <button type="button" id="cancelar" name="cancelar" class="btn btn-danger btn-sm" aria-label="Salvar">Cancelar</button>
                                            </div>

                                        </div>
                                    </div>


                                </fieldset>
                            </form>
                        </div>                        
                        <div class="col-md-2">
                        </div>                        
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8" id="consClientes" name="consClientes">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>