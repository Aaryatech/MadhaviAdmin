<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<style>
table {
	width: 100%;
	border: 1px solid #ddd;
}

#overlay2 {
	position: fixed;
	display: none;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(239, 219, 219, 0.5);
	z-index: 9992;
	cursor: pointer;
}

#text2 {
	position: absolute;
	top: 50%;
	left: 50%;
	font-size: 25px;
	color: white;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
}
</style>

<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getDateForAccHeader" value="/getDateForAccHeader" />

	<c:url var="getFrListForApprovrGrn" value="/getFrListForApprovrGrn" />

	<c:url var="getGrnHeaderList" value="/getGrnHeaderList" />




	<div class="container" id="main-container">

		<div id="overlay2">
			<div id="text2">
				<img
					src="${pageContext.request.contextPath}/resources/img/loader.gif"
					alt="madhvi_logo">
			</div>
		</div>

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
						<i class="fa fa-file-o"></i>GRN Header Account
					</h1>

				</div>
			</div> -->
			<!-- END Page Title -->

			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i>Search GRN Header for Account
							</h3>
							<div class="box-tool">
								<!-- <a href="">Back to List</a> <a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a> -->
							</div>
							<!-- <div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a> <a data-action="close" href="#"><i
									class="fa fa-times"></i></a>
							</div> -->
						</div>


						<div class="box-content">
							<form
								action="${pageContext.request.contextPath}/getGrnHeaderForAcc"
								class="form-horizontal" method="get">

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">From
										Date</label>
									<div class="col-sm-5 col-lg-3 controls">
										<input class="form-control date-picker" id="from_date"
											size="16" type="text" name="from_date" value="${fromDate}"
											required onblur="getDate()" />
									</div>
									<!-- </div>


								<div class="form-group"> -->
									<label class="col-sm-3 col-lg-2 control-label">To Date</label>
									<div class="col-sm-5 col-lg-3 controls">
										<input class="form-control date-picker" id="to_date" size="16"
											type="text" value="${toDate}" name="to_date" required
											onblur="getDate()" />
									</div>


								</div>

								<div class="form-group">
									<label class="col-sm-3 col-lg-2 control-label">Franchise</label>

									<div class="col-sm-5 col-lg-8 controls">

										<select data-placeholder="Choose Franchisee"
											class="form-control chosen" multiple="multiple" tabindex="6"
											id="selectFr" name="selectFr"
											onchange="setAllFrSelected(this.value)">

											<option value="-1"><c:out value="All" /></option>

											<c:forEach items="${unSelectedFrList}" var="fr"
												varStatus="count">
												<option value="${fr.frId}"><c:out
														value="${fr.frName}" /></option>
											</c:forEach>
										</select>

										<%-- <select data-placeholder="Choose Franchisee"
											class="form-control chosen" multiple="multiple" tabindex="6"
											id="selectFr" name="selectFr" onchange="getDate()">



											<c:choose>
												<c:when test="${frSelectedFlag==0}">
													<option value="-1"><c:out value="All" /></option>
													<c:forEach items="${unSelectedFrList}" var="fr"
														varStatus="count2">
														<option value="${fr.frId}"><c:out
																value="${fr.frName}" /></option>

													</c:forEach>

												</c:when>
												<c:when test="${frSelectedFlag==1}">
													<option value="-1" selected><c:out value="All" /></option>
													<c:forEach items="${unSelectedFrList}" var="fr"
														varStatus="count2">
														<option value="${fr.frId}"><c:out
																value="${fr.frName}" /></option>

													</c:forEach>

												</c:when>
												<c:when test="${frSelectedFlag==2}">
													<option value="-1"><c:out value="All" /></option>
													<c:forEach items="${unSelectedFrList}" var="fr"
														varStatus="count2">
														<c:set var="flag" value="0"></c:set>
														<c:forEach items="${franchiseList}" var="selFr"
															varStatus="count2">
															<c:choose>
																<c:when test="${selFr==fr.frId}">
																	<option selected value="${fr.frId}"><c:out
																			value="${fr.frName}" /></option>
																	<c:set var="flag" value="1"></c:set>
																</c:when>
																<c:otherwise>



																</c:otherwise>
															</c:choose>
														</c:forEach>
														<c:choose>
															<c:when test="${flag==0}">
																<option value="${fr.frId}"><c:out
																		value="${fr.frName}" /></option>
															</c:when>
														</c:choose>
													</c:forEach>

												</c:when>
												<c:otherwise>


												</c:otherwise>
											</c:choose>
											

										</select> --%>
									</div>

									<div class="col-md-2">
										<!-- <input type="submit" value="Submit" class="btn btn-primary"> -->

										<input type="button" class="btn btn-primary" value="Search"
											id="callSubmit" onclick="callSearch()">

									</div>

								</div>

								<div align="center" id="loader" style="display: none">

									<span>
										<h4>
											<font color="#343690">Loading</font>
										</h4>
									</span> <span class="l-1"></span> <span class="l-2"></span> <span
										class="l-3"></span> <span class="l-4"></span> <span
										class="l-5"></span> <span class="l-6"></span>
								</div>

							</form>

							<form action="" class="form-horizontal" method="post"
								id="validation-form">

								<div class="box">
									<div class="box-title">
										<h3>
											<i class="fa fa-table"></i> GRN List
										</h3>
										<div class="box-tool">
											<a data-action="collapse" href="#"><i
												class="fa fa-chevron-up"></i></a>
											<!--<a data-action="close" href="#"><i class="fa fa-times"></i></a>-->
										</div>
									</div>

									<div class="box-content">

										<div class="clearfix"></div>
										<div id="table-scroll" class="table-scroll">
											<div id="faux-table" class="faux-table" aria="hidden"></div>

											<div class="table-wrap">
												<table id="table1" class="table table-advance" border="1">
													<thead>
														<tr class="bgpink">
															<th class="col-md-1"><input type="checkbox"></th>
															<th class="col-md-1" style="text-align: center;">GrnSr
																No</th>
															<th class="col-md-1" style="text-align: center;">Date</th>
															<th class="col-md-1" style="text-align: center;">Franchisee</th>
															<th class="col-md-1" style="text-align: center;">Taxable
																Amt</th>
															<th class="col-md-1" style="text-align: center;">Tax
																Amt</th>
															<th class="col-md-1" style="text-align: center;">Amount</th>
															<th class="col-md-1" style="text-align: center;">Approved
																Amt</th>
															<th class="col-md-1" style="text-align: center;">Status</th>
															<th class="col-md-1" style="text-align: center;">Action</th>

														</tr>

													</thead>
													<tbody>
														<%-- <c:forEach items="${grnList}" var="grnList"
														varStatus="count">

														<tr>
														<tr>
															<td class="col-md-1"><c:out
																	value="${grnList.grngvnSrno}" /> <input type="hidden"
																name="headerId" id="headerId"
																value="${grnList.grnGvnHeaderId}"></td>
															<td class="col-md-1"><c:out
																	value="${grnList.grngvnDate}" /></td>

															<td class="col-md-1"><c:forEach
																	items="${unSelectedFrList}" var="fr" varStatus="cnt">
																	<c:choose>
																		<c:when test="${grnList.frId==fr.frId}">
												${fr.frName}
												</c:when>
																		<c:otherwise>

																		</c:otherwise>
																	</c:choose>
																</c:forEach></td>
															<td class="col-md-1"><c:out
																	value="${grnList.taxableAmt}" /></td>
															<td class="col-md-1"><c:out
																	value="${grnList.taxAmt}" /></td>
															<td class="col-md-1"><c:out
																	value="${grnList.totalAmt}" /></td>

															<td class="col-md-1"><fmt:formatNumber type="number"
																	minFractionDigits="2" maxFractionDigits="2"
																	value="${grnList.apporvedAmt}" /> <c:out value="${grnList.taxableAmt}" /></td>
															<c:set var="status" value="" />

															<c:choose>
																<c:when test="${grnList.grngvnStatus==1}">
																	<c:set var="status" value="Pending" />
																</c:when>
																<c:when test="${grnList.grngvnStatus==2}">
																	<c:set var="status" value="Approved By Dispatch" />
																</c:when>
																<c:when test="${grnList.grngvnStatus==3}">
																	<c:set var="status" value="Reject By Dispatch" />
																</c:when>
																<c:when test="${grnList.grngvnStatus==8}">
																	<c:set var="status" value="Partially Approved" />
																</c:when>
																<c:when test="${grnList.grngvnStatus==5}">
																	<c:set var="status" value="Pending" />
																</c:when>
																<c:when test="${grnList.grngvnStatus==6}">
																	<c:set var="status" value="Approved By Account" />

																</c:when>
																<c:when test="${grnList.grngvnStatus==7}">
																	<c:set var="status" value="Reject By Account" />
																</c:when>
															</c:choose>

															<td class="col-md-1"><c:out value="${status}"></c:out></td>
															<td class="col-md-1"><a
																href="${pageContext.request.contextPath}/getAccGrnDetail/${grnList.grnGvnHeaderId}"
																class="btn bnt-primary"> <i class="fa fa-list"></i></a></td>
														</tr>
													</c:forEach> --%>
													</tbody>
												</table>
											</div>
										</div>

										<input type="button" id="btn_submit" class="btn btn-primary"
											onclick="showVehNo()" value="Gen E-way Bill" /> <input
											type="button" id="btn_submit" class="btn btn-primary"
											onclick="showCancelEWB()" value="Cancel E-way Bill" />


										<div class="form-group"></div>

										<div id="eway_submit" style="display: none">

											<input type="text" name="vehNo" id="vehNo"
												style="width: 20%;" list="vehlist">

											<datalist id="vehlist">
												<c:forEach var="veh" items="${vehicleList}"
													varStatus="count">
													<option value="${veh.vehNo}">
												</c:forEach>

											</datalist>


											<input type="button" id="genEwayBill_button"
												class="btn btn-primary" onclick="genEwayBill()"
												value="Gen E-way Bill" style="width: 20%;" />

										</div>

										<div id="eway_cancel" style="display: none">

											<input type="text" name="cancelRemark" id="cancelRemark"
												style="width: 40%;" value="Data entry clearical error">

											<input type="button" id="cancelEwayBill_button"
												class="btn btn-primary" value="Cancel E-way Bill"
												style="width: 20%;">

										</div>




										<div class="table-wrap">

											<table id="table2" class="table table-advance" border="1"
												style="display: none">
												<thead>
													<tr style="background-color: red;">
														<th class="col-sm-1" align="left">Sr No</th>
														<th class="col-md-2" align="left">Invoice No</th>
														<th class="col-md-2" align="left">Error Code</th>
														<th class="col-md-4" align="left">Error Desc</th>
													</tr>
												</thead>
												<tbody>


												</tbody>
											</table>
										</div>


										<div style="display: none;"
											class="col-sm-25 col-sm-offset-3 col-lg-30 col-lg-offset-5">
											<input type="submit" value="Submit" class="btn btn-primary">
										</div>
										<!-- </form> -->
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- END Main Content -->
			<footer>
				<p>2019 © MADHVI.</p>
			</footer>


			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->



	<script type="text/javascript">
		function showVehNo() {
			document.getElementById("eway_submit").style.display = "block";
			//document.getElementById("vehNo").style.display="block";
		}

		function showCancelEWB() {
			document.getElementById("eway_cancel").style.display = "block";
			//document.getElementById("vehNo").style.display="block";
		}
	</script>


	<script type="text/javascript">
		$('#genEwayBill_button')
				.click(
						function() {

							//alert("hi");

							document.getElementById("overlay2").style.display = "block";

							var vehNo=document.getElementById("vehNo").value;
			//alert("vehNo"+vehNo);
			
			$.ajax({
										type : "POST",
										url : "${pageContext.request.contextPath}/genInEwayBill",
										data : $("#validation-form")
												.serialize(),
										dataType : 'json',
										success : function(data) {

											document.getElementById("overlay2").style.display = "none";

											//alert(JSON.stringify(data));
											if (data.length > 0) {
												document
														.getElementById("table2").style.display = "block";

												$('#table2 td').remove();
												if (data == "") {
													alert("No Bill Found");
												}

												$
														.each(
																data,
																function(key,
																		bill) {

																	var tr = $('<tr></tr>');

																	tr
																			.append($(
																					'<td class="col-sm-1"></td>')
																					.html(
																							key + 1));

																	tr
																			.append($(
																					'<td class="col-md-1"></td>')
																					.html(
																							bill.invoiceNo));
																	tr
																			.append($(
																					'<td class="col-md-1"></td>')
																					.html(
																							bill.errorCode));
																	tr
																			.append($(
																					'<td class="col-md-1"></td>')
																					.html(
																							bill.message));

																	$(
																			'#table2 tbody')
																			.append(
																					tr);

																});

											}

											callSearch();
										}
									})
						});
	</script>


	<script type="text/javascript">
		$('#cancelEwayBill_button')
				.click(
						function() {

							document.getElementById("overlay2").style.display = "block";

							var vehNo = document.getElementById("vehNo").value;
							//alert("vehNo"+vehNo);
							var form = document
									.getElementById("validation-form")

							$
									.ajax({
										type : "POST",
										url : "${pageContext.request.contextPath}/cancelEWBForGrnGvn",
										data : $("#validation-form")
												.serialize(),
										dataType : 'json',
										success : function(data) {

											document.getElementById("overlay2").style.display = "none";

											//alert(JSON.stringify(data));
											if (data.length > 0) {
												document
														.getElementById("table2").style.display = "block";

												$('#table2 td').remove();
												if (data == "") {
													alert("No Bill Found");
												}

												$
														.each(
																data,
																function(key,
																		bill) {

																	var tr = $('<tr></tr>');

																	tr
																			.append($(
																					'<td class="col-sm-1"></td>')
																					.html(
																							key + 1));

																	tr
																			.append($(
																					'<td class="col-md-1"></td>')
																					.html(
																							bill.invoiceNo));
																	tr
																			.append($(
																					'<td class="col-md-1"></td>')
																					.html(
																							bill.errorCode));
																	tr
																			.append($(
																					'<td class="col-md-1"></td>')
																					.html(
																							bill.message));

																	$(
																			'#table2 tbody')
																			.append(
																					tr);

																});

											}

											callSearch();
										}
									})
						});
	</script>



	<script type="text/javascript">
		function callSearch() {

			document.getElementById("eway_submit").style.display = "none";
			document.getElementById("eway_cancel").style.display = "none";

			var frIds = $("#selectFr").val();
			var fromDate = document.getElementById("from_date").value;
			var toDate = document.getElementById("to_date").value;

			$('#loader').show();

			$
					.getJSON(
							'${getGrnHeaderList}',
							{
								fr_id_list : JSON.stringify(frIds),
								from_date : fromDate,
								to_date : toDate,
								ajax : 'true'
							},
							function(data) {
								$('#table1 td').remove();
								$('#loader').hide();
								if (data == "") {
									alert("No Data Found");
								}

								$
										.each(
												data,
												function(key, bill) {

													var tr = $('<tr></tr>');
													tr
															.append($(
																	'<td class="col-sm-1"></td>')
																	.html(
																			"<input type='checkbox' name='select_to_print' id="+bill.grnGvnHeaderId+" value="+bill.grnGvnHeaderId+" />"));

													tr
															.append($(
																	'<td class="col-sm-1"></td>')
																	.html(
																			bill.grngvnSrno+"-"+bill.approvedDatetime));

													tr
															.append($(
																	'<td class="col-md-1"  style="text-align: center;"></td>')
																	.html(
																			bill.grngvnDate));

													tr
															.append($(
																	'<td class="col-md-1"></td>')
																	.html(
																			bill.frName));

													tr
															.append($(
																	'<td class="col-md-1"  style="text-align: right;"></td>')
																	.html(
																			bill.taxableAmt));

													tr
															.append($(
																	'<td class="col-md-1" style="text-align:right;"></td>')
																	.html(
																			bill.taxAmt));

													tr
															.append($(
																	'<td class="col-md-1" style="text-align:right;"></td>')
																	.html(
																			bill.totalAmt));

													tr
															.append($(
																	'<td class="col-md-1" style="text-align:right;"></td>')
																	.html(
																			bill.apporvedAmt));

													if (bill.grngvnStatus == 1) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Pending"));

													} else if (bill.grngvnStatus == 2) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Approved By Dispatch"));
													} else if (bill.grngvnStatus == 3) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Reject By Dispatch"));
													} else if (bill.grngvnStatus == 8) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Partially Approve"));
													} else if (bill.grngvnStatus == 5) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Pending"));
													} else if (bill.grngvnStatus == 6) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Approved By Account"));
													} else if (bill.grngvnStatus == 7) {
														tr
																.append($(
																		'<td class="col-md-1"></td>')
																		.html(
																				"Reject By Account"));
													} else if (bill.grngvnStatus == 4) {
														tr
														.append($(
																'<td class="col-md-1"></td>')
																.html(
																		" "));
													}

													tr
															.append($(
																	'<td class="col-md-1"  style="text-align: center;"></td>')
																	.html(
																			"<a href='${pageContext.request.contextPath}/getAccGrnDetail/"
																					+ bill.grnGvnHeaderId
																					+ "'  <i class='fa fa-list'></i></a>"));

													$('#table1 tbody').append(
															tr);

												})

							});

		}
	</script>


	<script>
		function setAllFrSelected(frId) {
			//alert("frId" + frId);
			//alert("hii")
			if (frId == -1) {

				$.getJSON('${getFrListForApprovrGrn}', {

					ajax : 'true'
				},
						function(data) {

							var len = data.length;

							//alert(len);

							$('#selectFr').find('option').remove().end()
							$("#selectFr").append(
									$("<option value='-1'>All</option>"));
							for (var i = 0; i < len; i++) {
								$("#selectFr").append(
										$("<option selected ></option>").attr(
												"value", data[i].frId).text(
												data[i].frName));
							}
							$("#selectFr").trigger("chosen:updated");
						});
			}
		}
	</script>






	<!--basic scripts-->
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

	<script type="text/javascript">
		function getDate() {

			var fromDate = $("#from_date").val();
			var toDate = $("#to_date").val();
			var selectedFr = $("#selectFr").val();

			$.getJSON('${getDateForAccHeader}', {
				fromDate : fromDate,
				toDate : toDate,
				fr_id_list : JSON.stringify(selectedFr),
				ajax : 'true',

			});

		}
	</script>

</body>
</html>

