<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<c:url var="getCustomerReportListAjax"
		value="/getCustomerReportListAjax"></c:url>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

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
					<i class="fa fa-file-o"></i>Customer Report
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
				<li class="active">Customer Report</li>
			</ul>
		</div>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i> Customer Report
				</h3>

			</div>

			<form id="submitBillForm"
				action="${pageContext.request.contextPath}/customerReport"
				method="get">

				<div class="box-content">

					<div class="row">
						<div class="col-md-2">Customer Added From</div>
						<div class="col-md-2" style="text-align: left;">
							<select data-placeholder="Select Group"
								class="form-control chosen" name="addedFrom" tabindex="-1"
								id="addedFrom" data-rule-required="true">
								<option value="1,2"
									${'1,2' == type ? 'selected="selected"' : ''}>All</option>
								<option value="1" ${'1' == type ? 'selected="selected"' : ''}>POS</option>
								<option value="2" ${'2' == type ? 'selected="selected"' : ''}>Online</option>
							</select>
						</div>

						<div class="col-md-4">
							<input type="submit" class="btn btn-info" value="Search"></input>

							<c:if test="${custList != ''}">
								<button class="btn btn-primary" value="PDF" id="PDFButton"
									onclick="genPdf()">PDF</button>

								<button class="btn btn-primary" value="Excel" id="ExcelButton"
									onclick="exportToExcel()">Excel</button>

								<input type="button" class="btn btn-info" value="Lucky Draw"
									data-toggle="modal" data-target="#custModal"
									onclick="luckyDraw()"></input>

							</c:if>



						</div>
						<div class="col-md-4" style="text-align: right;"></div>
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

			</form>

		</div>


		<div class="box">

			
			<div class=" box-content">
			
			<input type="text" id="tblSearch" placeholder="Search..."
				style="border-top: 0px; border-left: 0px; border-right: 0px; border-bottom: 1px solid; margin-bottom: 10px; width: 200px;">
			
			
				<div class="row">
					<div class="col-md-12 table-responsive">
						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f95d64;">
								<tr>
									<th style="text-align: center;">Sr.No.</th>
									<th style="text-align: center;">Name</th>
									<th style="text-align: center;">Phone</th>
									<th style="text-align: center;">Email</th>
									<th style="text-align: center;">Address</th>
									<th style="text-align: center;">Added From</th>
								</tr>
							</thead>
							<tbody id="tblBody">

								<c:forEach items="${custList}" varStatus="count" var="cust">

									<tr>
										<td>${count.index+1}</td>
										<td>${cust.custName}</td>
										<td style="text-align: center;">${cust.phoneNumber}</td>

										<c:choose>
											<c:when test="${cust.emailId != ''}">
												<td>${cust.emailId}</td>
											</c:when>
											<c:otherwise>
												<td>-</td>
											</c:otherwise>
										</c:choose>

										<%-- <td style="text-align: center;">${cust.custDob}</td> --%>

										<%-- <c:choose>
											<c:when test="${cust.gender == 1}">
												<td>Male</td>
											</c:when>
											<c:when test="${cust.gender == 2}">
												<td>Female</td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose> --%>

										<%-- <td>${cust.companyName}</td> --%>

										<c:choose>
											<c:when test="${cust.address != ''}">
												<td>${cust.address}</td>
											</c:when>
											<c:otherwise>
												<td>NA</td>
											</c:otherwise>
										</c:choose>

										<%-- <td>${cust.ageGroup}</td> --%>

										<c:choose>
											<c:when test="${cust.addedFromType == 1}">
												<td>POS</td>
											</c:when>
											<c:when test="${cust.addedFromType == 2}">
												<td>Online</td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>



									</tr>

								</c:forEach>

							</tbody>
						</table>
					</div>

				</div>

			</div>

		</div>

		<!-- MODAL -->
		<div class="modal fade" id="custModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">

			<!--SAVE LOADER-->
			<div id="overlay">
				<div class="clock"></div>
			</div>



			<div class="modal-dialog" role="document"
				style="width: 80%; height: 50%;">
				<!--Content-->
				<div class="modal-content form-elegant">

					<a href="#" class="close" data-dismiss="modal" aria-label="Close"
						style="margin: 10px;" id="closeCustModel"> <i
						class="fa fa-times" style="color: #000000;"></i>
					</a>

					<!--Header-->
					<div class="modal-header text-center">
						<h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3"
							id="myModalLabel" style="color: #ea4973;">
							<strong>Lucky Draw</strong>
						</h3>

						<div></div>
						<div class="modal-body mx-6">

							<div class="component">

								<table width="80%" id="modelTable" class="table table-advance"
									style="font-size: 13px; font-weight: bold; border: 1px solid; border-color: #f95d64;">
									<!-- class="table table-advance" -->
									<thead>
										<tr class="bgpink" style="background-color: #f95d64;">
											<th class="col-sm-1" align="center">Sr No</th>
											<th class="col-md-2" align="center">Name</th>
											<th class="col-md-1" align="center">Phone</th>
											<th class="col-md-1" align="center">Email</th>
											<th class="col-md-1" align="center">Address</th>
											<th class="col-md-1" align="center">Added From</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>

						</div>

					</div>
					<!--Body-->

					<!--Footer-->
				</div>
				<!--/.Content-->
			</div>
		</div>
		<!-- MODAL -->


	</div>
	<!-- END Main Content -->

	<footer>
		<p>2019 © MADHVI.</p>
	</footer>

	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>

	<script type="text/javascript">
		function genPdf() {
			var type = $("#addedFrom").val();

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/customerReportPdf/'
							+ type);

			//window.open("${pageContext.request.contextPath}/pdfForReport?url=showSaleReportByDatePdf/"+from_date+"/"+to_date);
		}

		function exportToExcel() {
			window.open("${pageContext.request.contextPath}/exportToExcelNew");
			document.getElementById("expExcel").disabled = true;
		}

		function luckyDraw() {

			//down.innerHTML = arr[Math.floor(Math.random() * arr.length)]; 

			$.getJSON('${getCustomerReportListAjax}', {
				ajax : 'true'
			}, function(data) {
				var len = data.length;
				//alert(JSON.stringify(data));

				$('#modelTable td').remove();

				for (var i = 0; i < 3; i++) {

					var random = Math.floor(Math.random() * len);
					console.log("" + data[random]);

					var tr = $('<tr></tr>');

					tr.append($('<td style="text-align:left;"></td>').html(
							i + 1));
					tr.append($('<td style="text-align:left;"></td>').html(
							data[random].custName));
					tr.append($('<td style="text-align:left;"></td>').html(
							data[random].phoneNumber));
					tr.append($('<td style="text-align:left;"></td>').html(
							data[random].emailId));
					tr.append($('<td style="text-align:left;"></td>').html(
							data[random].address));

					var type = "";
					if (data[random].addedFromType == 1) {
						type = "POS";
					} else if (data[random].addedFromType == 2) {
						type = "Online";
					}
					tr.append($('<td style="text-align:left;"></td>')
							.html(type));

					$('#modelTable tbody').append(tr);

				}

			});

		}
	</script>


	<script>
		$(document)
				.ready(
						function() {
							$("#tblSearch")
									.on(
											"keyup",
											function() {
												var value = $(this).val()
														.toLowerCase();
												$("#tblBody tr")
														.filter(
																function() {
																	$(this)
																			.toggle(
																					$(
																							this)
																							.text()
																							.toLowerCase()
																							.indexOf(
																									value) > -1)
																});
											});
						});
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