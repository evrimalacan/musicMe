<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="instrument-container flex-row mb-4" style="display:none;">
   	<form class="edit-instrument-form">
		<div class="mt-2 mb-3 d-flex flex-row justify-content-start">
	        <div class="col-md-3 col-6">
	            <label class="text-center font-weight-bold">Daily ($)</label>
	            <input type="number" step="0.01" min="0.01" class="form-control" name="dailyPrice" value="${instrument.getDailyPrice()}">
	        </div>
	        <div class="col-md-3 col-6">
	            <label class="text-center font-weight-bold">Monthly ($)</label>
	            <input type="number" step="0.01" min="0.01" class="form-control" name="monthlyPrice" value="${instrument.getMonthlyPrice()}">
	        </div>
	    </div>

	    <div class="mb-3 d-flex flex-row ">
	    	<div class="col">
		    	<label class="text-center font-weight-bold">Title</label>
		        <input type="text" class="form-control name-field" name="name" value="${instrument.getName()}">
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
		        <select name="brand_id" class="form-control">
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

	    <div class="mb-3 d-flex flex-row ">
	    	<div class="col-md-3 col">
		    	<label class="text-center font-weight-bold">Type</label>
		        <select name="type_id" class="form-control">
	                <c:forEach var="type" items="${types}">
	                    <option value="${type.getId()}"
	                    <c:if test="${type.getId() == instrument.getType().getId()}">
	                        selected
	                    </c:if>
	                    >
	                    	${type.getName()}
	                	</option>
	                </c:forEach>
	            </select>
		    </div>
	    </div>

	    <input type="hidden" value="${instrument.getId()}" name="id">

	    <div class="d-flex flex-row">
		    <div class="col">
		    	<hr>
	    		<button class="btn btn-success btn-block instrument-submit" disabled>Update</button>
	    	</div>
	    </div>
	</form>
</div>
