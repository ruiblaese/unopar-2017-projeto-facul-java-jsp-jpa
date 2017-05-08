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

            function somarItens() {
                totalItens = 0.00;
                $('#tabelaItens tr').each(function () {
                    coluna = 0;
                    $(this).find('td').each(function () {
                        if (coluna == 5) {
                            totalItens = totalItens + parseFloat($(this).html());
                        }
                        coluna++;
                    });
                });
                totalItens = totalItens.toFixed(2);
                return totalItens;
            }
            ;

            function html2json() {
                var json = '{';
                var otArr = [];
                var tbl2 = $('#tabelaItens tr').each(function (i) {
                    x = $(this).children();
                    var itArr = [];
                    x.each(function () {
                        itArr.push('"' + $(this).text().trim() + '"');
                    });
                    otArr.push('"' + i + '": [' + itArr.join(',') + ']');
                })
                json += otArr.join(",") + '}'

                return json;
            }



            $(function () {
                $('#formCad').submit(function (event) {
                    event.preventDefault(); // Prevent the form from submitting via the browser                    
                    if (($("#qtdeItens").val() > 0) || ($("#pedidoId").val() > 0)) {
                        var form = $(this);
                        $.ajax({
                            type: form.attr('method'),
                            url: form.attr('action'),
                            data: {
                                pedidoId: $("#pedidoId").val(),
                                data: $("#data").val(),
                                clienteId: $("#clienteId").val(),
                                entregadorId: $("#entregadorId").val(),
                                situacao_pedidoId: $("#situacao_pedidoId").val(),
                                subtotal: $("#subtotal").val(),
                                entrega: $("#entrega").val(),
                                total: $("#total").val(),
                                itens: html2json()
                            }
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
                    } else {
                        alert("Adicione pelo menos um item");
                    }
                });
            });

            $(function () {
                $('#formCadItem').submit(function (event) {
                    event.preventDefault(); // Prevent the form from submitting via the browser
                    if ($("#pedidoId").val() == 0) {
                        var form = $(this);
                        $.ajax({
                            type: form.attr('method'),
                            url: form.attr('action'),
                            data: {
                                qtdeItens: $("#qtdeItens").val().trim(),
                                produtoId: $("#produtoId").val().trim(),
                                qtde: $("#qtde").val()
                            }
                        }).done(function (data) {
                            if (data.search("Erro!") == -1) {
                                $("#qtdeItens").val(parseInt($("#qtdeItens").val()) + 1);
                                if ($("#qtdeItens").val() == 1) {
                                    $("#consItens").html(data);
                                } else {
                                    $("#tabelaItens").append(data.trim());
                                }
                                ;
                                $("#subtotal").val(somarItens());
                                $("#total").val(parseFloat($("#subtotal").val()) + parseFloat($("#entrega").val()))

                            } else {
                                $("#msgErro").text(data);
                                $("#alertaErro").show(2000);
                            }
                        }).fail(function (data) {
                            // Optionally alert the user of an error here...
                            $("#msgErro").text(data);
                            $("#alertaErro").show(2000);
                            alert(data);
                        });
                    }
                });
            });

            function cancelarEdicao() {
                $("#pedidoId").val("");
                $("#data").val("");
                $("#clienteId").val("");
                $("#listaCliente").val("").change();
                $("#entregadorId").val("");
                $("#listaEntregador").val("").change();
                $("#situacao_pedidoId").val("");
                $("#listaSituacao").val("").change();
                $("#subtotal").val("0.00");
                $("#entrega").val("0.00");
                $("#total").val("0.00");
                atualizaGradeItens();

                $("#data").prop('readonly', false);
                $("#clienteId").prop('readonly', false);
                $("#listaCliente").removeAttr('readonly');
                $("#entregadorId").prop('readonly', false);
                $("#listaEntregador").removeAttr('readonly');
                $("#entrega").prop('readonly', false);
            }
            $(function () {
                $('#cancelar').click(function (event) {
                    cancelarEdicao();

                })
            });
            function cancelarEdicaoItem() {
                $("#qtde").val("1");
                $("#produtoId").val("");
            }
            $(function () {
                $('#cancelarItem').click(function (event) {
                    cancelarEdicaoItem();

                })
            });
            function atualizaGrade() {
                $.get("jsp/pedido/consultaParaGrade.jsp", function (data, status) {
                    $("#consPedidos").html(data);
                });
            }
            atualizaGrade();
            function atualizaGradeItens() {
                if ($("#pedidoId").val() > 0) {
                    $.get("jsp/pedido/consultaItens.jsp?pedidoId=" + $("#pedidoId").val(), function (data, status) {
                        $("#consItens").html(data);
                    });
                } else {
                    $("#consItens").html("");
                }
            }
            atualizaGradeItens();

            function excluir(id) {
                if (id > 0) {
                    $.post("jsp/pedido/excluir.jsp", {id: id},
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
                if (id > 0) {
                    $.post("jsp/pedido/consParaAlterar.jsp", {id: id},
                            function (data, status) {
                                if (status == "success") {
                                    var obj = JSON.parse(data);

                                    $('#pedidoId').val(obj.id);
                                    $('#clienteId').val(obj.cliente.id);
                                    $('#listaCliente').val(obj.cliente.id).change();
                                    $('#entregadorId').val(obj.entregador.id);
                                    $('#listaEntregador').val(obj.entregador.id).change();
                                    $('#situacao_pedidoId').val(obj.situacaoPedido.id);
                                    $('#listaSituacao').val(obj.situacaoPedido.id).change();

                                    $('#subtotal').val(obj.sub_total);
                                    $('#entrega').val(obj.valor_entrega);
                                    $('#total').val(obj.total);
                                    if (obj.data) {
                                        $('#data').val(obj.data.year + "-" + addChar((obj.data.month + 1), 2, '0') + "-" + addChar(obj.data.dayOfMonth, 2, '0'));
                                    }
                                    ;
                                    atualizaGradeItens();

                                    $("#data").prop('readonly', true);
                                    $("#clienteId").prop('readonly', true);
                                    $("#listaCliente").attr('readonly', 'readonly');
                                    $("#entregadorId").prop('readonly', true);
                                    $("#listaEntregador").attr('readonly', 'readonly');
                                    $("#entrega").prop('readonly', true);
                                }
                            });

                }
            }
            //cliente
            function aoMudarClienteId() {
                if ($("#clienteId").val() > 0) {
                    $("#listaCliente").val($("#clienteId").val()).change();
                }
            }
            function aoMudarListaCliente() {
                if ($("#listaCliente").val() > 0) {
                    $("#clienteId").val($("#listaCliente").val());
                }
            }
            function atualizaListaCliente() {
                $.get("jsp/pedido/consultaCliente.jsp", function (data, status) {
                    $("#listaCliente").html(data);
                });
            }
            atualizaListaCliente();

            //entregador
            function aoMudarEntregadorId() {
                if ($("#entregadorId").val() > 0) {
                    $("#listaEntregador").val($("#entregadorId").val()).change();
                }
            }
            function aoMudarListaEntregador() {
                if ($("#listaEntregador").val() > 0) {
                    $("#entregadorId").val($("#listaEntregador").val());
                }
            }
            function atualizaListaEntregador() {
                $.get("jsp/pedido/consultaEntregador.jsp", function (data, status) {
                    $("#listaEntregador").html(data);
                });
            }
            atualizaListaEntregador();

            //situacao
            function aoMudarSituacaoId() {
                if ($("#situacao_pedidoId").val() > 0) {
                    $("#listaSituacao").val($("#situacao_pedidoId").val()).change();
                }
            }
            function aoMudarListaSituacao() {
                if ($("#listaSituacao").val() > 0) {
                    $("#situacao_pedidoId").val($("#listaSituacao").val());
                }
            }
            function atualizaListaSituacao() {
                $.get("jsp/pedido/consultaSituacaoPedido.jsp", function (data, status) {
                    $("#listaSituacao").html(data);
                });
            }
            atualizaListaSituacao();

            function aoMudarValorEntrega() {
                $("#entrega").val($("#entrega").val().replace(",","."));
                $("#subtotal").val(somarItens());
                $("#total").val(parseFloat($("#subtotal").val()) + parseFloat($("#entrega").val()));
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
                        <div class="col-md-6">
                            <form class="form-horizontal" id="formCad" name="formCad" action="jsp/pedido/alteracaoCadastro.jsp">
                                <fieldset>
                                    <!-- Form Name -->
                                    <legend>Cadastro de Pedido</legend>

                                    <div class="form-group form-group-sm">
                                        <label for="pedidoId" class="control-label col-sm-2">Id</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="pedidoId" name="pedidoId" placeholder="0" readonly="">
                                        </div>
                                    </div>
                                    <div class="form-group form-group-sm">
                                        <label for="data" class="control-label col-sm-2">Data</label>
                                        <div class="col-sm-4">
                                            <input type="date" class="form-control" id="data" name="data" placeholder="" required="">
                                        </div>
                                    </div>       
                                    <div class="form-group form-group-sm">
                                        <label for="clienteId" class="control-label col-sm-2">Cliente</label>                                        
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="clienteId" name="clienteId" required="" onchange="aoMudarClienteId();">
                                        </div>

                                        <div class="col-md-8">
                                            <select id="listaCliente" name="listaCliente" class="form-control" required="" onchange="aoMudarListaCliente();">
                                                <option value=""></option>
                                                <option value="1">Opcao 1</option>
                                                <option value="2">Option 2</option>
                                            </select>
                                        </div>
                                    </div>                                    
                                    <div class="form-group form-group-sm">
                                        <label for="entregadorId" class="control-label col-sm-2">Entregador</label>                                        
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="entregadorId" name="entregadorId" required="" onchange="aoMudarEntregadorId();">
                                        </div>

                                        <div class="col-md-8">
                                            <select id="listaEntregador" name="listaEntregador" class="form-control" required="" onchange="aoMudarListaEntregador();">
                                                <option value=""></option>
                                                <option value="1">Opcao 1</option>
                                                <option value="2">Option 2</option>
                                            </select>
                                        </div>
                                    </div>                                    
                                    <div class="form-group form-group-sm">
                                        <label for="situacao_pedidoId" class="control-label col-sm-2">Sit.Pedido</label>                                        
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="situacao_pedidoId" name="situacao_pedidoId" required="" onchange="aoMudarSituacaoId();">
                                        </div>

                                        <div class="col-md-8">
                                            <select id="listaSituacao" name="listaSituacao" class="form-control" required="" onchange="aoMudarListaSituacao();">
                                                <option value=""></option>
                                                <option value="1">Opcao 1</option>
                                                <option value="2">Option 2</option>
                                            </select>
                                        </div>
                                    </div>        

                                    <div class="form-group form-group-sm">
                                        <label for="subtotal" class="control-label col-sm-2">Sub.Total</label>                                        
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" id="subtotal" name="subtotal" required="" readonly="" value="0.00">
                                        </div>
                                        <label for="entrega" class="control-label col-sm-2">Entrega</label>                                                                                
                                        <div class="col-sm-3">
                                            <input type="text" class="form-control" id="entrega" name="entrega" required="" value="0.00" onchange="aoMudarValorEntrega();">
                                        </div>
                                    </div>       
                                    <div class="form-group form-group-sm">
                                        <label for="total" class="control-label col-sm-2">Total</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="total" name="total" placeholder="" required="" readonly="" value="0.00">

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

                            </br>
                            <div  class="hidden">
                                <input type="text" class="form-control" id="qtdeItens" name="qtdeItens" value="0" hidden="">
                            </div>
                            </br>

                        </div>                        
                        <div class="col-md-6">

                            <form class="form-horizontal" id="formCadItem" name="formCadItem" action="jsp/pedido/adicionaItem.jsp">
                                <fieldset>
                                    <!-- Form Name -->
                                    <legend>Adicionar Item</legend>
                                    <div class="form-group form-group-sm">
                                        <label for="qtde" class="control-label col-sm-2">Qtde</label>                                        
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="qtde" name="qtde" value="1" required="">
                                        </div>
                                        <label for="produtoId" class="control-label col-sm-2">Produto</label>                                                                                
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="produtoId" name="produtoId" required="">
                                        </div>
                                        <div id="salvarGroup" class="btn-group" role="group" aria-label="">
                                            <button type="submit" id="salvar" name="salvar" class="btn btn-info btn-sm" aria-label="Salvar">Adicionar</button>
                                            <button type="button" id="cancelarItem" name="cancelarItem" class="btn btn-info btn-sm" aria-label="Salvar">Cancelar</button>
                                        </div>
                                    </div>       
                                </fieldset>
                            </form>
                            <br>
                            <fieldset>
                                <legend>Itens</legend>
                                <div class="col-md-12" id="consItens" name="consItens">
                            </fieldset>
                        </div>                        
                    </div>
                    <div class="row">
                        <div class="col-md-12">

                        </div>
                    </div>
                    <div class="row">                                                
                        <legend>Consulta Pedidos</legend>
                        <div class="col-md-12" id="consPedidos" name="consPedidos">
                            aguarde... efetuando consulta
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>