<%@page import="java.text.DecimalFormat"%>
    <%@page import="java.text.SimpleDateFormat"%>
        <%@page import="wallet.model.Despesa"%>
            <%@page import="java.util.List"%>
                <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                    <!DOCTYPE html>
                    <html lang="pt-BR">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                        <link rel="stylesheet" href="css/Style.css">
                        <link rel="stylesheet" href="css/bootstrap.min.css">
                        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css?ver=4.7.0">
                        <title>Wallet Control</title>
                    </head>

                    <body class="bg-azul">
                        <header>
                            <nav class="navbar navbar-expand-lg navbar-light bg-vermelho">
                                <a class="navbar-brand" href="index.jsp">Wallet Control</a>
                                <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Alterna navegação">
                    <i class="fa fa-bars"></i>
                </button>
                                <div class="collapse navbar-collapse" id="navbarNav">
                                    <ul class="navbar-nav">
                                        <li class="nav-item active">
                                            <a class="nav-link" href="receitas.jsp">Receitas</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="despesas.jsp">Despesas</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="contas.jsp">Contas</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </header>
                        <section class="text-center m-5">
                            <h1>Despesas</h1>
                        </section>
                        <section>
                            <div class="container-fluid">
                                <form action="listarDespesas" method="post">
                                    <div class="form-row mb-3">
                                        <div class="form-group col-md-3">
                                            <button class="btn border border-white text-white" id="listarTodas" type="submit" name="listarTodas">Listar Todas</button>
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label class="lb-filtroTipo" for="inputTipoDespesa">Filtro por Tipo:</label>
                                            <select id="inputTipoDespesa" class="form-control d-inline sel-filtro" name="inputTipoDespesa">
                                            <option class="text-dark"  selected></option>
                                            <option class="text-dark" >Salário</option>
                                            <option class="text-dark" >Presente</option>
                                            <option class="text-dark" >Prêmio</option>
                                            <option class="text-dark" >Outros</option>
                                        </select>
                                            <button class="btn border border-white text-white" id="filtroPorTipo" type="submit" name="filtroPorTipo"><i class="fa fa-filter" aria-hidden="true"></i></button>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="lb-filtroTipo" for="inputPeriodo">Período:</label>
                                            <input type="date" class="form-control data-filtro d-inline" id="dataInicio" name="dataInicio" placeholder="Início">
                                            <label class="d-inline m-3" for="inputFiltroPeriodo"> - </label>
                                            <input type="date" class="form-control data-filtro d-inline" id="dataFim" name="dataFim" placeholder="Fim">
                                            <button class="btn border border-white text-white d-inline" id="filtroPorPeriodo" type="submit" name="filtroPorPeriodo"><i class="fa fa-filter" aria-hidden="true"></i></button>
                                        </div>
                                    </div>
                                </form>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Valor</th>
                                            <th scope="col">Pagamento</th>
                                            <th scope="col">Pagamento Esperado</th>
                                            <th scope="col">Tipo de Receita</th>
                                            <th scope="col">Conta</th>
                                            <th scope="col"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></th>
                                            <th scope="col"><i class="fa fa-trash-o" aria-hidden="true"></i></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                    String mensagem = (String) request.getAttribute("mensagem");
                            
                            		if(mensagem != null){
                            			out.print(mensagem);
                            		}
                            			
                            		Double totalSoma = 0.0;
                                
                                    if(request.getAttribute("receitas") != null){
                                        List<?> despesas = (List<?>) request.getAttribute("despesas");
                                        for(int contador = 0; contador <= (despesas.size() - 1); contador++){
                                            Despesa despesa = (Despesa) despesas.get(contador);
                                            totalSoma += despesa.getValor();
                                		%>
                                            <form action="modificarDespesas" method="post">
                                                <tr>
                                                    <th scope="row">
                                                        <% out.print(despesa.getIdDespesa()); %>
                                                            <input type="hidden" name="idItemExcluido" value="<% out.print(despesa.getIdDespesa()); %>">
                                                    </th>
                                                    <td>
                                                        <% 
                                                        DecimalFormat df = new DecimalFormat("###,###.00");
                                                        out.print("R$ "+ df.format(despesa.getValor())); 
                                                        %>
                                                    </td>
                                                    <td>
                                                        <% 
                                                    SimpleDateFormat formatoDataPagamento = new SimpleDateFormat("dd/MM/yyyy");  
                                                    String strDataPagamento = formatoDataPagamento.format(despesa.getDataPagamento());                                                    
                                                    out.print(strDataPagamento); 
                                                    %>
                                                    </td>
                                                    <td>
                                                        <% 
                                                    SimpleDateFormat formatoDataPagamentoEsperado = new SimpleDateFormat("dd/MM/yyyy");  
                                                    String strDataPagamentoEsperado = formatoDataPagamentoEsperado.format(despesa.getDataPagamentoEsperado());                                                    
                                                    out.print(strDataPagamento);
                                                    %>
                                                    </td>
                                                    <td>
                                                        <% out.print(despesa.getTipoDespesa()); %>
                                                    </td>
                                                    <td>
                                                        <% out.print(despesa.getConta()); %>
                                                    </td>
                                                    <td>
                                                        <input type="submit" class="btn text-white font-italic font-weight-bold" name="editar" value="Editar">
                                                    </td>
                                                    <td>
                                                        <input type="submit" class="btn text-white font-italic font-weight-bold" name="excluir" value="Excluir">
                                                    </td>
                                                </tr>
                                            </form>
                                            <% }} %>
                                    </tbody>
                                </table>
                                <div class="form-row">
                                    <div class="form-group col-md-12 text-left">
                                        <p class="totalsoma vermelho">
                                            Total:
                                            <% 
                            		DecimalFormat dfTotal = new DecimalFormat("###,###.00"); 
                            		out.print("R$ " + dfTotal.format(totalSoma)); %>
                                        </p>
                                    </div>
                                </div>
                                </form>
                            </div>
                        </section>
                        <script type='text/javascript' src='js/bootstrap.min.js'></script>
                    </body>

                    </html>