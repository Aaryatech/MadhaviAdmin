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
	<c:url var="getGrnGvnByGrpByFr" value="/getGrnGvnByGrpByFr"></c:url>

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
					<i class="fa fa-file-o"></i>Grn Gvn Report By Franchise
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
					<i class="fa fa-bars"></i>View Grn Gvn Franchise wise
				</h3>

			</div>
			<form id="submitDumpOrderForm"
				action="${pageContext.request.contextPath}/creditNoteReportBetweenDate"
				method="get">
				<div class="box-content">
					<div class="row">


						<div class="form-group">
							<label class="col-sm-3 col-lg-2	 control-label">From Date</label>
							<div class="col-sm-6 col-lg-4 controls date_select">
								<input class="form-control date-picker" id="fromDate"
									name="fromDate" size="30" type="text" value="${fromDate}"
									placeholder="From Date" />
							</div>

							<!-- </div>

					<div class="form-group  "> -->

							<label class="col-sm-3 col-lg-2	 control-label">To Date</label>
							<div class="col-sm-6 col-lg-4 controls date_select">
								<input class="form-control date-picker" id="toDate"
									name="toDate" size="30" type="text" value="${toDate}"
									placeholder="To Date" />
							</div>
						</div>

					</div>


					<br>

					<!-- <div class="col-sm-9 col-lg-5 controls">
 -->
					<div class="row">
						<div class="form-group">
							<%-- <label class="col-sm-3 col-lg-2 control-label">Select
							Route</label>
						<div class="col-sm-6 col-lg-4 controls">
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

						</div> --%>

							<label class="col-sm-3 col-lg-2 control-label">Select
								Franchisee</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose Franchisee"
									class="form-control chosen" id="selectFr" name="selectFr">

									<option value="0"><c:out value="All" /></option>

									<c:forEach items="${unSelectedFrList}" var="fr"
										varStatus="count">
										<c:choose>
											<c:when test="${frId==fr.frId}">
												<option value="${fr.frId}" selected><c:out
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
						</div>
					</div>

					<br>
					<div class="row">
						<label class="col-sm-3 col-lg-2 control-label"> </label>
						<div class="col-md-2"></div>


						<div class="col-md-3" style="text-align: center;">
							<!-- <input class="btn btn-info" value="Search Report" type="submit"> -->
							<button class="btn btn-primary" value="PDF" id="PDFButton"
								onclick="genPdf()">PDF</button>

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
			</form>
		</div>
		<div class="box-content" style="background-color: white;">

			<div class="">
				<!-- <div class="box-title">
				<h3>
					<i class="fa fa-list-alt"></i>Grn Gvn Report
				</h3>

			</div> -->

				<form id="submitBillForm" method="post">

					<div class="col-md-12 table-responsive">
						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f3b5db;">
								<tr>
									<th>Sr.No.</th>
									<th>Doc No.</th>
									<th>Date</th>
									<th>QTY</th>
									<th>UOM</th>
									<th>Rate</th>
									<th>Penalty AMT</th>
									<th>Credit AMT</th>

								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
						<div class="form-group" id="range">



							<div class="col-sm-3  controls">
								<!-- <input type="button" id="expExcel" class="btn btn-primary"
									value="EXPORT TO Excel" onclick="exportToExcel();"
									disabled="disabled"> -->
							</div>
						</div>
						<div align="center" id="showchart" style="display: none"></div>
					</div>



					<div id="chart"">
						<br> <br> <br>
						<hr>

						<!-- <table class="columns">
      <tr>
        <td><div id="chart_div" style="width: 50%" ></div></td>
        <td><div id="PieChart_div" style="width: 50%"></div></td>
      </tr>
    </table> -->

						<div id="chart_div" style="width: 100%; height: 100%;"></div>


						<div id="PieChart_div" style="width: 100%; height: 100%;"></div>


					</div>
				</form>
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
		function searchReport() {
			//	var isValid = validate();
			document.getElementById('chart').style.display = "display:none";
			document.getElementById("table_grid").style = "block";
			var isGrn = $("#isGrn").val();
			//alert("isGrn " +isGrn);

			//report 2
			var selectedFr = $("#selectFr").val();
			var routeId = $("#selectRoute").val();

			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			var totalReqQty = 0;
			var totalReqAmt = 0;
			var totalAprQty = 0;
			var totalAprValue = 0;

			$('#loader').show();

			$.getJSON('${getGrnGvnByGrpByFr}',

			{
				fr_id_list : JSON.stringify(selectedFr),
				from_date : from_date,
				to_date : to_date,
				route_id : routeId,
				is_grn : isGrn,
				ajax : 'true'

			}, function(data) {
				//alert(data);

				$('#table_grid td').remove();
				$('#loader').hide();

				if (data == "") {
					alert("No records found !!");
					document.getElementById("expExcel").disabled = true;
				}

				$.each(data, function(key, report) {

					totalReqQty = totalReqQty + report.reqQty;
					totalReqAmt = totalReqAmt + report.totalAmt;
					totalAprQty = totalAprQty + report.aprQty;
					totalAprValue = totalAprValue + report.aprGrandTotal;

					document.getElementById("expExcel").disabled = false;
					document.getElementById('range').style.display = 'block';

					var index = key + 1;
					//var tr = "<tr>";

					var type = null;
					if (report.isGrn == 0)
						type = "GVN";
					else if (report.isGrn == 1)
						type = "GRN";
					else
						type = "Cust Complaint";

					var tr = $('<tr></tr>');
					tr.append($('<td></td>').html(key + 1));
					tr.append($('<td></td>').html(type));
					tr.append($('<td></td>').html(report.frName));
					tr.append($('<td style="text-align:right;"></td>').html(
							report.reqQty.toFixed(2)));
					tr.append($('<td style="text-align:right;"></td>').html(
							report.totalAmt.toFixed(2)));
					tr.append($('<td style="text-align:right;"></td>').html(
							report.aprQty.toFixed(2)));
					tr.append($('<td style="text-align:right;"></td>').html(
							report.aprGrandTotal.toFixed(2)));

					$('#table_grid tbody').append(tr);

				})

				var tr = $('<tr></tr>');

				tr.append($('<td></td>').html(""));
				tr.append($('<td></td>').html(""));
				tr.append($('<td style="font-weight:bold;"></td>')
						.html("Total"));
				tr.append($('<td  style="text-align:right;"></td>').html(
						totalReqQty.toFixed(2)));
				tr.append($('<td  style="text-align:right;"></td>').html(
						totalReqAmt.toFixed(2)));
				tr.append($('<td  style="text-align:right;"></td>').html(
						totalAprQty.toFixed(2)));
				tr.append($('<td  style="text-align:right;"></td>').html(
						totalAprValue.toFixed(2)));

				$('#table_grid tbody').append(tr);

			});

		}
	</script>
	<script type="text/javascript">
		function validate() {

			var selectedFr = $("#selectFr").val();
			var isGrn = $("#isGrn").val();
			var selectedRoute = $("#selectRoute").val();

			var isValid = true;

			if (selectedFr == "" || selectedFr == null) {

				if (selectedRoute == "0" || selectedRoute == null) {
					alert("Please Select Franchise or Route ");
					isValid = false;
				}
				//alert("Please select Franchise/Route");

			} else if (isGrn == "-1" || isGrn == null) {

				isValid = false;
				alert("Please select Option");

			}
			return isValid;

		}
	</script>







	<script type="text/javascript">
		function showChart() {
			$("#PieChart_div").empty();
			$("#chart_div").empty();
			document.getElementById('chart').style.display = "block";
			document.getElementById("table_grid").style = "display:none";

			var isGrn = $("#isGrn").val();
			//alert("isGrn " +isGrn);

			//report 2
			var selectedFr = $("#selectFr").val();
			var routeId = $("#selectRoute").val();

			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			$('#loader').show();

			$
					.getJSON(
							'${getGrnGvnByGrpByFr}',

							{
								fr_id_list : JSON.stringify(selectedFr),
								from_date : from_date,
								to_date : to_date,
								route_id : routeId,
								is_grn : isGrn,
								ajax : 'true'

							},
							function(data) {

								//alert(data);
								if (data == "") {
									alert("No records found !!");

									$('#loader').hide();

								}
								var i = 0;
								$('#loader').hide();

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
									dataTable.addColumn('string',
											'Franchise Name'); // Implicit domain column.
									dataTable.addColumn('number',
											'Requested Value'); // Implicit data column.
									dataTable.addColumn('number',
											'Approved Value');

									var piedataTable = new google.visualization.DataTable();
									piedataTable.addColumn('string',
											'Franchise Name'); // Implicit domain column.
									piedataTable.addColumn('number',
											'Approved Value');

									$.each(data, function(key, report) {

										// alert("In Data")
										var reqValue = report.totalAmt;
										var aprValue = report.aprGrandTotal;

										var frName = report.frName;

										dataTable.addRows([

										[ frName, reqValue, aprValue ],

										]);

										piedataTable.addRows([

										[ frName, aprValue ],

										]);
									}) // end of  $.each(data,function(key, report) {-- function

									// Instantiate and draw the chart.

									var materialOptions = {

										width : 500,
										chart : {
											title : 'Fr wise Grn Gvn Report',
											subtitle : 'Requested and Approved Value',

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
													label : 'Req Value'
												}, // Left y-axis.
												brightness : {
													side : 'right',
													label : 'Approved Value'
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
									chart.draw(dataTable, {
										title : 'Fr wise Grn Gvn Report'
									});

									Piechart.draw(piedataTable, {
										title : 'Fr wise Grn Gvn Report',
										is3D : true
									});
									// drawMaterialChart();
								}
								;

							});

		}

		function genPdf() {
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();
			var selectedFr = $("#selectFr").val();

			window
					.open('${pageContext.request.contextPath}/creditNoteReportBetweenDatePdf?fromDate='
							+ from_date + '&toDate=' + to_date + '&selectedFr='+selectedFr);

		}
		function exportToExcel() {

			window.open("${pageContext.request.contextPath}/exportToExcel");
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