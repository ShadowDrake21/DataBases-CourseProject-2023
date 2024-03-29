<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
String errorMessage = (String) request.getAttribute("error");
if (errorMessage == null) {
	errorMessage = "";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tournament participation page</title>
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<header class="header">
		<nav class="navbar navbar-expand-lg navbar-light">
			<a class="navbar-brand nav__item" href="homepage.jsp">Chess2D</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link nav__item"
						href="player.jsp">Player</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="title.jsp">Title</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="openingusage.jsp">Opening Usage</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="opening.jsp">Opening</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="tournamentpart.jsp">Tournament Participation</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="tournament.jsp">Tournament</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="match.jsp">Match</a></li>
					<li class="nav-item"><a class="nav-link nav__item"
						href="statistics.jsp">Statistics</a></li>
				</ul>
				<ul class="navbar-nav ml-md-auto">
					<li class="nav-item"><span class="navbar-text nav__item">
							<strong>User:</strong> <span id="username"></span>
					</span></li>
					<li class="nav-item">
						<button type="button" id="loginButton"
							class="btn btn-primary ml-2" onclick="location.href='login.jsp'">Login</button>
					</li>
					<li class="nav-item">
						<button type="button" id="logoutButton"
							class="btn btn-danger ml-2" onclick="logout()">Logout</button>
					</li>
				</ul>
			</div>
		</nav>
	</header>
	<main class="main">
		<p class="error-message"><%=errorMessage%></p>
		<h1 class="page__title">Tournament participations</h1>
		<form method="post" action="tournamentpart">
			<div style="margin-bottom: 15px;">
				<select name="field">
					<option value="id_tournament_participation">Tournament
						participation id</option>
					<option value="id_player">Player id</option>
					<option value="id_tournament">Tournament id</option>
					<option value="tournament_participation_place">Tournament
						place</option>
				</select> <input type="text" name="value" placeholder="Enter search value">
				<input type="hidden" name="actiontype" value="searchtournamentpart">
				<input type="submit" name="searchtournamentpart" value="Search">
			</div>
			<c:if test="${not empty searchResults}">
				<table style="width: 100%" border="1">
					<tr class="first-row">
						<td>Id</td>
						<td>Player id</td>
						<td>Player name</td>
						<td>Tournament id</td>
						<td>Tournament name</td>
						<td>TournamentPart registration</td>
						<td>TournamentPart place</td>
						<td>Action</td>
					</tr>
					<c:forEach var="tournamentpart" items="${searchResults}">
						<tr>
							<td><c:out value="${tournamentpart.id}" /></td>
							<td><c:out value="${tournamentpart.idPlayer}" /></td>
							<td><c:out value="${tournamentpart.playerName}" /></td>
							<td><c:out value="${tournamentpart.idTournament}" /></td>
							<td><c:out value="${tournamentpart.tournamentName}" /></td>
							<td><c:out value="${tournamentpart.registration}" /></td>
							<td><c:out value="${tournamentpart.place}" /></td>
							<td><c:url var="deleteUrl" value="/deletetournamentpart.jsp">
									<c:param name="tournament_part_id" value="${tournamentpart.id}" />
									<c:param name="id_player" value="${tournamentpart.idPlayer}" />
									<c:param name="id_tournament"
										value="${tournamentpart.idTournament}" />
									<c:param name="registration"
										value="${tournamentpart.registration}" />
									<c:param name="place" value="${tournamentpart.place}" />
								</c:url> <c:url var="updateUrl" value="/updatetournamentpart.jsp">
									<c:param name="tournament_part_id" value="${tournamentpart.id}" />
									<c:param name="id_player" value="${tournamentpart.idPlayer}" />
									<c:param name="id_tournament"
										value="${tournamentpart.idTournament}" />
									<c:param name="registration"
										value="${tournamentpart.registration}" />
									<c:param name="place" value="${tournamentpart.place}" />
								</c:url>
								<p>
									<a href="${deleteUrl }" data-type="userlink">Delete
										tournament participation</a>
								</p>
								<p>
									<a href="${updateUrl }" data-type="userlink">Update
										tournament participation</a>
								</p></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${empty searchResults}">
				<jsp:useBean id="TournamentPartBean"
					class="databean.TournamentPartListDatabean" />
				<table style="width: 100%" border="1">
					<tr class="first-row">
						<td>Id</td>
						<td>Player id</td>
						<td>Player name</td>
						<td>Tournament id</td>
						<td>Tournament name</td>
						<td>TournamentPart registration</td>
						<td>TournamentPart place</td>
						<td>Action</td>
					</tr>
					<c:forEach var="tournamentpart"
						items="${TournamentPartBean.tournamentPartList}">
						<tr>
							<td><c:out value="${tournamentpart.id}" /></td>
							<td><c:out value="${tournamentpart.idPlayer}" /></td>
							<td><c:out value="${tournamentpart.playerName}" /></td>
							<td><c:out value="${tournamentpart.idTournament}" /></td>
							<td><c:out value="${tournamentpart.tournamentName}" /></td>
							<td><c:out value="${tournamentpart.registration}" /></td>
							<td><c:out value="${tournamentpart.place}" /></td>
							<td><c:url var="deleteUrl" value="/deletetournamentpart.jsp">
									<c:param name="tournament_part_id" value="${tournamentpart.id}" />
									<c:param name="id_player" value="${tournamentpart.idPlayer}" />
									<c:param name="id_tournament"
										value="${tournamentpart.idTournament}" />
									<c:param name="registration"
										value="${tournamentpart.registration}" />
									<c:param name="place" value="${tournamentpart.place}" />
								</c:url> <c:url var="updateUrl" value="/updatetournamentpart.jsp">
									<c:param name="tournament_part_id" value="${tournamentpart.id}" />
									<c:param name="id_player" value="${tournamentpart.idPlayer}" />
									<c:param name="id_tournament"
										value="${tournamentpart.idTournament}" />
									<c:param name="registration"
										value="${tournamentpart.registration}" />
									<c:param name="place" value="${tournamentpart.place}" />
								</c:url>
								<p>
									<a href="${deleteUrl }" data-type="userlink">Delete
										tournament participation</a>
								</p>
								<p>
									<a href="${updateUrl }" data-type="userlink">Update
										tournament participation</a>
								</p></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</form>
		<h6 class="title-add">Add tournament participation:</h6>
		<form method="post" action="tournamentpart" class="form__add">
			<table style="width: 100%" border="1">
				<tr class="first-row">
					<td>Player id</td>
					<td>Tournament id</td>
					<td>TournamentPart registration</td>
					<td>TournamentPart place</td>
					<td>Action</td>
				</tr>
				<tr class="last-row">
					<td><input type="text" data-type="userinput" name="id_player" /></td>
					<td><input type="text" data-type="userinput"
						name="id_tournament" /></td>
					<td><input type="text" data-type="userinput"
						name="registration" /></td>
					<td><input type="text" data-type="userinput" name="place" /></td>
					<td><input type="hidden" name="actiontype"
						value="addtournamentpart" /> <input type="submit"
						data-type="userinput" name="addtournamentpart"
						value="Add tournament participation" /></td>
				</tr>
			</table>
		</form>
	</main>
	<footer class="footer">
		<p class="footer__descr">©2023-2024 Krapyvianskyi "Drake21" Dmytro
			& Turevskyi "DTure" Dmytro</p>
	</footer>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/script.js"></script>
</body>
</html>