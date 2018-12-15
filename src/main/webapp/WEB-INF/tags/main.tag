<%@tag language="java" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@attribute name="pageName" required="true"%>

<%@attribute name="styles"  fragment="true" %>
<%@attribute name="scripts" fragment="true" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="MusicMe Home Page">
    <meta name="author" content="Evrim Alacan">

    <title>MusicMe - ${pageName}</title>

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css"
	integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz"
	crossorigin="anonymous">

	<!-- Bootstrap -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        body {
            padding-top: 5rem;
        }
        #search-form input {
            border-right: none;
            box-shadow: none;
        }
        #search-form input:focus + div > span {
         	border-color: #80bdff;
        }
        #search-form i {
            cursor: pointer;
        }
        #search-form {
        	width: calc((100% - 115px) / 2);
        }
    </style>

    <jsp:invoke fragment="styles"/>
</head>

<body>
    <nav class="navbar navbar-light bg-white navbar-expand-md fixed-top border-bottom">
        <a class="navbar-brand" href="/">MusicMe</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar"
        aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-between" id="navbar">
            <!-- <ul class="navbar-nav mr-auto">
                 <li class="nav-item active">
                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Link</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#">Disabled</a>
                </li>
            </ul>  -->
            <form class="form-inline my-2 my-lg-0" method="get" action="/" id="search-form">
                <div class="input-group w-100">
                    <input type="text" name="term" class="form-control" aria-label="Search"
                    placeholder="Search" autocomplete="off"
                    value="<%=request.getParameter("term") == null ? "" : request.getParameter("term")%>">

                    <div class="input-group-append">
                        <span class="input-group-text bg-white">
                            <i class="fa fa-search"></i>
                        </span>
                    </div>
                </div>
            </form>
            <ul class="navbar-nav ml-md-2">
	            <c:choose>
				    <c:when test="${user != null}">
		            	<li class="nav-item dropdown">
		                    <a class="nav-link dropdown-toggle" href="#" id="navbar-user" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                    	${user.getName()}
		                    </a>
		                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbar-user">
		                    	<a class="dropdown-item" href="/userInstrument">My Instruments</a>
		                    	<a class="dropdown-item" href="/userRent">My Rents & Rentals</a>
		                    	<a class="dropdown-item" href="/user">Settings</a>
		                        <a class="dropdown-item" href="#"
		                        onclick="event.preventDefault();$('#logout-form').submit();">
		                        	Logout
		                        </a>
		                    </div>
		                    <form class="d-none" id="logout-form" action="/logout" method="post">
						    </form>
		                </li>
				    </c:when>
				    <c:otherwise>
				        <li class="nav-item">
		                    <a class="btn btn-info btn-block" href="/login">LOGIN</a>
		                </li>
				    </c:otherwise>
				</c:choose>
			</ul>
        </div>
    </nav>

    <div role="main" class="container">
        <jsp:doBody/>
    </div>

    <script src="/resources/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
    	$('#search-form i').click(function() {
        	$(this).closest('form').submit();
        });

        $('#search-form').submit(function() {
            var term = $(this).find('input').val();

        	if (!term) {
            	window.location.href = '/';

            	return false;
            }

            return true;
        });

        $(function () {
       	  	$('[data-toggle="popover"]').popover({
           	  	html: true,
			})
       	})
    </script>
    
    <jsp:invoke fragment="scripts"/>
</body>
</html>
