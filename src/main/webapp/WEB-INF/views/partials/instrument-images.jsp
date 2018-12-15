<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="instrument-container flex-row flex-fill mb-4" style="display:none;">
    <div class="d-flex flex-column flex-fill">
    	<form method="post" action="/userInstrument" enctype="multipart/form-data">
	    	<div class="d-flex flex-row justify-content-center flex-wrap mb-4">
		    	<c:if test="${instrument.getImages().isEmpty()}">
					<div class="alert alert-secondary text-center w-100">
						There are no uploaded images
					</div>
				</c:if>
	
			    <c:forEach items="${instrument.getImages()}" var="image">
			   		<div class="flex-column instrument-image mb-4 mx-3">
				    	<img class="img-thumbnail mb-2" src="${imageDir}${image.getPath()}">
				    	<div>
				    		<i class="fas fa-thumbtack text-${image.isThumbnail() ? 'primary' : 'secondary'} change-thumbnail"
				    		data-image-id="${image.getId()}" data-instrument-id="${instrument.getId()}"></i>
				    		<i class="fas fa-trash-alt text-danger ml-2 delete-image"></i>
				    	</div>
				    	<input type="hidden" name="image_ids" value="${image.getId()}">
				    </div>
				</c:forEach>
			</div>
			
			<input type="hidden" value="${instrument.getId()}" name="id">
			<input type="hidden" name="type" value="image">
			
			<div class="mb-2 flex-row d-flex custom-file">
	            <input class="custom-file-input" type="file" name="file">
	            <label class="custom-file-label" >Choose file</label>
		    </div>
		    
		    <div class="d-flex flex-row">
			    <div class="col">
			    	<hr>
		    		<button type="submit" class="btn btn-success btn-block">Update</button>
		    	</div>
		    </div>
		</form>
    </div>
</div>
