<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="databaseConnection.DatabaseConnection"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Archivio campionati di calcio</title>
<style>
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
	width: 120px;
	font-weight: bold;
	background-color: #FFFFFF;
	border: 2px solid #FFFFFF;
	border-radius: 10px;
	color: #35a103;
	padding: 10px 24px;
	text-align: center	;
	text-decoration: none;
	display: inline-block;
	font-size: 13px;
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
	width: 50%;
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
	padding: 5px;
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

#firstRow2 {
	font-weight: bold;
	color: #ffffff;
	background-color: #35a103;
}
html {
	background: url(http://www.sfondilandia.it/1920/PalloneDaCalcio.jpg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

/* The container must be positioned relative: */
.custom-select {
	position: relative;
	left: 15%;
	font-family: Arial;
}

.custom-select select {
	display: none; /*hide original SELECT element: */
}

.select-selected {
	background-color: White;
}

/* Style the arrow inside the select element: */
.select-selected:after {
	position: absolute;
	content: "";
	top: 14px;
	right: 10px;
	width: 0;
	height: 0;
	border: 6px solid transparent;
	border-color: #35a103 transparent transparent transparent;
}

/* Point the arrow upwards when the select box is open (active): */
.select-selected.select-arrow-active:after {
	border-color: transparent transparent #35a103 transparent;
	top: 7px;
}

/* style the items (options), including the selected item: */
.select-items div, .select-selected {
	color: #35a103;
	padding: 8px 16px;
	border: 1px solid transparent;
	border-color: #35a103 transparent #35a103 transparent;
	cursor: pointer;
}

/* Style items (options): */
.select-items {
	position: absolute;
	background-color: rgba(255, 255, 255);
	top: 100%;
	left: 0;
	right: 0;
	z-index: 99;
	height: 140px;
	overflow: scroll;
}

/* Hide the items when the select box is closed: */
.select-hide {
	display: none;
}

.select-items div:hover, .same-as-selected {
	background-color: rgba(0, 0, 0, 0.1);
}

</style>
</head>
<body>
	<%
		// Ottieni dati tifoso
		try {
			int id_tifoso = (int) session.getAttribute("id_tifoso");
		} catch (NullPointerException e) {
			RequestDispatcher rd = request.getRequestDispatcher("../index.jsp");
		    rd.forward(request, response);
		}
		String nome = (String) session.getAttribute("nome");
		String cognome = (String) session.getAttribute("cognome");
		String squadra_tifata = (String) session.getAttribute("squadra_tifata");

		// Ottieni dati squadra
		String citta = (String) session.getAttribute("citta");
		String stadio = (String) session.getAttribute("stadio");
		int anno = (int) session.getAttribute("anno_fondazione");
		String nazione = (String) session.getAttribute("nazione");
		Connection conn;
		ResultSet res = null;
		try {

			conn = DatabaseConnection.getConn();

			String querySquadre = "select nome, stagione from campionato";
			PreparedStatement sq = conn.prepareStatement(querySquadre);
			res = sq.executeQuery();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	%>
	<div id="mydiv" align="center">
		<div align="center">
			<h4>
				Bentornato,
				<%=nome%>
				<%=cognome%>!
			</h4>
			<table>
				<thead>
					<tr id="firstRow">
						<th colspan="2">La tua squadra</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>Nome</th>
						<td><%=squadra_tifata%></td>
					</tr>
					<tr>
						<th>Città</th>
						<td><%=citta%></td>
					</tr>
					<tr>
						<th>Stadio</th>
						<td><%=stadio%></td>
					</tr>
					<tr>
						<th>Anno di fondazione</th>
						<td><%=anno%></td>
					</tr>
					<tr>
						<th>Nazione</th>
						<td><%=nazione%></td>
					</tr>
				</tbody>
			</table>
		</div>
		<br>
		<div align="center">
			<h4>Archivio Campionati</h4>
			<form action="<%=request.getContextPath()%>/daticampionato"
				method="post" name="stag" onSubmit="return validaInvio();">
				<table style="z-index:1;">
					<thead>
						<tr id="firstRow2">
							<th colspan="2">
								<div class="custom-select" style="width: 200px;">
									<select id="mysel" class="select" name="camp">
									<option value="" selected>SelezionaCampionato</option>
										<%
											while (res.next()) {
										%>
										<option value="<%=res.getString(1)%><%=res.getString(2)%>"><%=res.getString(1)%>
											<%=res.getString(2)%></option>
										<%
											}
										%>
									</select>
								</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<div align="center">
									<input type="submit" name="home" class="button"
										value="Classifica">
								</div>
							</td>


							<td>
								<div align="center">
									<input type="submit" name="home" class="button"
										value="Calendario">
								</div>
							</td>

						</tr>


					</tbody>

				</table>

			</form>


		</div>

		<br>
		<div align="center">
			<form action="<%=request.getContextPath()%>/logout" method="post">
				<input type="submit" class="button" value="Esci">
			</form>
		</div>
	</div>
	<script type="text/javascript">
		var x, i, j, selElmnt, a, b, c;
		/*look for any elements with the class "custom-select":*/
		x = document.getElementsByClassName("custom-select");
		for (i = 0; i < x.length; i++) {
			selElmnt = x[i].getElementsByTagName("select")[0];
			/*for each element, create a new DIV that will act as the selected item:*/
			a = document.createElement("DIV");
			a.setAttribute("class", "select-selected");
			a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
			x[i].appendChild(a);
			/*for each element, create a new DIV that will contain the option list:*/
			b = document.createElement("DIV");
			b.setAttribute("class", "select-items select-hide");
			for (j = 1; j < selElmnt.length; j++) {
				/*for each option in the original select element,
				create a new DIV that will act as an option item:*/
				c = document.createElement("DIV");
				c.innerHTML = selElmnt.options[j].innerHTML;
				c
						.addEventListener(
								"click",
								function(e) {
									/*when an item is clicked, update the original select box,
									and the selected item:*/
									var y, i, k, s, h;
									s = this.parentNode.parentNode
											.getElementsByTagName("select")[0];
									h = this.parentNode.previousSibling;
									for (i = 0; i < s.length; i++) {
										if (s.options[i].innerHTML == this.innerHTML) {
											s.selectedIndex = i;
											h.innerHTML = this.innerHTML;
											y = this.parentNode
													.getElementsByClassName("same-as-selected");
											for (k = 0; k < y.length; k++) {
												y[k].removeAttribute("class");
											}
											this.setAttribute("class",
													"same-as-selected");
											break;
										}
									}
									h.click();
								});
				b.appendChild(c);
			}
			x[i].appendChild(b);
			a.addEventListener("click", function(e) {
				/*when the select box is clicked, close any other select boxes,
				and open/close the current select box:*/
				e.stopPropagation();
				closeAllSelect(this);
				this.nextSibling.classList.toggle("select-hide");
				this.classList.toggle("select-arrow-active");
			});
		}
		function closeAllSelect(elmnt) {
			/*a function that will close all select boxes in the document,
			except the current select box:*/
			var x, y, i, arrNo = [];
			x = document.getElementsByClassName("select-items");
			y = document.getElementsByClassName("select-selected");
			for (i = 0; i < y.length; i++) {
				if (elmnt == y[i]) {
					arrNo.push(i)
				} else {
					y[i].classList.remove("select-arrow-active");
				}
			}
			for (i = 0; i < x.length; i++) {
				if (arrNo.indexOf(i)) {
					x[i].classList.add("select-hide");
				}
			}
		}
		/*if the user clicks anywhere outside the select box,
		 then close all select boxes:*/
		document.addEventListener("click", closeAllSelect);
		function validaInvio() {

			if (document.stag.camp.value=="") {
			alert("Selezionare Campionato");
			return false;
			}
		}
	</script>
</body>
</html>