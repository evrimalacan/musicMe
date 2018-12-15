<%@page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:main pageName="Home">
	<jsp:attribute name="styles">
		<style type="text/css">
			.instrument a {
				text-decoration: none;
			}
			.card-img-top {
				width: auto;
				height: 250px;
			}
		</style>
    </jsp:attribute>
    
    <jsp:body>
		<div class="jumbotron p-3 p-md-5 rounded bg-white border">
			<div class="col px-0 text-center">
				<h1 class="display-4 font-italic">Find an instrument for your needs</h1>
	<!-- 			<p class="lead my-3">Multiple lines of text that form the lede, informing new readers quickly and efficiently about what's most interesting in this post's contents.</p> -->
	<!-- 			<p class="lead mb-0"><a href="#" class="text-white font-weight-bold">Continue reading...</a></p> -->
			</div>
		</div>
		<div class="row">
			<c:if test="${instruments.isEmpty()}">
				<div class="col">
					<div class="alert alert-secondary text-center">
						There are no available instruments
					</div>
				</div>
			</c:if>
		    <c:forEach items="${instruments}" var="instrument">
		    	<div class="col-lg-3 col-md-4 col-sm-6 col-12">
			    	<div class="card instrument mb-4">
			    		<a href="/instrument/${instrument.getId()}" class="text-center">
			    			<c:set
				      			var="source"
				      			value="resources/images/thumbnail.svg"
				      		/>
				      		
				      		<c:forEach items="${instrument.getImages()}" var="image">
				      			<c:if test="${image.isThumbnail()}">
				      				<c:set
						      			var="source"
						      			value="${imageDir}${image.getPath()}"
						      		/>
				      			</c:if>
				      		</c:forEach>
				      		
			    			<img class="card-img-top" src="${source}" />
			    		</a>
		    			<div class="card-body p-3">
		    				<a class="text-dark" href="/instrument/${instrument.getId()}">
								<h5 class="font-weight-bold text-truncate">${instrument.getName()}</h5>
								<p class="text-truncate">${instrument.getDescription()}</p>
								<div class="d-flex text-info justify-content-between align-items-center">
									<span class="lead">$${instrument.getDailyPrice()}/day</span>
				                    <span class="lead">$${instrument.getMonthlyPrice()}/mo</span>
								</div>
								<hr>
							</a>
							<a href="/instrument/${instrument.getId()}" class="btn btn-sm btn-block btn-outline-primary">Rent Now</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</jsp:body>
</t:main>
