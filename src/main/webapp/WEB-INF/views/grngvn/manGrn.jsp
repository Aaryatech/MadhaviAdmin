<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

 	 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tableSearch.css">

<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>
	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>



	<c:url var="getItemsByBillNo" value="/getItemsByBillNo"></c:url>

	<c:url var="getBillForFr" value="/getBillForFr"></c:url>
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
					<i class="fa fa-file-o"></i>Manual Grn
				</h1>
				<!-- <h4>Franchise Manual Grn</h4> -->
			</div>
		</div>
		<!-- END Page Title -->

		<!-- BEGIN Breadcrumb -->
<%-- 		<div id="breadcrumbs">
			<ul class="breadcrumb">
				<li><i class="fa fa-home"></i> <a
					href="${pageContext.request.contextPath}/home">Home</a> <span
					class="divider"><i class="fa fa-angle-right"></i></span></li>
				<!-- 	<li class="active">Sell Transaction<span
					class="divider"><i class="fa fa-angle-right"></i></span></li>	
				<li class="active">Franchise Opening Stock</li> -->
			</ul>
		</div> --%>
		<!-- END Breadcrumb -->

		<!-- BEGIN Main Content -->
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-bars"></i>Menu
				</h3>

			</div>

			<div class="box-content">
				<div class="row">
					<div class="form-group">
						<label class=" col-md-2 control-label franchisee_label">Select
							Franchise </label>
						<div class=" col-md-3 controls franchisee_select">
							<select class="form-control chosen " tabindex="6" id="selectFr"
								name="selectFr" onchange="getBills()">

								<option value="-1">Select Franchisee</option>
								<c:forEach items="${frList}" var="fr" varStatus="count">
									<option value="${fr.frId}"><c:out value="${fr.frName}"/></option>
								</c:forEach>

							</select>
						</div>
					
						<label class="col-md-2 control-label menu_label">Select
							Bill</label>
						<div class=" col-md-3 controls menu_select">

							<select data-placeholder="Choose Bill"
								class="form-control chosen" tabindex="6" id="selectMenu"
								name="selectMenu">
							</select>
						</div>
					</div>

					<div class="form-group col-md-2">
						<div class="row" align="left">
							<div class="col-md-12" style="text-align: center">
								<button class="btn btn-primary" onclick="getItems()">Search</button>

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
<div class="col-md-9" ></div> 
					<label for="search" class="col-md-3" id="search">
    <i class="fa fa-search" style="font-size:20px"></i>
									<input type="text"  style="border-radius:25px;" id="myInput" onkeyup="myFunction()" style="border-radius: 25px;" placeholder="Search by ItemName" >
										</label>  
				</div>
			</div>
			
		</div>
		<div class="box">
			<div class="box-title">
				<h3>
					<i class="fa fa-list-alt"></i>Items For Manual Grn
				</h3>

			</div>

			<form id="openingStockForm"
				action="${pageContext.request.contextPath}/insertManGrn"
				method="post"  onsubmit="btnSubmit.disabled = true; return confirm('Do you want to save Grn ?');">
				<div class=" box-content">
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid" align="left">
								<thead style="background-color:#f3b5db; ">
									<tr>
										<th width="50">SELECT</th>
										<th width="50">Invoice</th>
										<th width="40">Item Name</th>
										<th width="40">GRN %</th>
										<th width="50">Pur Quantity</th>
										<th width="10">Rate</th>
										<th width="40">Grn Qty</th>
										<th width="50">Tax %</th>
										<th width="50">Taxable Amt</th>
										<th width="40">Tax Amt</th>
										<th width="40">Amount</th>
										<th width="50">Remark</th>

									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
					</div>

					<div class="row">
						<div class="form-group">
						
					<label class=" col-md-1 control-label franchisee_label">Date</label>
						<div class="col-sm-3 col-lg-2 controls">
										<input class="form-control date-picker" id="date" size="19" placeholder="dd-mm-yyyy"
											type="text" name="date"  required/>
									</div>
							<div class="col-sm-9 col-sm-offset-1 col-lg-1 col-lg-offset-1">

								<input type="submit" class="btn btn-primary" value="Submit"  id="btnSubmit"   disabled="disabled">
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- END Main Content -->

	<footer>
		<p>2019 © MADHVI.</p>
	</footer>

	<a id="btn-scrollup" class="btn btn-circle btn-lg" href="#"><i
		class="fa fa-chevron-up"></i></a>

	<script type="text/javascript">
				function getBills() {
					var selectedFr = $("#selectFr").val();
				
					
					$.getJSON('${getBillForFr}', {
						fr_id: selectedFr,
						ajax : 'true'
					}, function(data) {
						
						var len = data.length;
						
						$('#selectMenu')
					    .find('option')
					    .remove()
					    .end()
					    
			
						 $("#selectMenu").append(
	                                $("<option></option>").attr(
	                                    "value",'-1').text('Select Bill')
	                            );		
								
						for ( var i = 0; i < len; i++) {
							
					          
	                        $("#selectMenu").append(
	                                $("<option></option>").attr(
	                                    "value", data[i].billNo).text(data[i].invoiceNo+ " [" +data[i].billDate+" ]")
	                            );
						}
					 
						   $("#selectMenu").trigger("chosen:updated");
						 
					});
				}
			</script>


	<script type="text/javascript">
				function getItems() {
//alert("Hi");
					var bill = $("#selectMenu").val();
					
					//alert(bill);
					$('#loader').show();
					
					$.getJSON('${getItemsByBillNo}', {
						bill_no: bill,
						ajax : 'true'
					}, function(data) {
						//alert(data);
						var len = data.length;
						$('#btnSubmit').removeAttr("disabled");

						if(data==null){
							alert("No Record Found ")
							$('#loader').hide();
							$("#btnSubmit").attr("disabled", true);

						}
						
						$('#table_grid td').remove();
						$('#loader').hide();
						
						/* if (data == "" || data==null) {
							alert("No Items found !!");
							$('#submitStock').hide();
						}else{
							$.each(data,function(key, bill) { */
					
								$.each(data,function(key, bill) {
									
								 if(parseInt(bill.billQty)>0){

							var tr = $('<tr></tr>');

						  /* 	tr.append($('<td></td>').html(key+1)); */
														
							tr.append($('<td></td>').html("<input type=checkbox  id=check"+bill.billDetailNo+" name="+bill.billDetailNo+" value="+bill.billDetailNo+">"));
						  
						  						  	//tr.append($('<td></td>').html(bill.invoiceNo));


						  	tr.append($('<td></td>').html(bill.invoiceNo));

						  	tr.append($('<td></td>').html(bill.itemName));
						  
						  	
						  	tr.append($('<td></td>').html("<input type=text  onkeyup='return calcGrn("+bill.billQty+","+bill.rate+","+bill.itemId+","+bill.sgstPer+","+bill.cgstPer+","+bill.billDetailNo+","+bill.discPer+")' ondrop='return false;' onpaste='return false;' style='text-align: center; width:60px;' class='form-control' min=0 max=100 id=grnPer"+bill.billDetailNo+" name=grnPer"+bill.billDetailNo+" value="+bill.grnType+">"));
						  	tr.append($('<td></td>').html(bill.billQty));
						  	tr.append($('<td></td>').html(bill.rate));
						  	
						  //	tr.append($('<td></td>').html(bill.rate));

						 	tr.append($('<td></td>').html("<input type=text  onkeyup='return calcGrn("+bill.billQty+","+bill.rate+","+bill.itemId+","+bill.sgstPer+","+bill.cgstPer+","+bill.billDetailNo+","+bill.discPer+")' ondrop='return false;' onpaste='return false;' style='text-align: center;' class='form-control' min=0 id=qty"+bill.billDetailNo+" name=qty"+bill.billDetailNo+" Value="+0+" >"));
						  	tr.append($('<td></td>').html(bill.igstPer));
						  	tr.append($('<td id=taxable_amt'+bill.billDetailNo+'></td>').html(""));
						  	tr.append($('<td id=tax_amt'+bill.billDetailNo+'></td>').html(""));
						  	tr.append($('<td id=grn_amt'+bill.billDetailNo+'></td>').html(""));
						  	
						  	tr.append($('<td></td>').html(""));

						 	//tr.append($('<td></td>').html(' <a>   <span class="glyphicon glyphicon-edit" id="edit'+bill.billNo+'" onClick=editQty('+bill.billNo+');> </span> </a><a><span class="glyphicon glyphicon-remove" id="delete'+bill.billDetailNo+'" onClick=deleteOrder('+bill.billDetailNo+');> </span></a>'));
						 
							$('#table_grid tbody').append(tr);
							
								}

						})
					
		    });
					
		    
		}
			</script>





	<script type="text/javascript">	
	
				function validate() {
				
					var selectedMenu = $("#selectMenu").val();

					var isValid = true;

					if (selectedFr == "-1" || selectedFr == null) {

						isValid = false;
						alert("Please select Franchise");

					} else if (selectedMenu == "" || selectedMenu == null) {

						isValid = false;
						alert("Please select Menu");

					}
					return isValid;

				}
				
				function calcGrn(billQty,rate,itemId,cgstPer,sgstPer,dNo,discPer) {
									
					document.getElementById("check"+dNo).checked = false;
					
					var grnType=document.getElementById("grnPer"+dNo).value;
					//alert("GRN type="+grnType);
					
				    var grnQty =document.getElementById("qty"+dNo).value;	
				    
				    
				    if(parseInt(grnQty)>billQty){
						alert("Grn Quantity can not be greater than Purchase Quantity");
						
						document.getElementById("qty"+dNo).value=0;
						
						$("#grn_amt"+dNo).html(0.00);
						$("#taxable_amt"+dNo).html(0.00);
						$("#tax_amt"+dNo).html(0.00);
						
						document.getElementById("check"+dNo).checked = false;
						
					}else{
				    if(grnQty>0)
					{
					document.getElementById("check"+dNo).checked = true;
				
					}
					var baseRate=rate;
					
					var grnBaseRate;
					var grnRate;
					
					var grnRate=rate;
					grnBaseRate = baseRate * grnType / 100;
					//alert("grnBaseRate "+grnBaseRate);
					
					grnRate=(rate * grnType) / 100;
					//alert("grnRate "+grnRate);
					
				  
						var totTaxPer=parseFloat(sgstPer)+parseFloat(cgstPer);
						var taxableAmt=grnBaseRate*grnQty;
						//alert("prev taxableAmt " +taxableAmt)

						var discAmt=(taxableAmt*discPer)/100;
						//alert("disc  " +discAmt)

						taxableAmt=taxableAmt-discAmt;
						//alert("new  taxableAmt " +taxableAmt)

						var totalTax=taxableAmt*(cgstPer+sgstPer)/100;
						var grandTotal=taxableAmt+totalTax;
						//alert("taxable " +taxableAmt);
						//alert("totalTax " +totalTax);
						//alert("grandTotal " +grandTotal);
					$("#grn_amt"+dNo).html(grandTotal.toFixed(2));
					$("#tax_per"+dNo).html(totTaxPer.toFixed(2));
					$("#taxable_amt"+dNo).html(taxableAmt.toFixed(2));
					$("#tax_amt"+dNo).html(totalTax.toFixed(2));
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
		<script>
function myFunction() {
  var input, filter, table, tr, td,td1, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("table_grid");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[1];
    td1 = tr[i].getElementsByTagName("td")[2];

    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      }else if (td1.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      }  else {
        tr[i].style.display = "none";
      }
    }       
  }
}
</script>
</body>
</html>