package servlets.campionato;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databaseConnection.DatabaseConnection;

/**
 * Servlet implementation class VisualizzaGiornata
 */
@WebServlet("/visualizza_giornata")
public class VisualizzaGiornata extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VisualizzaGiornata() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn;
		
		String giornata = request.getParameter("giornateOption");
		ArrayList<String> giornate = new ArrayList<String>();

		try {
			conn = DatabaseConnection.getConn();
			HttpSession session;
			session = request.getSession(true);
			String codCamp = (String) session.getAttribute("campionato");

			
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
		
		
		RequestDispatcher rd = request.getRequestDispatcher("JSP/calendario.jsp");
		request.setAttribute("giornataSel", giornata);
		request.setAttribute("giornate", giornate);

		rd.forward(request, response);
		
	}

}
