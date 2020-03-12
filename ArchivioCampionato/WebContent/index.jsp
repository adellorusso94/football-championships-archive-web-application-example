<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

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
	top: 37%;
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
	background: rgba(254, 254, 254, 0.9);
	border-radius: 10px;
	overflow: hidden;
	padding: 55px 5px;
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

html {
	background:
		url(https://www.asdbassabresciana.it/wp-content/uploads/2016/06/Sfondo-HD-calcio-sport.jpeg)
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
</style>
<body>
	<%
		// Ottieni dati sessione
		try {
			int id_tifoso = (int) session.getAttribute("id_tifoso");
			response.sendRedirect("JSP/home.jsp");
		} catch (NullPointerException e) {
			System.out.println(e.getMessage());
		}

		String messaggio = (String) request.getAttribute("messaggio");
	%>


	<div id="mydiv" align="center">
		<div class="form">
			<h4>Login</h4>
			<form action="<%=request.getContextPath()%>/home" method="post">
				<%
					if (messaggio != null) {
				%>
				<p align="center">
					<a
						style="font-family: helvetica; font-weight: bold; color: red; font-size: 20px"><%=messaggio%></a>

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
					<input type="submit" class="button" value="Accedi">
				</p>
			</form>
			<form action="JSP/registrazione.jsp" method="post">
				<p>
					<input type="submit" class="button" value="Registrati">
				</p>
			</form>
		</div>
	</div>
</body>
</html>