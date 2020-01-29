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
										<p class="medium" style="font-size: 20px;">
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
											<button type="button" style="margin-bottom: 35px;"
												class="btn">Order List</button>
										</a> <a
											href="${pageContext.request.contextPath}/showproduction/${orderCounts.menuId}">
											<button type="button" style="margin-bottom: 35px;"
												class="btn">Add Order to Prod</button>
										</a>

									</div>
								</div>

							</div>


						</c:forEach>

					</div>
				</div>
			</div>


			<!-- END Breadcrumb -->
			<form action="${pageContext.request.contextPath}/searchOrdersCount"
				method="post" id="validation-form">
				<div class="container" id="main-container">
					<div class="row">
						<div class="col-md-1">
							<div class="col1title">Prod Date:</div>
						</div>
						<div class="col-md-2">
							<%-- <input class="form-control" placeholder="Date"
								name="from_datepicker" style="border-radius: 25px;"
								id="from_datepicker" type="date" format="dd-mm-yyyy"
								value="${cDate}" /> --%>

							<input class="form-control datepicker22  date-picker"  
								autocomplete="off" placeholder="Date" name="from_datepicker"
								style="border-radius: 25px;" id="from_datepicker" type="text"
								value="${cDate1}" />

						</div>
						<div class="col-md-4">
							<input type="submit" name="submit" id="submit"
								value="Search By Prod Date" class="btn btn-primary" /> <input
								type="submit" name="submit1" id="submit1"
								value="Search Pending For Bill" class="btn btn-primary" />


						</div>
					</div>
					<div class="form-group"></div>
					<div class="row">
						<div class="col-md-1">
							<div class="col1title">From Date:</div>
						</div>
						<div class="col-md-2">
							<input class="form-control datepicker22  date-picker"
								autocomplete="off" placeholder="Date" name="from_date"
								style="border-radius: 25px;" id="from_date" type="text"
								value="${fromDate}" onblur="checkDashboardDate()" />
						</div>
						<div class="col-md-1">
							<div class="col1title">To Date:</div>
						</div>
						<div class="col-md-2">
							<input class="form-control datepicker22  date-picker"
								autocomplete="off" placeholder="Date" name="to_date"
								style="border-radius: 25px;" id="to_date" type="text"
								value="${toDate}" onblur="checkDashboardDate()" />
						</div>


						<div class="col-md-3">

							<select data-placeholder="Choose Franchisee"
								class="form-control chosen" tabindex="6" id="selectFr"
								name="selectFr">
								<option selected value="-1"><c:out value="All" /></option>

								<c:forEach items="${frList}" var="fr" varStatus="count">
									<c:choose>

										<c:when test="${fr.frId==frId}">
											<option selected value="${fr.frId}"><c:out
													value="${fr.frName}" /></option>
										</c:when>
										<c:otherwise>
											<option value="${fr.frId}"><c:out
													value="${fr.frName}" /></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>

						</div>

						<div class="col-md-1">
							<input type="submit" name="submit2" id="submit2" value="Search" 
								class="btn btn-primary" />
						</div>
					</div>
				</div>
			</form>
			<br> <br>
			<!-- BEGIN Tiles -->
			<div class="row">


				<div class="col-md-12">
					<div class="row">



						<div class="clearfix"></div>
						<form method="post" id="modal-dialog_form1">
							<input type="hidden" id="ordHeaderIdForDel"
								name="ordHeaderIdForDel" value="0">


							<div id="table-scroll" class="table-scroll">

								<div id="faux-table">
									<table id="table2" class="table table-advance">

										<tr
											style="background-color: #f3b5db; font-size: 14; color: #fff"
											class="bgpink">
											<th style="background-color: #f3b5db; color: #fff"
												class="col-sm-1">Sr No</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Franchise Name</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Customer Name</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Customer Phone No.</th>
												
												<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Address</th>
												
												<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Kilometer</th>
												
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Delivery Date</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Delivery Time</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Grand Total</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Dairy Mart</th>
											<th style="background-color: #f3b5db; color: #fff"
												class="col-md-1">Action</th>

										</tr>


										<tbody>



											<c:forEach items="${advList}" var="advList" varStatus="count">

												<tr>
													<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
													<td class="col-md-2"><c:out value="${advList.frName}" /></td>

													<td class="col-md-2"><c:out
															value="${advList.custName}" /></td>
													<td class="col-md-1"><c:out
															value="${advList.phoneNumber}" /></td>
															
															<td class="col-md-1"><c:out
															value="${advList.address}" /></td>
															
															<td class="col-md-1"><c:out
															value="${advList.km}" /></td>

													<td class="col-md-2"><c:out
															value="${advList.deliveryDate}" /></td>
													<td class="col-md-1"><c:out value="${advList.exVar2}" /></td>
													<td class="col-md-1"><c:out value="${advList.total}" /></td>

													<td class="col-md-2"><c:choose>
															<c:when test="${advList.isDailyMart==1}">
 														No						
 												    </c:when>
															<c:otherwise>
												        Yes
												    </c:otherwise>
														</c:choose></td>

													<td class="col-md-2" style="white-space: nowrap;"><a
														href=""
														onclick="showDetailsForCp('${advList.advHeaderId}','${advList.frName}','${advList.custName}','${advList.total}','${advList.isDailyMart}','${advList.deliveryDate}','${advList.advanceAmt}','${advList.prodDate}','${advList.isBillGenerated}','${advList.exVar2}','${advList.address}','${advList.km}')"
														class="btn btn-default btn-rounded" data-toggle="modal"
														data-target="#elegantModalForm"><abbr title='Edit'><i
																class='fa fa-edit'></i></abbr></a> <c:if
															test="${prodDateSearch==0}">
															<c:if test="${advList.isBillGenerated==0}">
																<a href="#"
																	onclick="DeleteOrder('${advList.advHeaderId}')"
																	class="btn btn-default"><abbr title='Delete'><i
																		class='fa fa-trash-o'></i></abbr></a>
															</c:if>
														</c:if></td>
												</tr>
											</c:forEach>
										</tbody>


									</table>
									<div align="center" id="loader" style="display: none">

										<span>
											<h4>
												<font color="#343690">Loading</font>
											</h4>
										</span> <span class="l-1"></span> <span class="l-2"></span> <span
											class="l-3"></span> <span class="l-4"></span> <span
											class="l-5"></span> <span class="l-6"></span>
									</div>

								</div>

							</div>
						</form>


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

		<form method="post" id="modal-dialog_form">

			<input type="hidden" id="ordHeaderId" name="ordHeaderId" value="0">
			<input type="hidden" id="isMart" name="isMart" value="0">


			<div class="modal-dialog" role="document"
				style="width: 80%; height: 50%;">
				<!--Content-->
				<div class="modal-content form-elegant">

					<a href="#" class="close" data-dismiss="modal" aria-label="Close"
						style="margin: 10px;" id="closeHrefModel"> <i
						class="fa fa-times" style="color: #000000;"></i>
					</a>

					<!--Header-->
					<div class="modal-header text-center">
						<h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3"
							id="myModalLabel" style="color: #ea4973;">
							<strong>Advance Order Detail List</strong>
						</h3>

						<div></div>
						<div class="modal-body mx-6">
							<div class="row">
								<label class="col-sm-2 col-lg-2 control-label"
									style="color: #e20b31;">Amount :<span id="billAmt"></span></label>

								<label class="col-sm-2 col-lg-2 control-label"
									style="color: #e20b31;">Delivery Date :<span
									id="devDate"></span>
								</label> <label class="col-sm-1 col-lg-1 control-label"
									style="color: #e20b31;"><span id="isMart"></span> </label> <label
									class="col-sm-2 col-lg-3 control-label" style="color: blue;">Franchise
									Name:<span id="frName"></span>
								</label> <label class="col-sm-2 col-lg-3 control-label"
									style="color: blue;">Customer Name :<span id="custName"></span></label>

							</div>
							<div class="component">

								<table width="80%" id="modeltable" class="table table-advance"
									style="font-size: 13px; font-weight: bold; border: 1px solid; border-color: #91d6b8;">
									<!-- class="table table-advance" -->
									<thead>
										<tr class="bgpink" style="background-color: red">

											<th class="col-sm-1" align="right">Sr No</th>
											<th class="col-md-2" align="center">Item Name</th>
											<th class="col-md-1" align="center">Mrp</th>
											<th class="col-md-1" align="center">Rate</th>

											<th class="col-md-1" align="center">Qty</th>
											<th class="col-md-1" align="center">Disc %</th>
											<th class="col-md-1" align="center">Subtotal</th>

										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
							<div class="form-group"></div>
							<div class="row">
								<label class="col-sm-1 control-label" style="color: blue;">Advance
									Amt: </label>
								<div class="col-sm-2">
									<input type="text" id="advanceAmt" name="advanceAmt"
										class="form-control" style="width: 70%" value="0">
								</div>
								<label class="col-sm-1 control-label" style="color: blue;">Production
									Date</label>
								<div class="col-sm-2 controls date_select">
									<input class="form-control datepicker22  date-picker"
										onblur="checkProdDateLessThanDelDate()" id="prod_date"
										name="prod_date" size="15" type="text" /> <input
										class="form-control" style="display: none;"
										id="prod_date_hide" name="prod_date_hide" size="15"
										type="text" />
								</div>
								<label class="col-sm-1 control-label" style="color: blue;">Delivery
									Date</label>
								<div class="col-sm-2 controls date_select">
									<input class="form-control datepicker22  date-picker"
										onblur="checkProdDateLessThanDelDate()" id="deliveryDate"
										name="deliveryDate" size="25" type="text" /> <input
										class="form-control" style="display: none;"
										id="deliveryDate_hide" name="deliveryDate_hide" size="15"
										type="text" />
								</div>

								<label class="col-sm-1 control-label" style="color: blue;">Delivery
									Time:</label>
								<!-- <input type="time" id=delTime name="delTime" value="0"> -->
								<div class="col-sm-2">
									<input type="text" id="clockface_1" name="delTime"
										data-format="hh:mm A" readonly="readonly"
										class="form-control small clockface-open">
								</div>
							</div>
							
							<div class="row">
							
							<label class="col-sm-1 control-label" style="color: blue;">Delivery Address: </label>
								<div class="col-sm-8">
									<input type="text" id="addr" name="addr"
										class="form-control" value="">
								</div>
								
								<label class="col-sm-1 control-label" style="color: blue;">Kilometer: </label>
								<div class="col-sm-2">
									<input type="text" id="km" name="km" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
										class="form-control" style="width: 70%" value="0">
								</div>
							
							</div>
							
							<div class="form-group"></div>
							<div class="col-md-6">

								<c:choose>
									<c:when test="${prodDateSearch==1}">
										<input type="button" id="saveEditAdvOrderBtn"
											class="button btn-success" style="visibility: hidden;"
											value="Save/Update" disabled="disabled">
									</c:when>
									<c:otherwise>
										<input type="button" id="saveEditAdvOrderBtn"
											class="button btn-success" onclick="saveEditAdvOrder()"
											value="Save/Update">
									</c:otherwise>
								</c:choose>
							</div>

							<!-- 									<input type="text" id="clockface_1" value="2:30 PM" data-format="hh:mm A" class="form-control small clockface-open">
 -->

						</div>
						<div align="center" id="loader1" style="display: none">

							<span>
								<h4>
									<font color="#343690">Loading</font>
								</h4>
							</span> <span class="l-1"></span> <span class="l-2"></span> <span
								class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
							<span class="l-6"></span>
						</div>
					</div>
					<!--Body-->

					<!--Footer-->
				</div>
				<!--/.Content-->
			</div>
	</div>
	</form>
	</div>
	<style>
