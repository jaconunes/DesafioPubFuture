package wallet.controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import wallet.model.Conta;
import wallet.model.Despesa;
import wallet.model.Receita;

/**
 * Classe controladora captura o par�metro dos bot�es clicados e realiza as
 * a��es de acordo com cada bot�o.
 * 
 * Servlet implementation class modificarDespesasController
 */
@WebServlet("/modificarDespesasController")
public class modificarDespesasController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public modificarDespesasController() {
		super();
	}

	/**
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);

	}

	/**
	 * M�todo DOPOST captura a a��o na JSP de acordo com cada bot�o clicado realiza
	 * uma a��o, editar ou excluir.
	 * 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		ArrayList<Conta> contas = new Conta().listarContas();
		ArrayList<Despesa> despesas = new Despesa().listarDespesas();
		String mensagem = "<div class=\"alert alert-success mt-3\" role=\"alert\">Receita exclu�da com sucesso!</div>";

		if (request.getParameter("excluir") != null && request.getParameter("idItemExcluido") != null) {

			new Despesa().excluir(Integer.valueOf(request.getParameter("idItemExcluido")));
			new Receita().adicionaSaldoConta(Integer.parseInt(request.getParameter("codigoConta")),
					Double.parseDouble(request.getParameter("valorDespesa")));
			request.setAttribute("mensagem", mensagem);
			request.setAttribute("despesas", despesas);			
			RequestDispatcher dispatcher = request.getRequestDispatcher("listarDespesas.jsp");			
			dispatcher.forward(request, response);
		} else if (request.getParameter("editar") != null && request.getParameter("idItemExcluido") != null) {
			Despesa despesa = new Despesa().buscarDespesaPorId(Integer.valueOf(request.getParameter("idItemExcluido")));
			request.setAttribute("listaContas", contas);
			request.setAttribute("despesa", despesa);
			RequestDispatcher dispatcher = request.getRequestDispatcher("editarDespesa.jsp");
			dispatcher.forward(request, response);
		}
	}
}
