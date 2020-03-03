<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/tableSearch.css">

<body>
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

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

		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i> Recipe List
				</h3>

			</div>

			<!-- BEGIN Main Content -->
			<div class="box">

				<div class="box-content">

					<div class="row">

						<form action="${pageContext.request.contextPath}/showRecipeList"
							method="post">


							<label for="textfield2" class="col-md-1">Type</label>
							<div class="col-md-3 controls">
								<select class="form-control input-sm" name="typeId" id="typeId">

									<c:choose>

										<c:when test="${type==1}">
											<option value="1" selected="selected">Franchise End</option>
											<option value="0">Factory End</option>
										</c:when>
										<c:otherwise>
											<option value="1">Franchise End</option>
											<option value="0" selected="selected">Factory End</option>
										</c:otherwise>

									</c:choose>


								</select>
							</div>
							<div class="col-md-2">
								<button type="submit" class="btn btn-primary">Search</button>
							</div>

							<div class="col-md-2"></div>

							<label for="search" class="col-md-4" id="search"> <i
								class="fa fa-search" style="font-size: 20px"></i> <input
								type="text" id="myInput" onkeyup="myFunction()"
								style="border-radius: 25px;" placeholder="Search items by Name"
								title="Type in a name">
							</label>


						</form>

					</div>



					<div class="clearfix"></div>

					<div class="row">
						<div class="col-md-12 table-responsive">

							<table id="tab1" class="table table-advance" style="">
								<thead style="background-color: #f95d64;">
									<tr class="bgpink">
										<th>Sr No</th>
										<th>Item Name</th>
										<th>Raw Material</th>
										<th>RM Qty</th>
										<th>NO. OF PIECES/ITEM</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${itemDetailsList}" var="recipe"
										varStatus="count">

										<tr>

											<td><c:out value="${count.index+1}" /></td>
											<td><c:out value="${recipe.itemName}" /></td>
											<td><c:out value="${recipe.rmName}" /></td>
											<td><c:out value="${recipe.rmQty}" /></td>
											<td><c:out value="${recipe.noOfPiecesPerItem}" /></td>
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
	</div>
	<!-- END Content -->
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
		table = document.getElementById("tab1");
		tr = table.getElementsByTagName("tr");
		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[1];
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
</html>