.datepicker {
	z-index: 999999;
}
</style>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.ba-throttle-debounce.min.js"></script>
	<%-- <script
		src="${pageContext.request.contextPath}/resources/js/jquery.stickyheader.js"></script> --%>
	<!----------------------------------------------End MODEL 1------------------------------------------------>


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
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>

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

	<!-- for timepicker  -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>



<script type="text/javascript">

function submitOnClick() {
	
	var from = document.getElementById("from_date").value;
	var to = document.getElementById("to_date").value;

	//alert(from + "             " + to);

	if (from == "" || to == "") {
		alert("Please select date!");
	} else {

		var day1 = from.slice(0, 2);
		var month1 = from.slice(3, 5) - 1;
		var year1 = from.slice(6, 10);

		var day2 = to.slice(0, 2);
		var month2 = to.slice(3, 5) - 1;
		var year2 = to.slice(6, 10);

		var g1 = new Date(year1, month1, day1);
		var g2 = new Date(year2, month2, day2);

		//alert(g1 + "    -------------         " + g2);

		if (g1.getTime() > g2.getTime()) {

		
			alert("From Date should be less than To Date");

			document.getElementById("from_date").value = "";
			document.getElementById("to_date").value = "";
		}else{
			//document.getElementById("validation-form").submit();
			var form1=document.getElementById("validation-form");
			form1.action="searchOrdersCount";
			form1.method="post";
			form1.submit();
			alert("submit");
		}
	}
	
}

