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
</head>
<style>
input[type=text], input[type=password] {
	font-size: 20px;
	width: 200px;
	background: none;
	border: none;
	border-bottom: 2px solid #4ef500;
}

#mydiv {
	position: fixed;
	top: 31%;
	left: 50%;
	width: 30em;
	height: 18em;
	margin-top: -9em; /*set to a negative number 1/2 of your height*/
	margin-left: -15em; /*set to a negative number 1/2 of your width*/
	/*border: 1px solid #ccc;*/
	/*background-color: #f3f3f3;*/
}

.form {
	width: 390px;
	background: rgba(254, 254, 254, 0.98);
	border-radius: 10px;
	overflow: hidden;
	padding: 20px 5px;
	box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-moz-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-webkit-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-o-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
	-ms-box-shadow: 0 5px 10px 0 rgba(0, 0, 0, .1);
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
	margin-top: 5%;
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
	font-size: 20px;
}

html {
	background: url(https://images2.alphacoders.com/445/445926.jpg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
/* The container must be positioned relative: */
.custom-select {
	position: relative;
	font-family: Arial;
}

.custom-select select {
	display: none; /*hide original SELECT element: */
}

.select-selected {
	background-color: #rgba(255, 255, 255, .9);
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
	background-color: rgb(255, 255, 255);
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

<body>
	<%
		// Ottieni dati sessione
		try {
			int id_tifoso = (int) session.getAttribute("id_tifoso");
			response.sendRedirect("home.jsp");
		} catch (NullPointerException e) {
			System.out.println(e.getMessage());
		}
		String messaggio = (String) request.getAttribute("messaggio");
		ArrayList<String> squadreDb = new ArrayList<String>();
		Connection conn;

		try {

			conn = DatabaseConnection.getConn();

			String querySquadre = "select nome from squadra";
			PreparedStatement sq = conn.prepareStatement(querySquadre);
			ResultSet res = sq.executeQuery();

			while (res.next()) {
				squadreDb.add(res.getString(1));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	%>

	<div id="mydiv" align="center">
		<div class="form">
			<form action="<%=request.getContextPath()%>/nuovo_utente"
				method="post" name="reg" onSubmit="return validaInvio();">

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
				<p>
					<input type="text" placeholder="username" name="username">
				</p>
				<p>
					<input type="password" placeholder="password" name="password">
				</p>
				<p>
					<input type="text" placeholder="nome" name="nome">
				</p>
				<p>
					<input type="text" placeholder="cognome" name="cognome">
				</p>
				<p>
				<h4>Seleziona la tua squadre del cuore</h4>
				<div class="custom-select" style="width: 200px;">
					<select class="select" name="squadre">
						<option value="" selected>---</option>

						<%
							for (int i = 0; i < squadreDb.size(); i++) {
						%>
						<option value="<%=squadreDb.get(i)%>"><%=squadreDb.get(i)%></option>
						<%
							}
						%>
					</select>
				</div>
				</p>
				<p>
					<input type="submit" class="button" value="Registrati">
				</p>
			</form>
			<div align="center">
				<form action="<%=request.getContextPath()%>/index.jsp" method="post">
					<input type="submit" class="button" value="Accedi">
				</form>
				<br>
			</div>
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

			if (document.reg.squadre.value == "") {
				alert("Selezionare Squadra");
				return false;
			}
		}
	</script>
</body>
</html>