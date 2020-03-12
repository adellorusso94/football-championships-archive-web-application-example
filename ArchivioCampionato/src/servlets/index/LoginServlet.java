package servlets.index;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databaseConnection.DatabaseConnection;

/**
 * Servlet implementation class Login
 */
@WebServlet("/home")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	// Abbiamo preso username e password
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Abbiamo stabilito una connessione ad db
        Connection conn = DatabaseConnection.getConn();

        try {
            // Definisci sessione
            HttpSession session;

            // Login tifoso
            PreparedStatement smt = conn.prepareStatement("select * from tifoso where (username=? and password= AES_ENCRYPT(?,'key'))");
            smt.setString(1, username);
            smt.setString(2, password);
            ResultSet rs = smt.executeQuery();

            while (rs.next()) {
                // Ottieni dati tifoso dal database
                int id_tifoso = rs.getInt("id_tifoso");
                String nome = rs.getString("nome");
                String cognome = rs.getString("cognome");
                String squadra_tifata = rs.getString("squadra_tifata");

                // Crea sessione contenente dati tifoso
                session = request.getSession(true);
                session.setAttribute("id_tifoso", id_tifoso);
                session.setAttribute("nome", nome);
                session.setAttribute("cognome", cognome);
                session.setAttribute("squadra_tifata", squadra_tifata);

                // Ottieni dati squadra dal database
                PreparedStatement smt1 = conn.prepareStatement("select * from squadra where nome=?");
                smt1.setString(1, squadra_tifata);
                ResultSet rs1 = smt1.executeQuery();
                rs1.next();

                String citta = rs1.getString("citta");
                String stadio = rs1.getString("stadio");
                int anno_fondazione = rs1.getInt("anno_fondazione");
                String nazione = rs1.getString("nazione");

                // Aggiungi dati squadra alla risposta
                session.setAttribute("citta", citta);
                session.setAttribute("stadio", stadio);
                session.setAttribute("anno_fondazione", anno_fondazione);
                session.setAttribute("nazione", nazione);

                // Pagina dove dirigersi
                RequestDispatcher rd = request.getRequestDispatcher("JSP/home.jsp");
                rd.forward(request, response);
            }

            // Username e Password non presenti
            String messaggio = "Username e Password non sono presenti";
            request.setAttribute("messaggio", messaggio);

            // Pagina dove dirigersi
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
