package servlets.index;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import databaseConnection.DatabaseConnection;

/**
 * Servlet implementation class Registrazione
 */
@WebServlet("/nuovo_utente")
public class RegistrazioneServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrazioneServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        //response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String squadra_sel = request.getParameter("squadre");

        if (username.length() == 0 || password.length() == 0 || nome.length() == 0 || cognome.length() == 0) {
            RequestDispatcher rd3 = request.getRequestDispatcher("JSP/registrazione.jsp");
            String messaggio = "Inserire tutti i dati";
            request.setAttribute("messaggio", messaggio);
            rd3.forward(request, response);
        } else {
            try {
                Connection conn = DatabaseConnection.getConn();
                String query = " insert into tifoso (username, password, nome, cognome, squadra_tifata)"
                        + " values (?, (AES_ENCRYPT(?,'key')), ?, ?, ?)";
                PreparedStatement preparedStmt = conn.prepareStatement(query);

                preparedStmt.setString(1, username);
                preparedStmt.setString(2, password);
                preparedStmt.setString(3, nome);
                preparedStmt.setString(4, cognome);
                preparedStmt.setString(5, squadra_sel);

                // execute the preparedstatement
                preparedStmt.executeUpdate();
                
                response.setContentType("text/html");
                PrintWriter pw = response.getWriter();
                pw.write("<html><head><meta charset=\"ISO-8859-1\"><title>Archivio campionati di calcio</title><link rel=\"stylesheet\" href=\"CSS/styles.css\"></head>");
                pw.write("<body><link rel=\"stylesheet\" href=\"CSS/styles.css\"><div align=\"center\">"
                        + "<table><thead><tr><table><th>Registrazione avvenuta con successo</th></tr></thead>");
                pw.write("<tbody><tr><td>Attendere prego...</td></tr></tbody></table></div></body></html>");
                response.addHeader("REFRESH", "5;URL=index.jsp");

            } catch (SQLIntegrityConstraintViolationException e) {
                RequestDispatcher rd3 = request.getRequestDispatcher("JSP/registrazione.jsp");
                request.setAttribute("messaggio", "Username non disponibile");
                rd3.forward(request, response);
            } catch (SQLException e) {
                System.out.println(e.getMessage());

            }

        }

    }

}
