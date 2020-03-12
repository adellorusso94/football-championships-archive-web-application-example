<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="databaseConnection.DatabaseConnection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Archivio campionati di calcio</title>
<style>
html {
	background:
		url(https://png.pngtree.com/thumb_back/fw800/back_our/20190617/ourmid/pngtree-champion-lecture-poster-background-image_126040.jpg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	min-height: 100%;
}

#mydiv {
	position: fixed;
	top: 21%;
	left: 50%;
	height: 75%;
	margin-top: -10em; /*set to a negative number 1/2 of your height*/
	margin-left: -30em; /*set to a negative number 1/2 of your width*/
	width: 600px;
	background: rgba(254, 254, 254, 0.9);
	border-radius: 10px;
	overflow: hidden;
	padding: 75px 175px;
	box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-moz-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-webkit-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-o-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-ms-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	overflow-y: scroll;
}

.button {
	width: 200px;
	font-weight: bold;
	background-color: #FFFFFF;
	border: 2px solid #FFFFFF;
	border-radius: 10px;
	color: #35a103;
	padding: 10px 24px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s;
	transition-duration: 0.4s;
	cursor: pointer;
}

.button:hover {
	border: 2px solid #FFFFFF;
	border-radius: 50px;
	background-color: #35a103;
	color: #FFFFFF;
}

h4 {
	color: #35a103;
	font-size: 40px;
	margin-top: 0px;
}

table {
	width: 100%;
	margin: 20px auto;
	table-layout: auto;
}

.fixed {
	table-layout: fixed;
}

table, td, th {
	border-collapse: collapse;
}

th, td {
	padding: 10px;
	border: solid 1px #000;
	text-align: center;
}

.w {
	width: 400px;
}

tbody {
	background-color: rgba(255, 255, 255, 0.9);
}

#firstRow {
	font-weight: bold;
	color: #ffffff;
	background-color: #35a103;
}

.vincitore {
	background-color: #ffffb9;
}

.champions_league {
	background-color: #a6d2ff;
}

.europa_league {
	background-color: #ffb693;
}

.retrocessione {
	background-color: #ff7777;
}

.default {
	background-color: #ffffff;
}
</style>
</head>
<body>
	<%
		// Controlla sessione
		try {
			int id_tifoso = (int) session.getAttribute("id_tifoso");
		} catch (NullPointerException e) {
			RequestDispatcher rd = request.getRequestDispatcher("../index.jsp");
		    rd.forward(request, response);
		}
		Connection conn;
		String nomecamp = (String) request.getAttribute("nomecamp");
		String stagcamp = (String) request.getAttribute("stagcamp");
		String codcamp = (String) request.getAttribute("codcamp");
		ResultSet res = null;
		try {
			conn = DatabaseConnection.getConn();
			String querySquadre = "select squadra," + "count(squadra) as partite,"
					+ "sum(if(punteggio=3,1,0)) as vittorie," + "sum(if(punteggio=1,1,0)) as pareggi,"
					+ "sum(if(punteggio=0,1,0)) as sconfitte," + "sum(punteggio) as punteggio,"
					+ "sum(fatti) as fatti,                                                                    "
					+ "sum(subiti) as subiti,                                                                  "
					+ "sum(fatti)-sum(subiti) as diff_reti,                                                    "
					+ "sum(if(punteggio=3 and dove = \"C\",1,0)) as vittorie_casa,                               "
					+ "sum(if(punteggio=1 and dove = \"C\",1,0)) as pareggi_casa,                                "
					+ "sum(if(punteggio=0 and dove = \"C\",1,0)) as sconfitte_casa,                              "
					+ "sum(if(punteggio=3 and dove = \"T\",1,0)) as vittorie_trasferta,                          "
					+ "sum(if(punteggio=1 and dove = \"T\",1,0)) as pareggi_trasferta,                           "
					+ "sum(if(punteggio=0 and dove = \"T\",1,0)) as sconfitte_trasferta                          "
					+ "from                                                                                    "
					+ "(                                                                                       "
					+ "select squadra_casa as squadra,gol_casa as fatti,gol_ospiti as subiti,\"C\" as dove,      "
					+ "case                                                                                    "
					+ "when gol_casa > gol_ospiti then 3                                                       "
					+ "when gol_casa = gol_ospiti then 1                                                       "
					+ "else 0                                                                                  "
					+ "end as punteggio                                                                        "
					+ "from partita where campionato_partita=?                                                  "
					+ "union all                                                                               "
					+ "select squadra_ospite as squadra,gol_ospiti as fatti,gol_casa as subiti,\"T\",            "
					+ "case                                                                                    "
					+ "when gol_ospiti > gol_casa then 3                                                       "
					+ "when gol_ospiti = gol_casa then 1                                                       "
					+ "else 0                                                                                  "
					+ "end as punteggio                                                                        "
					+ "from partita     where campionato_partita=?                                             "
					+ ") as tab                                                                                "
					+ "group by squadra                                                                        "
					+ "order by punteggio desc                                                               ";
			PreparedStatement sq = conn.prepareStatement(querySquadre);
			sq.setString(1, codcamp);
			sq.setString(2, codcamp);
			res = sq.executeQuery();

		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	%>
	<div class="container" id="mydiv" align="center">
		<div align="center">
			<h4>Classifica <%=nomecamp%> <%=stagcamp%></h4>
			<table>
				<thead>
					<tr id="firstRow">
						<th colspan="2">Squadra</th>
						<th>Pt</th>
						<th>G</th>
						<th>V</th>
						<th>N</th>
						<th>P</th>
						<th>GF</th>
						<th>GS</th>
						<th>DR</th>
					</tr>
				</thead>
				<%
					int i = 1;
					while (res.next()) {
				%>

				<tr>
					<td align="left"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=i%>
					<td align="left"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(1)%>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(6)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(2)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(3)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(4)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(5)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(7)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(8)%></td>
					<td width="30px" align="center"
						<%if (i == 1)
					out.print(" class=\"vincitore\"");
				else if ((i >= 2) && (i <= 4))
					out.print(" class=\"champions_league\"");
				else if ((i >= 5) && (i <= 7))
					out.print(" class=\"europa_league\"");
				else if (i >= 18)
					out.print(" class=\"retrocessione\"");
				else
					out.print(" class=\"default\"");%>><%=res.getString(9)%></td>

				</tr>
				<%
					i++;
					}
				%>


			</table>

		</div>
		<br>
		<div align="center">
			<form action="javascript:history.back()">
				<input type="submit" class="button" value="Indietro">
			</form>
			<br>
		</div>
	</div>
</body>
</html>