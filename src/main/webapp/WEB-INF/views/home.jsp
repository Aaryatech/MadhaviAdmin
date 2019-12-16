<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<c:url var="getAdvaceOrderDetail" value="/getAdvaceOrderDetail" />

<body>
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
	<!-- BEGIN Container -->



	<div class="container" id="main-container">

		<!-- BEGIN Sidebar -->
		<div id="sidebar" class="navbar-collapse collapse">

			<jsp:include page="/WEB-INF/views/include/navigation.jsp"></jsp:include>

			<div id="sidebar-collapse" class="visible-lg">
				<i class="fa fa-angle-double-left"></i>
			</div>
			<!-- END Sidebar Collapse Button -->
		</div>
		<!-- END Sidebar -->


		<!-- BEGIN Content -->
		<div id="main-content">
			<!-- BEGIN Page Title -->
			<div class="page-title">
				<div>
					<h1>
						<i class="fa fa-file-o"></i> Dashboard
					</h1>
					<!--<h4>Overview, stats, chat and more</h4>-->
				</div>
			</div>
			<!-- END Page Title -->

			<!-- BEGIN Breadcrumb -->
			<div id="breadcrumbs">
				<ul class="breadcrumb">
					<li class="active"><i class="fa fa-home"></i> Home</li>
				</ul>
			</div>
			<!-- END Breadcrumb -->
			<form action="${pageContext.request.contextPath}/searchOrdersCount"
				method="post" id="validation-form">
				<div class="container" id="main-container">
					<div class="col-md-1">
						<div class="col1title">Date:</div>
					</div>
					<div class="col-md-3">
						<input class="form-control" placeholder="Date"
							name="from_datepicker" style="border-radius: 25px;"
							id="from_datepicker" type="date" format="dd-mm-yyyy"
							value="${cDate}" />
					</div>
					<div class="col-md-2">
						<input type="submit" name="submit" id="submit"
							class="btn btn-primary" />

					</div>
				</div>
			</form>
			<br> <br>
			<!-- BEGIN Tiles -->
			<div class="row">


				<div class="col-md-12">
					<div class="row">

						<c:forEach items="${orderCounts}" var="orderCounts">
							<!-- <a href="resoucres/index.php/orders/list_all"> -->
							<div class="col-md-3">
								<div class="tile tile-orange">
									<div class="img">
										<i class="fa fa-shopping-cart fa-5x"></i>
									</div>
									<div class="content">
										<p class="big">
											<c:out value="${orderCounts.total}"></c:out>
										</p>
										<p class="title">
											<c:out value="${orderCounts.menuTitle}"></c:out>
										</p>
										<%--  
										 <a href="showOrders/${orderCounts.menuId}"><span
														class="glyphicon glyphicon-list" title="Order List" style="color:white;"></span></a>
														 <a href="showproduction/${orderCounts.menuId}"><span
														class="glyphicon glyphicon-list" title="Add Order to Production"   style="color:white;"></span></a> --%>


										<a
											href="${pageContext.request.contextPath}/showOrders/${orderCounts.menuId}">
											<button type="button" class="btn">Order List</button>
										</a> <a
											href="${pageContext.request.contextPath}/showproduction/${orderCounts.menuId}">
											<button type="button" class="btn">Add Order to Prod</button>
										</a>

									</div>
								</div>

							</div>


						</c:forEach>

						<div class="clearfix"></div>

						<div id="table-scroll" class="table-scroll">

							<div id="faux-table">
								<table id="table2" class="table table-advance">
									<thead>
										<tr class="bgpink">
											<th class="col-sm-1">Sr No</th>
											<th class="col-md-1">Franchise Name</th>
											<th class="col-md-1">Customer Name</th>
											<th class="col-md-1">Customer Phone No.</th>
											<th class="col-md-1">Delivery Date</th>
											<th class="col-md-1">Delivery Time</th>
											<th class="col-md-1">Grand Total</th>
											<th class="col-md-1">Is Dairy Mart</th>
											<th class="col-md-1">Action</th>

										</tr>
									</thead>

									<tbody>



										<c:forEach items="${advList}" var="advList" varStatus="count">

											<tr>
												<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
												<td class="col-md-2"><c:out value="${advList.frName}" /></td>

												<td class="col-md-2"><c:out value="${advList.custName}" /></td>
												<td class="col-md-1"><c:out
														value="${advList.phoneNumber}" /></td>

												<td class="col-md-2"><c:out
														value="${advList.deliveryDate}" /></td>
												<td class="col-md-1"><c:out value="${advList.exVar1}" /></td>
												<td class="col-md-1"><c:out value="${advList.total}" /></td>

												<td class="col-md-2"><c:choose>
														<c:when test="${advList.isDailyMart==1}">
 														No						
 												    </c:when>
														<c:otherwise>
												        Yes
												    </c:otherwise>
													</c:choose></td>

												<td class="col-md-2"><div>
  														<a href=""
															onclick="showDetailsForCp('${advList.advHeaderId}','${advList.frName}','${advList.custName}','${advList.total}','${advList.isDailyMart}','${advList.deliveryDate}')"
															class="btn btn-default btn-rounded" data-toggle="modal"
															data-target="#elegantModalForm"><abbr title='Edit'><i
																class='fa fa-edit'></i></abbr></a>
													</div></td>
											</tr>
										</c:forEach>
									</tbody>


								</table>

							</div>

						</div>


					</div>


				</div>
			</div>


			<footer>
			<p>2019 © MADHAVI.</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>

		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->
	<!--basic scripts-->

	<!------------------------------------------ MODEL 1-------------------------------------------------->
	<div class="modal fade" id="elegantModalForm" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

		<!--SAVE LOADER-->
		<div id="overlay">
			<div class="clock"></div>
		</div>

		<div class="modal-dialog" role="document"
			style="width: 80%; height: 50%;">
			<!--Content-->
			<div class="modal-content form-elegant">
				<!--Header-->
				<div class="modal-header text-center">
					<h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3"
						id="myModalLabel" style="color: #ea4973;">
						<strong>Advance Order Detail List</strong>
					</h3>
					<%-- <a href="#" class="close" data-dismiss="modal" aria-label="Close"
						id="closeHrefModel"> <img
						src="${pageContext.request.contextPath}/resources/img/close.png"
						alt="X" class="imageclass" />
					</a> --%>
					<div></div>
					<div class="modal-body mx-6">
						 
							<label class="col-sm-2 col-lg-2 control-label"
								style="color: #e20b31;">Amount :<span id="billAmt"></span></label>

							<label class="col-sm-2 col-lg-2 control-label"
								style="color: #e20b31;">Delivery Date :<span id="devDate"></span>
							</label> <label class="col-sm-1 col-lg-2 control-label"
								style="color: #e20b31;"><span id="isMart"></span>
							</label> <label class="col-sm-2 col-lg-3 control-label"
								style="color: blue;">Franchise Name :<span id="frName"></span></label>
								
								<label class="col-sm-2 col-lg-2 control-label"
								style="color: blue;">Customer Name :<span id="custName"></span></label>

						 
							<div class="component">

								<table width="80%" id="modeltable"
									style="font-size: 13px; font-weight: bold; border: 1px solid; border-color: #91d6b8;">
									<!-- class="table table-advance" -->
									<thead>
										<tr>
										 
											<th width="17" style="width: 18px">Sr No</th>
											<th width="120" align="left">Item Name</th>
											<th width="100" align="left">Qty</th>
											<th width="100" align="left">Mrp</th>
											<th width="120" align="left">Rate</th>
											<th width="120" align="left">Subtotal</th>

										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>

							</div>
						 
						 
					</div>
					<!--Body-->
					 
					<!--Footer-->
				</div>
				<!--/.Content-->
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.ba-throttle-debounce.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.stickyheader.js"></script>
	<!----------------------------------------------End MODEL 1------------------------------------------------>
	
	
	<script type="text/javascript">
		function showDetailsForCp(headId, frName, custName, amount, isMart,devDate) {
			 
		 
			$("#billAmt").css("color", "red");
			$("#devDate").css("color", "red");
			$("#isMart").css("color", "red");
			$("#custName").css("color", "red");
			$("#frName").css("color", "red");
			var x;
			if(parseInt(isMart)==1){
				 x="Adv Order";
			}else{
				x="DM Order";
			}
			

			document.getElementById("billAmt").innerHTML = amount;
			document.getElementById("devDate").innerHTML = devDate;
			document.getElementById("isMart").innerHTML = x;
 			document.getElementById("frName").innerHTML = frName;
			document.getElementById("custName").innerHTML = custName;
			 
			$.post('${getAdvaceOrderDetail}', {
				headId : headId,
 				ajax : 'true'
			}, function(data) {

					//alert(JSON.stringify(data));
				$('#modeltable td').remove();

				$.each(data, function(key, data) {
					
					
					var tot;
					
					if(parseInt(isMart)==1){
						tot=parseInt(data.orderQty)*parseFloat(data.orderRate);
					}else{
						tot=parseInt(data.orderQty)*parseFloat(data.orderMrp);
					}
					

					var tr = $('<tr></tr>');

					tr.append($('<td ></td>').html(key + 1));
					tr.append($('<td ></td>').html(data.itemName));
					tr.append($('<td ></td>').html(data.orderQty));
					tr.append($('<td ></td>').html(data.orderMrp));
					tr.append($('<td ></td>').html(data.orderRate));
					tr.append($('<td ></td>').html(tot));
					 
					$('#modeltable tbody').append(tr);
				}); 

			});

		 
	 

		}
	</script>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery-2.0.3.min.js"><\/script>')
	</script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/jquery-cookie/jquery.cookie.js"></script>

	<!--page specific plugin scripts-->
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.resize.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.pie.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.stack.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.crosshair.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.tooltip.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/sparkline/jquery.sparkline.min.js"></script>

	<!--flaty scripts-->
	<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>

</body>
</html>
