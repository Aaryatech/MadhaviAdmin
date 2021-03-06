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
			action="${pageContext.request.contextPath}/showMonthlySalesPercentageReport"
			method="get">
			<!-- BEGIN Main Content -->
			<div class="box">
				<div class="box-title">
					<h3>
						<i class="fa fa-bars"></i>Sub Category Wise Contribution Report
					</h3>
				</div>
				<div class="box-content">
					<div class="row">
						<div class="form-group">
							<label class="col-sm-3 col-lg-2	 control-label">Year</label>
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
						<i class="fa fa-list-alt"></i>Sub Category Wise Contribution
						Report
					</h3>
				</div>
				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive"
							style="overflow: scroll; overflow: auto;">




							<table class="table table-bordered table-striped fill-head "
								style="width: 100%;" id="table_grid">
								<thead style="background-color: #f95d64;">
									<tr>
										<th rowspan="2">Sr.</th>
										<th rowspan="2">Group Name</th>
										<c:forEach var="report" items="${salesReturnValueReport}"
											varStatus="cnt">
											<th>${report.value.month}</th>
											<th>%</th>
										</c:forEach>

									</tr>


								</thead>
								<tbody>

									<c:forEach items="${subCatList}" var="subCatList"
										varStatus="count">
										<c:set var="grandTotal" value="0.0" />
										<c:set var="grnQty" value="0.0" />
										<c:set var="gvnQty" value="0.0" />
										<tr>
											<td>${count.index+1}</td>
											<td>${subCatList.subCatName}</td>
											<c:forEach var="report" items="${salesReturnValueReport}"
												varStatus="cnt">

												<c:forEach var="rep"
													items="${report.value.salesReturnQtyValueList}"
													varStatus="cnt1">

													<c:choose>
														<c:when test="${rep.subCatId==subCatList.subCatId}">


															<td style="text-align: right;"><fmt:formatNumber
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2"
																	value="${rep.grandTotal-(rep.gvnQty+rep.grnQty)}" />
															<td style="text-align: right;"><c:choose>
																	<c:when test="${report.value.totBillAmt>0}">
																		<fmt:formatNumber type="number" minFractionDigits="2"
																			maxFractionDigits="2"
																			value="${(rep.grandTotal-(rep.gvnQty+rep.grnQty))*100/report.value.totBillAmt}" />

																	</c:when>
																	<c:otherwise>
															0.00
															</c:otherwise>
																</c:choose></td>
														</c:when>
														<c:otherwise>

														</c:otherwise>
													</c:choose>

												</c:forEach>
											</c:forEach>

										</tr>
									</c:forEach>
									<tr>
										<th rowspan="2"></th>
										<th rowspan="2">Total</th>
										<c:forEach var="report" items="${salesReturnValueReport}"
											varStatus="cnt">
											<th style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													groupingUsed="false" value="${report.value.totBillAmt}" /></th>

											<th style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													groupingUsed="false" value="0.00" /></th>

										</c:forEach>
									</tr>
								</tbody>
							</table>




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