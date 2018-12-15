<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:main pageName="My Instruments">
	<jsp:attribute name="styles">
		<style>
			.table td,
			.table th {
				vertical-align: middle;
				text-align: center;
			}

			.table .thumbnail {
				padding: 5px;
			}

			.table img {
				width: 100%;
				height: auto;
			}

            .table tr {
            	transition: background-color 1s ease-in-out;
            }
		</style>
	</jsp:attribute>

	<jsp:attribute name="scripts">
		<script type="text/javascript">
		</script>
    </jsp:attribute>

	<jsp:body>
        <div class="row">
        	<c:if test="${!rents.isEmpty()}">
	            <div class="col-12 mb-4">
	                <h1 class="text-center">Your Rents</h1>
	                <hr>
	                <div class="table-responsive">
	                    <table class="table table-bordered">
	                        <thead>
	                            <tr>
	                                <th scope="col" width="12%" class="d-none d-sm-table-cell">Instrument</th>
	                                <th scope="col" width="40%">Title</th>
	                                <th scope="col" width="12%">Type</th>
	                                <th scope="col" width="12%">Date</th>
	                                <th scope="col" width="12%">Status</th>
	                                <th scope="col" width="12%">Details</th>
	                            </tr>
	                        </thead>

	                        <tbody>
	                            <c:forEach var="rent" items="${rents}">
	                                <tr>
	                                    <td class="d-none d-sm-table-cell thumbnail">
	                                        <c:set
	                                            var="source"
	                                            value="resources/images/thumbnail.svg"
	                                        />

	                                        <c:forEach items="${rent.getInstrument().getImages()}" var="image">
	                                            <c:if test="${image.isThumbnail()}">
	                                                <c:set
	                                                    var="source"
	                                                    value="${imageDir}${image.getPath()}"
	                                                />
	                                            </c:if>
	                                        </c:forEach>

	                                        <img class="img-thumbnail" src="${source}" />
	                                    </td>
	                                    <td>
	                                    	<a href="/instrument/${rent.getInstrument().getId()}">
	                                    		${rent.getInstrument().getName()}
	                                    	</a>
	                                    </td>
	                                    <td>
	                                    	<c:choose>
	                                    		<c:when test="${rent.getDay() == 0}">
	                                    			Monthly
	                                    		</c:when>
	                                    		<c:otherwise>
	                                    			Daily
	                                    		</c:otherwise>
	                                    	</c:choose>
	                                    </td>
	                                    <td>
	                                    	${rent.getDay() != 0 ? Integer.toString(rent.getDay()).concat("/") : ""}${rent.getMonth()}/${rent.getYear()}
	                                    </td>
	                                    <td>
	                                    	<span class="badge
	                                    	<c:choose>
	                                    		<c:when test="${rent.getStatus() == 0}">
	                                    			badge-secondary">Waiting Approval
	                                    		</c:when>
	                                    		<c:when test="${rent.getStatus() == 1}">
	                                    			badge-success">Approved
	                                    		</c:when>
	                                    		<c:when test="${rent.getStatus() == 2}">
	                                    			badge-danger">Rejected
	                                    		</c:when>
	                                    		<c:when test="${rent.getStatus() == 3}">
	                                    			badge-warning">Past
	                                    		</c:when>
	                                    	</c:choose>
	                                    	</span>
	                                    </td>
	                                    <td>
	                                        ${rent.getDetail()}
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
	                </div>
	            </div>
	        </c:if>
            <c:if test="${!rentals.isEmpty()}">
	        	<div class="col">
	                <h1 class="text-center">Your Rentals</h1>
	                <hr>
	                <div class="table-responsive">
	               		<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="col" width="12%" class="d-none d-sm-table-cell">Instrument</th>
		                            <th scope="col" width="52%">Title</th>
		                            <th scope="col" width="12%">User</th>
		                            <th scope="col" width="12%">Date</th>
		                            <th scope="col" width="12%">Action</th>
								</tr>
							</thead>

			  				<tbody>
			  					<c:forEach var="rent" items="${rentals}">
				    				<tr>
								      	<td class="d-none d-sm-table-cell thumbnail">
								      		<c:set
								      			var="source"
								      			value="resources/images/thumbnail.svg"
								      		/>

								      		<c:forEach items="${rent.getInstrument().getImages()}" var="image">
	                                            <c:if test="${image.isThumbnail()}">
	                                                <c:set
	                                                    var="source"
	                                                    value="${imageDir}${image.getPath()}"
	                                                />
	                                            </c:if>
	                                        </c:forEach>
											
											<a href="/instrument/${rent.getInstrument().getId()}">
							    				<img class="img-thumbnail" src="${source}" />
							    			</a>
								      	</td>
								      	<td>
								      		<a href="/instrument/${rent.getInstrument().getId()}">
	                                    		${rent.getInstrument().getName()}
	                                    	</a>
	                                    </td>
	                                    <td>
								      		${rent.getUser().getName()}
								      	</td>
								      	<td>
	                                    	${rent.getDay() != 0 ? Integer.toString(rent.getDay()).concat("/") : ""}${rent.getMonth()}/${rent.getYear()}
	                                    </td>
								      	<td>
								      		<form method="post" action="/userRent">
								      			<div class="btn-group btn-group-toggle" data-toggle="buttons">
												  	<label class="btn btn-outline-danger">
													  	<input type="radio" name="status" autocomplete="off" value="2"> Reject
													</label>
													<label class="btn btn-outline-success">
													  	<input type="radio" name="status" autocomplete="off" value="1"> Approve
													</label>
												</div>
												
												<input type="hidden" name="id" value="${rent.getId()}">
												
												<button type="submit" class="btn btn-block mt-3 btn-sm btn-outline-primary">Apply</button>
								      		</form>
								      	</td>
								    </tr>
								</c:forEach>
			  				</tbody>
						</table>
					</div>
	       		</div>
			</c:if>
        </div>
    </jsp:body>
</t:main>
