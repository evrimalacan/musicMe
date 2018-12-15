<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Login">
    <meta name="author" content="Evrim Alacan">
    <link rel="icon" href="../../../../favicon.ico">

    <title>MusicMe Sign In</title>

    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/css/login.css" rel="stylesheet">
</head>

<body class="h-100 d-flex align-items-center py-5 justify-content-center">
    <form class="form-signin w-100 p-2 my-0 mx-auto" method="post" action="/login">
        <div class="text-center mb-4">
            <!-- <img class="mb-4" src="https://getbootstrap.com/docs/4.0/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
            <h1 class="h3 mb-3 font-weight-normal">MusicMe</h1>
            <p>Please login using your email and password</p>
        </div>

        <div class="form-label-group">
            <input type="email" id="email" name="email" class="form-control" placeholder="Email address" required autofocus>
            <label for="email">Email Address</label>
        </div>

        <div class="form-label-group">
            <input type="password" id="password" name="password" class="form-control" placeholder="Password" required autocomplete="off">
            <label for="password">Password</label>
        </div>

        <div class="checkbox mb-3">
            <label>
                <input type="checkbox" name="remember" value="1"> Remember me
            </label>
        </div>
        
        <c:if test="${redirect != null}">
        	<input type="hidden" name="redirect" value="${redirect}">
        	<% request.getSession().removeAttribute("redirect"); %>
        </c:if>
		
		<input type="hidden" name="referer" value="<%= request.getHeader("referer") %>">
		
        <button class="btn btn-lg btn-primary btn-block mb-4" type="submit">Sign in</button>

        <c:if test="${error != null}">
            <div class="alert alert-danger text-center">
                ${error}
                <% request.getSession().removeAttribute("error"); %>
            </div>
        </c:if>

        <!-- <p class="mt-5 mb-3 text-muted text-center">© 2017-2018</p> -->
    </form>
</body>
</html>
