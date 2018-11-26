<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:main pageName="User Settings">
    <jsp:attribute name="styles">
        <style type="text/css">
            /*.a {
                b: c;
            }*/
        </style>
    </jsp:attribute>

    <jsp:body>
    	<form class="form-horizontal" method="post" action="/user">
        	<div class="row">
            	<div class="col-sm-6">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email" value="${user.getEmail()}">
                    </div>
                </div>
               	<div class="col-sm-6">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Name" value="${user.getName()}">
                    </div>
                </div>
                <div class="col">
                	<button class="btn btn-block btn-outline-primary">Update</button>
                </div>
                <c:if test="${message != null}">
                	<div class="col-12 mt-4 text-center">
                		<div class="alert alert-${messageType}">
	                		${message}
	                	</div>
                	</div>
                </c:if>
        	</div>
        </form>
    </jsp:body>
</t:main>
