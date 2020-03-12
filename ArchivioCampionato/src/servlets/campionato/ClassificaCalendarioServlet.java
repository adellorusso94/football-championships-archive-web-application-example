package servlets.campionato;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databaseConnection.DatabaseConnection;

/**
 * Servlet implementation class ClassificaServleet
 */
@WebServlet("/daticampionato")
public class ClassificaCalendarioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ClassificaCalendarioServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String camp = request.getParameter("camp");
		String stagione = camp.substring(7);
		String codCamp = null;
		camp = camp.substring(0, stagione.length() - 2);
		Connection conn = DatabaseConnection.getConn(); // abbiamo stabilito una connessione ad db
		
		// Classifica
		if (request.getParameter("home").equals("Classifica")) {

			try {

				String query1 = "select cod_campionato from campionato where nome=? and stagione=?";
				PreparedStatement st = conn.prepareStatement(query1);
				st.setString(1, camp);
				st.setString(2, stagione);
				ResultSet rs = st.executeQuery();
				rs.next();
				codCamp = rs.getString(1);

			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("JSP/classifica.jsp");
			request.setAttribute("codcamp", codCamp);
			request.setAttribute("nomecamp", camp);
			request.setAttribute("stagcamp", stagione);
			rd.forward(request, response);
			
		}
		
		// Calendario
		ArrayList<String> giornate = new ArrayList<String>();
		if (request.getParameter("home").equals("Calendario")) {
			
			HttpSession session;
			
			try {
				
				String query1 = "select cod_campionato from campionato where nome=? and stagione=?";
				PreparedStatement st = conn.prepareStatement(query1);
				st.setString(1, camp);
				st.setString(2, stagione);
				ResultSet rs = st.executeQuery();
				rs.next();
				codCamp = rs.getString(1);
				
				String query2 = "select giornata from partita where campionato_partita=? group by giornata";
				PreparedStatement st2 = conn.prepareStatement(query2);
				st2.setString(1, codCamp);
				ResultSet rs2 = st2.executeQuery();
				while (rs2.next()) {
                    giornate.add(rs2.getString(1));
                }
				
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
			
			session = request.getSession(true);
			session.setAttribute("campionato", codCamp);
			session.setAttribute("nomecamp", camp);
			session.setAttribute("stagcamp", stagione);
			
			RequestDispatcher rd = request.getRequestDispatcher("JSP/calendario.jsp");
			request.setAttribute("giornate", giornate);
			rd.forward(request, response);
			
		}
	}
}
