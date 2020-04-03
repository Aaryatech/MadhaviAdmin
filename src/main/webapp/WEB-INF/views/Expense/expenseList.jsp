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
	<c:url var="showPendingForFr" value="/getBillListForSettle" />
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
								<i class="fa fa-bars"></i>Expense List
							</h3>

						</div>

						<div class="box-content">

							<form name="${pageContext.request.contextPath}/showExpenseList"
								id="showExpenseList" class="form-horizontal" method="get"
								action="showExpenseList">
								<div class="row">


									<div class="form-group">
										<label class="col-sm-3 col-lg-2	 control-label">From
											Date</label>
										<div class="col-sm-6 col-lg-3 controls date_select">
											<input class="form-control date-picker" id="fromDate"
												name="fromDate" size="30" type="text" value="${fromDate}" />
										</div>

										<!-- </div>

					<div class="form-group  "> -->

										<label class="col-sm-3 col-lg-2	 control-label">To
											Date</label>
										<div class="col-sm-6 col-lg-3 controls date_select">
											<input class="form-control date-picker" id="toDate"
												name="toDate" size="30" type="text" value="${toDate}" />
										</div>




									</div>
								</div>
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

										<label class="col-sm-3 col-lg-1	 control-label">Select</label>
										<div class="col-sm-2 col-lg-2">
											<select data-placeholder="Choose "
												class="form-control chosen" tabindex="6" id="type"
												name="type">
												<option value="1">Regular</option>
												<option value="2">Payment Chalan</option>


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



							<div id="table-scroll">

								<div id="faux-table" class="table-responsive">
									<table id="table2"
										class="table table-bordered table-striped fill-head">
										<thead style="background-color: #f95d64;">
											<tr>
												<th class="col-sm-1">Sr No</th>
												<th class="col-md-1">Chalan No.</th>
												<th class="col-md-1">Date</th>
												<th class="col-md-1">Amount</th>
												<th class="col-md-1">Type</th>
												<th class="col-md-1">Status</th>
												<th class="col-md-1">Action</th>

											</tr>
										</thead>

										<tbody>



											<c:forEach items="${expList}" var="expList" varStatus="count">

												<tr>
													<td class="col-sm-1"><c:out value="${count.index+1}" /></td>
													<td class="col-md-2"><c:out
															value="${expList.chalanNo}" /></td>

													<td class="col-md-2"><c:out value="${expList.expDate}" /></td>
													<td class="col-md-1"><c:out value="${expList.chAmt}" /></td>

													<td class="col-md-2"><c:choose>
															<c:when test="${expList.expType==1}">
 														Regular						
 												    </c:when>
															<c:otherwise>
												         Payment Chalan
												    </c:otherwise>
														</c:choose></td>

													<td class="col-md-2"><c:choose>
															<c:when test="${expList.status==1}">
 														Approved						
 												    </c:when>
															<c:otherwise>
												         Pending
												    </c:otherwise>
														</c:choose></td>
													<td class="col-md-2"><div>

															<c:if test="${expList.expType==2}">
																<c:if test="${expList.status==2}">
																	<a href=""
																		onclick="showDetailsForCp('${expList.expId}','${expList.chAmt}','${expList.expDate}','${expList.chalanNo}','${expList.frId}')"
																		class="btn btn-default btn-rounded"
																		data-toggle="modal" data-target="#elegantModalForm"><abbr
																		title='Edit'><i class='fa fa-edit'></i></abbr></a>
																</c:if>
															</c:if>

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
							<strong>Close Bill Against Chalan</strong>
						</h3>

						<div></div>
						<div class="modal-body mx-6">

							<form name="modalfrm" id="modalfrm" method="post">

								<div class="row">
									<label class="col-sm-2 col-lg-3 control-label"
										style="color: blue;">Amount :<span id="chAmt"></span>
									</label> <label class="col-sm-2 col-lg-3 control-label"
										style="color: blue;">Chalan No :<span id="chNo"></label>
									<label class="col-sm-2 col-lg-3 control-label"
										style="color: blue;">Chalan Date :<span id="chDate"></span>
									</label> <label class="col-sm-2 col-lg-3 control-label"
										style="color: blue;">Franchise Name :<span id="frName"></span>
									</label>
								</div>

								<input type="text" name="expId" id="expId" style="display: none;" />
								<div class="component">

									<table width="80%" id="modeltable"
										class="table table-bordered table-striped fill-head">
										<!-- class="table table-advance" -->
										<thead style="background-color: #f95d64;">
											<tr>

												<th width="17" style="width: 18px; text-align: center;">Sr
													No</th>
												<th width="120" style="text-align: center;">Bill No</th>
												<th width="100" style="text-align: center;">Bill Date</th>
												<th width="100" style="text-align: center;">Bill Amount</th>
												<th width="120" style="text-align: center;">Paid Amt</th>
												<th width="120" style="text-align: center;">Pending Amt</th>
												<th width="120" style="text-align: center;">Settle Amt</th>

											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>

								</div>

								<div class="component" style="display: none;">
									<div class="row">
										<label class="col-sm-3 col-lg-1 control-label">Total </label>
										<div class="col-sm-9 col-lg-1 controls">
											<input type="text" name="total" id="total" value="0"
												style="width: 90px;" class="form-control" /> <input
												type="hidden" name="frId" id="frId" value="0"
												class="form-control" /> <input type="hidden" name="delDate"
												id="delDate" value="0" class="form-control" /> <input
												type="hidden" name="expenseId" id="expenseId" value="0"
												class="form-control" />
										</div>
									</div>
								</div>


							</form>
							<br>

							<div class="form-group"></div>
							<div class="col-md-12">
								<button type="button" class="btn btn-primary" id="sbtbtn"
									disabled="disabled">Submit</button>
							</div>
							
							<div align="center" id="loader" style="display: none">

									<span>
										<h4>
											<font color="#343690">Loading</font>
										</h4>
									</span> <span class="l-1"></span> <span class="l-2"></span> <span
										class="l-3"></span> <span class="l-4"></span> <span
										class="l-5"></span> <span class="l-6"></span>
								</div>



						</div>
						<div align="center" id="loader1" style="display: none">

							<span>
								<h4>
									<font color="#343690">Loading</font>
								</h4>
							</span> <span class="l-1"></span> <span class="l-2"></span> <span
								class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
							<span class="l-6"></span>
						</div>
					</div>
					<!--Body-->

					<!--Footer-->
				</div>
				<!--/.Content-->
			</div>
	</div>








	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.ba-throttle-debounce.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.stickyheader.js"></script>
	<!----------------------------------------------End MODEL 1------------------------------------------------>
	<script type="text/javascript">
		function showDetailsForCp(expId, expAmt, expDate, chalanNo, frId) {
			var finTot = 0;
			var settleTotal=0;
			document.getElementById("total").value;
			//alert("hii" + frId + expAmt + expDate + chalanNo);
			$("#chNo").css("color", "red");
			$("#chAmt").css("color", "red");
			$("#frName").css("color", "red");
			$("#chDate").css("color", "red");

			document.getElementById("chNo").innerHTML = chalanNo;
			document.getElementById("chAmt").innerHTML = expAmt;
			document.getElementById("chDate").innerHTML = expDate;
			document.getElementById("frId").value = frId;
			document.getElementById("delDate").value = expDate;
			document.getElementById("expenseId").value = expId;

			$
					.getJSON(
							'${showPendingForFr}',
							{

								frId : frId,
								expId : expId,
								expAmt : expAmt,
								ajax : 'true',
							},
							function(data) {
								
								if(data==""){
									document.getElementById("expId").value=0;
								}else{
									document.getElementById("expId").value=expId;
								}

								$('#modeltable td').remove();
								document.getElementById("frName").innerHTML = data[0].frName;
								var totalcalc = 0;

								$.each(data, function(key, data1) {
									
									var flag = 0;
									var y = 0;
									var tot = document.getElementById("total").value;

									if (parseFloat(data1.pendingAmt) <= parseFloat(expAmt)) {
										if ((parseFloat(tot) + parseFloat(data1.pendingAmt)) > parseFloat(expAmt)) {

											y = (parseFloat(tot) + parseFloat(data1.pendingAmt))- parseFloat(expAmt);
											flag = 1;
										}
									}

									var tr = $('<tr></tr>');

									
									tr.append($('<td></td>').html(key + 1));
									
									tr.append($('<td></td>').html(data1.billNo+ ""+ "<input type=hidden value='"+data1.billNo+"'  id=billNo"+data1.billHeadId+"  name=billNo"+data1.billHeadId+"  >"));

									tr.append($('<td></td>').html(data1.billDate+ ""+ "<input type=hidden value='"+data1.billDate+"'  id=billDate"+data1.billHeadId+"  name=billDate"+data1.billHeadId+"  >"));
							
									tr.append($('<td></td>').html(data1.billAmt+ ""+ "<input type=hidden value='"+data1.billAmt+"'  id=billAmt"+data1.billHeadId+"  name=billAmt"+data1.billHeadId+"  >"));
							
									tr.append($('<td></td>').html(data1.paidAmt+ ""+ "<input type=hidden value='"+data1.paidAmt+"'  id=paidAmt"+data1.billHeadId+"  name=paidAmt"+data1.billHeadId+"  >"));

									tr.append($('<td></td>').html(data1.pendingAmt+ ""+ "<input type=hidden value='"+data1.pendingAmt+"'  id=pendingAmt"+data1.billHeadId+"  name=pendingAmt"+data1.billHeadId+"  >"));

									tr.append($('<td></td>').html(data1.settleAmt+ ""+ "<input type=hidden value='"+data1.settleAmt+"'  id=settleAmt"+data1.billHeadId+"  name=settleAmt"+data1.billHeadId+"  >"));

									
									/* tr.append($('<td></td>').html("<input type=text onkeypress='return IsNumeric(event);'   style='width:100px;border-radius:25px; font-weight:bold;text-align:center;'  readonly ondrop='return false;' min='0'  onpaste='return false;' style='text-align: center;' class='form-control' name='settleAmt"
											+ data1.billHeadId
											+ "'  id=settleAmt"
											+ data1.billHeadId
											+ " value="
											+ data1.settleAmt
											+ "  /> &nbsp;  ")); */
									
									settleTotal=parseFloat(settleTotal)+parseFloat(data1.settleAmt);
									
									$('#modeltable tbody').append(tr);

								});
								
								
								var tr = $('<tr></tr>');

								tr.append($('<td></td>').html(" "));
								tr.append($('<td></td>').html(" "));
								tr.append($('<td></td>').html(" "));
								tr.append($('<td></td>').html(" "));
								tr.append($('<td></td>').html(" "));
								tr.append($('<td></td>').html(" TOTAL "));
								tr.append($('<td></td>').html(settleTotal.toFixed(2)));
								
								$('#modeltable tbody').append(tr);
							
								
								 if(parseFloat(expAmt)-parseFloat(settleTotal)==0){
									$("#sbtbtn").prop("disabled", false);

								}else{
									$("#sbtbtn").prop("disabled", true);
									
									var tr = $('<tr></tr>');

									tr.append($('<td></td>').html(" "));
									tr.append($('<td></td>').html(" "));
									tr.append($('<td></td>').html(" "));
									tr.append($('<td></td>').html(" "));
									tr.append($('<td></td>').html(" "));
									tr.append($('<td></td>').html(" REMAINING AMT "));
									tr.append($('<td></td>').html(parseFloat(expAmt)-parseFloat(settleTotal)));
									
									$('#modeltable tbody').append(tr);

								} 

							});
		}
	</script>
	<script type="text/javascript">
		function showTotalQty() {

			//alert("hii");
			var arr = [];
			$('input[name="chkItem"]:checked').each(function() {
				arr.push(this.value);
			});
			var totalQty = 0;
			arr.forEach(function(v) {
				var itemQty = parseFloat($('#settleAmt' + v).val());
				totalQty = totalQty + itemQty;
			});
			document.getElementById("total").value = totalQty.toFixed(3);
			var chAmt = document.getElementById("chAmt").innerHTML;

			if (parseFloat(total) <= parseFloat(chAmt)) {
				$("#sbtbtn").prop("disabled", false);

			}

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