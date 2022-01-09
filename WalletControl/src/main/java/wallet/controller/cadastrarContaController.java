package wallet.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import wallet.model.Conta;

/**
 * Servlet implementation class cadastrarContaController
 */
public class cadastrarContaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public cadastrarContaController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.doPost(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");		
		
		double valor = Double.parseDouble(request.getParameter("inputValor"));
		String tipoConta = request.getParameter("selectTipoConta");
		String instituicao = request.getParameter("inputNomeInstituicao");
		String mensagem = "<div class=\"alert alert-success mt-3\" role=\"alert\">Conta cadastrada com sucesso!</div>";	
			
			Conta conta = new Conta(valor, tipoConta, instituicao);
			conta.salvar();			
					
			RequestDispatcher dispatcher = request.getRequestDispatcher("contas.jsp");
			request.setAttribute("mensagem", mensagem);			
			dispatcher.forward(request, response);

	}
}
