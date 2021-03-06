<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getBillList" value="/getSaleReportBySubCatAndFrItem"></c:url>
	<c:url var="getAllCatByAjax" value="/getAllCatByAjax"></c:url>
	<c:url var="getGroup2ByCatId" value="/getSubCatByCatIdForReport"></c:url>

	<c:url var="getFrListofAllFr" value="/getFrListofAllFrForFrSummery"></c:url>


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
					<i class="fa fa-file-o"></i>Franchisee SubCategory Item-wise Report
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
				<li class="active">Bill Report</li>
			</ul>
		</div>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i> Franchisee SubCategory Item-wise Report
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



				<div class="row">
					<div class="col-md-2">Select Category</div>
					<div class="col-md-4" style="text-align: left;">
						<select data-placeholder="Select Group"
							class="form-control chosen" name="item_grp1" tabindex="-1"
							onchange="getSubCategoriesByCatId()" id="item_grp1"
							data-rule-required="true" multiple="multiple">
							<option value="-1">Select All</option>

							<c:forEach items="${mCategoryList}" var="mCategoryList">
								<option value="${mCategoryList.catId}"><c:out
										value="${mCategoryList.catName}"></c:out></option>
							</c:forEach>


						</select>
					</div>

					<label class="col-sm-2 col-lg-2 control-label">Sub Category</label>
					<div class="col-md-4">
						<select data-placeholder="Select Sub Category" multiple="multiple"
							class="form-control chosen " name="item_grp2" id="item_grp2"
							tabindex="-1" data-rule-required="true"
							onchange="setAllSubSelected()">

						</select>
					</div>

				</div>

				<br>
				<div class="row">
					<div class="form-group">

						<label class="col-sm-3 col-lg-2 control-label"> Select
							Franchise</label>
						<div class="col-sm-6 col-lg-4">

							<select data-placeholder="Choose Franchisee"
								class="form-control chosen" multiple="multiple" tabindex="6"
								id="selectFr" name="selectFr"
								onchange="setAllFrSelected(this.value)">

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
					<div class="form-group">

						<div id="cdcDiv">

							<label class="col-sm-3 col-lg-2 control-label"></label>
							<div class="col-sm-6 col-lg-4"></div>

							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type Option</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									multiple="multiple" tabindex="6" id="type_id" name="type_id">

									<option value="1" selected="selected">Franchisee Bill</option>
									<option value="2" selected="selected">Delivery Challan</option>
									<!-- <option value="3">Company Outlet Bill</option> -->
								</select>

							</div>
						</div>

						<div id="dairyDiv" style="display: none;">

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

							<label class="col-sm-3 col-lg-2 control-label">Select
								Type</label>
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

				<br>
				<div class="row">
					<div class="col-md-12" style="text-align: center;">
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
					<i class="fa fa-list-alt"></i>Franchisee SubCategory-wise Report
				</h3>

			</div>


			<div class=" box-content">
				<div class="row">



					<div class="col-md-12 table-responsive" id="purchase"
						style="display: none;">

						<input type="button"
							onclick="tableToExcel('table_grid', 'name', 'Franchise_SubCategory_Item_Wise_Report.xls')"
							value="Export to Excel">


						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f95d64;">
								<tr>
									<th style="text-align: center;">Sr.No.</th>
									<th style="text-align: center;">Item Name</th>
									<th style="text-align: center;">Sold Qty</th>
									<th style="text-align: center;">Sold Amt</th>
									<th style="text-align: center;">Var Qty</th>
									<th style="text-align: center;">Var Amt</th>
									<th style="text-align: center;">Ret Qty</th>
									<th style="text-align: center;">Ret Amt</th>
									<th style="text-align: center;">Net Qty</th>
									<th style="text-align: center;">Net Amt</th>
									<th style="text-align: center;">Ret Amt</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>


					<div class="col-md-12 table-responsive" id="sale"
						style="display: none;">

						<input type="button"
							onclick="tableToExcel('table_grid2', 'name', 'Franchise_SubCategory_Item_Wise_Report.xls')"
							value="Export to Excel">


						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid2">
							<thead style="background-color: #f95d64;">
								<tr>
									<th style="text-align: center;">Sr.No.</th>
									<th style="text-align: center;">Item Name</th>
									<th style="text-align: center;">Sold Qty</th>
									<th style="text-align: center;">Sold Amt</th>
									<th style="text-align: center;">CRN Qty</th>
									<th style="text-align: center;">CRN Amt</th>
									<th style="text-align: center;">Net Qty</th>
									<th style="text-align: center;">Net Amt</th>
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

			var selectedFr = $("#selectFr").val();
			var selectedSubCat = $("#item_grp2").val();

			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			var typeId = $("#type_id").val();

			var dairy = $("#dairy_id").val();
			
			var configType=document.getElementById("configType").value;

			var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;

			} else {
				billType = 2;
			}

			var isValid = 0;

			if (selectedSubCat == null) {
				alert("Please select Sub Category");
				isValid = 0;
			} else if (selectedFr == null) {
				alert("Please select Franchisee");
				isValid = 0;
			} else if (billType == 1) {
				if (typeId == null) {
					alert("Please select bill type options");
					isValid = 0;
				} else {
					isValid = 1;
				}
			} else if (billType == 2) {
				if (dairy == null) {
					alert("Please select Regular or Dairy Mart type");
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
									subCat_id_list : JSON
											.stringify(selectedSubCat),
									fromDate : from_date,
									toDate : to_date,
									billType : billType,
									typeId : JSON.stringify(typeId),
									dairy : JSON.stringify(dairy),
									configType : configType,
									ajax : 'true'

								},
								function(data) {

									$('#table_grid td').remove();
									$('#table_grid2 td').remove();
									$('#loader').hide();

									if (data == "") {
										alert("No records found !!");
										document.getElementById("expExcel").disabled = true;
									}

									var finalSoldQty = 0;
									var finalSoldAmt = 0;
									var finalVarQty = 0;
									var finalVarAmt = 0;
									var finalRetQty = 0;
									var finalRetAmt = 0;
									var finalNetQty = 0;
									var finalNetAmt = 0;
									var finalretAmtPer = 0;

									if (billType == 1) {

										$('#purchase').show();
										$('#sale').hide();

										$
												.each(
														data.frList,
														function(key, fr) {

															var index = 0;
															var tr = $('<tr></tr>');

															tr
																	.append($(
																			'<td></td>')
																			.html(
																					fr.frName));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));

															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));

															$(
																	'#table_grid tbody')
																	.append(tr);

															var totalSoldQty = 0;
															var totalSoldAmt = 0;
															var totalVarQty = 0;
															var totalVarAmt = 0;
															var totalRetQty = 0;
															var totalRetAmt = 0;
															var totalNetQty = 0;
															var totalNetAmt = 0;
															var retAmtPer = 0;

															$
																	.each(
																			data.subCatList,
																			function(
																					key,
																					subCat) {

																				var SoldQty = 0;
																				var SoldAmt = 0;
																				var VarQty = 0;
																				var VarAmt = 0;
																				var RetQty = 0;
																				var RetAmt = 0;
																				var NetQty = 0;
																				var NetAmt = 0;
																				var AmtPer = 0;

																				var tr = $('<tr></tr>');

																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										subCat.subCatName));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));

																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));

																				$(
																						'#table_grid tbody')
																						.append(
																								tr);

																				$
																						.each(
																								data.subCatItemReport,
																								function(
																										key1,
																										report) {
																									if (subCat.subCatId == report.subCatId) {

																										if (fr.frId == report.frId) {

																											SoldQty = SoldQty
																													+ report.soldQty;
																											SoldAmt = SoldAmt
																													+ report.soldAmt;
																											VarQty = VarQty
																													+ report.varQty;
																											VarAmt = VarAmt
																													+ report.varAmt;
																											RetQty = RetQty
																													+ report.retQty;
																											RetAmt = RetAmt
																													+ report.retAmt;
																											NetQty = NetQty
																													+ report.netQty;
																											NetAmt = NetAmt
																													+ report.netAmt;
																											AmtPer = AmtPer
																													+ report.retAmtPer;

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
																											/* 																										document
																											 .getElementById('range').style.display = 'block'; */

																											index = index + 1;

																											//var tr = "<tr>";

																											var tr = $('<tr></tr>');

																											tr
																													.append($(
																															'<td></td>')
																															.html(
																																	index));

																											tr
																													.append($(
																															'<td></td>')
																															.html(
																																	report.itemName));

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
																											tr
																													.append($(
																															'<td style="text-align:right;"></td>')
																															.html(
																																	addCommas(report.retAmtPer
																																			.toFixed(2))));

																											$(
																													'#table_grid tbody')
																													.append(
																															tr);

																										}
																									}

																								});

																				var tr = $('<tr></tr>');

																				tr
																						.append($(
																								'<td  ></td>')
																								.html(
																										" "));

																				tr
																						.append($(
																								'<td style="font-weight:bold;"></td>')
																								.html(
																										"Total"));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(SoldQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(SoldAmt
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(VarQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(VarAmt
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(RetQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(RetAmt
																												.toFixed(2))));

																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(NetQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(NetAmt
																												.toFixed(2))));

																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(AmtPer
																												.toFixed(2))));

																				$(
																						'#table_grid tbody')
																						.append(
																								tr);

																			});

															finalSoldQty = finalSoldQty
																	+ totalSoldQty;
															finalSoldAmt = finalSoldAmt
																	+ totalSoldAmt;
															finalVarQty = finalVarQty
																	+ totalVarQty;
															finalVarAmt = finalVarAmt
																	+ totalVarAmt;
															finalRetQty = finalRetQty
																	+ totalRetQty;
															finalRetAmt = finalRetAmt
																	+ totalRetAmt;
															finalNetQty = finalNetQty
																	+ totalNetQty;
															finalNetAmt = finalNetAmt
																	+ totalNetAmt;
															finalretAmtPer = finalretAmtPer
																	+ retAmtPer;

															var tr = $('<tr></tr>');

															tr
																	.append($(
																			'<td  ></td>')
																			.html(
																					" "));

															tr
																	.append($(
																			'<td style="font-weight:bold;"></td>')
																			.html(
																					"Franchisee Total"));
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
																					addCommas(retAmtPer
																							.toFixed(2))));

															$(
																	'#table_grid tbody')
																	.append(tr);

														})

										var tr = $('<tr></tr>');

										tr.append($('<td  ></td>').html(" "));

										tr
												.append($(
														'<td style="font-weight:bold;"></td>')
														.html("Final Total"));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalSoldQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalSoldAmt
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalVarQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalVarAmt
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalRetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalRetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalNetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalNetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalretAmtPer
																		.toFixed(2))));

										$('#table_grid tbody').append(tr);

									} else {

										$('#purchase').hide();
										$('#sale').show();

										$
												.each(
														data.frList,
														function(key, fr) {

															var index = 0;
															var tr = $('<tr></tr>');

															tr
																	.append($(
																			'<td></td>')
																			.html(
																					fr.frName));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));

															tr
																	.append($(
																			'<td></td>')
																			.html(
																					""));

															$(
																	'#table_grid2 tbody')
																	.append(tr);

															var totalSoldQty = 0;
															var totalSoldAmt = 0;
															var totalVarQty = 0;
															var totalVarAmt = 0;
															var totalRetQty = 0;
															var totalRetAmt = 0;
															var totalNetQty = 0;
															var totalNetAmt = 0;
															var retAmtPer = 0;

															$
																	.each(
																			data.subCatList,
																			function(
																					key,
																					subCat) {

																				var SoldQty = 0;
																				var SoldAmt = 0;
																				var VarQty = 0;
																				var VarAmt = 0;
																				var RetQty = 0;
																				var RetAmt = 0;
																				var NetQty = 0;
																				var NetAmt = 0;
																				var AmtPer = 0;

																				var tr = $('<tr></tr>');

																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										subCat.subCatName));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));

																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										""));

																				$(
																						'#table_grid2 tbody')
																						.append(
																								tr);

																				$
																						.each(
																								data.subCatItemReport,
																								function(
																										key1,
																										report) {
																									if (subCat.subCatId == report.subCatId) {

																										if (fr.frId == report.frId) {

																											SoldQty = SoldQty
																													+ report.soldQty;
																											SoldAmt = SoldAmt
																													+ report.soldAmt;
																											VarQty = VarQty
																													+ report.varQty;
																											VarAmt = VarAmt
																													+ report.varAmt;
																											RetQty = RetQty
																													+ report.retQty;
																											RetAmt = RetAmt
																													+ report.retAmt;
																											NetQty = NetQty
																													+ report.netQty;
																											NetAmt = NetAmt
																													+ report.netAmt;
																											AmtPer = AmtPer
																													+ report.retAmtPer;

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
																											AmtPer = AmtPer
																													+ report.retAmtPer;

																											document
																													.getElementById("expExcel").disabled = false;
																											/* 																										document
																											 .getElementById('range').style.display = 'block'; */

																											index = index + 1;

																											//var tr = "<tr>";

																											var tr = $('<tr></tr>');

																											tr
																													.append($(
																															'<td></td>')
																															.html(
																																	index));

																											tr
																													.append($(
																															'<td></td>')
																															.html(
																																	report.itemName));

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

																											$(
																													'#table_grid2 tbody')
																													.append(
																															tr);

																										}
																									}

																								});

																				var tr = $('<tr></tr>');

																				tr
																						.append($(
																								'<td  ></td>')
																								.html(
																										" "));

																				tr
																						.append($(
																								'<td style="font-weight:bold;"></td>')
																								.html(
																										"Total"));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(SoldQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(SoldAmt
																												.toFixed(2))));

																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(RetQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(RetAmt
																												.toFixed(2))));

																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(NetQty
																												.toFixed(2))));
																				tr
																						.append($(
																								'<td style="text-align:right;"></td>')
																								.html(
																										addCommas(NetAmt
																												.toFixed(2))));

																				$(
																						'#table_grid2 tbody')
																						.append(
																								tr);

																			});

															finalSoldQty = finalSoldQty
																	+ totalSoldQty;
															finalSoldAmt = finalSoldAmt
																	+ totalSoldAmt;
															finalVarQty = finalVarQty
																	+ totalVarQty;
															finalVarAmt = finalVarAmt
																	+ totalVarAmt;
															finalRetQty = finalRetQty
																	+ totalRetQty;
															finalRetAmt = finalRetAmt
																	+ totalRetAmt;
															finalNetQty = finalNetQty
																	+ totalNetQty;
															finalNetAmt = finalNetAmt
																	+ totalNetAmt;
															finalretAmtPer = finalretAmtPer
																	+ retAmtPer;

															var tr = $('<tr></tr>');

															tr
																	.append($(
																			'<td  ></td>')
																			.html(
																					" "));

															tr
																	.append($(
																			'<td style="font-weight:bold;"></td>')
																			.html(
																					"Franchisee Total"));
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

															$(
																	'#table_grid2 tbody')
																	.append(tr);

														})

										var tr = $('<tr></tr>');

										tr.append($('<td  ></td>').html(" "));

										tr
												.append($(
														'<td style="font-weight:bold;"></td>')
														.html("Final Total"));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalSoldQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalSoldAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalRetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalRetAmt
																		.toFixed(2))));

										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalNetQty
																		.toFixed(2))));
										tr
												.append($(
														'<td style="text-align:right;"></td>')
														.html(
																addCommas(finalNetAmt
																		.toFixed(2))));

										$('#table_grid2 tbody').append(tr);

									}

								});

			}
		}
	</script>



	<script>
		$('.datepicker').datepicker({
			format : {

				format : 'mm/dd/yyyy',
				startDate : '-3d'
			}
		});

		function genPdf() {
			var selectedFr = $("#selectFr").val();
			var selectedSubCatIdList = $("#item_grp2").val();
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

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/showSummeryFrAndSubCatItemPdf/'
							+ from_date
							+ '/'
							+ to_date
							+ '/'
							+ selectedFr
							+ '/'
							+ selectedSubCatIdList
							+ '/'
							+ billType
							+ '/'
							+ typeId + '/' + dairy);

		}
	</script>


	<script type="text/javascript">
		function getSubCategoriesByCatId() {
			var catId = $("#item_grp1").val();

			$
					.getJSON(
							'${getGroup2ByCatId}',
							{
								catId : JSON.stringify(catId),
								ajax : 'true'
							},
							function(data) {
								var html = '<option multiple="multiple" value="">Sub Category</option>';

								var len = data.length;

								$('#item_grp2').find('option').remove().end()

								$("#item_grp2")
										.append(
												$("<option ></option>").attr(
														"value", "").text(
														"Select Sub Category"));
								$("#item_grp2").append(
										$("<option></option>")
												.attr("value", -1).text("ALL"));
								for (var i = 0; i < len; i++) {
									$("#item_grp2").append(
											$("<option></option>").attr(
													"value", data[i].subCatId)
													.text(data[i].subCatName));
								}
								$("#item_grp2").trigger("chosen:updated");
							});
		}
		function setAllSubSelected() {
			var catId = $("#item_grp1").val();
			var subCatId = $("#item_grp2").val();
			if (subCatId == -1) {
				$
						.getJSON(
								'${getGroup2ByCatId}',
								{
									catId : JSON.stringify(catId),
									ajax : 'true'
								},
								function(data) {
									var html = '<option multiple="multiple" value="">Sub Category</option>';

									var len = data.length;

									$('#item_grp2').find('option').remove()
											.end()

									$("#item_grp2").append(
											$("<option ></option>").attr(
													"value", "").text(
													"Select Sub Category"));
									$("#item_grp2").append(
											$("<option></option>").attr(
													"value", -1).text("ALL"));
									for (var i = 0; i < len; i++) {
										$("#item_grp2")
												.append(
														$(
																"<option selected></option>")
																.attr(
																		"value",
																		data[i].subCatId)
																.text(
																		data[i].subCatName));
									}
									$("#item_grp2").trigger("chosen:updated");
								});
			}
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

	<script>
		function setAllFrSelected(frId) {
			//alert("hii")
			if (frId == -1) {

				$.getJSON('${getFrListofAllFr}', {

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


	<script type="text/javascript">
		function tableToExcel(table, name, filename) {
			let uri = 'data:application/vnd.ms-excel;base64,', template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><title></title><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>', base64 = function(
					s) {
				return window.btoa(decodeURIComponent(encodeURIComponent(s)))
			}, format = function(s, c) {
				return s.replace(/{(\w+)}/g, function(m, p) {
					return c[p];
				})
			}

			if (!table.nodeType)
				table = document.getElementById(table)
			var ctx = {
				worksheet : name || 'Worksheet',
				table : table.innerHTML
			}

			var link = document.createElement('a');
			link.download = filename;
			link.href = uri + base64(format(template, ctx));
			link.click();
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