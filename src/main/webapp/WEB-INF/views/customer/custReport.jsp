<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

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

			</form>

		</div>


		<div class="box">

			<div class=" box-content">
				<div class="row">
					<div class="col-md-12 table-responsive">
						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f95d64;">
								<tr>
									<th>Sr.No.</th>
									<th>Name</th>
									<th>Phone</th>
									<th>Email</th>
									<th>DOB</th>
									<th>Gender</th>
									<th>Business</th>
									<th>Address</th>
									<th>Age Group</th>
									<th>Added From</th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${custList}" varStatus="count" var="cust">

									<tr>
										<td>${count.index+1}</td>
										<td>${cust.custName}</td>
										<td>${cust.phoneNumber}</td>
										<td>${cust.emailId}</td>
										<td>${cust.custDob}</td>

										<c:choose>
											<c:when test="${cust.gender == 1}">
												<td>Male</td>
											</c:when>
											<c:when test="${cust.gender == 2}">
												<td>Female</td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>

										<td>${cust.companyName}</td>
										<td>${cust.address}</td>
										<td>${cust.ageGroup}</td>

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
		function searchReport() {
			//	var isValid = validate();

			var selectedFr = $("#selectFr").val();
			var selectedSubCat = $("#item_grp2").val();

			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			$('#loader').show();

			$
					.getJSON(
							'${getBillList}',

							{
								fr_id_list : JSON.stringify(selectedFr),
								subCat_id_list : JSON.stringify(selectedSubCat),
								fromDate : from_date,
								toDate : to_date,
								ajax : 'true'

							},
							function(data) {

								$('#table_grid td').remove();
								$('#loader').hide();

								if (data == "") {
									alert("No records found !!");
									document.getElementById("expExcel").disabled = true;
								}

								$
										.each(
												data.frList,
												function(key, fr) {
													var tr = $('<tr></tr>');

													tr.append($('<td></td>')
															.html(fr.frName));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));

													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));
													tr.append($('<td></td>')
															.html(""));

													$('#table_grid tbody')
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
																	data.subCatFrReportList,
																	function(
																			key,
																			report) {
																		if (fr.frId == report.frId) {
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
																									report.soldQty
																											.toFixed(2)));

																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.soldAmt
																											.toFixed(2)));

																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.varQty
																											.toFixed(2)));

																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.varAmt
																											.toFixed(2)));

																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.retQty
																											.toFixed(2)));
																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.retAmt
																											.toFixed(2)));

																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.netQty
																											.toFixed(2)));
																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.netAmt
																											.toFixed(2)));
																			tr
																					.append($(
																							'<td style="text-align:right;"></td>')
																							.html(
																									report.retAmtPer
																											.toFixed(2)));

																			$(
																					'#table_grid tbody')
																					.append(
																							tr);

																		}

																	})

													var tr = $('<tr></tr>');

													tr.append($('<td  ></td>')
															.html(" "));

													tr
															.append($(
																	'<td style="font-weight:bold;"></td>')
																	.html(
																			"Total"));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalSoldQty
																					.toFixed(2)));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalSoldAmt
																					.toFixed(2)));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalVarQty
																					.toFixed(2)));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalVarAmt
																					.toFixed(2)));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalRetQty
																					.toFixed(2)));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalRetAmt
																					.toFixed(2)));

													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalNetQty
																					.toFixed(2)));
													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			totalNetAmt
																					.toFixed(2)));

													tr
															.append($(
																	'<td style="text-align:right;font-weight:bold;"></td>')
																	.html(
																			retAmtPer
																					.toFixed(2)));

													$('#table_grid tbody')
															.append(tr);

												})

							});
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

			window
					.open('${pageContext.request.contextPath}/pdfForReport?url=pdf/showSummeryFrAndSubCatPdf/'
							+ from_date
							+ '/'
							+ to_date
							+ '/'
							+ selectedFr
							+ '/' + selectedSubCatIdList);

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
											$("<option ></option>").attr(
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