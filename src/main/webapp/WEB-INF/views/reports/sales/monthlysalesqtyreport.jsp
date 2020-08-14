<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body onload="billTypeSelection(${billType})">

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getBillList" value="/getSaleBillwise"></c:url>
	<c:url var="getAllCatByAjax" value="/getAllCatByAjax"></c:url>



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
					<i class="fa fa-file-o"></i>Monthly Sales Return Quantity Wise Report
				</h1>
				<h4></h4>
			</div>
		</div> -->
		<!-- END Page Title -->

		<!-- BEGIN Breadcrumb -->

		<!-- END Breadcrumb -->
		<form id="submitBillForm"
			action="${pageContext.request.contextPath}/showMonthlySalesQtyWiseReport"
			method="get">
			<!-- BEGIN Main Content -->
			<div class="box">
				<div class="box-title">
					<h3>
						<i class="fa fa-bars"></i>Monthly Sales Return Quantity Wise
						Report
					</h3>

				</div>

				<div class="box-content">
					<div class="row">


						<div class="form-group">
							<label class="col-sm-3 col-lg-2 control-label">Year</label>
							<div class="col-sm-6 col-lg-3 controls date_select">
								<select id="year" name="year" class="form-control">

									<option value="2019-2020">2019-2020</option>
									<option value="2020-2021">2020-2021</option>
									<option value="2021-2022">2021-2022</option>
								</select>
							</div>

							<div class="col-sm-6 col-lg-1"></div>


							<label class="col-sm-3 col-lg-2 control-label">Select
								Bill Type</label>
							<div class="col-sm-6 col-lg-4">

								<input type="radio" id="rd1" name="rd" value="1"
									${billType==1 ? 'checked' : ''} checked="checked"
									onchange="billTypeSelection(this.value)">&nbsp;Fr.
								Bills & Del. Challan &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
									type="radio" id="rd2" name="rd" value="2"
									${billType==2 ? 'checked' : ''}
									onchange="billTypeSelection(this.value)">&nbsp;Retail
								Outlet Bills

							</div>

						</div>
					</div>


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

										<c:choose>

											<c:when test="${typeIds == '1'}">
												<option value="1" selected="selected">Franchisee
													Bill</option>
												<option value="2">Delivery Challan</option>
											</c:when>
											<c:when test="${typeIds == '2'}">
												<option value="1">Franchisee Bill</option>
												<option value="2" selected="selected">Delivery
													Challan</option>
											</c:when>


											<c:otherwise>
												<option value="1" selected="selected">Franchisee
													Bill</option>
												<option value="2" selected="selected">Delivery
													Challan</option>
											</c:otherwise>

										</c:choose>


									</select>

								</div>
							</div>

							<div id="dairyDiv" style="display: none;">
								<br> <label class="col-sm-3 col-lg-2 control-label">Retail
									Outlet Type</label>
								<div class="col-sm-6 col-lg-4">

									<select data-placeholder="Choose " class="form-control chosen"
										tabindex="6" id="configType" name="configType">
										<option value="0" ${configType==0 ? 'checked' : ''}><c:out
												value="All" /></option>
										<option value="1" ${configType==1 ? 'checked' : ''}>POS</option>
										<option value="2" ${configType==2 ? 'checked' : ''}>Online</option>
									</select>

								</div>

								<label class="col-sm-3 col-lg-2 control-label">Select
									Type</label>
								<div class="col-sm-6 col-lg-4">
									<select data-placeholder="Choose " class="form-control chosen"
										multiple="multiple" tabindex="6" id="dairy_id" name="dairy_id">

										<c:choose>

											<c:when test="${dairy == '1'}">
												<option value="1" selected="selected">Regular</option>
												<option value="2">Is Dairy Mart</option>
											</c:when>
											<c:when test="${dairy == '2'}">
												<option value="1">Regular</option>
												<option value="2" selected="selected">Is Dairy Mart</option>
											</c:when>


											<c:otherwise>
												<option value="1" selected="selected">Regular</option>
												<option value="2" selected="selected">Is Dairy Mart</option>
											</c:otherwise>

										</c:choose>


									</select>
								</div>
							</div>

						</div>
					</div>
					<br>
					<div class="row">
						<div class="form-group" style="text-align: center;">
							<input type="submit" id="submit" class="btn btn-primary"
								value="Search">
						</div>
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



			<div class="box">
				<div class="box-title">
					<h3>
						<i class="fa fa-list-alt"></i>Monthly Sales Return Quantity Wise
						Report
					</h3>

				</div>


				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive"
							style="overflow: scroll; overflow: auto;">


							<c:choose>

								<c:when test="${billType==1}">

									<table class="table table-bordered table-striped fill-head "
										style="width: 100%; overflow: scroll; overflow: auto;"
										id="table_grid">
										<thead style="background-color: #f95d64;">
											<tr>
												<th rowspan="2">Sr.</th>
												<th rowspan="2">Group Name</th>
												<c:forEach var="report" items="${salesReturnQtyReport}"
													varStatus="cnt">
													<th colspan="4" style="text-align: center;">${report.value.month}</th>
												</c:forEach>
												<th colspan="4">Total II HALF</th>
											</tr>
											<tr>
												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GVN Qty</th>
												<th>GRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>GRN Qty</th>
												<th>GVN Qty</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="finalBillQty" value="0.0" />
											<c:set var="finalGrnQty" value="0.0" />
											<c:set var="finalGvnQty" value="0.0" />
											<c:forEach items="${subCatList}" var="subCatList"
												varStatus="count">
												<c:set var="billQty" value="0.0" />
												<c:set var="grnQty" value="0.0" />
												<c:set var="gvnQty" value="0.0" />
												<tr>
													<td>${count.index+1}</td>
													<td>${subCatList.subCatName}</td>
													<c:forEach var="report" items="${salesReturnQtyReport}"
														varStatus="cnt">

														<c:forEach var="rep"
															items="${report.value.salesReturnQtyDaoList}"
															varStatus="cnt1">

															<c:choose>
																<c:when test="${rep.subCatId==subCatList.subCatId}">
																	<td style="text-align: right;">${rep.billQty}</td>
																	<td style="text-align: right;">${rep.gvnQty}</td>
																	<td style="text-align: right;">${rep.grnQty}</td>
																	<td style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			maxFractionDigits="2"
																			value="${rep.billQty-(rep.gvnQty+rep.grnQty)}" /></td>
																	<c:set var="billQty" value="${billQty+rep.billQty}" />
																	<c:set var="grnQty" value="${rep.grnQty+grnQty}" />
																	<c:set var="gvnQty" value="${rep.gvnQty+gvnQty}" />
																</c:when>
																<c:otherwise>

																</c:otherwise>
															</c:choose>

														</c:forEach>
													</c:forEach>
													<td style="text-align: right;"><fmt:formatNumber
															type="number" minFractionDigits="2" maxFractionDigits="2"
															value="${billQty}" /></td>
													<td style="text-align: right;">${grnQty}</td>
													<td style="text-align: right;">${gvnQty}</td>
													<c:set var="finalBillQty" value="${finalBillQty+billQty}" />
													<c:set var="finalGrnQty" value="${grnQty+finalGrnQty}" />
													<c:set var="finalGvnQty" value="${gvnQty+finalGvnQty}" />
												</tr>
											</c:forEach>
											<tr>
												<th rowspan="2"></th>
												<th rowspan="2">Total</th>
												<c:forEach var="report" items="${salesReturnQtyReport}"
													varStatus="cnt">
													<th style="text-align: right;">${report.value.totBillQty}</th>

													<th style="text-align: right;">${report.value.totGvnQty}</th>
													<th style="text-align: right;">${report.value.totGrnQty}</th>
													<th style="text-align: right;"><fmt:formatNumber
															type="number" minFractionDigits="2" maxFractionDigits="2"
															value="${report.value.totBillQty-(report.value.totGrnQty+report.value.totGvnQty)}" />
													</th>

												</c:forEach>
												<th style="text-align: right;"><fmt:formatNumber
														type="number" minFractionDigits="2" maxFractionDigits="2"
														value="${finalBillQty}" /></th>
												<th style="text-align: right;">${finalGrnQty}</th>
												<th style="text-align: right;">${finalGvnQty}</th>
											</tr>
										</tbody>
									</table>

								</c:when>
								<c:otherwise>

									<table class="table table-bordered table-striped fill-head "
										style="width: 100%; overflow: scroll; overflow: auto;"
										id="table_grid">
										<thead style="background-color: #f95d64;">
											<tr>
												<th rowspan="2">Sr.</th>
												<th rowspan="2">Group Name</th>
												<c:forEach var="report" items="${salesReturnQtyReport}"
													varStatus="cnt">
													<th colspan="3" style="text-align: center;">${report.value.month}</th>
												</c:forEach>
												<th colspan="2">Total II HALF</th>
											</tr>
											<tr>
												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
												<th>Total</th>

												<th>Gross Sale</th>
												<th>CRN Qty</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="finalBillQty" value="0.0" />
											<c:set var="finalGrnQty" value="0.0" />
											<c:set var="finalGvnQty" value="0.0" />
											<c:forEach items="${subCatList}" var="subCatList"
												varStatus="count">
												<c:set var="billQty" value="0.0" />
												<c:set var="grnQty" value="0.0" />
												<c:set var="gvnQty" value="0.0" />
												<tr>
													<td>${count.index+1}</td>
													<td>${subCatList.subCatName}</td>
													<c:forEach var="report" items="${salesReturnQtyReport}"
														varStatus="cnt">

														<c:forEach var="rep"
															items="${report.value.salesReturnQtyDaoList}"
															varStatus="cnt1">

															<c:choose>
																<c:when test="${rep.subCatId==subCatList.subCatId}">
																	<td style="text-align: right;">${rep.billQty}</td>
																	<td style="text-align: right;">${rep.grnQty}</td>
																	<td style="text-align: right;"><fmt:formatNumber
																			type="number" minFractionDigits="2"
																			maxFractionDigits="2"
																			value="${rep.billQty-(rep.gvnQty+rep.grnQty)}" /></td>
																	<c:set var="billQty" value="${billQty+rep.billQty}" />
																	<c:set var="grnQty" value="${rep.grnQty+grnQty}" />
																	<c:set var="gvnQty" value="${rep.gvnQty+gvnQty}" />
																</c:when>
																<c:otherwise>

																</c:otherwise>
															</c:choose>

														</c:forEach>
													</c:forEach>
													<td style="text-align: right;"><fmt:formatNumber
															type="number" minFractionDigits="2" maxFractionDigits="2"
															value="${billQty}" /></td>
													<td style="text-align: right;"><fmt:formatNumber
															type="number" minFractionDigits="2" maxFractionDigits="2"
															value="${grnQty}" /></td>
													<c:set var="finalBillQty" value="${finalBillQty+billQty}" />
													<c:set var="finalGrnQty" value="${grnQty+finalGrnQty}" />
													<c:set var="finalGvnQty" value="${gvnQty+finalGvnQty}" />
												</tr>
											</c:forEach>
											<tr>
												<th rowspan="2"></th>
												<th rowspan="2">Total</th>
												<c:forEach var="report" items="${salesReturnQtyReport}"
													varStatus="cnt">
													<th style="text-align: right;">${report.value.totBillQty}</th>

													<th style="text-align: right;">${report.value.totGrnQty}</th>
													<th style="text-align: right;"><fmt:formatNumber
															type="number" minFractionDigits="2" maxFractionDigits="2"
															value="${report.value.totBillQty-(report.value.totGrnQty+report.value.totGvnQty)}" />
													</th>

												</c:forEach>
												<th style="text-align: right;"><fmt:formatNumber
														type="number" minFractionDigits="2" maxFractionDigits="2"
														value="${finalBillQty}" /></th>
												<th style="text-align: right;"><fmt:formatNumber
														type="number" minFractionDigits="2" maxFractionDigits="2"
														value="${finalGrnQty}" /></th>
											</tr>
										</tbody>
									</table>


								</c:otherwise>

							</c:choose>



						</div>
						<div class="form-group" id="range">

							<div class="col-sm-3  controls">
								<input type="button" id="expExcel" class="btn btn-primary"
									value="EXPORT TO Excel" onclick="exportToExcel();">
							</div>
						</div>
					</div>

				</div>

			</div>
		</form>
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

			var year = $("#year").val();
			alert(year);

			var typeId = $("#type_id").val();

			var dairyMartType = $("#dairy_id").val();

			var billType = 1;
			if (document.getElementById("rd1").checked == true) {
				billType = 1;

			} else {
				billType = 2;
			}

			$('#loader').show();

			$.getJSON('${getSalesReportList}', {
				year : year,
				ajax : 'true'

			}, function(data) {

				$('#table_grid td').remove();
				$('#loader').hide();

				if (data == "") {
					alert("No records found !!");
					document.getElementById("expExcel").disabled = true;
				}

				var totalIgst = 0;
				var totalSgst = 0;
				var totalCgst = 0;
				var totalBasicValue = 0;
				var totalRoundOff = 0;
				var totalFinal = 0;

				$.each(data, function(key, report) {

					totalIgst = totalIgst + report.igstSum;
					totalSgst = totalSgst + report.sgstSum;
					totalCgst = totalCgst + report.cgstSum;
					totalBasicValue = totalBasicValue + report.taxableAmt;
					totalRoundOff = totalRoundOff + report.roundOff;

					document.getElementById("expExcel").disabled = false;
					document.getElementById('range').style.display = 'block';
					var index = key + 1;

					var tr = $('<tr></tr>');

					tr.append($('<td></td>').html(key + 1));

					tr.append($('<td></td>').html(report.invoiceNo));

					tr.append($('<td></td>').html(report.billDate));

					tr.append($('<td></td>').html(report.frName));

					tr.append($('<td></td>').html(report.frCity));

					tr.append($('<td></td>').html(report.frGstNo));

					tr.append($('<td style="text-align:right;"></td>').html(
							report.taxableAmt.toFixed(2)));

					if (report.isSameState == 1) {
						tr.append($('<td style="text-align:right;"></td>')
								.html(report.cgstSum.toFixed(2)));
						tr.append($('<td style="text-align:right;"></td>')
								.html(report.sgstSum.toFixed(2)));
						tr.append($('<td style="text-align:right;"></td>')
								.html(0));
					} else {
						tr.append($('<td style="text-align:right;"></td>')
								.html(0));
						tr.append($('<td style="text-align:right;"></td>')
								.html(0));
						tr.append($('<td style="text-align:right;"></td>')
								.html(report.igstSum.toFixed(2)));
					}
					tr.append($('<td style="text-align:right;"></td>').html(
							report.roundOff));
					var total;

					if (report.isSameState == 1) {
						total = parseFloat(report.taxableAmt)
								+ parseFloat(report.cgstSum + report.sgstSum);
					} else {

						total = report.taxableAmt + report.igstSum;
					}

					totalFinal = totalFinal + total;

					tr.append($('<td style="text-align:right;"></td>').html(
							total.toFixed(2)));

					$('#table_grid tbody').append(tr);

				})

				var tr = $('<tr></tr>');

				tr.append($('<td></td>').html(""));
				tr.append($('<td></td>').html(""));
				tr.append($('<td></td>').html(""));
				tr.append($('<td></td>').html(""));
				tr.append($('<td></td>').html(""));
				tr.append($('<td style="font-weight:bold;"></td>')
						.html("Total"));
				tr.append($('<td style="text-align:right;"></td>').html(
						totalBasicValue.toFixed(2)));
				tr.append($('<td style="text-align:right;"></td>').html(
						totalCgst.toFixed(2)));
				tr.append($('<td style="text-align:right;"></td>').html(
						totalSgst.toFixed(2)));
				tr.append($('<td style="text-align:right;"></td>').html(
						totalIgst.toFixed(2)));
				tr.append($('<td style="text-align:right;"></td>').html(
						totalRoundOff.toFixed(2)));
				tr.append($('<td style="text-align:right;"></td>').html(
						totalFinal.toFixed(2)));

				$('#table_grid tbody').append(tr);

			});

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
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();
			var selectedFr = $("#selectFr").val();
			var routeId = $("#selectRoute").val();
			var selectedCat = $("#item_grp1").val();

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/showSaleReportByDatePdf/'
							+ from_date
							+ '/'
							+ to_date
							+ '/'
							+ selectedFr
							+ '/' + routeId + '/' + selectedCat + '/');

			//window.open("${pageContext.request.contextPath}/pdfForReport?url=showSaleReportByDatePdf/"+from_date+"/"+to_date);

		}
	</script>

	<script type="text/javascript">
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