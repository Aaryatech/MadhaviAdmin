<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>


	<c:url var="getBillList" value="/getSaleBillwiseGrpByDate"></c:url>
	<c:url var="getFrListofAllFr" value="/getFrListForDatewiseReport"></c:url>
	<c:url var="getCompOutBillList" value="/getSaleBillCompOutletDateWise"></c:url>

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

		<!-- END Page Title -->

		<!-- BEGIN Breadcrumb -->

		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Date wise Sale Report
				</h3>

			</div>

			<div class="box-content">
				<div class="row">


					<div class="form-group">
						<label class="col-sm-3 col-lg-2	 control-label">From Date</label>
						<div class="col-sm-6 col-lg-4 controls date_select">
							<input class="form-control date-picker" id="fromDate"
								name="fromDate" size="30" type="text" value="${todaysDate}" />
						</div>

						<!-- </div>

					<div class="form-group  "> -->

						<label class="col-sm-3 col-lg-2	 control-label">To Date</label>
						<div class="col-sm-6 col-lg-4 controls date_select">
							<input class="form-control date-picker" id="toDate" name="toDate"
								size="30" type="text" value="${todaysDate}" />
						</div>
					</div>

				</div>


				<br>

				<!-- <div class="col-sm-9 col-lg-5 controls">
 -->
				<div class="row">
					<div class="form-group">
						<label class="col-sm-3 col-lg-2 control-label"
							style="display: none;">Select Route</label>
						<div class="col-sm-6 col-lg-4 controls" style="display: none;">
							<select data-placeholder="Select Route"
								class="form-control chosen" name="selectRoute" id="selectRoute"
								onchange="disableFr()">
								<option value="0">Select Route</option>
								<c:forEach items="${routeList}" var="route" varStatus="count">
									<option value="${route.routeId}"><c:out
											value="${route.routeName}" />
									</option>

								</c:forEach>
							</select>

						</div>

						<label class="col-sm-3 col-lg-2 control-label">Select
							Franchisee</label>
						<div class="col-sm-6 col-lg-4">

							<select data-placeholder="Choose Franchisee"
								class="form-control chosen" multiple="multiple" tabindex="6"
								id="selectFr" name="selectFr"
								onchange="setAllFrSelected(this.value)"
								onchange="disableRoute()">

								<option value="-1"><c:out value="All" /></option>

								<c:forEach items="${unSelectedFrList}" var="fr"
									varStatus="count">
									<option value="${fr.frId}"><c:out value="${fr.frName}" /></option>
								</c:forEach>
							</select>

						</div>


						<label class="col-sm-3 col-lg-2 control-label">Select Bill
							Type</label>
						<div class="col-sm-6 col-lg-4">

							<input type="radio" id="rd1" name="rd" value="1"
								checked="checked" onchange="billTypeSelection(this.value)">&nbsp;Fr.
							Bills & Del. Challan &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
								type="radio" id="rd2" name="rd" value="2"
								onchange="billTypeSelection(this.value)">&nbsp;Retail
							Outlet Bills

						</div>

					</div>
				</div>

				<br>
				<div class="row">

					<label class="col-sm-3 col-lg-2 control-label"
						style="display: none;">Select</label>
					<div class="col-sm-6 col-lg-4 controls" style="display: none;">
						<select data-placeholder="Select Route"
							class="form-control chosen" name="selectStatus" id="selectStatus">
							<option value="-1">All</option>
							<option value="1">Taxable</option>
							<option value="2" selected="selected">Grand Total</option>
						</select>

					</div>




					<label class="col-sm-3 col-lg-2 control-label">Select Type</label>
					<div class="col-sm-6 col-lg-4">

						<select data-placeholder="Choose " class="form-control chosen"
							multiple="multiple" tabindex="6" id="dairy_id" name="dairy_id">
							<%-- <option value="-1"><c:out value="All" /></option> --%>
							<option value="1" selected="selected">Regular</option>
							<option value="2" selected="selected">Is Dairy Mart</option>
							<!-- <option value="3">Company Outlet Bill</option> -->
						</select>

					</div>

					<div id="cdcDiv">

						<label class="col-sm-3 col-lg-2 control-label">Select Bill
							Type Option</label>
						<div class="col-sm-6 col-lg-4">

							<select data-placeholder="Choose " class="form-control chosen"
								multiple="multiple" tabindex="6" id="type_id" name="type_id">
								<%-- <option value="-1"><c:out value="All" /></option> --%>
								<option value="1" selected="selected">Franchisee Bill</option>
								<option value="2" selected="selected">Delivery Challan</option>
								<!-- <option value="3">Company Outlet Bill</option> -->
							</select>

						</div>
					</div>

					<div id="configTypeDiv" style="display: none;">
						<label class="col-sm-3 col-lg-2 control-label">Retail
							Outlet Type</label>
						<div class="col-sm-6 col-lg-4">

							<select data-placeholder="Choose " class="form-control chosen"
								tabindex="6" id="configType" name="configType">
								<option value="0" selected="selected"><c:out
										value="All" /></option>
								<option value="1">POS</option>
								<option value="2">Online</option>
							</select>

						</div>
						
					</div>


				</div>
				<br>
				<div class="row">
					<div class="col-md-12" style="text-align: center;">
						<button class="btn btn-info" onclick="reports()">Search</button>

						<!-- <button class="btn search_btn" onclick="showChart()">Graph</button> -->

						<button class="btn btn-primary" value="PDF" id="PDFButton"
							onclick="genPdf()">PDF</button>

						<%-- <a href="${pageContext.request.contextPath}/pdfForReport?url=showSaleBillwiseGrpByDatePdf"
								target="_blank">PDF</a> --%>



					</div>
				</div>


				<div align="center" id="loader" style="display: none">

					<span>
						<h4>
							<font color="#343690">Loading</font>
						</h4>
					</span> <span class="l-1"></span> <span class="l-2"></span> <span
						class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
					<span class="l-6"></span>
				</div>

			</div>
		</div>


		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-list-alt"></i>Date wise Sale Report
				</h3>

			</div>


			<div class=" box-content" id="allTable" style="display: none;">
				<div class="row">
					<div class="col-md-12 table-responsive">
						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f95d64;">
								<tr>
									<th>Sr.No.</th>
									<th>Date</th>
									<th>Taxable Value</th>
									<th>Tax Value</th>
									<th>Grand Total</th>
									<th>GRN Taxable Value</th>
									<th>GRN Tax Value</th>
									<th>GRN Grand Total</th>
									<th>GVN Taxable Value</th>
									<th>GVN Tax Value</th>
									<th>GVN Grand Total</th>
									<th>NET Taxable Total</th>
									<th>NET Tax Total</th>
									<th>NET Grand Total</th>
									<!-- <th>Total</th> -->
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>

				</div>
			</div>




			<div id="taxableTable" style="display: none;">

				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid1">
								<thead style="background-color: #f95d64;">
									<tr>
										<th>Sr.No.</th>
										<th>Date</th>
										<th>Taxable Value</th>
										<th>Tax Value</th>

										<th>GRN Taxable Value</th>
										<th>GRN Tax Value</th>

										<th>GVN Taxable Value</th>
										<th>GVN Tax Value</th>

										<th>NET Taxable Total</th>
										<th>NET Tax Total</th>

										<!-- <th>Total</th> -->
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>

					</div>
				</div>


			</div>

			<div id="totalTable" style="display: none;">
				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid2">
								<thead style="background-color: #f95d64;">
									<tr>
										<th style="text-align: center;">Sr.No.</th>
										<th style="text-align: center;">Date</th>
										<th style="text-align: center;">Grand Total</th>
										<th style="text-align: center;">GRN Grand Total</th>
										<th style="text-align: center;">GVN Grand Total</th>
										<th style="text-align: center;">NET Grand Total</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>

					</div>


				</div>

			</div>


			<div id="compOutletTable" style="display: none;">
				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid3">
								<thead style="background-color: #f95d64;">
									<tr>
										<th style="text-align: center;">Sr.No.</th>
										<th style="text-align: center;">Date</th>
										<th style="text-align: center;">Franchisee</th>
										<th style="text-align: center;">Bill Total</th>
										<th style="text-align: center;">Transaction Total</th>
										<th style="text-align: center;">Disc Total</th>
										<th style="text-align: center;">Adv Total</th>
										<th style="text-align: center;">Expense Total</th>
										<th style="text-align: center;">Credit Note Total</th>
										<th style="text-align: center;">Withdrawl Total</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>

					</div>


				</div>
			</div>

			<div class="form-group" style="display: none;" id="range">
				<div class="col-sm-3  controls">
					<input type="button" id="expExcel" class="btn btn-primary"
						value="EXPORT TO Excel" onclick="exportToExcel();"
						disabled="disabled">
				</div>
			</div>




		</div>
		<!-- END Main Content -->

		<footer>
			<p>2019 © MADHVI.</p>
		</footer>

		<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
			class="fa fa-chevron-up"></i></a>

		<script type="text/javascript">
			function billTypeSelection(val) {

				if (val == 2) {
					document.getElementById("cdcDiv").style.display = "none";
					document.getElementById("configTypeDiv").style.display = "block";
				} else {
					document.getElementById("cdcDiv").style.display = "block";
					document.getElementById("configTypeDiv").style.display = "none";
				}

			}
		</script>

		<script type="text/javascript">
			function reports() {

				var billType = 1;
				if (document.getElementById("rd1").checked == true) {
					billType = 1;

				} else {
					billType = 2;
				}

				if (billType == 1) {
					searchReport();
				} else {
					searchCompOutReport();
				}

			}
		</script>




		<script type="text/javascript">
			function searchReport() {
				//	var isValid = validate();

				var selectedFr = $("#selectFr").val();
				var routeId = $("#selectRoute").val();

				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();

				var typeId = $("#type_id").val();

				var selectStatus = document.getElementById("selectStatus").value;
				//alert(selectStatus);

				var dairyMartType = $("#dairy_id").val();

				var billType = 1;
				if (document.getElementById("rd1").checked == true) {
					billType = 1;

				} else {
					billType = 2;
				}

				var isValid = 0;

				if (selectedFr == null) {
					alert("Please select franchisee");
					isValid = 0;
				} else if (billType == 1) {
					if (typeId == null) {
						alert("Please select bill type options");
						isValid = 0;
					} else if (dairyMartType == null) {
						alert("Please select Regular or Dairy Mart Type");
						isValid = 0;
					} else {
						isValid = 1;
					}
				} else {
					isValid = 1;
				}

				if (isValid == 1) {

					$('#loader').show();

					$
							.getJSON(
									'${getBillList}',

									{
										fr_id_list : JSON.stringify(selectedFr),
										fromDate : from_date,
										toDate : to_date,
										route_id : routeId,
										typeId : JSON.stringify(typeId),
										billType : billType,
										dairyMartType : JSON
												.stringify(dairyMartType),
										ajax : 'true'

									},
									function(data) {
										//alert(data);

										$('#allTable').hide();
										$('#taxableTable').hide();
										$('#totalTable').hide();
										$('#compOutletTable').hide();

										$('#table_grid td').remove();
										$('#table_grid1 td').remove();
										$('#table_grid2 td').remove();
										$('#loader').hide();

										if (data == "") {
											alert("No records found !!");
											document.getElementById("expExcel").disabled = true;

										}
										if (selectStatus == -1) {

											$('#allTable').show();
											$('#taxableTable').hide();
											$('#totalTable').hide();

											var totalGrnGrandTotal = 0;
											var totalGrnTaxableAmt = 0;
											var totalGrnTax = 0;

											var totalGvnGrandTotal = 0;
											var totalGvnTax = 0;
											var totalGvnTaxableAmt = 0;

											var totalGrandTotal = 0;
											var totalTax = 0;
											var totalTaxableAmt = 0;

											var totalNetGrandTotal = 0;
											var totalNetTax = 0;
											var totalNetTaxableAmt = 0;

											$
													.each(
															data,
															function(key,
																	report) {

																totalGrnGrandTotal = totalGrnGrandTotal
																		+ report.grnGrandTotal;
																totalGrnTaxableAmt = totalGrnTaxableAmt
																		+ report.grnTaxableAmt;
																totalGrnTax = totalGrnTax
																		+ report.grnTotalTax;

																totalGvnGrandTotal = totalGvnGrandTotal
																		+ report.gvnGrandTotal;
																totalGvnTaxableAmt = totalGvnTaxableAmt
																		+ report.gvnTaxableAmt;
																totalGvnTax = totalGvnTax
																		+ report.gvnTotalTax;

																totalGrandTotal = totalGrandTotal
																		+ report.grandTotal;
																totalTax = totalTax
																		+ report.totalTax;
																totalTaxableAmt = totalTaxableAmt
																		+ report.taxableAmt;

																totalNetGrandTotal = totalNetGrandTotal
																		+ report.netGrandTotal;
																totalNetTax = totalNetTax
																		+ report.netTotalTax;

																totalNetTaxableAmt = totalNetTaxableAmt
																		+ report.netTaxableAmt;

																document
																		.getElementById("expExcel").disabled = false;
																document
																		.getElementById('range').style.display = 'block';
																var index = key + 1;
																//var tr = "<tr>";
																var tr = $('<tr></tr>');
																tr
																		.append($(
																				'<td></td>')
																				.html(
																						key + 1));
																tr
																		.append($(
																				'<td></td>')
																				.html(
																						report.billDate));
																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.taxableAmt
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.totalTax
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.grandTotal
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.grnTaxableAmt
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.grnTotalTax
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.grnGrandTotal
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.gvnTaxableAmt
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.gvnTotalTax
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.gvnGrandTotal
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.netTaxableAmt
																								.toFixed(2)));
																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.netTotalTax
																								.toFixed(2)));
																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.netGrandTotal
																								.toFixed(2)));

																$(
																		'#table_grid tbody')
																		.append(
																				tr);

															})

											var tr = $('<tr></tr>');

											tr.append($('<td></td>').html(""));

											tr
													.append($(
															'<td style="font-weight:bold;"></td>')
															.html("Total"));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalTaxableAmt
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalTax
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGrandTotal
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGrnTaxableAmt
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGrnTax
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGrnGrandTotal
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGvnTaxableAmt
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGvnTax
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGvnGrandTotal
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalNetTaxableAmt
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalNetTax
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalNetGrandTotal
																			.toFixed(2)));

											$('#table_grid tbody').append(tr);

										}

										else if (selectStatus == 1) {

											$('#taxableTable').show();
											$('#allTable').hide();
											$('#totalTable').hide();

											var totalGrnGrandTotal = 0;
											var totalGrnTaxableAmt = 0;
											var totalGrnTax = 0;

											var totalGvnGrandTotal = 0;
											var totalGvnTax = 0;
											var totalGvnTaxableAmt = 0;

											var totalGrandTotal = 0;
											var totalTax = 0;
											var totalTaxableAmt = 0;

											var totalNetGrandTotal = 0;
											var totalNetTax = 0;
											var totalNetTaxableAmt = 0;

											$
													.each(
															data,
															function(key,
																	report) {

																totalGrnGrandTotal = totalGrnGrandTotal
																		+ report.grnGrandTotal;
																totalGrnTaxableAmt = totalGrnTaxableAmt
																		+ report.grnTaxableAmt;
																totalGrnTax = totalGrnTax
																		+ report.grnTotalTax;

																totalGvnGrandTotal = totalGvnGrandTotal
																		+ report.gvnGrandTotal;
																totalGvnTaxableAmt = totalGvnTaxableAmt
																		+ report.gvnTaxableAmt;
																totalGvnTax = totalGvnTax
																		+ report.gvnTotalTax;

																totalGrandTotal = totalGrandTotal
																		+ report.grandTotal;
																totalTax = totalTax
																		+ report.totalTax;
																totalTaxableAmt = totalTaxableAmt
																		+ report.taxableAmt;

																totalNetGrandTotal = totalNetGrandTotal
																		+ report.netGrandTotal;
																totalNetTax = totalNetTax
																		+ report.netTotalTax;

																totalNetTaxableAmt = totalNetTaxableAmt
																		+ report.netTaxableAmt;

																document
																		.getElementById("expExcel").disabled = false;
																document
																		.getElementById('range').style.display = 'block';
																var index = key + 1;
																//var tr = "<tr>";
																var tr = $('<tr></tr>');
																tr
																		.append($(
																				'<td></td>')
																				.html(
																						key + 1));
																tr
																		.append($(
																				'<td></td>')
																				.html(
																						report.billDate));
																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.taxableAmt
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.totalTax
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.grnTaxableAmt
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.grnTotalTax
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.gvnTaxableAmt
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.gvnTotalTax
																								.toFixed(2)));

																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.netTaxableAmt
																								.toFixed(2)));
																tr
																		.append($(
																				'<td style="text-align:right;"></td>')
																				.html(
																						report.netTotalTax
																								.toFixed(2)));

																$(
																		'#table_grid1 tbody')
																		.append(
																				tr);

															})

											var tr = $('<tr></tr>');

											tr.append($('<td></td>').html(""));

											tr
													.append($(
															'<td style="font-weight:bold;"></td>')
															.html("Total"));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalTaxableAmt
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalTax
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGrnTaxableAmt
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGrnTax
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGvnTaxableAmt
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalGvnTax
																			.toFixed(2)));

											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalNetGrandTotal
																			.toFixed(2)));
											tr
													.append($(
															'<td style="text-align:right;"></td>')
															.html(
																	totalNetTax
																			.toFixed(2)));

											$('#table_grid1 tbody').append(tr);

										}

										else

										{

											if (billType == 1) {

												$('#totalTable').show();
												$('#allTable').hide();
												$('#taxableTable').hide();

												var totalGrnGrandTotal = 0;
												var totalGrnTaxableAmt = 0;
												var totalGrnTax = 0;

												var totalGvnGrandTotal = 0;
												var totalGvnTax = 0;
												var totalGvnTaxableAmt = 0;

												var totalGrandTotal = 0;
												var totalTax = 0;
												var totalTaxableAmt = 0;

												var totalNetGrandTotal = 0;
												var totalNetTax = 0;
												var totalNetTaxableAmt = 0;

												$
														.each(
																data,
																function(key,
																		report) {

																	totalGrnGrandTotal = totalGrnGrandTotal
																			+ report.grnGrandTotal;
																	totalGrnTaxableAmt = totalGrnTaxableAmt
																			+ report.grnGrandTotal;
																	totalGrnTax = totalGrnTax
																			+ report.grnGrandTotal;

																	totalGvnGrandTotal = totalGvnGrandTotal
																			+ report.gvnGrandTotal;
																	totalGvnTaxableAmt = totalGvnTaxableAmt
																			+ report.gvnTaxableAmt;
																	totalGvnTax = totalGvnTax
																			+ report.gvnTotalTax;

																	totalGrandTotal = totalGrandTotal
																			+ report.grandTotal;
																	totalTax = totalTax
																			+ report.totalTax;
																	totalTaxableAmt = totalTaxableAmt
																			+ report.taxableAmt;

																	totalNetGrandTotal = totalNetGrandTotal
																			+ report.netGrandTotal;
																	totalNetTax = totalNetTax
																			+ report.netTotalTax;

																	totalNetTaxableAmt = totalNetTaxableAmt
																			+ report.netTaxableAmt;

																	document
																			.getElementById("expExcel").disabled = false;
																	document
																			.getElementById('range').style.display = 'block';
																	var index = key + 1;
																	//var tr = "<tr>";
																	var tr = $('<tr></tr>');
																	tr
																			.append($(
																					'<td style="text-align:center;"></td>')
																					.html(
																							key + 1));
																	tr
																			.append($(
																					'<td style="text-align:center;"></td>')
																					.html(
																							report.billDate));

																	tr
																			.append($(
																					'<td style="text-align:right;"></td>')
																					.html(
																							addCommas(report.grandTotal
																									.toFixed(2))));

																	tr
																			.append($(
																					'<td style="text-align:right;"></td>')
																					.html(
																							addCommas(report.grnGrandTotal
																									.toFixed(2))));

																	tr
																			.append($(
																					'<td style="text-align:right;"></td>')
																					.html(
																							addCommas(report.gvnGrandTotal
																									.toFixed(2))));

																	tr
																			.append($(
																					'<td style="text-align:right;"></td>')
																					.html(
																							addCommas(report.netGrandTotal
																									.toFixed(2))));

																	$(
																			'#table_grid2 tbody')
																			.append(
																					tr);

																})

												var tr = $('<tr></tr>');

												tr.append($('<td></td>').html(
														""));

												tr
														.append($(
																'<td style="font-weight:bold;"></td>')
																.html("Total"));

												tr
														.append($(
																'<td style="text-align:right;font-weight:bold;"></td>')
																.html(
																		addCommas(totalGrandTotal
																				.toFixed(2))));

												tr
														.append($(
																'<td style="text-align:right;font-weight:bold;"></td>')
																.html(
																		addCommas(totalGrnGrandTotal
																				.toFixed(2))));

												tr
														.append($(
																'<td style="text-align:right;font-weight:bold;"></td>')
																.html(
																		addCommas(totalGvnGrandTotal
																				.toFixed(2))));

												tr
														.append($(
																'<td style="text-align:right;font-weight:bold;"></td>')
																.html(
																		addCommas(totalNetGrandTotal
																				.toFixed(2))));

												$('#table_grid2 tbody').append(
														tr);

											}
										}

									});
				}

			}
		</script>


		<script type="text/javascript">
			function searchCompOutReport() {
				//	var isValid = validate();

				var selectedFr = $("#selectFr").val();
				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();
				
				var configType=document.getElementById("configType").value;

				var selectStatus = document.getElementById("selectStatus").value;
				//alert(selectStatus);

				var typeId = $("#type_id").val();
				var dairyMartType = $("#dairy_id").val();

				var billType = 1;
				if (document.getElementById("rd1").checked == true) {
					billType = 1;

				} else {
					billType = 2;
				}

				if (selectedFr == null) {
					alert("Please select franchisee");
				} else if (dairyMartType == null) {
					alert("Please select Regular or Dairy Mart Type");
					isValid = 0;
				} else {

					$('#loader').show();

					$
							.getJSON(
									'${getCompOutBillList}',
									{
										fr_id_list : JSON.stringify(selectedFr),
										fromDate : from_date,
										toDate : to_date,
										dairyMartType : JSON
												.stringify(dairyMartType),
										configType : configType,
										ajax : 'true'

									},
									function(data) {
										//alert(JSON.stringify(data));

										$('#allTable').hide();
										$('#taxableTable').hide();
										$('#totalTable').hide();
										$('#compOutletTable').hide();

										$('#table_grid td').remove();
										$('#table_grid1 td').remove();
										$('#table_grid2 td').remove();
										$('#table_grid3 td').remove();
										$('#loader').hide();

										if (data == "") {
											alert("No records found !!");
											document.getElementById("expExcel").disabled = true;
										}

										$('#totalTable').hide();
										$('#allTable').hide();
										$('#taxableTable').hide();
										$('#compOutletTable').show();

										var totalBill = 0;
										var totalTr = 0;
										var totalDisc = 0;
										var totalAdv = 0;
										var totalExp = 0;
										var totalCredit = 0;
										var totalWithdrawl = 0;

										$
												.each(
														data,
														function(key, report) {

															totalBill = totalBill
																	+ report.billTotal;
															totalTr = totalTr
																	+ report.trTotal;
															totalDisc = totalDisc
																	+ report.discTotal;
															totalAdv = totalAdv
																	+ report.advTotal;
															totalExp = totalExp
																	+ report.expTotal;
															totalCredit = totalCredit
																	+ report.creditTotal;
															totalWithdrawl = totalWithdrawl
																	+ report.withdrawlTotal;

															document
																	.getElementById("expExcel").disabled = false;
															document
																	.getElementById('range').style.display = 'block';

															var index = key + 1;

															var tr = $('<tr></tr>');
															tr
																	.append($(
																			'<td style="text-align:center;"></td>')
																			.html(
																					key + 1));
															tr
																	.append($(
																			'<td style="text-align:center;"></td>')
																			.html(
																					report.billDate));

															tr
																	.append($(
																			'<td style="text-align:left;"></td>')
																			.html(
																					report.frName));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.billTotal
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.trTotal
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.discTotal
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.advTotal
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.expTotal
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.creditTotal
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.withdrawlTotal
																							.toFixed(2))));

															$(
																	'#table_grid3 tbody')
																	.append(tr);

														});

										var tr = $('<tr></tr>');

										tr.append($('<td></td>').html(""));
										tr.append($('<td></td>').html(""));

										tr
												.append($(
														'<td style="font-weight:bold;"></td>')
														.html("Total"));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalBill
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalTr
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalDisc
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalAdv
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalExp
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalCredit
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;font-weight:bold;"></td>')
														.html(
																addCommas(totalWithdrawl
																		.toFixed(2))));

										$('#table_grid3 tbody').append(tr);

									});
				}
			}
		</script>




		<script type="text/javascript">
			function addCommas(x) {

				x = String(x).toString();
				var afterPoint = '';
				if (x.indexOf('.') > 0)
					afterPoint = x.substring(x.indexOf('.'), x.length);
				x = Math.floor(x);
				x = x.toString();
				var lastThree = x.substring(x.length - 3);
				var otherNumbers = x.substring(0, x.length - 3);
				if (otherNumbers != '')
					lastThree = ',' + lastThree;
				return otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",")
						+ lastThree + afterPoint;
			}
		</script>

		<script type="text/javascript">
			function validate() {

				var selectedFr = $("#selectFr").val();
				var selectedRoute = $("#selectRoute").val();

				var isValid = true;

				if ((selectedFr == "" || selectedFr == null)
						&& (selectedRoute == 0)) {

					alert("Please Select Route  Or Franchisee");
					isValid = false;

				}
				return isValid;

			}
		</script>



		<script type="text/javascript">
			function disableFr() {

				//alert("Inside Disable Fr ");
				document.getElementById("selectFr").disabled = true;

			}

			function disableRoute() {

				//alert("Inside Disable route ");
				var x = document.getElementById("selectRoute")
				//alert(x.options.length);
				var i;
				for (i = 0; i < x; i++) {
					document.getElementById("selectRoute").options[i].disabled;
					//document.getElementById("pets").options[2].disabled = true;
				}
				//document.getElementById("selectRoute").disabled = true;

			}
		</script>

		<script>
			function setAllFrSelected(frId) {
				//alert("frId" + frId);
				//alert("hii")
				if (frId == -1) {

					$.getJSON('${getFrListofAllFr}', {

						ajax : 'true'
					}, function(data) {

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



		<script type="text/javascript">
			function showChart() {

				//alert("Hi");

				$("#PieChart_div").empty();
				$("#chart_div").empty();
				//document.getElementById('chart').style.display = "block";
				document.getElementById("table_grid").style = "display:none";

				var selectedFr = $("#selectFr").val();
				var routeId = $("#selectRoute").val();

				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();
				//alert("fr "+selectedFr);
				//alert(from_date);
				//alert(to_date);
				//alert(routeId);

				//document.getElementById('btn_pdf').style.display = "block";
				$
						.getJSON(
								'${getBillList}',

								{
									fr_id_list : JSON.stringify(selectedFr),
									fromDate : from_date,
									toDate : to_date,
									route_id : routeId,
									ajax : 'true'

								},
								function(data) {

									//alert(data);
									if (data == "") {
										alert("No records found !!");

									}
									var i = 0;

									google.charts.load('current', {
										'packages' : [ 'corechart', 'bar' ]
									});
									google.charts.setOnLoadCallback(drawStuff);

									function drawStuff() {

										// alert("Inside DrawStuff");

										var chartDiv = document
												.getElementById('chart_div');
										document.getElementById("chart_div").style.border = "thin dotted red";

										var PiechartDiv = document
												.getElementById('PieChart_div');
										document.getElementById("PieChart_div").style.border = "thin dotted red";

										var dataTable = new google.visualization.DataTable();
										dataTable.addColumn('string', 'Date'); // Implicit domain column.
										//  dataTable.addColumn('number', 'Base Value'); // Implicit data column.
										dataTable.addColumn('number', 'Total');

										var piedataTable = new google.visualization.DataTable();
										piedataTable
												.addColumn('string', 'Date'); // Implicit domain column.
										piedataTable.addColumn('number',
												'Total');

										$
												.each(
														data,
														function(key, report) {

															// alert("In Data")
															//   var baseValue=report.taxableAmt;

															var total;

															if (report.isSameState == 1) {
																total = parseFloat(report.taxableAmt)
																		+ parseFloat(report.cgstSum
																				+ report.sgstSum);
															} else {

																total = report.taxableAmt
																		+ report.igstSum;
															}

															var date = report.billDate;
															//var date= item.billDate+'\nTax : ' + item.tax_per + '%';

															dataTable.addRows([

															[ date, total ],

															// ["Sai", 12,14],
															//["Sai", 12,16],
															// ["Sai", 12,18],
															// ["Sai", 12,19],

															]);

															piedataTable
																	.addRows([

																			[
																					date,
																					total ],

																	]);
														}) // end of  $.each(data,function(key, report) {-- function

										// Instantiate and draw the chart.

										var materialOptions = {

											width : 500,
											chart : {
												title : 'Date wise Tax Graph',
												subtitle : 'Total tax & Taxable Amount per day',

											},
											series : {
												0 : {
													axis : 'distance'
												}, // Bind series 0 to an axis named 'distance'.
												1 : {
													axis : 'brightness'
												}
											// Bind series 1 to an axis named 'brightness'.
											},
											axes : {
												y : {
													distance : {
														label : 'Total Tax'
													}, // Left y-axis.
													brightness : {
														side : 'right',
														label : 'Taxable Amount'
													}
												// Right y-axis.
												}
											}
										};

										function drawMaterialChart() {
											var materialChart = new google.charts.Bar(
													chartDiv);

											// alert("mater chart "+materialChart);
											materialChart
													.draw(
															dataTable,
															google.charts.Bar
																	.convertOptions(materialOptions));
											// button.innerText = 'Change to Classic';
											// button.onclick = drawClassicChart;
										}

										var chart = new google.visualization.ColumnChart(
												document
														.getElementById('chart_div'));

										var Piechart = new google.visualization.PieChart(
												document
														.getElementById('PieChart_div'));
										chart
												.draw(
														dataTable,
														{
															width : 1150,
															height : 600,
															title : 'Sales Summary Group By Date'
														});

										Piechart
												.draw(
														piedataTable,
														{
															width : 1150,
															height : 600,
															title : 'Sales Summary Group By Date',
															is3D : true
														});
										// drawMaterialChart();
									}
									;

								});

			}
			function genPdf() {
				var selectedFr = $("#selectFr").val();
				var routeId = $("#selectRoute").val();
				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();
				var typeIdList = $("#type_id").val();
				var dairyMartType = $("#dairy_id").val();

				var billType = 1;
				if (document.getElementById("rd1").checked == true) {
					billType = 1;

				} else {
					billType = 2;
				}

				window
						.open('pdfForReport?url=pdf/showSaleBillwiseGrpByDatePdf/'
								+ from_date
								+ '/'
								+ to_date
								+ '/'
								+ selectedFr
								+ '/'
								+ routeId
								+ '/'
								+ typeIdList
								+ '/'
								+ billType + '/' + dairyMartType + '/');

			}
			function exportToExcel() {

				window
						.open("${pageContext.request.contextPath}/exportToExcelNew");
				document.getElementById("expExcel").disabled = true;
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
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/jquery-tags-input/jquery.tagsinput.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/jquery-pwstrength/jquery.pwstrength.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-duallistbox/duallistbox/bootstrap-duallistbox.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/dropzone/downloads/dropzone.min.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-switch/static/js/bootstrap-switch.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/assets/ckeditor/ckeditor.js"></script>

		<!--flaty scripts-->
		<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>
</body>
</html>