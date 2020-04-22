<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

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

	<c:url var="getBillList" value="/getSaleReportRoyConsoByCat"></c:url>
	<c:url var="getAllCategoryForReport" value="/getAllCategoryForReport"></c:url>
	<c:url var="getFrListofAllFr" value="/getFrListForDatewiseReport"></c:url>

	<c:url var="getSubCatListForChart" value="/getSubCatListForChart"></c:url>
	<c:url var="getItemListForChart" value="/getItemListForChart"></c:url>
	<c:url var="getDateWiseSaleForItem" value="/getDateWiseSaleForItem"></c:url>
	<c:url var="getFrWiseSaleForItem" value="/getFrWiseSaleForItem"></c:url>





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
		<!-- <div class="page-title">
			<div>
				<h1>
					<i class="fa fa-file-o"></i>Royalty Report By Category
				</h1>
				<h4></h4>
			</div>
		</div> -->
		<!-- END Page Title -->

		<!-- BEGIN Breadcrumb -->
		<%-- <div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="fa fa-home"></i> <a
					href="${pageContext.request.contextPath}/home">Home</a> <span
					class="divider"><i class="fa fa-angle-right"></i></span></li>
				<li class="active">Bill Report</li>
			</ul>
		</div> --%>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Product wise Sale Report
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
							Bills & Del. Challan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
								type="radio" id="rd2" name="rd" value="2"
								onchange="billTypeSelection(this.value)">&nbsp;Retail
							Outlet Bills

						</div>



					</div>
				</div>







				<div class="row">

					<div class="form-group">
						<br> <label class="col-sm-3 col-lg-2 control-label">Select
							Category</label>
						<div class="col-sm-3 col-lg-4">

							<select data-placeholder="Choose Category"
								class="form-control chosen" multiple="multiple" tabindex="6"
								id="selectCat" name="selectCat"
								onchange="setAllCategory(this.value)">

								<option value="-1"><c:out value="All" /></option>

								<c:forEach items="${catList}" var="cat" varStatus="count">
									<option value="${cat.catId}"><c:out
											value="${cat.catName}" /></option>
								</c:forEach>
							</select>
						</div>

						<div id="cdcDiv">


							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type Option</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									multiple="multiple" tabindex="6" id="type_id" name="type_id">

									<option value="1" selected="selected">Franchise Bill</option>
									<option value="2" selected="selected">Delivery Chalan</option>
									<!-- <option value="3">Company Outlet Bill</option> -->
								</select>

							</div>
						</div>

						<div id="outletDiv" style="display: none;">


							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type Option</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									multiple="multiple" tabindex="6" id="dairyId" name="dairyId">

									<option value="1" selected="selected">Regular</option>
									<option value="2" selected="selected">Is Dairy Mart</option>
								</select>

							</div>
						</div>

					</div>

				</div>


				<div class="row">

					<div class="form-group">
						<br> <label class="col-sm-3 col-lg-2 control-label">Sort
							By</label>
						<div class="col-sm-3 col-lg-4">

							<select data-placeholder="Sort" class="form-control chosen"
								tabindex="6" id="selectSort" name="selectSort">

								<option value="1"><c:out value="Sale Quantity" /></option>
								<option value="2"><c:out value="Sale Value" /></option>


							</select>
						</div>

					</div>

				</div>


				<div class="row">

					<div class="form-group">

						<div class="form-group">


							<label class="col-sm-3 col-lg-1 control-label"
								style="display: none;">By</label>
							<div class="col-sm-3 col-lg-2" style="display: none;">

								<select data-placeholder="Get By" class="form-control chosen"
									tabindex="6" id="getBy" name="getBy">

									<option value="1">Taxable Amt</option>
									<option value="2" selected="selected">Grand Total</option>
								</select>
							</div>
							<label class="col-sm-3 col-lg-1 control-label"
								style="display: none;">GRN/CRN</label>
							<div class="col-sm-3 col-lg-2" style="display: none;">

								<select data-placeholder="GRN/CRN" class="form-control chosen"
									tabindex="6" id="type" name="type">

									<option value="1">GRN</option>
									<option value="2" selected="selected">CRN</option>
								</select>
							</div>

							<div class="col-md-12" style="text-align: center;">
								<br>
								<button class="btn btn-info" onclick="searchReport(0)">Search
									Report</button>
								<!-- <button class="btn search_btn"  onclick="showChart()">Graph</button> -->


								<button class="btn btn-primary" value="PDF" id="PDFButton"
									onclick="genPdf()">PDF</button>

								<button class="btn btn-primary" id="graphButton"
									onclick="searchReport(1)">Graph</button>
							</div>


						</div>

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





				<div class="box">
					<div class="box-title">
						<h3>
							<i class="fa fa-list-alt"></i>Product wise Sale Report
						</h3>

					</div>

					<form id="submitBillForm"
						action="${pageContext.request.contextPath}/submitNewBill"
						method="post">
						<div class=" box-content">
							<div class="row" style="display: none;">
								<div class="col-md-12 table-responsive">
									<table class="table table-bordered table-striped fill-head "
										style="width: 100%" id="table_grid">
										<thead style="background-color: #f95d64;">
											<tr>
												<th style="text-align: center;">Sr.No.</th>
												<th style="text-align: center;">Item Name</th>
												<th style="text-align: center;">Sale Qty</th>
												<th style="text-align: center;">Sale Value</th>
												<th id="thDiscAmt" style="text-align: center;">Discount</th>
												<th id="thGrnQty" style="text-align: center;">GRN Qty</th>
												<th id="thGrnVal" style="text-align: center;">GRN Value</th>
												<th id="thGvnQty" style="text-align: center;">GVN Qty</th>
												<th id="thGvnVal" style="text-align: center;">GVN Value</th>
												<th style="text-align: center;">Net Qty</th>
												<th style="text-align: center;">Net Value</th>
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
							<br>



							<div id="grn" style="display: none;">
								<input type="button"
									onclick="tableToExcel('table_grid1', 'name', 'ProductWiseReport.xls')"
									value="Export to Excel">
								<div class="col-md-12 table-responsive">
									<table style="width: 100%; border: 1px;" id="table_grid1"
										border="1">
										<thead style="background-color: #f95d64;">
											<tr>
												<th style="text-align: center;">Sr.No.</th>
												<th style="text-align: center;">Item Name</th>
												<th style="text-align: center;">Sale Qty</th>
												<th style="text-align: center;">Sale Value</th>
												<th id="thDiscAmt2" style="text-align: center;">Discount</th>
												<th id="thGrnQty2" style="text-align: center;">GRN Qty</th>
												<th id="thGrnVal2" style="text-align: center;">GRN
													Value</th>
												<th id="thGvnQty2" style="text-align: center;">GVN Qty</th>
												<th id="thGvnVal2" style="text-align: center;">GVN
													Value</th>
												<th style="text-align: center;">Net Qty</th>
												<th style="text-align: center;">Net Value</th>
												<th style="text-align: center;">Contribution</th>
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
								</div>
							</div>


							<div id="crn" style="display: none;">
								<input type="button"
									onclick="tableToExcel('table_grid2', 'name', 'ProductWiseReport.xls')"
									value="Export to Excel">
								<div class="col-md-12 table-responsive">
									<table style="width: 100%; border: 1px;" id="table_grid2"
										border="1">
										<thead style="background-color: #f95d64;">
											<tr>
												<th style="text-align: center;">Sr.No.</th>
												<th style="text-align: center;">Item Name</th>
												<th style="text-align: center;">Sale Qty</th>
												<th style="text-align: center;">Sale Value</th>
												<th id="thGrnQty2" style="text-align: center;">CRN Qty</th>
												<th id="thGrnVal2" style="text-align: center;">CRN
													Value</th>
												<th style="text-align: center;">Net Qty</th>
												<th style="text-align: center;">Net Value</th>
												<th style="text-align: center;">Contribution</th>
											</tr>
										</thead>
										<tbody>

										</tbody>
									</table>
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


							<div id="chart_div"></div>
							<br>
							<div id="chart_div1"></div>




						</div>

						<!-- <div id="chart_div"
							style="width: 100%; height: 700px; background-color: white;"></div>
						<div id="PieChart_div" style="width: 100%; height: 700px;"></div> -->





					</form>






				</div>
			</div>
			<!-- END Main Content -->
		</div>
		<footer>
			<p>2019 © MADHVI.</p>
		</footer>

		<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
			class="fa fa-chevron-up"></i></a>


	</div>

	<script type="text/javascript">
			function billTypeSelection(val) {

				if (val == 2) {
					document.getElementById("cdcDiv").style.display = "none";
					document.getElementById("outletDiv").style.display = "block";
				} else {
					document.getElementById("cdcDiv").style.display = "block";
					document.getElementById("outletDiv").style.display = "none";
				}

			}
		</script>


	<script type="text/javascript">
			function searchReport(graph) {
					//var isValid = validate();
                   
				//document.getElementById('chart').style.display = "block";
				//document.getElementById("PieChart_div").style = "display:none";
				//document.getElementById("chart_div").style = "display:none";
               // if(isValid==true){
				var selectedFr = $("#selectFr").val();
				var type_id = $("#type_id").val();
				var routeId = $("#selectRoute").val();
				var isGraph = 0;

				var selectedCat = $("#selectCat").val();
				var getBy= $("#getBy").val();
				var type= $("#type").val();
				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();
              // alert(selectedCat);
              
              var dairyId = $("#dairyId").val();
              
              var selectedSort = $("#selectSort").val();
              
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
				} else if (selectedCat == "" || selectedCat == null) { 

					alert("Please Select Category");
					isValid = 0;
			
			    } else if (billType == 1) {
					if (type_id == null) {
						alert("Please select bill type options");
						isValid = 0;
					} else {
						isValid = 1;
					}
				}  else {
					isValid = 1;
				}
				
				if(isValid==1){
					
					//getby-2 - grand total
					//type -1-grn,2-crn
              
              
				$('#loader').show();

				$
						.getJSON(
								'${getBillList}',

								{
									fr_id_list : JSON.stringify(selectedFr),
									fromDate : from_date,
									toDate : to_date,
									route_id : routeId,
									cat_id_list : JSON.stringify(selectedCat),
									is_graph : isGraph,
									getBy:getBy,
									type:type,
									type_id : JSON.stringify(type_id),
									billType : billType,
									sort : selectedSort,
									dairy : dairyId,
									ajax : 'true'

								},
								function(data) {
									
									if(graph==1){
										drawGraph();
									}
									
									
								if(billType==2){
									
									document.getElementById("thGrnQty").innerHTML ="CRN Qty";
									document.getElementById("thGrnVal").innerHTML ="CRN Value";
									
									document.getElementById("thGrnQty2").innerHTML ="CRN Qty";
									document.getElementById("thGrnVal2").innerHTML ="CRN Value";
									
									$('#thGvnQty').hide();
									$('#thGvnVal').hide();
									
									$('#thGvnQty2').hide();
									$('#thGvnVal2').hide();
									
									$('#thDiscAmt2').hide();
									$('#thDiscAmt').hide();
									
								}else{

									document.getElementById("thGrnQty").innerHTML ="GRN Qty";
									document.getElementById("thGrnVal").innerHTML ="GRN Value";
									
									document.getElementById("thGrnQty2").innerHTML ="GRN Qty";
									document.getElementById("thGrnVal2").innerHTML ="GRN Value";

									$('#thGvnQty').show();
									$('#thGvnVal').show();
									
									$('#thGvnQty2').show();
									$('#thGvnVal2').show();
									
									$('#thDiscAmt').show();
									$('#thDiscAmt2').show();

								}	
									

									$('#table_grid td').remove();
									$('#table_grid1 td').remove();
									$('#loader').hide();
									var royPer = ${royPer};
									if (data == "") {
										alert("No records found !!");
										  document.getElementById("expExcel").disabled=true;

									}
									

									$.each(data.categoryList,function(key, cat) {
											document.getElementById("expExcel").disabled=false;
											document.getElementById('range').style.display = 'block';
											
											

														var tr = $('<tr></tr>');
														tr
																.append($(
																		'<td></td>')
																		.html(
																				cat.catName));
													
														if(billType==1){
														
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
														
														}
														
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
														
														$('#table_grid tbody')
																.append(tr);

														var srNo = 0;
														$
																.each(
																		data.salesReportRoyalty,
																		function(
																				key,
																				report) {

																			if (cat.catId == report.catId) {
																				//alert("Hi");
																				srNo = srNo + 1;
																				//var index = key + 1;
																				var tr = $('<tr></tr>');
																				//tr.append($('<td></td>').html(cat.catName));
																				tr
																						.append($(
																								'<td style="text-align:center;"></td>')
																								.html(
																										srNo));
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										report.item_name));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tBillQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas((report.tBillTaxableAmt).toFixed(2))));

																				if(billType==1){
																				tr
																				.append($(
																						'<td  style="text-align:right;"></td>')
																						.html(
																								addCommas((report.discAmt).toFixed(2))));
																				}
																				
																				
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGrnQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGrnTaxableAmt.toFixed(2))));
																				
																				
																				if(billType==1){
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGvnQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGvnTaxableAmt.toFixed(2))));
																				}
																				

																				var netQty = report.tBillQty
																						- (report.tGrnQty + report.tGvnQty);
																				netQty = netQty
																						.toFixed(2);

																				var netValue = report.tBillTaxableAmt
																						- (report.tGrnTaxableAmt + report.tGvnTaxableAmt);
																				netValue = netValue
																						.toFixed(2);

																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(netQty)));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(netValue)));
																			

																		rAmt = netValue
																				* royPer
																				/ 100;
																		rAmt = rAmt
																				.toFixed(2);

																				$(
																						'#table_grid tbody')
																						.append(
																								tr);

																			}//end of if

																		})
													});
									
						
													
													
													
								if(billType==1){
									
									
									
									$('#grn').show();
									$('#crn').hide();

									
									$.each(data.categoryList,function(key, cat) {
										
										var netQtySum=0.0;var netValueSum=0.0;var rAmtSum=0.0;var billQtySum=0.0;var billTaxableAmtSum=0.0;var grnQtySum=0.0;var gvnQtySum=0.0;var gvnTaxableAmtSum=0.0;var grnTaxableAmtSum=0.0;
										var finalDiscTotal=0.0;
										
										var tr = $('<tr style="background-color:pink;"></tr>');tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(cat.catName));
												tr.append($('<td></td>').html(""));
												tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											$('#table_grid1 tbody').append(tr);	
											
											var srNo = 0;		
											
											$.each(cat.subCategoryList,function(key, subcat) {
												
												var tr = $('<tr style="background-color:lightgrey;"></tr>');tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td></td>').html(subcat.subCatName));
													tr.append($('<td  style="text-align:right;"></td>').html(""));
													tr.append($('<td  style="text-align:right;"></td>').html(("")));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												
												$('#table_grid1 tbody').append(tr);
												
												
												var contributionTotal=0;
												$.each(data.salesReportRoyalty,function(key,report) {
													if (subcat.subCatId == report.subCatId) {
														contributionTotal=contributionTotal+report.tBillTaxableAmt-(report.tGrnTaxableAmt + report.tGvnTaxableAmt);
													}
												});
												
												
											var netQtyTotal=0.0;var netValueTotal=0.0;var rAmtTotal=0.0;var billQtyTotal=0.0;var billTaxableAmtTotal=0.0;var grnQtyTotal=0.0;var gvnQtyTotal=0.0;var gvnTaxableAmtTotal=0.0;var grnTaxableAmtTotal=0.0;
											var discTotal=0.0;
											var contriTot=0
											
											
											$.each(data.salesReportRoyalty,function(key,report) {

																			if (subcat.subCatId == report.subCatId) {
																				
																				srNo = srNo + 1;
																				
																		billQtyTotal=billQtyTotal+report.tBillQty;
																		billTaxableAmtTotal=billTaxableAmtTotal+report.tBillTaxableAmt;
																				
																		grnQtyTotal=grnQtyTotal+report.tGrnQty;
																		gvnQtyTotal=gvnQtyTotal+report.tGvnQty;
																	
																		grnTaxableAmtTotal=grnTaxableAmtTotal+report.tGrnTaxableAmt;
																		gvnTaxableAmtTotal=gvnTaxableAmtTotal+report.tGvnTaxableAmt;
																	    var netQty = report.tBillQty- (report.tGrnQty + report.tGvnQty);
																		netQtyTotal=netQtyTotal+netQty;
																				   
																		var netValue = report.tBillTaxableAmt-(report.tGrnTaxableAmt + report.tGvnTaxableAmt);
																		netValueTotal =netValueTotal+ netValue;
																		rAmt = netValue* royPer/ 100;
																		rAmtTotal = rAmtTotal+rAmt;
																		
																		discTotal=discTotal+report.discAmt;
																		
																		var contri=0.0;
																		if(contributionTotal!=0){
																			contri=(netValue*100)/contributionTotal;
																		}
																		
																		contriTot=contriTot+contri;
																		
																		
																				var tr = $('<tr></tr>');
																				//tr.append($('<td></td>').html(cat.catName));
																				 tr
																						.append($(
																								'<td style="text-align:center;"></td>')
																								.html(
																										srNo)); 
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										report.item_name));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tBillQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas((report.tBillTaxableAmt).toFixed(2))));
																				
																				tr
																				.append($(
																						'<td  style="text-align:right;"></td>')
																						.html(
																								addCommas(report.discAmt.toFixed(2))));

																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGrnQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGrnTaxableAmt.toFixed(2))));
																				
																				
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGvnQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGvnTaxableAmt.toFixed(2))));
																				
																				tr
																				.append($(
																						'<td  style="text-align:right;"></td>')
																						.html(
																								addCommas(netQty.toFixed(2))));
																		tr
																				.append($(
																						'<td  style="text-align:right;"></td>')
																						.html(
																								addCommas(netValue.toFixed(2))));
																		
																		tr
																		.append($(
																				'<td  style="text-align:right;"></td>')
																				.html(
																						addCommas(contri.toFixed(2))));
																		
																		
																		
																		
																		$(
																				'#table_grid1 tbody')
																				.append(
																						tr);
																		
																		

																			}//end of if

																		})	
											netQtySum=netQtySum+netQtyTotal;
																		netValueSum=netValueSum+netValueTotal;
																		rAmtSum=rAmtSum+rAmtTotal;
																		billQtySum=billQtySum+billQtyTotal;
																		billTaxableAmtSum=billTaxableAmtSum+billTaxableAmtTotal;
																		grnQtySum=grnQtySum+grnQtyTotal;
																		gvnQtySum=gvnQtySum+gvnQtyTotal;
																		gvnTaxableAmtSum=gvnTaxableAmtSum+gvnTaxableAmtTotal;
																		grnTaxableAmtSum=grnTaxableAmtSum+grnTaxableAmtTotal;
																		finalDiscTotal=finalDiscTotal+discTotal;
											
											var tr = $('<tr style="background-color:lightgrey;"></tr>');tr.append($('<td></td>').html(" "));
											tr.append($('<td></td>').html(subcat.subCatName+" Total"));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(billQtyTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html((addCommas(billTaxableAmtTotal.toFixed(2)))));
											
											tr.append($('<td  style="text-align:right;"></td>').html((addCommas(discTotal.toFixed(2)))));

											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnQtyTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnTaxableAmtTotal.toFixed(2))));
											
												tr.append($('<td  style="text-align:right;"></td>').html(addCommas(gvnQtyTotal.toFixed(2))));
												tr.append($('<td  style="text-align:right;"></td>').html(addCommas(gvnTaxableAmtTotal.toFixed(2))));
											
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netQtyTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netValueTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(contriTot.toFixed(2))));
											
											
											$('#table_grid1 tbody').append(tr);
											
						})
						var tr = $('<tr style="background-color:lightgrey; font-weight:bold;"></tr>');tr.append($('<td></td>').html(" "));
											tr.append($('<td></td>').html("Total"));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(billQtySum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html((addCommas(billTaxableAmtSum.toFixed(2)))));
											
											tr.append($('<td  style="text-align:right;"></td>').html((addCommas(finalDiscTotal.toFixed(2)))));
											

											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnQtySum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnTaxableAmtSum.toFixed(2))));
											
												tr.append($('<td  style="text-align:right;"></td>').html(addCommas(gvnQtySum.toFixed(2))));
												tr.append($('<td  style="text-align:right;"></td>').html(addCommas(gvnTaxableAmtSum.toFixed(2))));
											
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netQtySum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netValueSum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(" "));
											$('#table_grid1 tbody').append(tr);
									})
									
								}else{
									
									
									$('#crn').show();
									$('#grn').hide();
									
									$.each(data.categoryList,function(key, cat) {
										var netQtySum=0.0;var netValueSum=0.0;var rAmtSum=0.0;var billQtySum=0.0;var billTaxableAmtSum=0.0;var grnQtySum=0.0;var gvnQtySum=0.0;var gvnTaxableAmtSum=0.0;var grnTaxableAmtSum=0.0;
											var tr = $('<tr style="background-color:pink;"></tr>');tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(cat.catName));
											
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											tr.append($('<td></td>').html(""));
											$('#table_grid2 tbody').append(tr);	var srNo = 0;												
											$.each(cat.subCategoryList,function(key, subcat) {
												var tr = $('<tr style="background-color:lightgrey;"></tr>');tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td></td>').html(subcat.subCatName));
												
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));

												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												tr.append($('<td  style="text-align:right;"></td>').html(""));
												$('#table_grid2 tbody').append(tr);
												
												var contributionTotal=0;
												$.each(data.salesReportRoyalty,function(key,report) {
													if (subcat.subCatId == report.subCatId) {
														contributionTotal=contributionTotal+report.tBillTaxableAmt-(report.tGrnTaxableAmt + report.tGvnTaxableAmt);
													}
												});
												
												
											var netQtyTotal=0.0;var netValueTotal=0.0;var rAmtTotal=0.0;var billQtyTotal=0.0;var billTaxableAmtTotal=0.0;var grnQtyTotal=0.0;var gvnQtyTotal=0.0;var gvnTaxableAmtTotal=0.0;var grnTaxableAmtTotal=0.0;
											var contriTot=0;
											
											$.each(data.salesReportRoyalty,function(key,report) {

																			if (subcat.subCatId == report.subCatId) {
																				
																				srNo = srNo + 1;
																				
																		billQtyTotal=billQtyTotal+report.tBillQty;
																		billTaxableAmtTotal=billTaxableAmtTotal+report.tBillTaxableAmt;
																				
																		grnQtyTotal=grnQtyTotal+report.tGrnQty;
																		gvnQtyTotal=gvnQtyTotal+report.tGvnQty;
																	
																		grnTaxableAmtTotal=grnTaxableAmtTotal+report.tGrnTaxableAmt;
																		gvnTaxableAmtTotal=gvnTaxableAmtTotal+report.tGvnTaxableAmt;
																	    var netQty = report.tBillQty- (report.tGrnQty + report.tGvnQty);
																		netQtyTotal=netQtyTotal+netQty;
																				   
																		var netValue = report.tBillTaxableAmt-(report.tGrnTaxableAmt + report.tGvnTaxableAmt);
																		netValueTotal =netValueTotal+ netValue;
																		rAmt = netValue* royPer/ 100;
																		rAmtTotal = rAmtTotal+rAmt;
																		
																		var contri=0.0;
																		if(contributionTotal!=0){
																			contri=(netValue*100)/contributionTotal;
																		}
																		
																		contriTot=contriTot+contri;
																		
																		
																				var tr = $('<tr></tr>');
																				//tr.append($('<td></td>').html(cat.catName));
																				 tr
																						.append($(
																								'<td style="text-align:center;"></td>')
																								.html(
																										srNo)); 
																				tr
																						.append($(
																								'<td></td>')
																								.html(
																										report.item_name));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tBillQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas((report.tBillTaxableAmt).toFixed(2))));

																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGrnQty.toFixed(2))));
																				tr
																						.append($(
																								'<td  style="text-align:right;"></td>')
																								.html(
																										addCommas(report.tGrnTaxableAmt.toFixed(2))));
																				
																				
																				tr
																				.append($(
																						'<td  style="text-align:right;"></td>')
																						.html(
																								addCommas(netQty.toFixed(2))));
																		tr
																				.append($(
																						'<td  style="text-align:right;"></td>')
																						.html(
																								addCommas(netValue.toFixed(2))));
																		
																		tr
																		.append($(
																				'<td  style="text-align:right;"></td>')
																				.html(
																						addCommas(contri.toFixed(2))));
																		
																		
																		
																		
																		$(
																				'#table_grid2 tbody')
																				.append(
																						tr);
																		
																		

																			}//end of if

																		})	
											netQtySum=netQtySum+netQtyTotal;
																		netValueSum=netValueSum+netValueTotal;
																		rAmtSum=rAmtSum+rAmtTotal;
																		billQtySum=billQtySum+billQtyTotal;
																		billTaxableAmtSum=billTaxableAmtSum+billTaxableAmtTotal;
																		grnQtySum=grnQtySum+grnQtyTotal;
																		gvnQtySum=gvnQtySum+gvnQtyTotal;
																		gvnTaxableAmtSum=gvnTaxableAmtSum+gvnTaxableAmtTotal;
																		grnTaxableAmtSum=grnTaxableAmtSum+grnTaxableAmtTotal;
											
											var tr = $('<tr style="background-color:lightgrey;"></tr>');tr.append($('<td></td>').html(" "));
											tr.append($('<td></td>').html(subcat.subCatName+" Total"));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(billQtyTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html((addCommas(billTaxableAmtTotal.toFixed(2)))));

											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnQtyTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnTaxableAmtTotal.toFixed(2))));
											
											
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netQtyTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netValueTotal.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(contriTot.toFixed(2))));
											
											$('#table_grid2 tbody').append(tr);
											
						})
						var tr = $('<tr style="background-color:lightgrey; font-weight:bold;"></tr>');tr.append($('<td></td>').html(" "));
											tr.append($('<td></td>').html("Total"));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(billQtySum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html((addCommas(billTaxableAmtSum.toFixed(2)))));

											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnQtySum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(grnTaxableAmtSum.toFixed(2))));
											
											
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netQtySum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(addCommas(netValueSum.toFixed(2))));
											tr.append($('<td  style="text-align:right;"></td>').html(" "));
											$('#table_grid2 tbody').append(tr);
									})
									
								}					
													
									
									
									
									
									
									
									
									
									
									
								});
				}
               // }
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


	<script>
			function setAllCategory(catId) {
				
				
				if (catId == -1) {

					$.getJSON('${getAllCategoryForReport}', {

						ajax : 'true'
					}, function(data) {

						var len = data.length;

						//alert(len);

						$('#selectCat').find('option').remove().end()
						$("#selectCat").append(
								$("<option value='-1'>All</option>"));
						for (var i = 0; i < len; i++) {
							$("#selectCat").append(
									$("<option selected ></option>").attr(
											"value", data[i].catId).text(
											data[i].catName));
						}
						$("#selectCat").trigger("chosen:updated");
					});
				}
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
			var Header = [ 'Category', 'Amount', 'ID' ];
			dataSale.push(Header);
			$.post('${getSubCatListForChart}', {
				ajax : 'true'
			}, function(chartsdata) {
				//alert(JSON.stringify(chartsdata));
				//	console.log('data ' + JSON.stringify(chartsdata));
				var len = chartsdata.length;
				datag = datag + '[';
				$.each(chartsdata, function(key, chartsdata) {
					var temp = [];
					temp.push(chartsdata.subCatName + " ("
							+ (parseFloat(chartsdata.total).toFixed(2))
							+ ")", (parseFloat(chartsdata.total)),
							parseInt(chartsdata.subCatId));
					dataSale.push(temp);

				});

				//console.log(dataSale);
				var data1 = google.visualization.arrayToDataTable(dataSale);

				var options = {
					title : 'Sub-category wise sale(%)',
					pieHole : 0.4,
					backgroundColor : 'transparent',
					pieSliceText : 'none',
					sliceVisibilityThreshold : 0,
					legend : {
						position : 'labeled',
						labeledValueText : 'both',
						textStyle : {
							color : 'red',
							fontSize : 10
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
						getItemListBySubCatId(chartsdata[i].subCatId,chartsdata[i].subCatName);

					}
				}

				google.visualization.events.addListener(chart, 'select',
						selectQtyHandler);
				chart.draw(data1, options);

			});

		}
	</script>


	<script type="text/javascript">
		function drawItemDonutChart() {
			//alert("hii donut ch");
			//to draw donut chart
			var chart;
			var datag = '';
			var a = "";
			var dataSale = [];
			var Header = [ 'Category', 'Amount', 'ID' ];
			dataSale.push(Header);
			$.post('${getSubCatListForChart}', {
				ajax : 'true'
			}, function(chartsdata) {
				//alert(JSON.stringify(chartsdata));
				//	console.log('data ' + JSON.stringify(chartsdata));
				var len = chartsdata.length;
				datag = datag + '[';
				$.each(chartsdata, function(key, chartsdata) {
					var temp = [];
					temp.push(chartsdata.subCatName + " ("
							+ (parseFloat(chartsdata.total).toFixed(2))
							+ ")", (parseFloat(chartsdata.total)),
							parseInt(chartsdata.subCatId));
					dataSale.push(temp);

				});

				//console.log(dataSale);
				var data1 = google.visualization.arrayToDataTable(dataSale);

				var options = {
					title : 'Sub-category wise sale(%)',
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
						.getElementById('donutchart'));

				function selectQtyHandler() {
					// alert("hii");
					var selectedItem = chart.getSelection()[0];
					if (selectedItem) {
						// alert("hii selectedItem");
						i = selectedItem.row, 0;

						//alert("hii selectedItem" + chartsdata[i].subCatId);
						getItemListBySubCatId(chartsdata[i].subCatId,chartsdata[i].subCatName);

					}
				}

				google.visualization.events.addListener(chart, 'select',
						selectQtyHandler);
				chart.draw(data1, options);

			});

		}
	</script>

	<script type="text/javascript">
		function drawGraph() {

			google.charts.load("current", {
				packages : [ "corechart" ]
			});
			google.charts.setOnLoadCallback(drawDonutChart);

			google.charts.load('current', {
				'packages' : [ 'corechart', 'line' ]
			});
			google.charts.setOnLoadCallback(drawStuff1); 

			var type = $
			{
				type
			}
			;


		}
	</script>




	<script type="text/javascript">
		function getItemListBySubCatId(id,name) {
			

			var chart;
			var datag = '';
			var a = "";
			var dataSale = [];
			var Header = [ 'Category', 'Amount', 'ID' ];
			dataSale.push(Header);
			
			$.post('${getItemListForChart}', {
				subCatId : id,
				ajax : 'true'
			}, function(chartsdata) {

				
				
				var len = chartsdata.length;
				datag = datag + '[';
				$.each(chartsdata, function(key, chartsdata) {
					var temp = [];
					temp.push(chartsdata.itemName + " ("
							+ (parseFloat(chartsdata.total).toFixed(2))
							+ ")", (parseFloat(chartsdata.total)),
							parseInt(chartsdata.itemId));
					dataSale.push(temp);

				});

				//console.log(dataSale);
				var data1 = google.visualization.arrayToDataTable(dataSale);

				var title=name+" Item wise sale(%)";
				
				var options = {
					title : title,
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
					var selectedItem = chart.getSelection()[0];
					if (selectedItem) {
						i = selectedItem.row, 0;

						drawStuff(chartsdata[i].itemId);
						drawStuffFr(chartsdata[i].itemId)

					}
				}

				google.visualization.events.addListener(chart, 'select',
						selectQtyHandler); 
				chart.draw(data1, options);
			

			});
		}
	</script>


	<script type="text/javascript">
		function drawStuff(id) {
			
			
			var selectedFr = $("#selectFr").val();
			var type_id = $("#type_id").val();
			var selectedCat = $("#selectCat").val();
			var type= $("#type").val();
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();
          
          	var dairyId = $("#dairyId").val();
          
      		var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;
			} else {
				billType = 2;
			}
			
			var chartDiv = document.getElementById('chart_div');
			document.getElementById("chart_div").style.border = "thin dotted red";
			
			var dataTable = new google.visualization.DataTable();

			dataTable.addColumn('string', 'Date'); // Implicit domain column.
			dataTable.addColumn('number', 'Amount'); // Implicit data column.

			$.post('${getDateWiseSaleForItem}', {
				fr_id_list : JSON.stringify(selectedFr),
				fromDate : from_date,
				toDate : to_date,
				cat_id_list : JSON.stringify(selectedCat),
				type_id : JSON.stringify(type_id),
				billType : billType,
				dairy : dairyId,
				itemId : id,
				ajax : 'true'
			}, function(chartsBardata) {

				$.each(chartsBardata, function(key, chartsBardata) {

					dataTable.addRows([ [ chartsBardata.billDate,
							parseInt(chartsBardata.total) ] ]);

				});

				//alert(11);

				var materialOptions = {
					width : 900,
					height : 500,
					chart : {
						title : 'Sell Amount By Date',
						subtitle : ' '
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
								label : 'Sell Amount'
							}, // Left y-axis.
							brightness : {
								side : 'right',
								label : 'Date'
							}
						// Right y-axis.
						}
					}
				};

				//var materialChart = new google.charts.Bar(chartDiv);
				var materialChart = new google.charts.Line(chartDiv);

				function drawMaterialChart() {
					// var materialChart = new google.charts.Bar(chartDiv);
					// google.visualization.events.addListener(materialChart, 'select', selectHandler);    
					materialChart.draw(dataTable, google.charts.Line
							.convertOptions(materialOptions));
					// button.innerText = 'Change to Classic';
					// button.onclick = drawClassicChart;
				}

				drawMaterialChart();

			});

		}
	</script>

	<script type="text/javascript">
		function drawStuffFr(id) {
			
			
			var selectedFr = $("#selectFr").val();
			var type_id = $("#type_id").val();
			var selectedCat = $("#selectCat").val();
			var type= $("#type").val();
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();
          
          	var dairyId = $("#dairyId").val();
          
      		var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;
			} else {
				billType = 2;
			}
			
			var chartDiv = document.getElementById('chart_div1');
			document.getElementById("chart_div1").style.border = "thin dotted red";
			
			var dataTable = new google.visualization.DataTable();

			dataTable.addColumn('string', 'Date'); // Implicit domain column.
			dataTable.addColumn('number', 'Amount'); // Implicit data column.

			$.post('${getFrWiseSaleForItem}', {
				fr_id_list : JSON.stringify(selectedFr),
				fromDate : from_date,
				toDate : to_date,
				cat_id_list : JSON.stringify(selectedCat),
				type_id : JSON.stringify(type_id),
				billType : billType,
				dairy : dairyId,
				itemId : id,
				ajax : 'true'
			}, function(chartsBardata) {

				$.each(chartsBardata, function(key, chartsBardata) {

					dataTable.addRows([ [ chartsBardata.frName,
							parseInt(chartsBardata.total) ] ]);

				});

				//alert(11);

				var materialOptions = {
					width : 900,
					height : 500,
					chart : {
						title : 'Sell Amount By Franchisee',
						subtitle : ' '
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
								label : 'Sell Amount'
							}, // Left y-axis.
							brightness : {
								side : 'right',
								label : 'Franchisee'
							}
						// Right y-axis.
						}
					}
				};

				//var materialChart = new google.charts.Bar(chartDiv);
				var materialChart = new google.charts.Line(chartDiv);

				function drawMaterialChart() {
					// var materialChart = new google.charts.Bar(chartDiv);
					// google.visualization.events.addListener(materialChart, 'select', selectHandler);    
					materialChart.draw(dataTable, google.charts.Line
							.convertOptions(materialOptions));
					// button.innerText = 'Change to Classic';
					// button.onclick = drawClassicChart;
				}

				drawMaterialChart();

			});

		}
	</script>


	<script type="text/javascript">
		function drawStuff1() {
			var chartDiv = document.getElementById('chart_div');
			document.getElementById("chart_div").style.border = "thin dotted red";
		}
	</script>







	<script type="text/javascript">
		
		function addCommas(x){

			x=String(x).toString();
			 var afterPoint = '';
			 if(x.indexOf('.') > 0)
			    afterPoint = x.substring(x.indexOf('.'),x.length);
			 x = Math.floor(x);
			 x=x.toString();
			 var lastThree = x.substring(x.length-3);
			 var otherNumbers = x.substring(0,x.length-3);
			 if(otherNumbers != '')
			     lastThree = ',' + lastThree;
			 return otherNumbers.replace(/\B(?=(\d{2})+(?!\d))/g, ",") + lastThree + afterPoint;
			} 
		
		</script>


	<script type="text/javascript">
	function validate() {

		var selectedFr = $("#selectFr").val();
		var selectedRoute = $("#selectRoute").val();
		var selectedCat = $("#selectCat").val();


		var isValid = true;
		
		if ((selectedFr == "" || selectedFr == null ) && (selectedRoute==0)) { 

				alert("Please Select Route  Or Franchisee");
				isValid = false;
		
		}else if (selectedCat == "" || selectedCat == null) { 

			alert("Please Select Category");
			isValid = false;
	
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


	<script type="text/javascript">
			function genPdf() {
				var from_date = $("#fromDate").val();
				var to_date = $("#toDate").val();
				var selectedFr = $("#selectFr").val();
				var routeId = $("#selectRoute").val();
				var isGraph = 0;
				var selectedCat = $("#selectCat").val();
				var getBy= $("#getBy").val();
				var type= $("#type").val();
				var typeId = $("#type_id").val();
				var dairyId = $("#dairyId").val();
	            var selectedSort = $("#selectSort").val();
				
				var billType = 1;
				if (document.getElementById("rd1").checked == true) {
					billType = 1;
				} else {
					billType = 2;
				}

				window.open('pdfForReport?url=pdf/getSaleReportRoyConsoByCatPdf/'
						+ from_date + '/' + to_date+'/'+selectedFr+'/'+routeId+'/'+selectedCat+'/'+isGraph+'/'+getBy+'/'+type+'/'+typeId+'/'+billType+'/'+dairyId+'/'+selectedSort);

			}
			function exportToExcel()
			{
				 
				window.open("${pageContext.request.contextPath}/exportToExcelNew");
						document.getElementById("expExcel").disabled=true;
			}
			
			
		</script>
	<script type="text/javascript">
function tableToExcel(table, name, filename) {
        let uri = 'data:application/vnd.ms-excel;base64,', 
        template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><title></title><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>', 
        base64 = function(s) { return window.btoa(decodeURIComponent(encodeURIComponent(s))) },         format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; })}
        
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}

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