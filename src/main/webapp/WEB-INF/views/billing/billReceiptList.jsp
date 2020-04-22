<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<%-- <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/component.css" /> --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/tableSearch.css">
<style type="text/css">
a[disabled="disabled"] {
	pointer-events: none;
}

.switch-toggle {
	width: 14em;
}

.sticky-thead {
	display: none;
}
</style>
<body>
	<c:url var="getReceiptList" value="/getReceiptList" />
	<c:url var="getBillReceiptDetailList" value="/getBillReceiptDetailList" />


	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<div class="container" id="main-container">

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





			<div class="row hidden-xs">
				<div class="col-md-12">
					<div class="box">

						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i>Bill Receipt List
							</h3>

						</div>

						<div class="box-content">

							<div class="row">


								<div class="form-group">
									<label class="col-sm-3 col-lg-2	 control-label">From
										Date</label>
									<div class="col-sm-6 col-lg-4 controls date_select">
										<input class="form-control date-picker" id="fromDate"
											name="fromDate" size="30" type="text" value="${fromDate}" />
									</div>

									<!-- </div>

					<div class="form-group  "> -->

									<label class="col-sm-3 col-lg-2	 control-label">To Date</label>
									<div class="col-sm-6 col-lg-4 controls date_select">
										<input class="form-control date-picker" id="toDate"
											name="toDate" size="30" type="text" value="${toDate}" />
									</div>




								</div>
							</div>
							<br>
							<div class="row">

								<div class="form-group">

									<label class="col-sm-3 col-lg-2	 control-label">Select
										Franchisee</label>
									<div class="col-md-4 controls">

										<select class="form-control chosen" multiple="multiple"
											tabindex="6" name="fr_id" id="fr_id"
											onchange="setAllFrSelected(this.value)">

											<option value="-1">All</option>
											<c:forEach items="${allFrIdNameList}" var="allFrIdNameList"
												varStatus="count">
												<option value="${allFrIdNameList.frId}">${allFrIdNameList.frName}</option>

											</c:forEach>

										</select>
									</div>


									<div class="col-md-6" style="text-align: left;">
										<input type="button" class="btn btn-info" value="Search"
											onclick="showReceiptList()" />
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

							<br>
						</div>
					</div>
				</div>
			</div>
			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">

					<div class="box">

						<div class="box-content">
							<!-- <div class="col-md-9"></div>
							<label for="search" class="col-md-3" id="search"> <i
								class="fa fa-search" style="font-size: 20px"></i> <input
								type="text" id="myInput" onkeyup="myFunction()"
								style="border-radius: 25px;"
								placeholder="Search items by Name or Code"
								title="Type in a name">
							</label> -->



							<div id="table-scroll">

								<div id="faux-table" class="table-responsive">
									<table id="table2"
										class="table table-bordered table-striped fill-head">
										<thead style="background-color: #f95d64;">
											<tr>
												<th class="col-sm-1" style="text-align: center;">Sr No</th>
												<th class="col-md-1" style="text-align: center;">Franchisee</th>
												<th class="col-md-1" style="text-align: center;">Receipt
													Date</th>
												<th class="col-md-1" style="text-align: center;">Receipt
													No.</th>
												<th class="col-md-1" style="text-align: center;">Expense
													No.</th>
												<th class="col-md-1" style="text-align: center;">Expense
													Amount</th>
												<th class="col-md-1" style="text-align: center;">Action</th>

											</tr>
										</thead>

										<tbody>

										</tbody>


									</table>

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
		</div>
		<!-- END Content -->
	</div>



	<!-- --------------------MODAL----------------------------------- -->


	<div class="modal fade" id="elegantModalForm" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

		<!--SAVE LOADER-->
		<div id="overlay">
			<div class="clock"></div>
		</div>


		<div class="modal-dialog" role="document"
			style="width: 80%; height: 50%;">
			<!--Content-->
			<div class="modal-content form-elegant">

				<a href="#" class="close" data-dismiss="modal" aria-label="Close"
					style="margin: 10px;" id="closeHrefModel"> <i
					class="fa fa-times" style="color: #000000;"></i>
				</a>

				<!--Header-->
				<div class="modal-header text-center">
					<h3 class="modal-title w-100 dark-grey-text font-weight-bold my-3"
						id="myModalLabel" style="color: #ea4973;">
						<strong>Bill Receipt Details</strong>
					</h3>

					<div></div>
					<div class="modal-body mx-6">

						<form name="modalfrm" id="modalfrm" method="post">

							<div class="row">
								<!-- <label class="col-sm-2 col-lg-6 control-label"
									style="color: blue;">Franchise Name :<span id="frName"></span>
								</label>
								
								<label class="col-sm-2 col-lg-6 control-label"
									style="color: blue;">Expense Amount :<span id="expAmt"></span>
								</label> -->
								
								
							</div>

							<div class="component">

								<table width="80%" id="modeltable"
									class="table table-bordered table-striped fill-head">
									<!-- class="table table-advance" -->
									<thead style="background-color: #f95d64;">
										<tr>

											<th width="17" style="width: 18px; text-align: center;">Sr
												No</th>
											<th width="120" style="text-align: center;">Bill No</th>
											<th width="100" style="text-align: center;">Bill Amount</th>
											<th width="120" style="text-align: center;">Paid Amt</th>

										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>

							</div>

						</form>
						<br>

					</div>
				</div>
				<!--Body-->

				<!--Footer-->
			</div>
			<!--/.Content-->
		</div>
	</div>



	<script>
		function setAllFrSelected(frId) {
			//alert("frId" + frId);
			//alert("hii")
			if (frId == -1) {

				$.getJSON('${pageContext.request.contextPath}/getFrList', {

					ajax : 'true'
				}, function(data) {

					var len = data.length;

					//alert(len);

					$('#fr_id').find('option').remove().end()
					$("#fr_id").append($("<option value='-1'>All</option>"));
					for (var i = 0; i < len; i++) {
						$("#fr_id").append(
								$("<option selected ></option>").attr("value",
										data[i].frId).text(data[i].frName));
					}
					$("#fr_id").trigger("chosen:updated");
				});
			}
		}
	</script>




	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.ba-throttle-debounce.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.stickyheader.js"></script>
	<!----------------------------------------------End MODEL 1------------------------------------------------>
	<script type="text/javascript">
		function showDetailsForBillReceipt(recId,expAmt) {
			//alert("hi");
			
			//document.getElementById("expAmt").innerHTML = expAmt;
			
			$('#modeltable td').remove();

			$.getJSON('${getBillReceiptDetailList}', {

				recId : recId,
				ajax : 'true',
			}, function(data) {

				if (data == "") {
					alert("No Record Found!");
				}

				$('#modeltable td').remove();

				$.each(data, function(key, data1) {

					var tr = $('<tr></tr>');

					tr.append($('<td></td>').html(key + 1));

					tr.append($('<td></td style="text_align:center;">').html(
							data1.invoiceNo));
					tr.append($('<td></td style="text_align:right;">').html(
							data1.billAmt));
					tr.append($('<td></td style="text_align:right;">').html(
							data1.paidAmt));

					$('#modeltable tbody').append(tr);

				});

			});
		}
	</script>


	<script type="text/javascript">
		$('#sbtbtn').click(function() {
			$("#overlay").fadeIn(300);
			$('#loader').show();

			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/submitRespose",
				data : $("#modalfrm").serialize(),
				dataType : 'json',
				success : function(data) {
					$('#loader').hide();
					if (data == 2) {
						$('#modeltable td').remove();
						alert("Bill Settled Successfully")
						$("#overlay").fadeOut(300);
						$("#closeHrefModel")[0].click();

						window.location.reload();

					}
				}
			}).done(function() {
				setTimeout(function() {
					$("#overlay").fadeOut(300);
					$('#loader').hide();
				}, 500);
			});
		});
	</script>



	<script type="text/javascript">
		function showReceiptList() {

			var fromDate = document.getElementById("fromDate").value;
			var toDate = document.getElementById("toDate").value;
			var frId = $("#fr_id").val();

			$('#loader').show();

			$
					.getJSON(
							'${getReceiptList}',
							{

								fromDate : fromDate,
								toDate : toDate,
								frId : JSON.stringify(frId),
								ajax : 'true',
							},
							function(data) {

								if (data == "") {
									alert("No Record Found!");
								}

								$('#loader').hide();

								$('#table2 td').remove();

								$
										.each(
												data,
												function(key, data1) {

													var tr = $('<tr></tr>');

													tr.append($('<td></td>')
															.html(key + 1));

													tr
															.append($(
																	'<td></td>')
																	.html(
																			data1.frName));
													tr
															.append($(
																	'<td style="text-align:center;"></td>')
																	.html(
																			data1.receiptDate));
													tr
															.append($(
																	'<td  style="text-align:center;"></td>')
																	.html(
																			data1.receiptNo));
													tr
															.append($(
																	'<td style="text-align:center;"></td>')
																	.html(
																			data1.chalanNo));
													tr
															.append($(
																	'<td style="text-align:right;"></td>')
																	.html(
																			data1.expAmt));
													tr
															.append($(
																	'<td style="text-align:center;"></td>')
																	.html(
																			"<a href='' onclick=showDetailsForBillReceipt("
																					+ data1.billReceiptId
																					+ ","
																					+ data1.expAmt
																					+ ") class=''btn btn-default btn-rounded' data-toggle='modal' data-target='#elegantModalForm'><abbr title='Detail'><i class='fa fa-edit'></i></abbr></a>"));

													$('#table2 tbody').append(
															tr);

												});

							});
		}
	</script>



	<!-- END Container -->

	<!-- <!--basic scripts-->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<!-- 	<script>
		window.jQuery
				|| document
						.write('<script src="${pageContext.request.contextPath}/resources/assets/jquery/jquery-2.0.3.min.js"><\/script>')
	</script> -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/jquery-cookie/jquery.cookie.js"></script>

	<!--page specific plugin scripts-->
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.resize.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.pie.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.stack.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.crosshair.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.tooltip.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/sparkline/jquery.sparkline.min.js"></script>


	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/jquery.validate.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/jquery-validation/dist/additional-methods.min.js"></script>

	<!--flaty scripts-->
	<script src="${pageContext.request.contextPath}/resources/js/flaty.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/flaty-demo-codes.js"></script>
	<!--page specific plugin scripts-->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-fileupload/bootstrap-fileupload.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/chosen-bootstrap/chosen.jquery.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/clockface/js/clockface.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/date.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/assets/bootstrap-daterangepicker/daterangepicker.js"></script>


	<!-- js & css  for modal  -->




	<!--  -->
</body>



</html>