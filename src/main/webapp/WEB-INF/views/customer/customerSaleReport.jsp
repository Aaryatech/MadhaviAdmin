<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<c:url var="getAllFrListForCustReport"
		value="/getAllFrListForCustReport"></c:url>

	<c:url var="getCustSaleReportAjax" value="/getCustSaleReportAjax"></c:url>


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
					<i class="fa fa-file-o"></i>Customer Sale Report
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
				<li class="active">Customer Sale Report</li>
			</ul>
		</div>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i> Customer Sale Report
				</h3>

			</div>



			<div class="box-content">

				<div class="row">
					<div class="form-group">
						<label class="col-md-1	 control-label">From Date</label>
						<div class="col-md-2 controls date_select">
							<input class="form-control date-picker" id="fromDate"
								name="fromDate" size="30" type="text" value="${todaysDate}" />
						</div>

						<label class="col-md-1	 control-label">To Date</label>
						<div class="col-md-2 controls date_select">
							<input class="form-control date-picker" id="toDate" name="toDate"
								size="30" type="text" value="${todaysDate}" />
						</div>

						<div class="col-md-2">Customer Added From</div>
						<div class="col-md-4" style="text-align: left;">
							<select data-placeholder="Select Group"
								class="form-control chosen" name="addedFrom" tabindex="-1"
								id="addedFrom" data-rule-required="true">
								<option value="1,2"
									${'1,2' == type ? 'selected="selected"' : ''}>All</option>
								<option value="1" ${'1' == type ? 'selected="selected"' : ''}>POS</option>
								<option value="2" ${'2' == type ? 'selected="selected"' : ''}>Online</option>
							</select>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-md-1">Franchise</div>
						<div class="col-md-8" style="text-align: left;">
							<select data-placeholder="Choose Franchisee"
								class="form-control chosen" multiple="multiple" tabindex="6"
								id="selectFr" name="selectFr"
								onchange="setAllFrSelected(this.value)">

								<option value="-1"><c:out value="All" /></option>

								<c:forEach items="${frList}" var="fr" varStatus="count">
									<option value="${fr.frId}"><c:out value="${fr.frName}" /></option>
								</c:forEach>
							</select>
						</div>

						<div class="col-md-3">
							<input type="button" class="btn btn-info" value="Search"
								onclick="searchCust()"></input>

							<button class="btn btn-primary" value="PDF" id="PDFButton" style="display: none;"
								onclick="genPdf()">PDF</button>

							<button class="btn btn-primary" value="Excel" id="ExcelButton" style="display: none;"
								onclick="exportToExcel()">Excel</button>


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

			</div>

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
									<th style="text-align: center;">Added From</th>
									<th style="text-align: center;">Sell AMT</th>
									<th style="text-align: center;">Discount AMT</th>
									<th style="text-align: center;">Wallet AMT</th>
									<th style="text-align: center;">Extra Charges AMT</th>
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



	</div>
	<!-- END Main Content -->

	<footer>
		<p>2019 © MADHVI.</p>
	</footer>

	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>

	<script>
		function setAllFrSelected(frId) {
			//alert("frId" + frId);
			//alert("hii")
			if (frId == -1) {

				$.getJSON('${getAllFrListForCustReport}', {

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


	<script type="text/javascript">
		function searchCust() {

			var selectedFr = $("#selectFr").val();
			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();
			var addedFrom = $("#addedFrom").val();

			if (selectedFr == null) {
				alert("Please select franchisee");
			} else {

				$('#loader').show();

				//alert(JSON.stringify(addedFrom))

				$.getJSON('${getCustSaleReportAjax}', {
					fr_id_list : JSON.stringify(selectedFr),
					fromDate : from_date,
					toDate : to_date,
					addedFrom : JSON.stringify(addedFrom),
					ajax : 'true'
				}, function(data) {
					$('#loader').hide();
					//alert(JSON.stringify(data));
					
					if(data == ''){
						$('#PDFButton').hide();
						$('#ExcelButton').hide();
					}else{
						$('#PDFButton').show();
						$('#ExcelButton').show();
					}

					$('#table_grid td').remove();
					
					var totalSell=0,totalDisc=0,totalWallet=0,totalExCh=0;

					$.each(data, function(key, report) {
						

						var tr = $('<tr></tr>');

						tr.append($('<td></td>').html(key + 1));

						tr.append($('<td></td>').html(report.custName));
						tr.append($('<td style="text-align:center"></td>').html(report.phoneNumber));
						
						var addedFrom="";
						if(report.addedFromType==1){
							addedFrom="POS";
						}else if(report.addedFromType==2){
							addedFrom="Online";
						}
						tr.append($('<td style="text-align:center"></td>').html(addedFrom));
						
						tr.append($('<td style="text-align:right"></td>').html(addCommas(report.payableAmt)));
						tr.append($('<td style="text-align:right"></td>').html(addCommas(report.discAmt)));
						tr.append($('<td style="text-align:right"></td>').html(addCommas(report.wallet)));
						tr.append($('<td style="text-align:right"></td>').html(addCommas(report.extraCh)));
						
						totalSell=totalSell+report.payableAmt;
						totalDisc=totalDisc+report.discAmt;
						totalWallet=totalWallet+report.wallet;
						totalExCh=totalExCh+report.extraCh;

						$('#table_grid tbody').append(tr);

					})
					
					var tr = $('<tr></tr>');
					
					tr.append($('<td colspan=4 style="font-weight:bold;"></td>').html("TOTAL"));
					tr.append($('<td style="text-align:right; font-weight:bold;"></td>').html(addCommas(totalSell)));
					tr.append($('<td style="text-align:right; font-weight:bold;"></td>').html(addCommas(totalDisc)));
					tr.append($('<td style="text-align:right; font-weight:bold;"></td>').html(addCommas(totalWallet)));
					tr.append($('<td style="text-align:right; font-weight:bold;"></td>').html(addCommas(totalExCh)));
					$('#table_grid tbody').append(tr);

					//table_grid

				});

			}

		}
		
		
		
		function genPdf() {
			var type = $("#addedFrom").val();

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/customerSaleReportPdf/'
							+ type);
		}
		
		function exportToExcel() {
			window.open("${pageContext.request.contextPath}/exportToExcelNew");
			document.getElementById("expExcel").disabled = true;
		}
		
		
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