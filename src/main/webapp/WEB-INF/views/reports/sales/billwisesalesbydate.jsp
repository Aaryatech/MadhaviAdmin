<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getBillList" value="/getSaleBillwise"></c:url>
	<c:url var="getAllCatByAjax" value="/getAllCatByAjax"></c:url>
	<c:url var="getFrListofAllFr" value="/getFrListForDatewiseReport"></c:url>


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
					<i class="fa fa-file-o"></i>Bill wise Sale Report
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
				<li class="active">Bill-wise Report</li>
			</ul>
		</div>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Bill wise Sale Report
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
							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type Option</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									multiple="multiple" tabindex="6" id="type_id" name="type_id">
									<%-- <option value="-1"><c:out value="All" /></option> --%>
									<option value="1" selected="selected">Franchisee Bill</option>
									<option value="2" selected="selected">Delivery Challan</option>
									<!-- <option value="3">Company Outlet Bill</option> -->
								</select>

							</div>
							<br> <br>
						</div>

						<div id="configTypeDiv" style="display: none;">
							<label class="col-sm-3 col-lg-2 control-label">Retail Outlet Type</label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Choose " class="form-control chosen"
									tabindex="6" id="configType" name="configType">
									<option value="0" selected="selected"><c:out
											value="All" /></option>
									<option value="1">POS</option>
									<option value="2">Online</option>
								</select>

							</div>
							<br> <br>
						</div>


					</div>
				</div>

				<div class="row" style="display: none;">
					<div class="col-md-2" style="display: none;">Select Category</div>
					<div class="col-md-4" style="text-align: left; display: none;">
						<select data-placeholder="Select Group"
							class="form-control chosen" name="item_grp1" tabindex="-1"
							id="item_grp1" data-rule-required="true"
							onchange="setCatOptions(this.value)" multiple="multiple">
							<option value="-1">Select All</option>

							<c:forEach items="${mCategoryList}" var="mCategoryList">
								<option value="${mCategoryList.catId}"><c:out
										value="${mCategoryList.catName}"></c:out></option>
							</c:forEach>


						</select>
					</div>


				</div>
				<div class="row">
					<br>

					<div class="col-md-12" style="text-align: center;">
						<button class="btn btn-info" onclick="searchReport()">Search
							Billwise Report</button>
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
		</div>


		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-list-alt"></i>Bill wise Sale Report
				</h3>

			</div>

			<form id="submitBillForm"
				action="${pageContext.request.contextPath}/submitNewBill"
				method="post">
				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid">
								<thead style="background-color: #f95d64;">
									<tr>
										<th>Sr.No.</th>
										<th>Bill No</th>
										<th>Date</th>
										<th>Party Name</th>
										<!-- <th>City</th> -->
										<th>GSTIN</th>
										<th id="custTh" style="display: none;">Customer</th>
										<th>Basic Value</th>
										<th>CGST</th>
										<th>SGST</th>
										<th>IGST</th>
										<th>Disc %</th>
										<th>Disc Amt</th>
										<th>Round Off</th>
										<th>Total</th>

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
			</form>
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
		function setCatOptions(catId) {
			if (catId == -1) {
				$.getJSON('${getAllCatByAjax}', {
					ajax : 'true'
				}, function(data) {
					var len = data.length;
					$('#item_grp1').find('option').remove().end()

					$("#item_grp1").append(
							$("<option ></option>").attr("value", -1).text(
									"Select All"));

					for (var i = 0; i < len; i++) {

						$("#item_grp1").append(
								$("<option selected></option>").attr("value",
										data[i].catId).text(data[i].catName));
					}

					$("#item_grp1").trigger("chosen:updated");
				});
			}
		}
	</script>

	<script type="text/javascript">
		function searchReport() {
			//	var isValid = validate();

			var selectedFr = $("#selectFr").val();
			var selectedCat = $("#item_grp1").val();

			var routeId = $("#selectRoute").val();

			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			var typeId = $("#type_id").val();
			var dairyMartType = $("#dairy_id").val();
			//alert(dairyMartType);
			
			var configType=document.getElementById("configType").value;

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
				} else {
					isValid = 1;
				}

			} else if (dairyMartType == null) {
				alert("Please select Regular or Dairy Mart Type");
				isValid = 0;
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
									cat_id_list : JSON.stringify(selectedCat),
									fromDate : from_date,
									toDate : to_date,
									route_id : routeId,
									typeId : JSON.stringify(typeId),
									billType : billType,
									dairyMartType : JSON
											.stringify(dairyMartType),
									configType : configType,
									ajax : 'true'

								},
								function(data) {
									$('#loader').hide();

									$('#table_grid td').remove();
									

									if (data == "") {
										alert("No records found !!");
										document.getElementById("expExcel").disabled = true;
									}

									if (billType == 2) {
										document.getElementById("custTh").style.display = "block";
									} else {
										document.getElementById("custTh").style.display = "none";
									}

									var totalIgst = 0;
									var totalSgst = 0;
									var totalCgst = 0;
									var totalBasicValue = 0;
									var totalRoundOff = 0;
									var totalFinal = 0;

									var totDiscAmt = 0;

									$
											.each(
													data,
													function(key, report) {

														if (report.isSameState == 0) {
															totalIgst = totalIgst
																	+ report.igstSum;
														}

														totalSgst = totalSgst
																+ report.sgstSum;
														totalCgst = totalCgst
																+ report.cgstSum;
														totalBasicValue = totalBasicValue
																+ report.taxableAmt;
														totalRoundOff = totalRoundOff
																+ report.roundOff;

														totDiscAmt = totDiscAmt
																+ report.discAmt;

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
																				report.invoiceNo));

														tr
																.append($(
																		'<td></td>')
																		.html(
																				report.billDate));

														tr
																.append($(
																		'<td></td>')
																		.html(
																				report.frName));

														/* tr
																.append($(
																		'<td></td>')
																		.html(
																				report.frCity)); */

														tr
																.append($(
																		'<td></td>')
																		.html(
																				report.frGstNo));

														if (billType == 2) {
															tr
																	.append($(
																			'<td></td>')
																			.html(
																					report.custName));
														}

														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				addCommas(report.taxableAmt
																						.toFixed(2))));

														if (report.isSameState == 1) {
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.cgstSum
																							.toFixed(2))));
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.sgstSum
																							.toFixed(2))));
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					0));
														} else {
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					0));
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					0));
															tr
																	.append($(
																			'<td style="text-align:right;"></td>')
																			.html(
																					addCommas(report.igstSum
																							.toFixed(2))));
														}
														//tr.append($('<td></td>').html(report.igstSum));

														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				report.discPer
																						.toFixed(2)));

														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				report.discAmt
																						.toFixed(2)));

														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				report.roundOff));
														var total;

														if (report.isSameState == 1) {
															if (report.taxApplicable == 2) {
																total = parseFloat(report.taxableAmt)
																		+ parseFloat(report.cgstSum
																				+ report.sgstSum)
																		+ parseFloat(report.discAmt);

															} else {
																total = parseFloat(report.taxableAmt)
																		+ parseFloat(report.cgstSum
																				+ report.sgstSum);

															}
														} else {

															if (report.taxApplicable == 2) {
																total = report.taxableAmt
																		+ report.igstSum
																		+ parseFloat(report.discAmt);

															} else {
																total = report.taxableAmt
																		+ report.igstSum;

															}

														}

														totalFinal = totalFinal
																+ total;

														tr
																.append($(
																		'<td style="text-align:right;"></td>')
																		.html(
																				addCommas(total
																						.toFixed(2))));

														$('#table_grid tbody')
																.append(tr);

													})

									var tr = $('<tr></tr>');

									tr.append($('<td></td>').html(""));
									tr.append($('<td></td>').html(""));
									tr.append($('<td></td>').html(""));
									tr.append($('<td></td>').html(""));
									/* tr.append($('<td></td>').html("")); */
									tr
											.append($(
													'<td style="font-weight:bold;"></td>')
													.html("Total"));
									if (billType == 2) {
										tr.append($('<td></td>').html(""));
									}
									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totalBasicValue
																	.toFixed(2))));
									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totalCgst
																	.toFixed(2))));
									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totalSgst
																	.toFixed(2))));
									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totalIgst
																	.toFixed(2))));

									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(""));

									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totDiscAmt
																	.toFixed(2))));

									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totalRoundOff
																	.toFixed(2))));
									tr
											.append($(
													'<td style="text-align:right;font-weight:bold;"></td>')
													.html(
															addCommas(totalFinal
																	.toFixed(2))));

									$('#table_grid tbody').append(tr);

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

	<script>
		function setAllFrSelected(frId) {
			//alert("frId" + frId);
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
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();
			var selectedFr = $("#selectFr").val();
			var routeId = $("#selectRoute").val();
			var selectedCat = $("#item_grp1").val();

			var typeIdList = $("#type_id").val();

			var dairyMartType = $("#dairy_id").val();
			
			var configType=document.getElementById("configType").value;

			var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;

			} else {
				billType = 2;
			}

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/showSaleReportByDatePdf/'
							+ from_date
							+ '/'
							+ to_date
							+ '/'
							+ selectedFr
							+ '/'
							+ routeId
							+ '/'
							+ selectedCat
							+ '/'
							+ typeIdList
							+ '/'
							+ billType
							+ '/'
							+ dairyMartType							
							+ '/'
							+configType);

			//window.open("${pageContext.request.contextPath}/pdfForReport?url=showSaleReportByDatePdf/"+from_date+"/"+to_date);

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

	<!--basic scripts-->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('_$tag_________________________________________________________________________________________$tag_____')
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