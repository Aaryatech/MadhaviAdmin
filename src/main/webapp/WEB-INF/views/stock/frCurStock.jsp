<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>


	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>


	<c:url var="getFrStock" value="/getFrStock"></c:url>
	<c:url var="getFrListofAllFr" value="/getAllFrListForStock"></c:url>
	<c:url var="getAllItemsByCategoryForFrStock"
		value="/getAllItemsByCategoryForFrStock"></c:url>

	<c:url var="selectAllFrListForStock" value="/selectAllFrListForStock"></c:url>




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

		<!-- BEGIN Breadcrumb -->

		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Franchisee Item Stock
				</h3>

			</div>

			<div class="box-content">

				<div class="row">
					<div class="form-group">


						<label class="col-sm-3 col-lg-1 control-label"> Franchisee</label>
						<div class="col-sm-6 col-lg-11">

							<select data-placeholder="Choose Franchisee"
								class="form-control chosen" multiple="multiple" tabindex="6"
								id="selectFr" name="selectFr"
								onchange="setAllFrSelected(this.value)"
								onchange="disableRoute()">

								<option value="-1"><c:out value="All" /></option>

								<c:forEach items="${unSelectedFrList}" var="fr"
									varStatus="count">
									<option value="${fr.frId}"><c:out value="${fr.frName}" /></option>
								</c:forEach>
							</select>

						</div>

					</div>
				</div>

				<br>
				<div class="row">
					<div class="form-group">


						<label class="col-sm-3 col-lg-1 control-label">Category</label>
						<div class="col-sm-9 col-lg-11 controls">
							<select data-placeholder="Select Category"
								class="form-control chosen" name="item_grp1" tabindex="-1"
								id="item_grp1" data-rule-required="true"
								onchange="getItemsByCatId(this.value)">
								<option selected>Select Category</option>

								<c:forEach items="${mCategoryList}" var="mCategoryList">


									<option value="${mCategoryList.catId}"><c:out
											value="${mCategoryList.catName}"></c:out></option>
								</c:forEach>


							</select>
						</div>



					</div>
				</div>

				<br>
				<div class="row">
					<div class="form-group">


						<label class="col-sm-3 col-lg-1 control-label"> Items</label>
						<div class="col-sm-6 col-lg-11">

							<select data-placeholder="Choose Items"
								class="form-control chosen" multiple="multiple" tabindex="6"
								id="selectItem" name="selectItem"
								onchange="selectAllItems(this.value)">

							</select>

						</div>

					</div>
				</div>

				<br>
				<div class="row">
					<div class="col-md-12" style="text-align: center;">
						<button id="btnStock" class="btn btn-info" onclick="getStock()">Get
							Stock</button>
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
		</div>


		
		<!-- END Main Content -->

		<footer>
			<p>2019 © MADHAVI.</p>
		</footer>

		<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
			class="fa fa-chevron-up"></i></a>







		<script type="text/javascript">
			function getStock() {

				var selectedFr = $("#selectFr").val();
				var selectItem = $("#selectItem").val();
				var catId = $("#item_grp1").val();

				var isValid = 1;

				if (isValid == 1) {

					$('#loader').show();

					$.getJSON('${getFrStock}', {
						selectedFr : JSON.stringify(selectedFr),
						selectItem : JSON.stringify(selectItem),
						catId : catId,
						ajax : 'true'
					}, function(data) {

						//document.getElementById("btnStock").disabled = true;

						//alert(JSON.stringify(data));

						$('#table_grid th').remove();
						$('#table_grid td').remove();

						$('#loader').hide();

						if (data == "") {
							alert("No records found !!");
						} else {
							exportToExcel();
						}

						/* var tr;
						tr = document
								.getElementById('table_grid').tHead.children[0];
						tr.insertCell(0).outerHTML = "<th align='left'>Sr.No.</th>"

						tr.insertCell(1).outerHTML = "<th style='width=130px'>Item Name</th>"
						var i = 0;
						var j = 0;
						$.each(data.frIdNamesList, function(
								key, fr) {
							i = key + 2;
							tr.insertCell(i).outerHTML = "<th>"
									+ fr.frName + "</th>"
						});

						$('#table_grid tbody').append(tr);

						var srNo = 0;
						$
								.each(
										data.itemList,
										function(key, item) {
											//alert(item.itemName)
											srNo = srNo + 1;
											var tr = $('<tr></tr>');
											tr
													.append($(
															'<td></td>')
															.html(
																	srNo));
											tr
													.append($(
															'<td></td>')
															.html(
																	item.itemName));
											$
													.each(
															data.frIdNamesList,
															function(
																	key,
																	franchise) {


																tr
																		.append($(
																				'<td></td>')
																				.html(
																						"<h4 name=itemQty"+franchise.frId+""+item.id+" id=itemQty"+franchise.frId+""+item.id+"></h4>"));

															});

											$(
													'#table_grid tbody')
													.append(tr);

										});//itemList for end

						$
								.each(
										data.currentStockDetailList,
										function(key, report) {


											document
													.getElementById('itemQty'
															+ report.frId
															+ ''
															+ report.itemId).innerHTML = report.regCurStock;

										}); */

					});
				}

			}
		</script>




		<script type="text/javascript">
			function exportToExcel() {

				//alert("hi");

				window.open("/admin/exportToExcelNew");
				document.getElementById("expExcel").disabled = true;
			}
		</script>

		<script type="text/javascript">
			function validate() {

				var selectedFr = $("#selectFr").val();
				var selectedRoute = $("#selectRoute").val();

				var isValid = true;

				if ((selectedFr == "" || selectedFr == null)
						&& (selectedRoute == 0)) {

					alert("Please Select Route  Or Franchisee");
					isValid = false;

				}
				return isValid;

			}
		</script>

		<script>
			function setAllFrSelected(frId) {
				//alert("frId" + frId);
				//alert("hii")
				if (frId == -1) {

					$.getJSON('${getFrListofAllFr}', {

						ajax : 'true'
					}, function(data) {

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


		<script>
			function getItemsByCatId(catId) {
				//alert("frId" + frId);
				//alert("hii")

				$.getJSON('${getAllItemsByCategoryForFrStock}', {
					catId : catId,
					ajax : 'true'
				}, function(data) {

					var len = data.length;

					$('#selectItem').find('option').remove().end()
					$("#selectItem").append(
							$("<option value='-1'>All</option>"));
					for (var i = 0; i < len; i++) {
						$("#selectItem").append(
								$("<option ></option>").attr("value",
										data[i].id).text(data[i].itemName));
					}
					$("#selectItem").trigger("chosen:updated");
				});
			}
		</script>


		<script>
			function selectAllItems(id) {
				//alert("frId" + frId);
				//alert("hii")
				if (id == -1) {

					$.getJSON('${selectAllFrListForStock}', {
						ajax : 'true'
					}, function(data) {

						var len = data.length;

						//alert(len);

						$('#selectItem').find('option').remove().end()
						$("#selectItem").append(
								$("<option value='-1'>All</option>"));
						for (var i = 0; i < len; i++) {
							$("#selectItem").append(
									$("<option selected ></option>").attr(
											"value", data[i].id).text(
											data[i].itemName));
						}
						$("#selectItem").trigger("chosen:updated");
					});
				}
			}
		</script>


		<script type="text/javascript">
			function tableToExcel(table, name, filename) {
				let uri = 'data:application/vnd.ms-excel;base64,', template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><title></title><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>', base64 = function(
						s) {
					return window
							.btoa(decodeURIComponent(encodeURIComponent(s)))
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