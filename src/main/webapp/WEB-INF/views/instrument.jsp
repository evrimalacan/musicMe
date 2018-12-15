<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:main pageName="${instrument.getName()}">
	<jsp:attribute name="styles">
		<link href="/resources/plugins/slick-1.8.1/slick.css" rel="stylesheet">
		<link href="/resources/plugins/slick-1.8.1/slick-theme.css" rel="stylesheet">
		<link href="/resources/plugins/bootstrap-datepicker-1.6.4/css/bootstrap-datepicker.min.css" rel="stylesheet">

		<style>
			.slick-track {
			    display: flex !important;
			}

			.slick-list, .slick-track {
				height: 100%;
			}

			.slick-slide {
			    height: inherit !important;
			    outline: none;
			}

			@media (min-width:768px) {
				.w-md-250 {
					width: 250px !important;
				}
			}
		</style>
	</jsp:attribute>

	<jsp:attribute name="scripts">
		<script src="/resources/plugins/slick-1.8.1/slick.min.js"></script>
		<script src="/resources/plugins/bootstrap-datepicker-1.6.4/js/bootstrap-datepicker.min.js"></script>

		<script type="text/javascript">
			$('#instrument-slick').slick({
				dots: true,
				prevArrow: null,
				nextArrow: null,
				adaptiveHeight: true
			});

			$('#rent-datepicker').datepicker({
				format: "dd/mm/yyyy",
				startDate: new Date(),
			});

			$('input[name="type"]').change(function() {
				$('#rent-datepicker').datepicker('destroy');
				$('#rent-datepicker').val('');

				if (this.value == 'day') {
					$('#rent-datepicker').datepicker({
						format: "dd/mm/yyyy",
						startDate: new Date(),
					});
			    } else if (this.value == 'month') {
			    	$('#rent-datepicker').datepicker({
			    		startDate: new Date(),
						format: "mm/yyyy",
					    startView: 1,
					    minViewMode: 1,
					    maxViewMode: 2,
					    todayHighlight: true
					});
			    }
			});

			$('#rent-form').submit(function() {
				var $this = $(this);
				
				$.ajax({
					type: 'post',
					url: '/rent',
					data: $(this).serialize(),
					success: function() {
						$this.remove();
						
						$('#rent-title').html(
							'<div class="alert alert-success w-100 text-center">' +
							'Your renting request is waiting for owner\'s approval' +
							'</div>'
						);		
					},
				});

				return false;
			});
		</script>
	</jsp:attribute>

    <jsp:body>
		<div class="row">
	    	<div class="col">
		    	<div class="card flex-md-row mb-4">
		    		<div class="w-100 w-md-250" id="instrument-slick" style="height:350px;">
		    			<c:if test="${empty instrument.getImages()}">
		    				<div class="h-100">
		    					<img class="w-100 h-100 card-img-right flex-auto" src="/resources/images/thumbnail.svg">
		    				</div>
		    			</c:if>

		    			<c:if test="${!empty instrument.getImages()}">
			    			<c:forEach items="${instrument.getImages()}" var="image">
			    				<div class="h-100">
			    					<img class="w-100 h-100 card-img-right flex-auto" src="${imageDir}${image.getPath()}">
			    				</div>
			    			</c:forEach>
			    		</c:if>
		    		</div>
	            	<div class="card-body d-flex flex-column align-items-start">
	              		<strong class="d-inline-block mb-2 text-primary">
	              			$${instrument.getDailyPrice()}/day -
	              			$${instrument.getMonthlyPrice()}/mo
	              		</strong>
	           			<h3 class="mb-0">${instrument.getName()}</h3>
	              		<div class="mb-1 text-muted">${instrument.getBrand().getName()}</div>
	              		<p class="card-text mb-4">${instrument.getDescription()}</p>
	<!--               		<a href="#">Continue reading</a> -->
						<c:if test="${user.getId() != instrument.getUser().getId()}">
							<div id="rent-title" class="d-flex h-100 w-100 justify-content-center align-items-end mb-3">
								<c:choose>
									<c:when test="${isRenting}">
										<div class="alert alert-success w-100 text-center">
											Your renting request is waiting for owner's approval
										</div>
									</c:when>
									<c:otherwise>
										<h2>Rent This Instrument</h2>	
									</c:otherwise>
								</c:choose>
							</div>

							<c:if test="${!isRenting}">
								<div class="w-100">
									<form id="rent-form">
										<div class="d-flex justify-content-center mb-2">
											<div class="btn-group btn-group-toggle mr-3" data-toggle="buttons">
												<label class="btn btn-outline-info active">
												    <input type="radio" name="type" id="daily" autocomplete="off" checked value="day">
												    For a Day
												</label>
												<label class="btn btn-outline-info">
												    <input type="radio" name="type" id="monthly" autocomplete="off" value="month">
												    For a Month
												</label>
											</div>
	
											<!-- <button class="btn btn-outline-info mr-2" data-toggle="button">For a Day</button>
											<button class="btn btn-outline-info mr-2" data-toggle="button">For a Month</button> -->
	
											<input id="rent-datepicker" name="date" autocomplete="off" class="form-control">
										</div>
	
										<input type="hidden" name="instrument_id" value="${instrument.getId()}">
	
										<button type="submit" class="btn btn-block btn-outline-primary"
										<c:if test="${user == null}">
					                        disabled
					                    </c:if>
										>
											Rent This Instrument
										</button>
	
										<c:if test="${user == null}">
											<div class="alert alert-danger mt-3 text-center">
												You must
												<a href="/login">login</a>
												to rent this instrument
											</div>
										</c:if>
									</form>
								</div>
							</c:if>
						</c:if>
	            	</div>
	          	</div>
			</div>
		</div>
	</jsp:body>
</t:main>
