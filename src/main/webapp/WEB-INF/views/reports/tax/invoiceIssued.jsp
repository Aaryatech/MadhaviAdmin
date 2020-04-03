<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getBillList" value="/getInvoiceIssuedReportAjax"></c:url>

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

		<!-- END Page Title -->

		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Tax Summary Report
				</h3>

			</div>

			<div class="box-content">
				<form action="${pageContext.request.contextPath}/showTaxReport"
					method="get" id="validation-form" onsubmit="return validateForm()">

					<div class="row">
						<div class="form-group">
							<label class="col-sm-3 col-lg-2	 control-label">From Date</label>
							<div class="col-sm-6 col-lg-4 controls date_select">
								<input class="form-control date-picker" id="fromDate"
									name="fromDate" size="30" type="text" value="${fromDate}"
									autocomplete="off" />
							</div>

							<label class="col-sm-3 col-lg-2	 control-label">To Date</label>
							<div class="col-sm-6 col-lg-4 controls date_select">
								<input class="form-control date-picker" id="toDate"
									autocomplete="off" name="toDate" size="30" type="text"
									value="${toDate}" />
							</div>

						</div>
					</div>

					<br>
					<div class="row">
						<div class="form-group" style="text-align: center;">
							<input type="button" class="btn btn-info" value="Search"
								onclick="searchReport()" />
						</div>
					</div>

				</form>


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
				<div class="row">
					<div class="col-md-12 table-responsive">

						<table class="table table-bordered table-striped fill-head "
							style="width: 100%" id="table_grid">
							<thead style="background-color: #f95d64;">
								<tr>
									<th style="text-align: center; padding: 10px; color: white;"
										rowspan="2">No.</th>
									<th style="text-align: center; color: white;" colspan="2">Sr.
										No.</th>
									<th style="text-align: center; padding: 10px; color: white;"
										rowspan="2">Total Number</th>
									<th style="text-align: center; padding: 10px; color: white;"
										rowspan="2">Cancelled Number</th>
									<th style="text-align: center; padding: 10px; color: white;"
										rowspan="2">Cancelled Invoices</th>
									<th style="text-align: center; padding: 10px; color: white;"
										rowspan="2">Net Issued</th>

								</tr>

								<tr>
									<th style="text-align: center; color: white;" width="50px;">From</th>
									<th style="text-align: center; color: white;" width="50px;">To</th>

								</tr>

							</thead>
							<tbody>
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
	</div>
	<!-- END Main Content -->

	<footer>
		<p>2019 © MADHVI.</p>
	</footer>

	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>



	<script type="text/javascript">
		function searchReport() {

			var from_date = $("#fromDate").val();
			var to_date = $("#toDate").val();

			$('#loader').show();

			$.getJSON('${getBillList}',

			{
				fromDate : from_date,
				toDate : to_date,
				ajax : 'true'

			}, function(data) {

				$('#table_grid td').remove();
				$('#loader').hide();

				if (data == "") {
					alert("No records found !!");
					document.getElementById("expExcel").disabled = true;
				}

				$.each(data, function(key, report) {

					document.getElementById("expExcel").disabled = false;
					document.getElementById('range').style.display = 'block';
					var index = key + 1;
					//var tr = "<tr>";

					var tr = $('<tr></tr>');

					tr.append($('<td></td>').html(key + 1));

					tr.append($('<td></td>').html(report.fromInvoice));

					tr.append($('<td></td>').html(report.toInvoice));

					tr.append($('<td></td>').html(report.totalNumber));

					tr.append($('<td></td>').html(report.totalDeleted));

					tr.append($('<td></td>').html(report.deletedInvoice));

					tr.append($('<td></td>').html(report.netIssued));

					$('#table_grid tbody').append(tr);

				})

			});

		}
	</script>


	<script type="text/javascript">
		function validateForm() {

			var fromDt = document.getElementById("fromDate").value;
			var toDt = document.getElementById("toDate").value;
			var a = document.getElementById("type_id").value;

			if (fromDt == "") {
				alert("Please Select From Date");
				return false;
			} else if (toDt == "") {
				alert("Please Select To Date");
				return false;
			} else if (a == 0) {
				alert("Please Select Bill Type");
				return false;
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

	<script type="text/javascript">
		function exportToExcel() {

			window.open("${pageContext.request.contextPath}/exportToExcelNew");
			document.getElementById("expExcel").disabled = true;
		}
		function exportToExcelTally() {

			window
					.open("${pageContext.request.contextPath}/exportToExcelTally");
			document.getElementById("expExcelTally").disabled = true;
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