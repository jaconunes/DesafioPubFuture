<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="wallet.model.Receita"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="css/Style.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css?ver=4.7.0">
<title>Wallet Control</title>
</head>

<body class="bg-azul">
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-vermelho">
			<a class="navbar-brand" href="index.jsp">Wallet Control</a>
			<button class="navbar-toggler text-white" type="button"
				data-toggle="collapse" data-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Alterna navegação">
				<i class="fa fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link"
						href="receitas.jsp">Receitas</a></li>
					<li class="nav-item"><a class="nav-link" href="despesas.jsp">Despesas</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="contas.jsp">Contas</a>
					</li>
				</ul>
			</div>
		</nav>
	</header>
	<section class="text-center m-5">
		<h1>Receitas</h1>
	</section>
	<section>
		<div class="container-fluid">
			<form action="listarReceitas" method="post">
				<div class="form-row mb-3">
					<div class="form-group col-md-3">
						<button class="btn bg-transparent border border-white text-white"
							id="listarTodas" type="submit" name="listarTodas">Listar
							Todas</button>
					</div>
					<div class="form-group col-md-3">
						<label class="lb-filtroTipo" for="inputTipoReceita">Filtro
							por Tipo:</label> <select id="inputTipoReceita"
							class="form-control d-inline sel-filtro" name="inputTipoReceita">
							<option class="text-dark" selected></option>
							<option class="text-dark">Salário</option>
							<option class="text-dark">Presente</option>
							<option class="text-dark">Prêmio</option>
							<option class="text-dark">Outros</option>
						</select>
						<button class="btn bg-transparent border border-white text-white"
							id="filtroPorTipo" type="submit" name="filtroPorTipo">
							<i class="fa fa-filter" aria-hidden="true"></i>
						</button>
					</div>
					<div class="form-group col-md-6">
						<label class="lb-filtroTipo" for="inputPeriodo">Período:</label> <input
							type="date" class="form-control data-filtro d-inline"
							id="dataInicio" name="dataInicio" placeholder="Início"> <label
							class="d-inline m-3" for="inputFiltroPeriodo"> - </label> <input
							type="date" class="form-control data-filtro d-inline"
							id="dataFim" name="dataFim" placeholder="Fim">
						<button class="btn bg-transparent border border-white text-white d-inline"
							id="filtroPorPeriodo" type="submit" name="filtroPorPeriodo">
							<i class="fa fa-filter" aria-hidden="true"></i>
						</button>
					</div>
				</div>
			</form>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Valor</th>
						<th scope="col">Recebimento</th>
						<th scope="col">Recebimento Esperado</th>
						<th scope="col">Descrição</th>
						<th scope="col">Conta</th>
						<th scope="col">Tipo de Receita</th>
						<th scope="col">Editar</th>
						<th scope="col">Excluir</th>
					</tr>
				</thead>
				<tbody>
					<%
					String mensagem = (String) request.getAttribute("mensagem");

					if (mensagem != null) {
						out.print(mensagem);
					}

					Double totalSoma = 0.0;

					if (request.getAttribute("receitas") != null) {
						List<?> receitas = (List<?>) request.getAttribute("receitas");
						for (int contador = 0; contador <= (receitas.size() - 1); contador++) {
							Receita receita = (Receita) receitas.get(contador);
							totalSoma += receita.getValorReceita();
					%>
					<form action="modificarReceitas" method="post">
						<tr>
							<th scope="row">
								<%
								out.print(receita.getIdReceita());
								%> <input type="hidden"
								name="idItemExcluido"
								value="<%out.print(receita.getIdReceita());%>">
							</th>
							<td>
								<%
								DecimalFormat df = new DecimalFormat("###,###.00");
								out.print("R$ " + df.format(receita.getValorReceita()));
								%> <input
								type="hidden" name="valorReceita"
								value="<%out.print(receita.getValorReceita());%>">
							</td>
							<td>
								<%
								SimpleDateFormat formatoDataRecebimento = new SimpleDateFormat("dd/MM/yyyy");
								String strDataRecebimento = formatoDataRecebimento.format(receita.getDataRecebimento());
								out.print(strDataRecebimento);
								%>
							</td>
							<td>
								<%
								SimpleDateFormat formatoDataRecebimentoEsperado = new SimpleDateFormat("dd/MM/yyyy");
								String strDataRecebimentoEsperado = formatoDataRecebimentoEsperado.format(receita.getDataRecebimentoEsperado());
								out.print(strDataRecebimento);
								%>
							</td>
							<td>
								<%
								out.print(receita.getDescricao());
								%>
							</td>
							<td>
								<%
								out.print(receita.getCodigoConta() + " - " + receita.buscarContaPorCodigo(receita.getCodigoConta()));
								%>
							</td>
							<td>
								<%
								out.print(receita.getTipoReceita());
								%>
							</td>
							<td>
								<button class="btn-icons" type="submit" name="editar">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
								</button> <input type="hidden" name="codigoConta"
								value="<%out.print(receita.getCodigoConta());%>">
							</td>
							<td>
								<button class="btn-icons" type="submit" name="excluir">
									<i class="fa fa-trash-o" aria-hidden="true"></i>
								</button>
							</td>
						</tr>
					</form>
					<%
					}
					}
					%>
				</tbody>
			</table>
			<div class="form-row">
				<div class="form-group col-md-12 text-left">
					<p class="totalsoma vermelho">
						Total:
						<%
					DecimalFormat dfTotal = new DecimalFormat("###,###.00");
					out.print("R$ " + dfTotal.format(totalSoma));
					%>
					</p>
				</div>

			</div>
			</form>
		</div>
	</section>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
</body>

</html>