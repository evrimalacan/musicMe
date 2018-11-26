<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-12 d-none">
	<div class="card flex-row flex-fill mb-4">
<!-- 	    <img class="d-none d-md-block flex-grow-1" style="width:25%;" -->
<!-- 	    src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22250%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20250%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_167422792f1%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A13pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_167422792f1%22%3E%3Crect%20width%3D%22200%22%20height%3D%22250%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2255.609375%22%20y%3D%22131%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"> -->
	    <div class="d-flex flex-column flex-fill">
	    	<form class="instrument-form">
				<div class="mt-2 mb-3 d-flex flex-row justify-content-start">
			        <div class="col-md-3 col-6">
			            <label class="text-center font-weight-bold">Daily ($)</label>
			            <input type="number" class="form-control" name="dailyPrice" value="${instrument.getDailyPrice()}">
			        </div>
			        <div class="col-md-3 col-6">
			            <label class="text-center font-weight-bold">Monthly ($)</label>
			            <input type="number" class="form-control" name="monthlyPrice" value="${instrument.getMonthlyPrice()}">
			        </div>
			    </div>
			    
			    <div class="mb-3 d-flex flex-row ">
			    	<div class="col">
				    	<label class="text-center font-weight-bold">Title</label>
				        <input type="text" class="form-control" name="name" value="${instrument.getName()}">
				    </div>
			    </div>
			    
			    <div class="mb-3 d-flex flex-row ">
			    	<div class="col">
				    	<label class="text-center font-weight-bold">Description</label>
				        <textarea class="form-control" name="description">${instrument.getDescription()}</textarea>
				    </div>
			    </div>
			    
			    <div class="mb-3 d-flex flex-row ">
			    	<div class="col-md-3 col">
				    	<label class="text-center font-weight-bold">Brand</label>
				        <select name="brand" class="form-control">
			                <c:forEach var="brand" items="${brands}">
			                    <option value="${brand.getId()}"
			                    <c:if test="${brand.getId() == instrument.getBrand().getId()}">
			                        selected
			                    </c:if>
			                    >
			                    ${brand.getName()}</option>
			                </c:forEach>
			            </select>
				    </div>
			    </div>
			    
			    <div class="d-flex flex-row">
			    	<div class="col-auto">
			    		<label class="text-center font-weight-bold">Images</label>
			    		<br>
			    		<button class="btn btn-primary">Edit Images</button>
			    	</div>
			    </div>
			    
			    <div class="mb-3 d-flex flex-row">
				    <div class="col">
				    	<hr>
			    		<button class="btn btn-success btn-block instrument-submit" disabled>Update</button>
			    	</div>
			    </div>
			</form>
	    </div>
	</div>
</div>