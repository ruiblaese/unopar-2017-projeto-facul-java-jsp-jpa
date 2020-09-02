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
                $("#entregadorId").val("");                
                $("#nome").val("");
                $("#rg").val("");
                $("#cpf").val("");
                $("#celular").val("");
                $("#empresaId").val("");
                $("#listaEmpresa").val("").change();
            }
            $(function () {
                $('#cancelar').click(function (event) {
                    cancelarEdicao();
                });
            });
            function atualizaGrade() {
                $.get("jsp/entregador/consultaParaGrade.jsp", function (data, status) {
                    $("#consEntregadors").html(data);
                });
            }
            atualizaGrade();
            function excluir(id) {
                if (id > 0) {
                    $.post("jsp/entregador/excluir.jsp", {id: id},
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
                $.post("jsp/entregador/consParaAlterar.jsp", {id: id},
                        function (data, status) {
                            if (status == "success") {
                                var obj = JSON.parse(data);
                                $('#entregadorId').val(obj.id);                                
                                $('#nome').val(obj.nome);
                                $('#cpf').val(obj.cpf);
                                $('#rg').val(obj.rg);
                                $('#celular').val(obj.celular);
                                $('#empresaId').val(obj.empresa.id);
                                $('#listaEmpresa').val(obj.empresa.id).change();
                            }
                        });
            }

            function aoMudarEmpresaId() {
                if ($("#empresaId").val() > 0) {
                    $("#listaEmpresa").val($("#empresaId").val()).change();
                }
            }
            function aoMudarListaEmpresa() {
                if ($("#listaEmpresa").val() > 0) {
                    $("#empresaId").val($("#listaEmpresa").val());
                }
            }            
            function atualizaListaEmpresa() {
                $.get("jsp/entregador/consultaEmpresa.jsp", function (data, status) {
                    $("#listaEmpresa").html(data);
                });
            }            
            atualizaListaEmpresa();

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
                            <form class="form-horizontal" id="formCad" name="formCad" action="jsp/entregador/alteracaoCadastro.jsp">
                                <fieldset>
                                    <!-- Form Name -->
                                    <legend>Cadastro de Entregador</legend>

                                    <div class="form-group form-group-sm">
                                        <label for="entregadorId" class="control-label col-sm-2">Id</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="entregadorId" name="entregadorId" placeholder="0" readonly="">

                                        </div>
                                    </div>

                                    <div class="form-group form-group-sm">
                                        <label for="nome" class="control-label col-sm-2">Nome</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="nome" name="nome" placeholder="" required="">

                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="cpf" class="control-label col-sm-2">CPF</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="cpf" name="cpf" placeholder="" required="">

                                        </div>
                                    </div>                                    
                                    <div class="form-group form-group-sm">
                                        <label for="rg" class="control-label col-sm-2">RG</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="rg" name="rg" placeholder="" required="">

                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="celular" class="control-label col-sm-2">Celular</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="celular" name="celular" placeholder="" required="">

                                        </div>
                                    </div>                                    

                                    <div class="form-group form-group-sm">
                                        <label for="empresaId" class="control-label col-sm-2">Empresa</label>                                        
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="empresaId" name="empresaId" onchange="aoMudarEmpresaId();">
                                        </div>

                                        <div class="col-md-8">
                                            <select id="listaEmpresa" name="listaEmpresa" class="form-control" onchange="aoMudarListaEmpresa();">
                                                <option value=""></option>
                                                <option value="1">Opcao 1</option>
                                                <option value="2">Option 2</option>
                                            </select>
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
                        <div class="col-md-">
                        </div>                        
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8" id="consEntregadors" name="consEntregadors">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
