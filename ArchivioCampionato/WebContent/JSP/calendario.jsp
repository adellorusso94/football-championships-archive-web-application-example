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

html {
	background: url(https://virtualtours.oovirt.com/wp-content/uploads/2017/04/juve.jpg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

/* The container must be positioned relative: */
.custom-select {
	position: relative;
	left: 33%;
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
		// Controlla sessione
		try {
			int id_tifoso = (int) session.getAttribute("id_tifoso");
		} catch (NullPointerException e) {
			RequestDispatcher rd = request.getRequestDispatcher("../index.jsp");
			rd.forward(request, response);
		}
		String messaggio = (String) request.getAttribute("messaggio");
	
		ArrayList<String> giornate = (ArrayList<String>) request.getAttribute("giornate");
		String nomecamp = (String) session.getAttribute("nomecamp");
		String stagcamp = (String) session.getAttribute("stagcamp");
	%>
	<div id="mydiv" align="center">
		<div align="center">
			<h4>Calendario <%=nomecamp%> <%=stagcamp%></h4>
			<form action="visualizza_giornata" name="visual" method="post" onSubmit="return validaInvio();">
				<%			
					if (messaggio != null) {
				%>
				<p align="center">
					<a style="font-family: helvetica; color: red; font-size: 20px">
						<%
							out.print(messaggio);
						%>
					</a>
				</p>
				<%
					}
				%>
				<table>
					<thead>
						<tr id="firstRow">
							<th>
								<div class="custom-select" style="width: 200px;">
									<select class="select" name="giornateOption">
										<option value=""selected>Seleziona Giornata</option>
										<%
											for (int i = 0; i < giornate.size(); i++) {
										%>
										<option value="<%=giornate.get(i)%>">Giornata <%=giornate.get(i)%></option>
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
									<input type="submit" class="button" value="Visualizza">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<%
            Connection conn;

            String giornata = "";
            String codcamp=(String) session.getAttribute("campionato");
            giornata = (String) request.getAttribute("giornataSel");
            if (giornata == null) {
                giornata = "1";
            }

            ResultSet res = null;
            try {

                conn = DatabaseConnection.getConn();
                String queryGiornata = "select * from partita where giornata=? and campionato_partita=?";
                PreparedStatement sq = conn.prepareStatement(queryGiornata);
                sq.setString(1, giornata);
                sq.setString(2, codcamp);
                res = sq.executeQuery();

            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        %>
		<div align="center">
			<table>
				<thead>
					<tr id="firstRow">
						<th colspan="3">
							<%
								String giornataSel = (String) request.getAttribute("giornataSel");
								if (giornataSel != null) {
									out.print("Giornata " + giornataSel);
								} else {
									out.print("Giornata 1");
								}
							%>
						</th>
					</tr>
					<tr id="firstRow">
						<th>Data</th>
						<th>Partita</th>
						<th>Risultato</th>
					</tr>
				</thead>
				<%
					while (res.next()) {
				%>
				<tbody>
					<tr>
						<td><%=res.getString(4)%></td>
						<td><%=res.getString(5)%>-<%=res.getString(6)%></td>
						<td><%=res.getString(7)%>-<%=res.getString(8)%></td>
					</tr>
				</tbody>
				<%
					}
				%>
			</table>
		</div>
		<div align="center">
			<form action="<%=request.getContextPath()%>/home" method="post">
				<input type="submit" class="button" value="Indietro">
			</form>
			<br>
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

			if (document.visual.giornateOption.value=="") {
			alert("Selezionare Giornata");
			return false;
			}
		}
	</script>
</body>
</html>
