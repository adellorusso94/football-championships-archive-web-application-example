package databaseConnection;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DatabaseConnection {
	
	private static Connection con;
	
	static {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/archivio-campionati");
			con = ds.getConnection();
		} catch(NamingException | SQLException e) {
			System.out.println("Errore nella connessione al DB");
		}
	}
	
	public static Connection getConn() {
		return con;
	}
	
}
