package wallet.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import wallet.dao.DespesaDao;
import wallet.model.Despesa;
import wallet.model.Receita;

/**
 * Classe controladora faz a captura dos par�metros da tela de edi��o de
 * Despesas, faz a chamada do m�todo para alterar o objeto no banco de dados.
 * 
 * Servlet implementation class editarDespesasController
 */
@WebServlet("/editarDespesasController")
public class editarDespesasController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public editarDespesasController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);

	}

	/**
	 * M�todo DOPOST faz a captura dos par�metros da tela de edi��o de Despesas, faz
	 * a chamada do m�todo para alterar o objeto no banco de dados.
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		SimpleDateFormat formatoDataPagamento = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatoDataPagamentoEsperado = new SimpleDateFormat("yyyy-MM-dd");

		int idContaDespesaEditada = Integer.parseInt(request.getParameter("idContaDespesaEditada"));
		int id = Integer.parseInt(request.getParameter("id"));
		double valor = Double.parseDouble(request.getParameter("inputValor"));
		String paramentoDataPagamento = request.getParameter("inputPagamento");
		String paramentoDataPagamentoEsperado = request.getParameter("inputPagamentoEsperado");
		Date dataPagamento = null;
		Date dataPagamentoEsperado = null;
		String tipoDespesa = request.getParameter("inputTipoDespesa");
		int codigoConta = Integer.parseInt(request.getParameter("inputConta"));
		String mensagem = "<div class=\"alert alert-success mt-3\" role=\"alert\">Despesa editada com sucesso!</div>";
		try {
			dataPagamento = formatoDataPagamento.parse(paramentoDataPagamento);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		try {
			dataPagamentoEsperado = formatoDataPagamentoEsperado.parse(paramentoDataPagamentoEsperado);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Despesa despesa = new Despesa(id, valor, dataPagamento, dataPagamentoEsperado, tipoDespesa, codigoConta);
		new DespesaDao().AlterarDespesa(despesa);
		if (idContaDespesaEditada != codigoConta) {
			despesa.debitarSaldoConta(codigoConta, valor);
			new Receita().adicionaSaldoConta(idContaDespesaEditada, valor);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("listarDespesas.jsp");
		request.setAttribute("mensagem", mensagem);
		dispatcher.forward(request, response);

	}
}
