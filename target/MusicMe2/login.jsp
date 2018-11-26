<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Login">
    <meta name="author" content="Evrim Alacan">
    <link rel="icon" href="../../../../favicon.ico">

    <title>MusicMe Sign In</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
    html, body {
        height: 100%;
    }
</style>
<!-- Custom styles for this template -->
<!--     <link href="signin.css" rel="stylesheet"> -->
</head>

<body class="d-flex justify-content-center align-items-top text-center">
    <form class="mt-3" method="post" action="login">
        <!--       <img class="mb-4" src="https://getbootstrap.com/docs/4.0/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->

        <h3 class="mb-3 font-weight-bold">MusicMe Login</h3>

        <label for="email" class="sr-only">Email address</label>
        <input type="email" id="email" name="email" class="form-control form-control-lg mb-2" placeholder="Email address" required autofocus>

        <label for="password" class="sr-only">Password</label>
        <input type="password" id="password" name="password" class="form-control form-control-lg mb-2" placeholder="Password" required>

        <button class="btn btn-lg btn-primary btn-block mb-2" type="submit">Sign in</button>
        <!-- <p class="mt-5 mb-3 text-muted">&copy; 2017-2018</p> -->
		
		<c:if test="${error != null}">
			<div class="alert alert-danger">
				${error}
            </div>		
		</c:if>
    </form>
</body>
</html>
