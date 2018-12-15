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

			.table i {
				font-size: 25px;
			}
			
			.instrument-action,
			.change-thumbnail {
				cursor: pointer;
			}

            .table i:hover,
            .table i.active {
                color: #007bff;
            }
            
            .instrument-image {
            	width: 140px;
            }
            
            @keyframes fade {
			    from {
			    	background-color: #c3e6cb;
			    } to {
			    	background-color: transparent;
			    }
			}
		</style>
	</jsp:attribute>

	<jsp:attribute name="scripts">
		<script type="text/javascript">
			(function () {
				var id = window.location.hash.substr(1);
				
				if (id) {
					$('#tr-' + id).css('animation', 'fade 8s');
				}
			}());
			
			$('.edit-instrument-form').submit(function(e) {
				var $this = $(this);

				if(!$this.find('input[name="id"]').val()) {
					$this.prop('action', '/userInstrument');
					$this.prop('method', 'post');

					return true;
				}
				
				e.preventDefault();
	
				$.ajax({
					type: 'post',
					url: '/userInstrument',
					data: $(this).serialize(),
					success: function() {
						var $td = $this.closest('td');
						var $tr = $td.parent('tr').prev();

						$tr.find('.name').text($this.find('.name-field').val());
						toggleInstrument($td, true);

						$tr.css('animation', 'fade 8s');

						setTimeout(function(){
							$tr.removeClass('table-success');
						}, 2000);
					}
				});
	    	});

	    	$('.edit-instrument-form :input').on('change keyup paste', function() {
// 		    	var $form = $(this).closest('.instrument-form');
		    	$(this)
		    	.closest('.edit-instrument-form')
		    	.find('.instrument-submit')
		    	.prop('disabled', false);
		    });

		    $('.instrument-action').click(function() {
		    	var $target = $($(this).data('target'));

		    	toggleInstrument(null, true);
		    	
			    if ($(this).hasClass('active')) {
				    toggleInstrument($target, true);
				} else {
					toggleInstrument($target, false);
				}
            });

            $('.delete-image').click(function() {
                $(this).closest('.instrument-image').hide();
                $(this).parent('div').siblings('input').prop('name', 'deleted_ids');
            });

            $('.change-thumbnail').click(function() {
                var $this = $(this);

                if ($this.hasClass('text-primary')) {
                    return false;
                }
                
                var instrument_id = $this.data('instrument-id');
                
                $.ajax({
                    url: '/userInstrument',
                    method: 'post',
                    data: {
                        type: 'thumbnail',
                        image_id: $this.data('image-id'),
                        id: instrument_id,
                    },
                    success: function(result) {
                        var src = $this.parent('div').siblings('img').prop('src');
                        $('#thumbnail-' + instrument_id).prop('src', src);
                        
                        $('.change-thumbnail.text-primary').toggleClass('text-primary text-secondary');
                        $this.toggleClass('text-secondary text-primary');
                    }
                });
            });

            function toggleInstrument(target, hide) {
                if (target === null) {
                    target = $('.slide-instrument-row');
                }

            	if (hide == true) {
            		target.each(function() {
                		if (!$(this).is(':visible')) {
                    		return;
                    	}
                		                    	
            			$('.instrument-container', $(this)).stop().slideUp();
            			$(this).stop().slideUp();
            			$('i[data-target="#' + this.id + '"]').removeClass('active');
    				});
                } else {
                	target.each(function() {
                		if ($(this).is(':visible')) {
                    		return;
                    	}
                    	
                		$(this).stop().slideDown();
            			$('.instrument-container', $(this)).stop().slideDown();
            			$('i[data-target="#' + this.id + '"]').addClass('active');
    				});
                }
            }
		</script>
    </jsp:attribute>

	<jsp:body>
        <div class="row">
        	<div class="col mb-4">
                <h1 class="text-center">Your Instruments</h1>
                <hr>
                <div class="table-responsive">
	                <%@include file="/WEB-INF/views/partials/instrument-edit.jsp" %>
		        	<table class="table table-bordered">
						<thead>
							<tr>
								<th scope="col" width="12%" class="d-none d-sm-table-cell">Thumbnail</th>
	                            <th scope="col" width="52%">Title</th>
	                            <th scope="col" width="12%">Total Rents</th>
								<th scope="col" width="12%">Edit</th>
								<th scope="col" width="12%">Images</th>
							</tr>
						</thead>
	
		  				<tbody>
		  					<tr>
		  						<td colspan="5">
				  					<div class="alert alert-primary instrument-action" data-target="#new-instrument">
				  						<i class="fa fa-plus">
				  							Add New
				  						</i>
				  					</div>
				  				</td>
			  				</tr>
			  				<tr>
						    	<td class="slide-instrument-row" colspan="5" style="display:none;"
						    	id="new-instrument">
						    		<%@include file="/WEB-INF/views/partials/instrument-edit.jsp" %>
						    	</td>
						    </tr>
		  					<c:forEach var="instrument" items="${ownedInstruments}">
			    				<tr id="tr-${instrument.getId()}">
		                            <!-- <img src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22250%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20250%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_167422792f1%20text%20%7B%20fill%3A%23eceeef%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A13pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_167422792f1%22%3E%3Crect%20width%3D%22200%22%20height%3D%22250%22%20fill%3D%22%2355595c%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2255.609375%22%20y%3D%22131%22%3EThumbnail%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"> -->
							      	<td class="d-none d-sm-table-cell thumbnail">
							      		<%-- <i class="fas fa-search" data-toggle="popover" data-trigger="hover" data-placement="bottom"
							      		data-content="<img src='uploads/90x70.jpg'>">
							      		</i> --%>
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
	
						    			<img class="img-thumbnail" id="thumbnail-${instrument.getId()}" src="${source}" />
							      	</td>
							      	<td class="name">${instrument.getName()}</td>
							      	<td>${instrument.getRents().size()}</td>
							      	<td>
							      		<i class="fas fa-edit instrument-action" data-target="#edit-${instrument.getId()}"></i>
							      	</td>
							      	<td>
							      		<i class="far fa-image instrument-action" data-target="#edit-images-${instrument.getId()}"></i>
							      	</td>
							    </tr>
							    <tr>
							    	<td class="slide-instrument-row" colspan="5" style="display:none;" id="edit-${instrument.getId()}">
							    		<%@include file="/WEB-INF/views/partials/instrument-edit.jsp" %>
							    	</td>
							    </tr>
							    <tr>
							    	<td class="slide-instrument-row" colspan="5" style="display:none;" id="edit-images-${instrument.getId()}">
							    		<%@include file="/WEB-INF/views/partials/instrument-images.jsp" %>
							    	</td>
							    </tr>
							</c:forEach>
		  				</tbody>
					</table>
				</div>
       		</div>
        </div>
    </jsp:body>
</t:main>
