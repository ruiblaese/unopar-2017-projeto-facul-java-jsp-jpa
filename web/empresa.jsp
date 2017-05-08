<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Language" content="pt-br">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Casa das Marmitas</title>

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
                $("#empresaId").val("");
                $("#nome").val("");
                $("#cnpj").val("");
                $("#endereco").val("");
                $("#telefone").val("");
                $("#email").val("");
            }

            $(function () {
                $('#cancelar').click(function (event) {
                    cancelarEdicao();

                })
            });
            function atualizaGrade() {
                $.get("jsp/empresa/consultaParaGrade.jsp", function (data, status) {
                    $("#consEmpresas").html(data);
                });
            }
            atualizaGrade();
            function excluir(id) {
                if (id > 0) {
                    $.post("jsp/empresa/excluir.jsp", {id: id},
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
            function editar(id) {
                $.post("jsp/empresa/consParaAlterar.jsp", {id: id},
                        function (data, status) {
                            if (status == "success") {
                                var obj = JSON.parse(data);
                                $('#empresaId').val(obj.id);
                                $('#nome').val(obj.nome);
                                $('#cnpj').val(obj.cnpj);
                                $('#endereco').val(obj.endereco);
                                $('#telefone').val(obj.telefone);
                                $('#email').val(obj.email);
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
                            <form class="form-horizontal" id="formCad" name="formCad" action="jsp/empresa/alteracaoCadastro.jsp">
                                <fieldset>
                                    <!-- Form Name -->
                                    <legend>Cadastro de Empresa</legend>

                                    <div class="form-group form-group-sm">
                                        <label for="empresaId" class="control-label col-sm-2">Id</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="empresaId" name="empresaId" placeholder="0" readonly="">

                                        </div>
                                    </div>

                                    <div class="form-group form-group-sm">
                                        <label for="nome" class="control-label col-sm-2">Descrição</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="nome" name="nome" placeholder="" required="">

                                        </div>
                                    </div>                                    
                                    <div class="form-group form-group-sm">
                                        <label for="cnpj" class="control-label col-sm-2">CNPJ</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="cnpj" name="cnpj" placeholder="" required="">

                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="endereco" class="control-label col-sm-2">Endereço</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="endereco" name="endereco" placeholder="" required="">

                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="telefone" class="control-label col-sm-2">Telefone</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="telefone" name="telefone" placeholder="" required="">

                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="email" class="control-label col-sm-2">Email</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="email" name="email" placeholder="" required="">

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
                        <div class="col-md-8" id="consEmpresas" name="consEmpresas">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>