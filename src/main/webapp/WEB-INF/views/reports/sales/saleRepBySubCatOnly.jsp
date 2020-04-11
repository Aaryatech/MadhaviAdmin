<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<style>

/* .chart_l{float: none !important; width:100% !important; margin: 0 0 15px 0;}
  .chart_r{float: none !important; width:100% !important; min-height:auto !important;} */
#donutchart {
	width: 100%;
	height: 500px;
	display: block;
}

#donutchart1 {
	width: 100%;
	height: 500px;
	display: block;
}
</style>

<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getBillList" value="/getSubCatReport"></c:url>
	<c:url var="getAllCatByAjax" value="/getAllCatByAjax"></c:url>
	<c:url var="getGroup2ByCatId" value="/getSubCatByCatIdForReport"></c:url>
	<c:url var="getSubCatReportChart" value="/getSubCatReportChart"></c:url>




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
					<i class="fa fa-file-o"></i> Sub Category Summary Report
				</h1>
				<h4></h4>
			</div>
		</div>
		<!-- END Page Title -->

		<!-- BEGIN Breadcrumb -->
		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="fa fa-home"></i> <a
					href="${pageContext.request.contextPath}/home">Home</a> <span
					class="divider"><i class="fa fa-angle-right"></i></span></li>
				<li class="active">Sub Category Summary Report</li>
			</ul>
		</div>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Sub Category Summary Report
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

						<label class="col-sm-3 col-lg-2	 control-label">To Date</label>
						<div class="col-sm-6 col-lg-4 controls date_select">
							<input class="form-control date-picker" id="toDate" name="toDate"
								size="30" type="text" value="${todaysDate}" />
						</div>
					</div>
				</div>

				<br>

				<div class="row">
					<div class="form-group">

						<label class="col-sm-3 col-lg-2 control-label">Select Bill
							Type</label>
						<div class="col-sm-6 col-lg-4">

							<input type="radio" id="rd1" name="rd" value="1"
								${billType==1 ? 'checked' : ''} checked="checked"
								onchange="billTypeSelection(this.value)">&nbsp;Fr. Bills
							& Del. Challan &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
								id="rd2" name="rd" value="2" ${billType==2 ? 'checked' : ''}
								onchange="billTypeSelection(this.value)">&nbsp;Retail
							Outlet Bills

						</div>


						<div id="cdcDiv">


							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type Option</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									multiple="multiple" tabindex="6" id="type_id" name="type_id">

									<option value="1" selected="selected">Franchisee Bill</option>
									<option value="2" selected="selected">Delivery Challan</option>

								</select>

							</div>
						</div>

						<div id="dairyDiv" style="display: none;">


							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type Option</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									multiple="multiple" tabindex="6" id="dairy_id" name="dairy_id">

									<option value="1" selected="selected">Regular</option>
									<option value="2" selected="selected">Is Dairy Mart</option>

								</select>

							</div>
						</div>



					</div>
				</div>


				<br> <br>
				<div class="row">

					<div class="col-md-6" style="text-align: center;">
						<button class="btn btn-info" onclick="searchReport()">Search
							Report</button>
						<button class="btn btn-primary" value="PDF" id="PDFButton"
							onclick="genPdf()">PDF</button>
					</div>
				</div>
				<br>

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
					<i class="fa fa-list-alt"></i>Sub Category Summary Report
				</h3>
			</div>
			<div class=" box-content">
				<div class="row">
					<div class="col-md-12 table-responsive" id="purchase"
						style="display: none;">
						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f95d64;">
								<tr>
									<th style="text-align: center;">Sr.No.</th>
									<th style="text-align: center;">Sub Category Name</th>
									<th style="text-align: center;">Sold Qty</th>
									<th style="text-align: center;">Sold Amt</th>
									<th style="text-align: center;">Var Qty</th>
									<th style="text-align: center;">Var Amt</th>
									<th style="text-align: center;">Ret Qty</th>
									<th style="text-align: center;">Ret Amt</th>
									<th style="text-align: center;">Net Qty</th>
									<th style="text-align: center;">Net Amt</th>
									<th style="text-align: center;">Qty %</th>
									<th style="text-align: center;">Amt %</th>
									<th style="text-align: center;">Ret Amt</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>

					<div class="col-md-12 table-responsive" id="sale"
						style="display: none;">
						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid2">
							<thead style="background-color: #f95d64;">
								<tr>
									<th style="text-align: center;">Sr.No.</th>
									<th style="text-align: center;">Sub Category Name</th>
									<th style="text-align: center;">Sold Qty</th>
									<th style="text-align: center;">Sold Amt</th>
									<th style="text-align: center;">CRN Qty</th>
									<th style="text-align: center;">CRN Amt</th>
									<th style="text-align: center;">Net Qty</th>
									<th style="text-align: center;">Net Amt</th>
									<th style="text-align: center;">Qty %</th>
									<th style="text-align: center;">Amt %</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>

					<div class="form-group" style="display: none;" id="range">



						<div class="col-sm-3  controls">
							<input type="button" id="expExcel" class="btn btn-primary"
								value="EXPORT TO Excel" onclick="exportToExcel();"
								disabled="disabled">
						</div>
					</div>
				</div>


				<div class="row" style="display: inline-block; width: 100%;">
					<div class="chart_l"
						style="float: none !important; width: 100% !important; margin: 0 0 15px 0;">

						<div id="donutchart"></div>
						<!-- style="width: 900px; height: 500px;" -->
					</div>

					<div class="clr"></div>

				</div>

				<div class="row" style="display: inline-block; width: 100%;">
					<div class="chart_l"
						style="float: none !important; width: 100% !important; margin: 0 0 15px 0;">

						<div id="donutchart1"></div>
						<!-- style="width: 900px; height: 500px;" -->
					</div>

					<div class="clr"></div>

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

	<script type="text/javascript">
		function billTypeSelection(val) {

			if (val == 2) {
				document.getElementById("cdcDiv").style.display = "none";
				document.getElementById("dairyDiv").style.display = "block";

			} else {
				document.getElementById("cdcDiv").style.display = "block";
				document.getElementById("dairyDiv").style.display = "none";
			}

		}
	</script>


	<script type="text/javascript">
		function searchReport() {
			//	var isValid = validate();
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			var typeId = $("#type_id").val();
			var dairy = $("#dairy_id").val();

			var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;

			} else {
				billType = 2;
			}

			var isValid = 0;

			if (billType == 1) {
				if (typeId == null) {
					alert("Please select bill type options");
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

									fromDate : from_date,
									toDate : to_date,
									typeId : JSON.stringify(typeId),
									billType : billType,
									dairy : JSON.stringify(dairy),
									ajax : 'true'

								},
								function(data) {

									//alert(data);

									$('#table_grid td').remove();
									$('#table_grid2 td').remove();
									$('#loader').hide();

									if (data == "") {
										alert("No records found !!");
										document.getElementById("expExcel").disabled = true;
									}

									drawGraph();

									if (billType == 1) {

										var totalSoldQty = 0;
										var totalSoldAmt = 0;
										var totalVarQty = 0;
										var totalVarAmt = 0;
										var totalRetQty = 0;
										var totalRetAmt = 0;
										var totalNetQty = 0;
										var totalNetAmt = 0;
										var retAmtPer = 0;
										var totalQtyPer = 0;
										var totalAmtPer = 0;

										$('#purchase').show();
										$('#sale').hide();

										var netQtySum = 0;
										var netAmtSum = 0;

										$.each(data, function(key, report) {
											netQtySum = netQtySum
													+ report.netQty;
											netAmtSum = netAmtSum
													+ report.netAmt;
										});

										$
												.each(
														data,
														function(key, report) {

															totalSoldQty = totalSoldQty
																	+ report.soldQty;
															totalSoldAmt = totalSoldAmt
																	+ report.soldAmt;
															totalVarQty = totalVarQty
																	+ report.varQty;
															totalVarAmt = totalVarAmt
																	+ report.varAmt;
															totalRetQty = totalRetQty
																	+ report.retQty;
															totalRetAmt = totalRetAmt
																	+ report.retAmt;
															totalNetQty = totalNetQty
																	+ report.netQty;
															totalNetAmt = totalNetAmt
																	+ report.netAmt;
															retAmtPer = retAmtPer
																	+ report.retAmtPer;

															document
																	.getElementById("expExcel").disabled = false;
															document
																	.getElementById('range').style.display = 'block';
															var index = key + 1;
															//var tr = "<tr>";

															var tr = $('<tr></tr>');

															tr
																	.append($(
																			'<td style="text-align: center;"></td>')
																			.html(
																					key + 1));

															tr
																	.append($(
																			'<td></td>')
																			.html(
																					report.subCatName));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.soldQty
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.soldAmt
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.varQty
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.varAmt
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.retQty
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.retAmt
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.netQty
																							.toFixed(2))));
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.netAmt
																							.toFixed(2))));

															var qtyPer = 0;
															if (netQtySum > 0) {
																qtyPer = (report.netQty * 100)
																		/ netQtySum;
															}
															totalQtyPer = totalQtyPer
																	+ qtyPer;

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(qtyPer
																							.toFixed(2))));

															var amtPer = 0;
															if (netAmtSum > 0) {
																amtPer = (report.netAmt * 100)
																		/ netAmtSum;
															}
															totalAmtPer = totalAmtPer
																	+ amtPer;

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(amtPer
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.retAmtPer
																							.toFixed(2))));

															$(
																	'#table_grid tbody')
																	.append(tr);

															//alert("hii2");

														})

										var tr = $('<tr></tr>');

										tr.append($('<td  ></td>').html(" "));

										tr
												.append($(
														'<td style="font-weight:bold;"></td>')
														.html("Total"));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalSoldQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalSoldAmt
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalVarQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalVarAmt
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalRetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalRetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalNetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalNetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalQtyPer
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalAmtPer
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(retAmtPer
																		.toFixed(2))));

										$('#table_grid tbody').append(tr);

									} else {

										var totalSoldQty = 0;
										var totalSoldAmt = 0;
										var totalVarQty = 0;
										var totalVarAmt = 0;
										var totalRetQty = 0;
										var totalRetAmt = 0;
										var totalNetQty = 0;
										var totalNetAmt = 0;
										var retAmtPer = 0;
										var totalQtyPer = 0;
										var totalAmtPer = 0;

										$('#purchase').hide();
										$('#sale').show();

										var netQtySum = 0;
										var netAmtSum = 0;

										$.each(data, function(key, report) {
											netQtySum = netQtySum
													+ report.netQty;
											netAmtSum = netAmtSum
													+ report.netAmt;
										});

										$
												.each(
														data,
														function(key, report) {

															totalSoldQty = totalSoldQty
																	+ report.soldQty;
															totalSoldAmt = totalSoldAmt
																	+ report.soldAmt;
															totalVarQty = totalVarQty
																	+ report.varQty;
															totalVarAmt = totalVarAmt
																	+ report.varAmt;
															totalRetQty = totalRetQty
																	+ report.retQty;
															totalRetAmt = totalRetAmt
																	+ report.retAmt;
															totalNetQty = totalNetQty
																	+ report.netQty;
															totalNetAmt = totalNetAmt
																	+ report.netAmt;
															retAmtPer = retAmtPer
																	+ report.retAmtPer;

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
																					report.subCatName));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.soldQty
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.soldAmt
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.retQty
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.retAmt
																							.toFixed(2))));

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.netQty
																							.toFixed(2))));
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.netAmt
																							.toFixed(2))));

															var qtyPer = 0;
															if (netQtySum > 0) {
																qtyPer = (report.netQty * 100)
																		/ netQtySum;
															}
															totalQtyPer = totalQtyPer
																	+ qtyPer;

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(qtyPer
																							.toFixed(2))));

															var amtPer = 0;
															if (netAmtSum > 0) {
																amtPer = (report.netAmt * 100)
																		/ netAmtSum;
															}
															totalAmtPer = totalAmtPer
																	+ amtPer;

															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(amtPer
																							.toFixed(2))));

															$(
																	'#table_grid2 tbody')
																	.append(tr);

														})

										var tr = $('<tr></tr>');

										tr.append($('<td  ></td>').html(" "));

										tr
												.append($(
														'<td style="font-weight:bold;"></td>')
														.html("Total"));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalSoldQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalSoldAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalRetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalRetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalNetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalNetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalQtyPer
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(totalAmtPer
																		.toFixed(2))));

										$('#table_grid2 tbody').append(tr);

									}

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
			var selectedMenu = $("#selectMenu").val();
			var selectedRoute = $("#selectRoute").val();

			var isValid = true;

			if (selectedFr == "" || selectedFr == null) {

				if (selectedRoute == "" || selectedRoute == null) {
					alert("Please Select atleast one ");
					isValid = false;
				}
				//alert("Please select Franchise/Route");

			} else if (selectedMenu == "" || selectedMenu == null) {

				isValid = false;
				alert("Please select Menu");

			}
			return isValid;

		}
	</script>

	<script type="text/javascript">
		function updateTotal(orderId, rate) {

			var newQty = $("#billQty" + orderId).val();

			var total = parseFloat(newQty) * parseFloat(rate);

			$('#billTotal' + orderId).html(total);
		}
	</script>

	<script>
		$('.datepicker').datepicker({
			format : {
				/*
				 * Say our UI should display a week ahead,
				 * but textbox should store the actual date.
				 * This is useful if we need UI to select local dates,
				 * but store in UTC
				 */
				format : 'mm/dd/yyyy',
				startDate : '-3d'
			}
		});

		function genPdf() {
			var fromDate = $("#fromDate").val();
			var toDate = $("#toDate").val();

			var typeId = $("#type_id").val();
			var dairy = $("#dairy_id").val();

			var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;

			} else {
				billType = 2;
			}

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/showSaleReportBySubCatPdf/'
							+ fromDate
							+ '/'
							+ toDate
							+ '/'
							+ typeId
							+ '/'
							+ billType + '/' + dairy);

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

		function exportToExcel() {

			window.open("${pageContext.request.contextPath}/exportToExcelNew");
			document.getElementById("expExcel").disabled = true;
		}
	</script>









	<script type="text/javascript">
		function drawGraph() {

			google.charts.load("current", {
				packages : [ "corechart" ]
			});
			google.charts.setOnLoadCallback(drawDonutChart);

			google.charts.load("current", {
				packages : [ "corechart" ]
			});
			google.charts.setOnLoadCallback(drawDonutChartAmt);

			/* google.charts.load('current', {
				'packages' : [ 'corechart', 'line' ]
			});
			google.charts.setOnLoadCallback(drawStuff1);  */

			var type = $
			{
				type
			}
			;

		}
	</script>

	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>

	<script type="text/javascript">
		function drawDonutChart() {
			//alert("hii donut ch");
			//to draw donut chart
			var chart;
			var datag = '';
			var a = "";
			var dataSale = [];
			var Header = [ 'Sub-category', 'Amount', 'ID' ];
			dataSale.push(Header);
			$.post('${getSubCatReportChart}', {
				ajax : 'true'
			}, function(chartsdata) {
				//alert(JSON.stringify(chartsdata));
				//	console.log('data ' + JSON.stringify(chartsdata));
				var len = chartsdata.length;
				datag = datag + '[';
				$.each(chartsdata, function(key, chartsdata) {
					var temp = [];

					if (parseFloat(chartsdata.netQty) > 0) {

						temp.push(chartsdata.subCatName + " ("
								+ (parseFloat(chartsdata.netQty).toFixed(2))
								+ ")", (parseFloat(chartsdata.netQty)),
								parseInt(chartsdata.subCatId));
						dataSale.push(temp);
					}

				});

				//console.log(dataSale);
				var data1 = google.visualization.arrayToDataTable(dataSale);

				var options = {
					title : 'Sub-category Quantity wise Chart',
					pieHole : 0.6,
					backgroundColor : 'transparent',
					pieSliceText : 'none',
					sliceVisibilityThreshold : 0,
					legend : {
						position : 'labeled',
						labeledValueText : 'both',
						textStyle : {
							color : 'red',
							fontSize : 13
						}
					},
					is3D : true,
				};
				//  alert(222);
				chart = new google.visualization.PieChart(document
						.getElementById('donutchart'));

				function selectQtyHandler() {
					// alert("hii");
					var selectedItem = chart.getSelection()[0];
					if (selectedItem) {
						// alert("hii selectedItem");
						i = selectedItem.row, 0;

						//alert("hii selectedItem" + chartsdata[i].subCatId);
						//getItemListBySubCatId(chartsdata[i].subCatId,chartsdata[i].subCatName);

					}
				}

				google.visualization.events.addListener(chart, 'select',
						selectQtyHandler);
				chart.draw(data1, options);

			});

		}
	</script>


	<script type="text/javascript">
		function drawDonutChartAmt() {
			//alert("hii donut ch");
			//to draw donut chart
			var chart;
			var datag = '';
			var a = "";
			var dataSale = [];
			var Header = [ 'Sub-category', 'Amount', 'ID' ];
			dataSale.push(Header);
			$.post('${getSubCatReportChart}', {
				ajax : 'true'
			}, function(chartsdata) {
				//alert(JSON.stringify(chartsdata));
				//	console.log('data ' + JSON.stringify(chartsdata));
				var len = chartsdata.length;
				datag = datag + '[';
				$.each(chartsdata, function(key, chartsdata) {
					var temp = [];

					if (parseFloat(chartsdata.netAmt) > 0) {
						temp.push(chartsdata.subCatName + " ("
								+ (parseFloat(chartsdata.netAmt).toFixed(2))
								+ ")", (parseFloat(chartsdata.netAmt)),
								parseInt(chartsdata.subCatId));
						dataSale.push(temp);
					}

				});

				//console.log(dataSale);
				var data1 = google.visualization.arrayToDataTable(dataSale);

				var options = {
					title : 'Sub-category Amount wise Chart',
					pieHole : 0.4,
					backgroundColor : 'transparent',
					pieSliceText : 'none',
					sliceVisibilityThreshold : 0,
					legend : {
						position : 'labeled',
						labeledValueText : 'both',
						textStyle : {
							color : 'red',
							fontSize : 13
						}
					},
					is3D : true,
				};
				//  alert(222);
				chart = new google.visualization.PieChart(document
						.getElementById('donutchart1'));

				function selectQtyHandler() {
					// alert("hii");
					var selectedItem = chart.getSelection()[0];
					if (selectedItem) {
						// alert("hii selectedItem");
						i = selectedItem.row, 0;

						//alert("hii selectedItem" + chartsdata[i].subCatId);
						//getItemListBySubCatId(chartsdata[i].subCatId,chartsdata[i].subCatName);

					}
				}

				google.visualization.events.addListener(chart, 'select',
						selectQtyHandler);
				chart.draw(data1, options);

			});

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