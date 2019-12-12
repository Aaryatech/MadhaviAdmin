<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>

<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/tableSearch.css">
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
			<!-- BEGIN Page Title -->
			<!-- 	<div class="page-title">
				<div>
					<h1>
						<i class="fa fa-file-o"></i> Item Ledger
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->


			<div class="row hidden-xs">
				<div class="col-md-12">
					<div class="box box-pink">
						<div class="box-title">
							<h3>
								<i class="fa fa-bars"></i> Pending Bill List
							</h3>
							<div class="box-tool">
								<a data-action="collapse" href="#"><i
									class="fa fa-chevron-up"></i></a>
							</div>
						</div>
						<div class="box-content">

							<form name="${pageContext.request.contextPath}/showPendingBillList"
								id="showExpenseList" class="form-horizontal" method="get"
								action="showPendingBillList">

								<div class="row">

									<div class="form-group">

										<label for="textfield2"
											class="col-xs-3 col-lg-2 control-label">Select
											Franchise </label>
										<div class="col-sm-9 col-lg-4 controls">

											<select class="form-control chosen" multiple="multiple"
												tabindex="6" name="fr_id" id="fr_id">

												<option value="-1">All</option>
												<c:forEach items="${allFrIdNameList}" var="allFrIdNameList"
													varStatus="count">
													<option value="${allFrIdNameList.frId}">${allFrIdNameList.frName}</option>

												</c:forEach>

											</select>
										</div>


									</div>
								</div>




								<br>
								<div class="row">

									<div class="col-md-12" style="text-align: center;">
										<input type="submit" class="btn btn-info" value="Search" />
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">

					<div class="box">

						<div class="box-content">
							<div class="col-md-9"></div>
							<label for="search" class="col-md-3" id="search"> <i
								class="fa fa-search" style="font-size: 20px"></i> <input
								type="text" id="myInput" onkeyup="myFunction()"
								style="border-radius: 25px;"
								placeholder="Search items by Name or Code"
								title="Type in a name">
							</label>

							<div class="clearfix"></div>

							<div id="table-scroll" class="table-scroll">

								<div id="faux-table">
									<table id="table2" class="table table-advance">
										<thead>
											<tr class="bgpink">
												<th class="col-sm-1">Sr No</th>
												<th class="col-md-1">Bill No.</th>
												<th class="col-md-1">Bill Date</th>
												<th class="col-md-1">Bill Amount</th>
												<th class="col-md-1">Paid Amount</th>
												<th class="col-md-1">Pending Amount</th>

												<th class="col-md-1">Action</th>

											</tr>
										</thead>

										<tbody>



											<c:forEach items="${billList}" var="billList"
												varStatus="count">

												<tr>
													<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
													<td class="col-md-2"><c:out value="${billList.billNo}" /></td>

													<td class="col-md-2"><c:out
															value="${billList.billDate}" /></td>
													<td class="col-md-1"><c:out
															value="${billList.billAmt}" /></td>

													<td class="col-md-2"><c:out
															value="${billList.paidAmt}" /></td>
													<td class="col-md-1"><c:out
															value="${billList.pendingAmt}" /></td>



													<td class="col-md-2"><div>
															<a
																href="${pageContext.request.contextPath}/closeBill/${billList.billTransId}">
																<abbr title='Close Bill'><i class='fa fa-edit'></i></abbr>
															</a>

														</div></td>
												</tr>
											</c:forEach>
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
				<p>2019 © MADHAVI.</p>
			</footer>

			<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
				class="fa fa-chevron-up"></i></a>
		</div>
		<!-- END Content -->
	</div>
	<!-- END Container -->

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
</body>


<script>
	function myFunction() {
		var input, filter, table, tr, td, td1, i;
		input = document.getElementById("myInput");
		filter = input.value.toUpperCase();
		table = document.getElementById("table1");
		tr = table.getElementsByTagName("tr");
		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[3];
			td1 = tr[i].getElementsByTagName("td")[2];
			if (td || td1) {
				if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else if (td1.innerHTML.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}//end of for

	}
</script>

<script type="text/javascript">
	function exportToExcel() {
		window.open("${pageContext.request.contextPath}/exportToExcel");
		document.getElementById("expExcel").disabled = true;
	}
	function exportToExcel1() {
		window.open("${pageContext.request.contextPath}/exportToExcelDummy");
		document.getElementById("expExcel1").disabled = true;
	}
</script>
<script type="text/javascript">
	function deleteById() {

		var checkedVals = $('.chk:checkbox:checked').map(function() {
			return this.value;
		}).get();
		checkedVals = checkedVals.join(",");

		if (checkedVals == "") {
			alert("Please Select Item")
		} else {
			window.location.href = '${pageContext.request.contextPath}/deleteItem/'
					+ checkedVals;

		}

	}
</script>
<script type="text/javascript">
	function inactiveById() {

		var checkedVals = $('.chk:checkbox:checked').map(function() {
			return this.value;
		}).get();
		checkedVals = checkedVals.join(",");

		if (checkedVals == "") {
			alert("Please Select Item")
		} else {
			window.location.href = '${pageContext.request.contextPath}/inactiveItem/'
					+ checkedVals;

		}

	}
</script>

</html>