<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/component.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/tableSearch.css">
<style type="text/css">
a[disabled="disabled"] {
	pointer-events: none;
}

.switch-toggle {
	width: 14em;
}
</style>
<body>
	<c:url var="showPendingForFr" value="/getBillListForSettle" />
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

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
			<!-- 	<div class="page-title">
				<div>
					<h1>
						<i class="fa fa-file-o"></i> Item Ledger
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->


			<div class="row hidden-xs">
				<div class="col-md-12">
					<div class="box box-pink">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i> Expense List
							</h3>
							<div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
						</div>
						<div class="box-content">

							<form name="${pageContext.request.contextPath}/showExpenseList"
								id="showExpenseList" class="form-horizontal" method="get"
								action="showExpenseList">
								<div class="row">


									<div class="form-group">
										<label class="col-sm-3 col-lg-2	 control-label">From
											Date</label>
										<div class="col-sm-6 col-lg-3 controls date_select">
											<input class="form-control date-picker" id="fromDate"
												name="fromDate" size="30" type="text" value="${fromDate}" />
										</div>

										<!-- </div>

					<div class="form-group  "> -->

										<label class="col-sm-3 col-lg-2	 control-label">To
											Date</label>
										<div class="col-sm-6 col-lg-3 controls date_select">
											<input class="form-control date-picker" id="toDate"
												name="toDate" size="30" type="text" value="${toDate}" />
										</div>




									</div>
								</div>
								<div class="row">

									<div class="form-group">

										<label for="textfield2"
											class="col-xs-3 col-lg-2 control-label">Select
											Franchise </label>
										<div class="col-sm-9 col-lg-4 controls">

											<select class="form-control chosen" multiple="multiple"
												tabindex="6" name="fr_id" id="fr_id">

												<option value="-1">All</option>
												<c:forEach items="${allFrIdNameList}" var="allFrIdNameList"
													varStatus="count">
													<option value="${allFrIdNameList.frId}">${allFrIdNameList.frName}</option>

												</c:forEach>

											</select>
										</div>

										<label class="col-sm-3 col-lg-1	 control-label">Select</label>
										<div class="col-sm-2 col-lg-2">
											<select data-placeholder="Choose "
												class="form-control chosen" tabindex="6" id="type"
												name="type">
												<option value="1">Regular</option>
												<option value="2">Payment Chalan</option>


											</select>


										</div>
									</div>
								</div>




								<br>
								<div class="row">

									<div class="col-md-12" style="text-align: center;">
										<input type="submit" class="btn btn-info" value="Search" />
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">

					<div class="box">

						<div class="box-content">
							<div class="col-md-9"></div>
							<label for="search" class="col-md-3" id="search"> <i
								class="fa fa-search" style="font-size: 20px"></i> <input
								type="text" id="myInput" onkeyup="myFunction()"
								style="border-radius: 25px;"
								placeholder="Search items by Name or Code"
								title="Type in a name">
							</label>

							<div class="clearfix"></div>

							<div id="table-scroll" class="table-scroll">

								<div id="faux-table">
									<table id="table2" class="table table-advance">
										<thead>
											<tr class="bgpink">
												<th class="col-sm-1">Sr No</th>
												<th class="col-md-1">Chalan No.</th>
												<th class="col-md-1">Date</th>
												<th class="col-md-1">Amount</th>
												<th class="col-md-1">Type</th>
												<th class="col-md-1">Status</th>
												<th class="col-md-1">Action</th>

											</tr>
										</thead>

										<tbody>



											<c:forEach items="${expList}" var="expList" varStatus="count">

												<tr>
													<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
													<td class="col-md-2"><c:out
															value="${expList.chalanNo}" /></td>

													<td class="col-md-2"><c:out value="${expList.expDate}" /></td>
													<td class="col-md-1"><c:out value="${expList.chAmt}" /></td>

													<td class="col-md-2"><c:choose>
															<c:when test="${expList.expType==1}">
 														Regular						
 												    </c:when>
															<c:otherwise>
												         Payment Chalan
												    </c:otherwise>
														</c:choose></td>

													<td class="col-md-2"><c:choose>
															<c:when test="${expList.status==1}">
 														Approved						
 												    </c:when>
															<c:otherwise>
												         Pending
												    </c:otherwise>
														</c:choose></td>
													<td class="col-md-2"><div>

															<c:if test="${expList.expType==2}">
													<c:if test="${expList.status==2}">
															<a href=""
																onclick="showDetailsForCp('${expList.expId}','${expList.chAmt}','${expList.expDate}','${expList.chalanNo}','${expList.frId}')"
																class="btn btn-default btn-rounded" data-toggle="modal"
																data-target="#elegantModalForm"><abbr title='Edit'><i
																	class='fa fa-edit'></i></abbr></a>
																</c:if></c:if>

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
			</div>

			<!-- END Main Content -->
			<footer>
				<p>2019 © MADHAVI.</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>

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
						<strong>Close Bill Against Chalan</strong>
					</h3>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"
						id="closeHrefModel"> <img
						src="${pageContext.request.contextPath}/resources/img/close.png"
						alt="X" class="imageclass" />
					</a>
					<div></div>
					<div class="modal-body mx-6">
						<form name="modalfrm" id="modalfrm" method="post">
							<label class="col-sm-3 col-lg-3 control-label"
								style="color: #e20b31;">Amount :<span id="chAmt"></span></label>

							<label class="col-sm-3 col-lg-4 control-label"
								style="color: #e20b31;">Chalan No :<span id="chNo"></span>
							</label> <label class="col-sm-3 col-lg-4 control-label"
								style="color: #e20b31;">Chalan Date :<span id="chDate"></span>
							</label> <label class="col-sm-3 col-lg-4 control-label"
								style="color: blue;">Franchise Name :<span id="frName"></span></label>

							<input type="hidden" name="expId" id="expId" />
							<div class="component">

								<table width="80%" id="modeltable"
									style="font-size: 13px; font-weight: bold; border: 1px solid; border-color: #91d6b8;">
									<!-- class="table table-advance" -->
									<thead>
										<tr>
											<th width="17" style="width: 18px"><input
												type="checkbox" /></th>
											<th width="17" style="width: 18px">Sr No</th>
											<th width="120" align="left">Bill No</th>
											<th width="100" align="left">Bill Date</th>
											<th width="100" align="left">Bill Amount</th>
											<th width="120" align="left">Paid Amt</th>
											<th width="120" align="left">Pending Amt</th>
											<th width="120" align="left">Settle Amt</th>

										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>

							</div>
							<div class="component">
								<label class="col-sm-3 col-lg-1 control-label">Total </label>
								<div class="col-sm-9 col-lg-1 controls">
									<input type="text" name="total" id="total" value="0"
										style="width: 90px;" class="form-control" /> <input
										type="hidden" name="frId" id="frId" value="0"
										class="form-control" /> <input type="hidden" name="delDate"
										id="delDate" value="0" class="form-control" /> <input
										type="hidden" name="expenseId" id="expenseId" value="0"
										class="form-control" />
								</div>
							</div>
						</form>
					</div>
					<!--Body-->
					<div class="modal-body mx-4">
						<!--Body-->
						<div class="text-center mb-1">
							<button type="button" class="btn btn-primary" id="sbtbtn"
								disabled="disabled">Submit</button>
						</div>
					</div>
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
		function showDetailsForCp(expId, expAmt, expDate, chalanNo, frId) {
			var finTot = 0;
			 document
				.getElementById("total").value;
			//alert("hii" + frId + expAmt + expDate + chalanNo);
			$("#chNo").css("color", "red");
			$("#chAmt").css("color", "red");
			$("#frName").css("color", "red");
			$("#chDate").css("color", "red");

			document.getElementById("chNo").innerHTML = chalanNo;
			document.getElementById("chAmt").innerHTML = expAmt;
			document.getElementById("chDate").innerHTML = expDate;
			document.getElementById("frId").value = frId;
			document.getElementById("delDate").value = expDate;
			document.getElementById("expenseId").value = expId;

			$
					.getJSON(
							'${showPendingForFr}',
							{

								frId : frId,
								ajax : 'true',
							},
							function(data) {
								var len = data.length;

								$('#modeltable td').remove();
								//alert(JSON.stringify(data));
								//alert("hii"+len)
								document.getElementById("frName").innerHTML = data[0].frName;
								var totalcalc = 0;
								
								$
										.each(
												data,
												function(key, data) {

													var flag = 0;
													var y = 0;
													var tot = document
															.getElementById("total").value;
													//alert("tot" + tot);
													//alert("expAmt"+expAmt);
													if (parseFloat(data.pendingAmt) <= parseFloat(expAmt)) {
														if ((parseFloat(tot) + parseFloat(data.pendingAmt)) > parseFloat(expAmt)) {
															//alert("ist gret");

															y = (parseFloat(tot) + parseFloat(data.pendingAmt))
																	- parseFloat(expAmt);
															//alert("ist gret"
															//		+ y);
															flag = 1;
														}
													}

													var tr = $('<tr></tr>');

													if (parseFloat(data.pendingAmt) <= parseFloat(expAmt)) {
														tr
																.append($(
																		'<td></td>')
																		.html(
																				"<input type=checkbox class=abc name='chkItem'  checked value="+data.billHeadId+"   id="+ data.billHeadId+"  >  <label for="+ data.billHeadId+" ></label>"));

													} else {

														tr
																.append($(
																		'<td></td>')
																		.html(
																				"<input type=checkbox  class=abc name='chkItem'   value="+data.billHeadId+"   id="+ data.billHeadId+" >  <label for="+ data.billHeadId+" ></label>"));

													}

													tr.append($('<td></td>')
															.html(key + 1));
													tr
															.append($(
																	'<td></td>')
																	.html(
																			data.billNo
																					+ ""
																					+ "<input type=hidden value='"+data.billNo+"'  id=billNo"+data.billHeadId+"  name=billNo"+data.billHeadId+"  >"));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			data.billDate
																					+ ""
																					+ "<input type=hidden value='"+data.billDate+"'  id=billDate"+data.billHeadId+"  name=billDate"+data.billHeadId+"  >"));
													tr
															.append($(
																	'<td></td>')
																	.html(
																			data.billAmt
																					+ ""
																					+ "<input type=hidden value='"+data.billAmt+"'  id=billAmt"+data.billHeadId+"  name=billAmt"+data.billHeadId+"  >"));
													tr
															.append($(
																	'<td></td>')
																	.html(
																			data.paidAmt
																					+ ""
																					+ "<input type=hidden value='"+data.paidAmt+"'  id=paidAmt"+data.billHeadId+"  name=paidAmt"+data.billHeadId+"  >"));
													tr
															.append($(
																	'<td></td>')
																	.html(
																			data.pendingAmt
																					+ ""
																					+ "<input type=hidden value='"+data.pendingAmt+"'  id=pendingAmt"+data.billHeadId+"  name=pendingAmt"+data.billHeadId+"  >"));

													if (flag == 0) {
														
														//alert("in if");

														tr
																.append($(
																		'<td></td>')
																		.html(
																				"<input type=text onkeypress='return IsNumeric(event);'   style='width:100px;border-radius:25px; font-weight:bold;text-align:center;'  readonly ondrop='return false;' min='0'  onpaste='return false;' style='text-align: center;' class='form-control' name='settleAmt"
																						+ data.billHeadId
																						+ "'  id=settleAmt"
																						+ data.billHeadId
																						+ " value="
																						+ data.pendingAmt
																						+ "  /> &nbsp;  "));

														if (parseFloat(data.pendingAmt) <= parseFloat(expAmt)) {
															finTot = parseFloat(data.pendingAmt)
																	+ (parseFloat(finTot));
															document
																	.getElementById("total").value = finTot
																	.toFixed(3);
														}
													}

													else {
														
														//alert("in else");
														var fin = parseFloat(data.pendingAmt)
														- (parseFloat(y));
														
														//alert("fin"+fin);
											
														tr
																.append($(
																		'<td></td>')
																		.html(
																				"<input type=text onkeypress='return IsNumeric(event);'   style='width:100px;border-radius:25px; font-weight:bold;text-align:center;'  readonly ondrop='return false;' min='0'  onpaste='return false;' style='text-align: center;' class='form-control' name='settleAmt"
																						+ data.billHeadId
																						+ "'  id=settleAmt"
																						+ data.billHeadId
																						+ " value="
																						+ fin
																						+ "  /> &nbsp;  "));

													
														if (parseFloat(data.pendingAmt) <= parseFloat(expAmt)) {
															finTot = fin
																	+ (parseFloat(finTot));
															//alert("finTot"+finTot);
															document.getElementById("total").value = finTot
																	.toFixed(3);
															
														
														}
														$("#chkItem").prop(
																"disabled",
																true);
														
														//document.getElementById("chkItem").disabled=checkStat == 1 ? true : false;
														 
													}

													$('#modeltable tbody')
															.append(tr);

													document.getElementById(data.billHeadId).disabled = true; 

												});
								finTot = 0;

							 

								if (parseFloat(	document.getElementById("total").value) <= parseFloat(expAmt)) {
									$("#sbtbtn").prop("disabled", false);

								} 

							});
		}
	</script>
	<script type="text/javascript">
		function showTotalQty() {

			//alert("hii");
			var arr = [];
			$('input[name="chkItem"]:checked').each(function() {
				arr.push(this.value);
			});
			var totalQty = 0;
			arr.forEach(function(v) {
				var itemQty = parseFloat($('#settleAmt' + v).val());
				totalQty = totalQty + itemQty;
			});
			document.getElementById("total").value = totalQty.toFixed(3);
			var chAmt = document.getElementById("chAmt").innerHTML;

			if (parseFloat(total) <= parseFloat(chAmt)) {
				$("#sbtbtn").prop("disabled", false);

			}

		}
	</script>

	<script type="text/javascript">
		$('#sbtbtn').click(function() {
			$("#overlay").fadeIn(300);

			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/submitRespose",
				data : $("#modalfrm").serialize(),
				dataType : 'json',
				success : function(data) {
					if (data == 2) {
						$('#modeltable td').remove();
						alert("Updated Successfully")
						$("#overlay").fadeOut(300);
						$("#closeHrefModel")[0].click()
					}
				}
			}).done(function() {
				setTimeout(function() {
					$("#overlay").fadeOut(300);
				}, 500);
			});
		});
	</script>

	<!-- END Container -->

	<!-- <!--basic scripts-->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<!-- 	<script>
		window.jQuery
				|| document
						.write('<script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery-2.0.3.min.js"><\/script>')
	</script> -->
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


	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>

	<!--flaty scripts-->
	<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>
	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>


	<!-- js & css  for modal  -->




	<!--  -->
</body>



</html>