</script>

	<script type="text/javascript">
		function checkDashboardDate() {

			//alert("hi");

			var from = document.getElementById("from_date").value;
			var to = document.getElementById("to_date").value;

			//alert(from + "             " + to);

			if (from == "" || to == "") {

			} else {

				var day1 = from.slice(0, 2);
				var month1 = from.slice(3, 5) - 1;
				var year1 = from.slice(6, 10);

				var day2 = to.slice(0, 2);
				var month2 = to.slice(3, 5) - 1;
				var year2 = to.slice(6, 10);

				var g1 = new Date(year1, month1, day1);
				var g2 = new Date(year2, month2, day2);

				//alert(g1 + "    -------------         " + g2);

				if (g1.getTime() > g2.getTime()) {

				
					alert("From Date should be less than To Date");

					document.getElementById("from_date").value = "";
					document.getElementById("to_date").value = "";
				}
			}

		}
	</script>



	<script type="text/javascript">
		function checkProdDateLessThanDelDate() {

			var prod = document.getElementById("prod_date").value;
			var del = document.getElementById("deliveryDate").value;

			var oldProd = document.getElementById("prod_date_hide").value;
			var oldDel = document.getElementById("deliveryDate_hide").value;

			//alert(prod + "             " + del);

			var day1 = prod.slice(0, 2);
			var month1 = prod.slice(3, 5) - 1;
			var year1 = prod.slice(6, 10);

			var day2 = del.slice(0, 2);
			var month2 = del.slice(3, 5) - 1;
			var year2 = del.slice(6, 10);

			var g1 = new Date(year1, month1, day1);
			var g2 = new Date(year2, month2, day2);

			//alert(g1 + "    -------------         " + g2);

			if (g1.getTime() > g2.getTime()) {

				if (confirm('Production Date should be less than Delivery Date')) {
					document.getElementById("prod_date").value = oldProd;
					document.getElementById("deliveryDate").value = oldDel;
				} else {
					document.getElementById("prod_date").value = oldProd;
					document.getElementById("deliveryDate").value = oldDel;
				}

				/* 	alert("Production Date should be less than Delivery Date");
					
					document.getElementById("prod_date").value=oldProd;
					document.getElementById("deliveryDate").value=oldDel; */
			}

		}
	</script>




	<script type="text/javascript">
		function showDetailsForCp(headId, frName, custName, amount, isMart,
				devDate, advanceAmt, prodDate, isBillGenerated, delivTime,addr,km) {

			//alert(" hiiiiiiiiiiiiiii "+prodDate);

			$("#billAmt").css("color", "red");
			$("#devDate").css("color", "red");
			$("#isMart").css("color", "red");
			$("#custName").css("color", "red");
			$("#frName").css("color", "red");
			var x;
			if (parseInt(isMart) == 1) {
				x = "Adv Order";
			} else {
				x = "DM Order";
			}

			document.getElementById("ordHeaderId").value = headId;
			document.getElementById("isMart").value = isMart;
			document.getElementById("advanceAmt").value = advanceAmt;

			document.getElementById("billAmt").innerHTML = amount;
			document.getElementById("devDate").innerHTML = devDate;
			document.getElementById("isMart").innerHTML = x;
			document.getElementById("frName").innerHTML = frName;
			document.getElementById("custName").innerHTML = custName;
			document.getElementById("deliveryDate").value = devDate;
			document.getElementById("clockface_1").value = delivTime;
			
			document.getElementById("addr").value = addr;
			document.getElementById("km").value = km;

			document.getElementById("deliveryDate_hide").value = devDate;

			$
					.post(
							'${getAdvaceOrderDetail}',
							{
								headId : headId,
								ajax : 'true'
							},
							function(data) {

								//alert(JSON.stringify(data));
								$('#modeltable td').remove();
								document.getElementById("saveEditAdvOrderBtn").disabled = false;
								document.getElementById("saveEditAdvOrderBtn").style.display = "block";
								document.getElementById("prod_date").value = prodDate;
								document.getElementById("prod_date_hide").value = prodDate;

								$
										.each(
												data,
												function(key, data) {

													var tot;

													if (parseInt(isMart) == 1) {
														tot = parseInt(data.orderQty)
																* parseFloat(data.orderRate);
													} else {
														tot = parseInt(data.orderQty)
																* parseFloat(data.orderMrp);
													}
													tot = tot
															- (parseFloat(tot)
																	* parseFloat(data.isPositive) / 100);

													var tr = $('<tr></tr>');
													var tb_qty = '<input onChange="changeSubTotal('
															+ data.orderId
															+ ')" type="number" class="form-control" min="0" max="99999"  style="width: 70% color:red" id="tb_qty'
															+ data.orderId
															+ '" name="tb_qty'
															+ data.orderId
															+ '" value="'
															+ data.orderQty
															+ '">';
													var disc_per = '<input onChange="changeSubTotal('
															+ data.orderId
															+ ')" type="number" class="form-control"  min="0" max="99999" style="width: 70%" id="disc_per'
															+ data.orderId
															+ '" name="disc_per'
															+ data.orderId
															+ '" value="'
															+ data.isPositive
															+ '">';
													var tb_rate = '<input type="number" class="form-control" min="0" max="99999"  style="width: 70%" id="tb_rate'
															+ data.orderId
															+ '" name="tb_rate'
															+ data.orderId
															+ '" value="'
															+ data.orderRate
															+ '">';

													tr
															.append($(
																	'<td class="col-sm-1" align="left" ></td>')
																	.html(
																			key + 1));
													tr
															.append($(
																	'<td class="col-md-2" align="left"  ></td>')
																	.html(
																			data.itemName));
													tr
															.append($(
																	'<td name="tb_mrp'
															+ data.orderId
															+ '" id="tb_mrp'
															+ data.orderId
															+ '"  class="col-md-1" align="left"  ></td>')
																	.html(
																			data.orderMrp));
													tr
															.append($(
																	'<td class="col-md-1" align="left" ></td>')
																	.html(
																			tb_rate));

													tr
															.append($(
																	'<td class="col-md-1" align="left"></td>')
																	.html(
																			tb_qty));
													tr
															.append($(
																	'<td class="col-md-1" align="left" ></td>')
																	.html(
																			disc_per));
													tr
															.append($(
																	'<td id="tb_total'
															+ data.orderId
															+ '" class="col-md-1" align="left" ></td>')
																	.html(tot));

													tr
															.append($(
																	'<td id="tb_isPositive'
															+ data.orderId
															+ '" style="display:none;" class="col-md-1" align="left" ></td>')
																	.html(
																			data.isPositive));

													$('#modeltable tbody')
															.append(tr);
													if (isBillGenerated == 2) {
														document
																.getElementById("saveEditAdvOrderBtn").disabled = true;
														document
																.getElementById("saveEditAdvOrderBtn").style.display = "none";

														$(
																"#saveEditAdvOrderBtn")
																.hide();
													}
												});

							});

		}

		function changeSubTotal(id) {

			//alert(id);
			var qty = document.getElementById("tb_qty" + id).value;
			var disc = document.getElementById("disc_per" + id).value;

			var isMart = document.getElementById("isMart").value;

			var rate = document.getElementById("tb_rate" + id).value;
			var mrp = document.getElementById("tb_mrp" + id).innerHTML;
			var isPositive = document.getElementById("tb_isPositive" + id).innerHTML;

			//alert(qty+"           "+disc+"          "+isMart+"      "+rate+"      "+mrp);

			var tot;

			if (parseInt(isMart) == 1) {
				tot = parseInt(qty) * parseFloat(rate);
			} else {
				tot = parseInt(qty) * parseFloat(mrp);
			}

			tot = tot - (parseFloat(tot) * parseFloat(disc) / 100);

			document.getElementById("tb_total" + id).innerHTML = tot;

		}

		function saveEditAdvOrder() {

			var prod = document.getElementById("prod_date").value;
			var del = document.getElementById("deliveryDate").value;

			var oldProd = document.getElementById("prod_date_hide").value;
			var oldDel = document.getElementById("deliveryDate_hide").value;
			
			//alert(prod + "             " + del);

			var day1 = prod.slice(0, 2);
			var month1 = prod.slice(3, 5) - 1;
			var year1 = prod.slice(6, 10);

			var day2 = del.slice(0, 2);
			var month2 = del.slice(3, 5) - 1;
			var year2 = del.slice(6, 10);

			var g1 = new Date(year1, month1, day1);
			var g2 = new Date(year2, month2, day2);

			//alert(g1 + "    -------------         " + g2);

			if (g1.getTime() > g2.getTime()) {

				alert("Production Date should be less than Delivery Date");

			} else {

				$('#loader1').show();
				document.getElementById("saveEditAdvOrderBtn").disabled = true;
				$
						.ajax({
							type : "POST",
							url : "${pageContext.request.contextPath}/editAdvanceOrderSubmit",
							data : $("#modal-dialog_form").serialize(),
							dataType : 'json',
							success : function(data) {
								// alert(JSON.stringify(data));
								$('#loader1').hide();

								location.reload(true);

							}
						})

			}

		}

		function DeleteOrder(ordHeadId) {

			var x = confirm("Are you sure to delete? ");
			//alert(x)
			if (x) {
				//alert("Yes");
				$('#loader').show();

				document.getElementById("ordHeaderIdForDel").value = ordHeadId;

				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/deleteAdvOrder",
					data : $("#modal-dialog_form1").serialize(),
					dataType : 'json',
					success : function(data) {
						$('#loader').hide();
						// alert(JSON.stringify(data));
						location.reload(true);

					}
				})
			}

		}
		/* $("#submit1").click(function(){
			
		var form1=document.getElementById("validation-form");
		form1.action="searchOrdersCount";
		form1.method="post";
		form1.submit();
			
			}) */
	</script>


</body>
</html>
