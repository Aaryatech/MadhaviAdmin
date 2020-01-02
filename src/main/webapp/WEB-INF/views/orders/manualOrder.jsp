<%@page import="com.ats.adminpanel.model.franchisee.SubCategory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page
	import="java.io.*, java.util.*, java.util.Enumeration, java.text.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Madhvi</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


<style type="text/css">
.close_popup{position: absolute; right: 10px; top:12px; background: none; border: 0; color: #F00; font-size: 20px;}
.add_customer{background: #FFF; width: 100%; margin: 2px auto 0 auto;}
.add_customer_one{float: left; width: 30%; font-size: 14px; font-weight: 700; text-align: left; margin:5px 0 0 0;}
.close_popup{position: absolute; right: 10px; top:12px; background: none; border: 0; color: #F00; font-size: 20px;}
.pop_head{font-size: 18px; padding: 15px; border-bottom: 1px solid #f4f4f4; letter-spacing: 0.5px; display: inline-block; width: 100%;}
.add_frm{padding: 15px; border-bottom: 1px solid #f4f4f4;}
.add_frm_one{margin: 6px 0; display: inline-block; width: 100%;}
.add_customer_bx{display: block;}
.customer_row{margin: 5px 0;}
.customer_one{float: left; width: 20%; font-size: 14px; color: #444;}
.customer_two{float: left; width: 65%;}
.customer_three{float: left; width: 4%; padding: 0 5px;}
.add_input{float: right; width: 70%;}
.radio_row.popup_radio{margin: 5px 0 0 0;}
.radio_row{display: inline-block; position: relative;}

.radio_row ul{list-style: none; margin: 0; padding: 0; overflow: auto;}
.radio_row ul li{color: #777; display: block; position: relative; float: left; padding-left: 5px;}
.plus_btn{background: #444; color: #FFF; border: 1px solid #3c3c3c; font-size: 15px; padding: 4px 10px;}
.plus_btn:hover{background: #fff600; color: #333; border: 1px solid #f5ed00;}
.input_add{font-size: 12px; font-weight: 400; color: #333; padding: 6px 12px; border: 1px solid #d2d6de; width: 100%;}
.input_add:focus{border: 1px solid #3c8dbc;}
.input_add *:focus {border: 1px solid #3c8dbc;}
.pop_btns{padding: 15px;}
.close_l{float: left;}
.close_btn{background: #f4f4f4; border: 1px solid #ddd; padding: 6px 14px; font-size: 14px; border-radius: 3px; color: #444; -webkit-transition: all ease 0.5s;-moz-transition: all ease 0.5s;-o-transition: all ease 0.5s;-ms-transition: all ease 0.5s;transition: all ease 0.5s;}
.close_btn:hover{background: #e7e7e7; border: 1px solid #adadad; -webkit-transition: all ease 0.5s;-moz-transition: all ease 0.5s;-o-transition: all ease 0.5s;-ms-transition: all ease 0.5s;transition: all ease 0.5s;}
.close_r{float: right;}
.close_r a{background: #ed1b24; border: 1px solid #e1001b; padding: 6px 14px; font-size: 14px; color: #FFF; border-radius: 3px; display: inline-block; -webkit-transition: all ease 0.5s;-moz-transition: all ease 0.5s;-o-transition: all ease 0.5s;-ms-transition: all ease 0.5s; transition: all ease 0.5s;}
.close_r a:hover{background: #fff600; color: #333; border: 1px solid #f5ed00; -webkit-transition: all ease 0.5s;-moz-transition: all ease 0.5s;-o-transition: all ease 0.5s;-ms-transition: all ease 0.5s; transition: all ease 0.5s;}

select {
    width: 180px;
    height: 30px;
}
</style>
<style>
.switch {
  position: relative;
  /* display: inline-block; */
  width: 60px;
  height: 41px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 16px;
  width: 20px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #F87DA9;
}

input:focus + .slider {
  box-shadow: 0 0 1px #F87DA9;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

[type="radio"]:checked,
[type="radio"]:not(:checked) {
    position: absolute;
    left: -9999px;
}
[type="radio"]:checked + label,
[type="radio"]:not(:checked) + label
{
    position: relative;
    padding-left: 28px;
    cursor: pointer;
    line-height: 20px;
    display: inline-block;
    color: #666;
}
[type="radio"]:checked + label:before,
[type="radio"]:not(:checked) + label:before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    width: 18px;
    height: 18px;
    border: 1px solid #ddd;
    border-radius: 100%;
    background: #fff;
}
[type="radio"]:checked + label:after,
[type="radio"]:not(:checked) + label:after {
    content: '';
    width: 12px;
    height: 12px;
    background: #F87DA9;
    position: absolute;
    top: 3px;
    left: 3px;
    border-radius: 100%;
    -webkit-transition: all 0.2s ease;
    transition: all 0.2s ease;
}
[type="radio"]:not(:checked) + label:after {
    opacity: 0;
    -webkit-transform: scale(0);
    transform: scale(0);
}
[type="radio"]:checked + label:after {
    opacity: 1;
    -webkit-transform: scale(1);
    transform: scale(1);
}

/* The Modal (background) */
.modal {
	 /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 9999; /* Sit on top */
	padding-top: 60px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 8px 20px 20px 20px;
	border: 1px solid #888;
	width: 45%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
</style>

</head>
<body onload="showPdf('${billNo}')">
<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>
<c:url var="checkEmailText" value="/checkEmailText" />
<c:url var="saveCustomerFromBill" value="/saveCustomerFromBill" />
<c:url var="editCustomerFromBill" value="/editCustomerFromBill" />
	<c:url var="setAllItemSelected" value="/setAllItemSelected" />
	<c:url var="findFranchiseeData" value="/findFranchiseeData" />
	<c:url var="findItemsByCatId" value="/getItemsOfMenuId" />
	<c:url var="findItemsByCatIdForMulFr" value="/getItemsOfMenuIdForMulFr" />
	<c:url var="findAllMenus" value="/getMenuForOrder" />
	<c:url var="getAllMenu" value="/getAllMenu" />
	<c:url var="insertItem" value="/insertItem" />
	<c:url var="deleteItems" value="/deleteItems" />
	<c:url var="generateManualBill" value="/generateManualBill" />
	<c:url var="getItemsByCatIdManOrder" value="/getItemsByCatIdManOrder" />
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>


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
						<i class="fa fa-file-o"></i> Manual Order
					</h1>
				</div>
			</div> -->
			<!-- END Page Title -->


			<!-- BEGIN Main Content -->
			<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12">
							<div class="box">
								<div class="box-title">
									<h3>
										<i class="fa fa-bars"></i>  Manual Order
									</h3>
									<div class="box-tool">
										<a href="${pageContext.request.contextPath}/"></a> <a data-action="collapse" href="#"><i
											class="fa fa-chevron-up"></i></a>
									</div>
								</div>
		
		<form action="${pageContext.request.contextPath}/generateManualBill" class="form-horizontal"
										id="validation-form" method="post">

								
								<div class="box-content">
									<%-- <form action="${pageContext.request.contextPath}/addManualOrder" class="form-horizontal"
										id="validation-form" method="post"> --%>
						<div class="form-group">
			<label class="col-sm-3 col-lg-2 control-label">Order Type</label>
									  <label class="col-sm-3 col-lg-2 control-label">
    <input type="radio" name="ordertype" class="order" value="0" id="or1" checked onchange="checkCheckedStatus()">
  <label for="or1"> Manual Order</label>
  </label>
<label class="col-sm-3 col-lg-2 control-label">
    <input type="radio" name="ordertype" class="order" value="1" id="or2" onchange="checkCheckedStatus()">
   <label for="or2"> Manual Bill </label>
  </label>		
 <!--  <label class="col-sm-3 col-lg-2 control-label">
    <input type="radio" name="ordertype" class="order" value="2" id="or3" onchange="checkCheckedStatus()">
   <label for="or3"> Multiple FR Bill </label>
  </label> -->
  
  <div id="dailyMartDiv" style="display: none;">
  	<label class="col-sm-3 col-lg-2 control-label">	 Is Dairy Mart?	</label>
  <label class="switch">
  <input type="checkbox" id="isDairyMart" name="isDairyMart" onchange="onDairyMartCheck()" >
  <span class="slider round"></span>
</label>

  	</div>				    
  </div>

	<input type="hidden" name="flagRate" value="0"	id="flagRate"/>


										<div class="form-group" id="singleFr">
											<label class="col-sm-3 col-lg-2 control-label">Franchisee</label>
											<div class="col-sm-9 col-lg-5 controls">
												<select data-placeholder="Select Franchisee" name="fr_id"
													class="form-control chosen" tabindex="-1" id="fr_id"
													onchange="findFranchiseeData(this.value)">
													<option value="0">Select Franchisee </option>
														<c:forEach
															items="${allFranchiseeAndMenuList.getAllFranchisee()}"
															var="franchiseeList">
															<option value="${franchiseeList.frId}">${franchiseeList.frName}</option>

														</c:forEach>
												

												</select>
											</div>
											
										</div>
<div class="form-group" style="display: none;" id="mulFr">
											<label class="col-sm-3 col-lg-2 control-label">Franchisee</label>
											<div class="col-sm-9 col-lg-5 controls">
												<select data-placeholder="Select Franchisee" name="fr_id1"
													class="form-control chosen" tabindex="-1" id="fr_id1" multiple="multiple"
													 >
													<option value="0">Select Franchisee </option>
														<c:forEach
															items="${allFranchiseeAndMenuList.getAllFranchisee()}"
															var="franchiseeList">
															<c:if test="${franchiseeList.frRateCat==1}">
																<option value="${franchiseeList.frId}">${franchiseeList.frName}</option>
															</c:if>

														</c:forEach>
												

												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Menu</label>
											<div class="col-sm-9 col-lg-5 controls">
												<select data-placeholder="Select Menu" name="menu"
													class="form-control"  id="menu"
													data-rule-required="true" onchange="onCatIdChangeForManOrder(this.value)">
	                                            	<option value="0">Select Menu </option>                                                     


												</select>
											</div>
											
											<div style="display: none;">
											<label class="col-sm-3 col-lg-2	 control-label">Select
							Section</label>
						<div class="col-sm-6 col-lg-3 controls date_select">
							<select data-placeholder="Choose Menu"
								class="form-control chosen" id="sectionId" name="sectionId"
								>

								<option value="">Select Section</option>

								<%-- <c:forEach items="${sectionList}" var="sectionList"> --%>
									<option  selected value="1"><c:out
											value="First Delivery (Next Day)" /></option>
							<%-- 	</c:forEach> --%>


							</select>
						</div>
						</div>
										</div>
										<div class="form-group">
										<label class="col-sm-3 col-lg-2 control-label">Order</label>
									  <label class="col-sm-3 col-lg-2 control-label">
    <input type="radio" name="typename" class="type" value="0" checked="" id="t1" onchange="checkOrderByStatus()">
    <label for="t1">Billing</label>
  </label>
<label class="col-sm-3 col-lg-2 control-label">
    <input type="radio" name="typename" class="type" value="1" id="t2" onchange="checkOrderByStatus()">
    <label for="t2">By MRP</label>
  </label>			
  	<label class="col-sm-3 col-lg-1	 control-label">Delivery</label>
						<div class="col-sm-6 col-lg-2 controls date_select">
							<select data-placeholder="Choose Menu"
								class="form-control chosen" id="delType" name="delType" onchange="onDelChange(this.value)">
								<option value="">Select Delivery</option>
	                            <option value="1">Same Day</option>
	                        	<option value="2">Regular</option>
	                        	<option value="3">Advance Order</option>
							</select>
		</div>		
		<div id="dt" style="display: none;"> <div class="col-md-1" style="width: 10.333333%;">
										<input class="form-control date-picker" id="delDate" size="16"   style="width: 110px;"
											type="text" name="delDate"  placeholder="dd-MM-yyyy"   autocomplete="off"/>
										</div><div class="col-md-1">	<input type="text" id="clockface_1" name="delTime" value="2:30 PM" data-format="hh:mm A" style="width: 110px;" class="form-control small clockface-open">
											
								</div>	</div>				    
  </div>
		<div class="form-group" id="custSelDiv" style="display: none;">
			
			<label class="col-sm-3 col-lg-2 control-label">Bill To Customer</label>
											<div class="col-sm-9 col-lg-2 controls">
												<select data-placeholder="Select Customer" name="cust"
													class="form-control chosen"  id="cust"
													  onchange="onCustChange()">
	                                            	<option value="0">Select Customer </option>                                                     
	                                         <c:forEach items="${customerList}" var="customerList">
												<c:choose>
													<c:when test="${customerList.custId==defaultCustomer}">
														<option value="${customerList.custId}"
															style="text-align: left;" selected>${customerList.custName}
															&nbsp;${customerList.phoneNumber}</option>
													</c:when>
													<c:otherwise>
														<option value="${customerList.custId}"
															style="text-align: left;">${customerList.custName}
															&nbsp;${customerList.phoneNumber}</option>
													</c:otherwise>
												</c:choose>

											</c:forEach>

												</select>
											</div>
											
							<div class="customer_three">
								<button class="plus_btn addcust_open" type="button"  onclick="openMyModal('myModal')">
									<i class="fa fa-plus" aria-hidden="true"></i>
								</button>
							</div>
							<div class="customer_three">
								<button class="plus_btn" type="button" onclick="editCustomer()">
									<i class="fa fa-pencil" aria-hidden="true"></i>
								</button>
							
							</div>
							</div>
				<div class="form-group">
				
		<div id="custOrder"  style="display: none;">
		
											<label class="col-sm-3 col-lg-2 control-label">Cust Name</label>
											<div class="col-sm-9 col-lg-2 controls">
				<input type="text" name="billToName" value="${defCust.custName}"	id="billToName" class="form-control"/>
											
											</div>
											<label class="col-sm-3 col-lg-1 control-label">GSTIN</label>
											<div class="col-sm-9 col-lg-2 controls">
				<input type="text" name="billToGstin" value="${defCust.gstNo}"	id="billToGstin" class="form-control"/>								
											</div>
											<label class="col-sm-3 col-lg-1 control-label">Address</label>
											<div class="col-sm-9 col-lg-3 controls">
				<input type="text" name="billToAddress" value="${defCust.address}"	id="billToAddress" class="form-control"/>						
											</div>
		</div>
		
		<div style="display: none;" id="mulOrder">
											<label class="col-sm-3 col-lg-2 control-label">Item</label>
											<div class="col-sm-9 col-lg-5 controls">
							<select data-placeholder="Choose Item"
								class="form-control chosen" id="itemId" name="itemId"
								>

								<option value="">Select Item</option>

								<c:forEach items="${itemList}" var="itemList">
									<option value="${itemList.id}"><c:out
											value="${itemList.itemName}" /></option>
								</c:forEach>


							</select>
						
											
				</div>
				<label class="col-sm-3 col-lg-1 control-label">Qty</label>
											<div class="col-sm-9 col-lg-2 controls">
				<input type="text" name="qty" value="0"	id="qty" class="form-control"/>						
											</div>		
				 <input type="button" class="btn btn-primary" id="searchBtn" value="Add" onclick="onSearchMulFr()"  >					
											
		</div>
		
											
		</div>			<div class="form-group" style="display: none;"  id="shipToFr">
		 <label class="col-sm-3 col-lg-2 control-label" >Ship To Franchise</label>
											<div class="col-sm-9 col-lg-2 controls">
												<select data-placeholder="ShipTo Franchisee" name="ship_fr_id"
													class="form-control chosen" tabindex="-1" id="ship_fr_id"
													onchange="findShipFranchiseeData(this.value)">
													<option value="0">Select Franchisee </option>
														<c:forEach
															items="${allFranchiseeAndMenuList.getAllFranchisee()}"
															var="franchiseeList">
															<option value="${franchiseeList.frId}">${franchiseeList.frName}</option>

														</c:forEach>
												

												</select>
											</div>	</div>		
		<div id="singleOrder" class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Party Name</label>
											<div class="col-sm-9 col-lg-2 controls">
				<input type="text" name="frName" value="-"	id="frName" class="form-control"/>
											
											</div>
											<label class="col-sm-3 col-lg-1 control-label">GSTIN</label>
											<div class="col-sm-9 col-lg-2 controls">
				<input type="text" name="gstin" value="-"	id="gstin" class="form-control"/>								
											</div>
											<label class="col-sm-3 col-lg-1 control-label">Address</label>
											<div class="col-sm-9 col-lg-3 controls">
				<input type="text" name="address" value="-"	id="address" class="form-control"/>						
											</div>
											 <input type="button" class="btn btn-primary" id="searchBtn" value="Search" onclick="onSearch()"  >
		</div>						
									<!-- 	<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Item</label>
											<div class="col-sm-9 col-lg-5 controls">
												<select data-placeholder="Select Item" name="items"
													class="form-control chosen" tabindex="-1" id="items"
													data-rule-required="true" >
                                                   	<option value="0">Select Item </option>
												</select>
												
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 col-lg-2 control-label">Qty</label>
											<div class="col-sm-9 col-lg-5 controls">
											<input type="text" name="qty" value="0"	id="qty" class="form-control"/>
												
											</div>
										</div> 
										<div class="form-group">
											<div
												class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2">
												<input type="button" class="btn btn-primary"
													value="Add Item" onclick="onSearch(this.value)"  >
												
											</div>
										</div>-->
									<!-- </form> -->	</div>
                <div align="center" id="loader" style="background-color:white;display: none; ">

					<span style="background-color:white;font-size: 15px;text-align: center;" >
							<font color="#343690" style="background-color:white;">Loading</font>
					
					</span> <span class="l-1"></span> <span class="l-2"></span> <span
						class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
					<span class="l-6"></span>
				</div>
							
		
		<div class="box-content">
		<div class="col-md-9" ></div> 
					<label for="search" class="col-md-3" id="search">
    <i class="fa fa-search" style="font-size:20px"></i>
									<input type="text"  id="myInput" onkeyup="myFunction()" autocomplete="off" style="border-radius: 25px;" placeholder="Search items by Name" title="Type in a name">
										</label>  <br> <br> <br>
					<div class="row">
						<div class="col-md-12 table-responsive">
							<table class="table table-bordered table-striped fill-head "
								style="width: 100%" id="table_grid">
								<thead style="background-color: #f3b5db;">
									<tr>
										<th style="text-align:center;">Sr.No.</th>
										<th style="text-align:center;">Item Name</th>
										
											<th style="text-align:center;" id="limQtyCol">Limit Qty</th>
										<th style="text-align:center;">Min Qty</th>
										<th style="text-align:center;">Qty</th>
										<th style="text-align:center;" id="discth">Disc</th>
										<th style="text-align:center;">MRP</th>
										<th style="text-align:center;">Rate</th>
										<th style="text-align:center;">Total</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>
				
					</div>
					<div class="row">
<div id="advOrderTotal" style="display:none;">
								<div class="col-md-1">Advance:</div>

								<div class="col-md-1">

									<input type="text" class="form-control" name="advanceAmt" id="advanceAmt2" onkeypress="return event.charCode >= 48"
										onchange="setAmt(2)" oninput="setAmt(2)" 
										autocomplete="off" required  size="20" value="0" />
								</div>

								<div class="col-md-2">Pending Amt:</div>
								<div class="col-md-1">

									<input type="text" name="remainAmt" id="remainAmt2"
										class="form-control" autocomplete="off" required value="0" 
										 size="20" readonly style="background-color: lightgrey;"/>
								</div>


								<div class="col-md-1">Total:</div>
								<div class="col-md-1" id="calTotal2" style="color: red;">00
								</div>

							<input type="hidden" name="fintotal1" id="fintotal2" value="0">
</div>
							<!-- </div>
						<div class="row"> -->
					
						<div class="col-md-1" style="float: right;">
							<input type="submit" class="btn btn-info" value="ORDER" name="submitorder" id="submitorder"  disabled>
<input type="submit" class="btn btn-info" value="ORDER_&_BILL" name="submitbill" id="submitbill" style="display: none;"  disabled>
						</div>
					</div>

	</div>
	<input type="hidden" name="dailyFlagMart" id="dailyFlagMart1"
							value="0">
	
	</form>
								<!-- <div align="center" id="loader1" style="display: none">

					<span>
						<h4>
							<font color="#343690">Saving your order,please wait</font>
						</h4>
					</span> <span class="l-1"></span> <span class="l-2"></span> <span
						class="l-3"></span> <span class="l-4"></span> <span class="l-5"></span>
					<span class="l-6"></span>
				</div>	 -->
							</div>
						</div>
					</div>
				</div>
					<div id="myModal" class="modal">

			<!-- Modal content -->
			<div class="modal-content">
					<div id="addcust" class="add_customer" >
			<button class="addcust_close close_popup"
				onclick="closeMyModal('myModal')">
				<i class="fa fa-times" aria-hidden="true"></i>
			</button>
			<h3 class="pop_head" id="add_cust_head_name">Add Customer</h3>

			<div class="add_frm">
				<div class="add_frm_one">
					<div class="add_customer_one">Customer Name</div>
					<div class="add_input">
						<input type="text" class="input_add"
							placeholder="Enter Customer Name" name="customerName"
							onchange="trim(this)" id="customerName" /> <input type="hidden"
							name="custId" id="custId" value="0" />
					</div>
					<div class="clr"></div>
				</div>
				<div class="add_frm_one">
					<div class="add_customer_one">Mobile Number</div>
					<div class="add_input">
						<input type="text" class="input_add"
							placeholder="Enter Mobile Number" name="mobileNo" id="mobileNo"
							onchange="trim(this)" maxlength="10" />
					</div>
					<div class="clr"></div>
				</div>

				<div class="add_frm_one">
					<div class="add_customer_one">Gender</div>
					<div class="add_input">
						<div class="radio_row popup_radio">
							<ul>
								<li><input type="radio" type="radio" name="gender"
									id="moption" checked value="1"> <label for="moption">M</label>
									<div class="check"></div></li>
								<li><input type="radio" id="foption" name="gender"
									value="2"> <label for="foption">F </label>
									<div class="check">
										<div class="inside"></div>
									</div></li>
							</ul>
						</div>
					</div>
					<div class="clr"></div>
				</div>
				<div class="add_frm_one">
					<div class="add_customer_one">Type</div>
					<div class="add_input">
						<select name="custType" id="custType"
							data-placeholder="Customer Type" class="input_add"
							style="text-align: left;" required>
							<option value="0" style="text-align: left;">Select
								Customer Type</option>
							<option value="1">Owner</option>
							<option value="2">Employee</option>
							<option value="3">Customer</option>
						</select>
					</div>
				</div>
				<div class="add_frm_one">
					<div class="add_customer_one">Age-Group</div>
					<div class="add_input">
						<select name="ageRange" id="ageRange"
							data-placeholder="Customer Age-Group" class="input_add"
							style="text-align: left;" required>
							<option value="0" style="text-align: left;">Customer
								Age-Group</option>
							<option value="14-21">14-21 Years</option>
							<option value="22-28">22-28 Years</option>
							<option value="29-35">29-35 Years</option>
							<option value="36-42">36-42 Years</option>
							<option value="43-49">43-49 Years</option>
							<option value="50-56">50-56 Years</option>
							<option value="57 & above">57 & above</option>

						</select>
					</div>
				</div>
				<div class="add_frm_one">
					<div class="add_customer_one">DOB</div>
					<div class="add_input">
						<input autocomplete="off" placeholder="Date Of Birth"
							name="dateOfBirth" id="dateOfBirth" type="date" class="input_add" />
					</div>
					<div class="clr"></div>
				</div>
				<div class="add_frm_one">
					<div class="add_customer_one">Business</div>
					<div class="add_input">
						<div class="radio_row popup_radio">
							<ul>
								<li><input type="radio" type="radio" name="selector"
									id="y-option" onclick="isBuissness(1)"> <label
									for="y-option">Yes</label>
									<div class="check"></div></li>
								<li><input type="radio" id="n-option" name="selector"
									onclick="isBuissness(0)" checked> <label for="n-option">No
								</label>
									<div class="check">
										<div class="inside"></div>
									</div></li>
							</ul>
						</div>
					</div>
					<div class="clr"></div>
				</div>
				<div style="display: none;" id="isbuissnessdiv">
					<div class="add_frm_one">
						<div class="add_customer_one">Company Name</div>
						<div class="add_input">
							<input placeholder="Enter Company Name" name="companyName"
								onchange="trim(this)" id="companyName" type="text"
								class="input_add" />
						</div>
						<div class="clr"></div>
					</div>
					<div class="add_frm_one">
						<div class="add_customer_one">GST Number</div>
						<div class="add_input">
							<input placeholder="Enter GST Name" name="gstNo" id="gstNo"
								onchange="trim(this)" type="text" class="input_add" />
						</div>
						<div class="clr"></div>
					</div>
					<div class="add_frm_one">
						<div class="add_customer_one">Address</div>
						<div class="add_input">
							<input placeholder="Enter Address" name="custAdd" id="custAdd"
								onchange="trim(this)" type="text" class="input_add" />
						</div>
						<div class="clr"></div>
					</div>
				</div>
			</div>

			<div class="pop_btns">
				<div class="close_l">
					<button class="addcust_close close_btn"
						onclick="closeMyModal('myModal')">Close</button>
				</div>
				<div class="close_r">
					<a href="#" onclick="addCustomer()">Save</a>
				</div>
				<div class="clr"></div>
			</div>


		</div></div></div>
		
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
 <!--basic scripts--><!-- 
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script> -->
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
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.crosshair.js"></script><%-- 
	<script
		src="${pageContext.request.contextPath}/resources/assets/flot/jquery.flot.tooltip.min.js"></script> --%>
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
<script>
$(function() {
    $('#typeselector').change(function(){
        $('.formgroup').hide();
        $('#' + $(this).val()).show();
    });
});
</script>
<script type="text/javascript">
		function trim(el) {
			el.value = el.value.replace(/(^\s*)|(\s*$)/gi, ""). // removes leading and trailing spaces
			replace(/[ ]{2,}/gi, " "). // replaces multiple spaces with one space 
			replace(/\n +/, "\n"); // Removes spaces after newlines
			return;
		}
		function validateMobile(mobile) {
			var mob = /^[1-9]{1}[0-9]{9}$/;

			if (mob.test($.trim(mobile)) == false) {

				//alert("Please enter a valid email address .");
				return false;

			}
			return true;

		}
		function onCustChange() {

			var custId = document.getElementById("cust").value;
			if (custId != 0) {
				$.post(
								'${editCustomerFromBill}',
								{
									custId : custId,
									ajax : 'true'
								},
								function(data) {
		 document.getElementById("billToName").value=data.custName;
         document.getElementById("billToGstin").value=data.gstNo;
         document.getElementById("billToAddress").value=data.address;
								});
			}
		}
		function editCustomer() {

			var custId = document.getElementById("cust").value;

			if (custId != 0) {
				//document.getElementById("overlay2").style.display = "block";
				$
						.post(
								'${editCustomerFromBill}',
								{
									custId : custId,
									ajax : 'true'
								},
								function(data) {
									//document.getElementById("overlay2").style.display = "none";
								//	$('.addcust_open').trigger('click');
									//$('#myModalEdit').modal('show');
									//$('#addcust').popup('show');
										
											
									openMyModal('myModal');
									document
											.getElementById("add_cust_head_name").innerHTML = "Edit Customer";
									document.getElementById("customerName").value = data.custName;
									document.getElementById("mobileNo").value = data.phoneNumber;
									document.getElementById("custId").value = data.custId;
									document.getElementById("dateOfBirth").value = data.custDob;
									if (data.gender == 1) {
										document.getElementById("moption").checked = true;
										}else{
										document.getElementById("foption").checked = true;
										}
										document.getElementById("custType").value =data.exInt1;
										$("#custType").trigger("chosen:updated");
										document.getElementById("ageRange").value =data.ageGroup;
										$("#ageRange").trigger("chosen:updated");
										$('.chosen-select').trigger('chosen:updated');
									if (data.isBuissHead == 1) {

										$("#isbuissnessdiv").show();
										document.getElementById("y-option").checked = true;
										document.getElementById("companyName").value = data.companyName;
										document.getElementById("gstNo").value = data.gstNo;
										document.getElementById("custAdd").value = data.address;
									} else {
										$("#isbuissnessdiv").hide();
										document.getElementById("y-option").checked = false;
									}

								});

			} else {
				alert("Select Customer ");
			}

		}

		function addCustomer() {
			var phNo="";
			//$('#addcust').modal('hide');
			//$('#addcust').popup('hide'); //for close popup;
			var custId = document.getElementById("custId").value;
			var customerName = document.getElementById("customerName").value;
			var mobileNo = document.getElementById("mobileNo").value;
			phNo=mobileNo;
			var dateOfBirth = document.getElementById("dateOfBirth").value;
			var custType = document.getElementById("custType").value;
			var ageRange = document.getElementById("ageRange").value;
			if(custId!=0)
				{
				phNo="0000000000";
				}
			$.getJSON('${checkEmailText}', {
				phoneNo : phNo,	
					ajax : 'true',
			},

			function(saveFlag) {
				 if(parseInt(saveFlag)==1){		
					   alert("Duplicate Mobile No Found.");
						//document.getElementById("sbtbtn4").disabled = true;
						document.getElementById("mobileNo").value = "";
						document.getElementById("mobileNo").focus();
				}else{
			var gender = 2;
			if (document.getElementById('moption').checked) {
				gender = 1;
			}
			//var isBuissness = document.getElementById("isBuissness").value;
			var buisness = 0;
			if (document.getElementById('y-option').checked) {
				buisness = 1;
			}
			var companyName = document.getElementById("companyName").value;
			var gstNo = document.getElementById("gstNo").value;
			var custAdd = document.getElementById("custAdd").value;

			var flag = 0;

			if (customerName == "") {
				alert("Enter Customer Name");
				flag = 1;
			} else if (mobileNo == "" || !validateMobile(mobileNo)) {
				alert("Enter Valid Mobile No");
				flag = 1;
			} /* else if (dateOfBirth == "") {
				alert("Enter Date of Birth");
				flag = 1;
			} */else if (custType == 0) {
				alert("Please Select Customer Type");
				flag = 1;
			}
			else if (ageRange == 0) {
				alert("Please Select Age Group");
				flag = 1;
			} else if (buisness == 1) {

				if (companyName == "") {
					alert("Enter Company Name");
					flag = 1;
				} else if (gstNo == "") {
					alert("Enter GST No");
					flag = 1;
				} else if (custAdd == "") {
					alert("Enter Address");
					flag = 1;
				}
			}

			if (flag == 0) {
				$
						.post(
								'${saveCustomerFromBill}',
								{
									customerName : customerName,
									mobileNo : mobileNo,
									dateOfBirth : dateOfBirth,
									buisness : buisness,
									companyName : companyName,
									gstNo : gstNo,
									custAdd : custAdd,
									custId : custId,
									custType:custType,
									ageRange:ageRange,
									gender:gender,
									ajax : 'true'
								},
								function(data) {

									//alert(JSON.stringify(data));

									if (data.error == false) {

										var html = '<option value="0" selected>Select Customer</option>';
										var len = data.customerList.length;
										//alert(data.addCustomerId);
										for (var i = 0; i < len; i++) {

											if (data.customerList[i].custId == data.addCustomerId) {
												 document.getElementById("billToName").value=data.customerList[i].custName;
					                              document.getElementById("billToGstin").value=data.customerList[i].gstNo;
					                              document.getElementById("billToAddress").value=data.customerList[i].address;
												html += '<option value="' + data.customerList[i].custId + '" selected>'
														+ data.customerList[i].custName
														+ '&nbsp;'
														+ data.customerList[i].phoneNumber
														+ '</option>';
											} else {
												html += '<option value="' + data.customerList[i].custId + '">'
														+ data.customerList[i].custName
														+ '&nbsp;'
														+ data.customerList[i].phoneNumber
														+ '</option>';
											}

										}

										$('#cust').html(html);

										$("#cust").trigger("chosen:updated");
										$('.chosen-select').trigger(
												'chosen:updated');

										document.getElementById("customerName").value = "";
										document.getElementById("mobileNo").value = "";

										document.getElementById("dateOfBirth").value = "";

										document.getElementById("n-option").checked = true;
										document.getElementById("companyName").value = "";
										document.getElementById("gstNo").value = "";
										document.getElementById("custAdd").value = "";
										document.getElementById("custId").value = 0;
										document.getElementById("moption").checked = true;
										document.getElementById("custType").value ="0";
										$("#custType").trigger("chosen:updated");
										document.getElementById("ageRange").value ="0";
										$("#ageRange").trigger("chosen:updated");
										$('.chosen-select').trigger('chosen:updated');
										document
												.getElementById("add_cust_head_name").innerHTML = "Add Customer";
										$("#isbuissnessdiv").hide();

										if (custId != 0) {
											alert("Update Successfully");
											closeMyModal('myModal');

										} else {
											alert("Customer Add Successfully");
											closeMyModal('myModal');
										}
										
									} else {
										alert("Failed To Add Customer");
										
									}

								});
			}
				}
				});
		}
		
		function clearAddCustomerpopup() {

			document.getElementById("customerName").value = "";
			document.getElementById("mobileNo").value = "";
			document.getElementById("dateOfBirth").value = "";
			document.getElementById("n-option").checked = true;
			document.getElementById("companyName").value = "";
			document.getElementById("gstNo").value = "";
			document.getElementById("custAdd").value = "";
			document.getElementById("custId").value = 0;
			document.getElementById("moption").checked = true;
			document.getElementById("custType").value ="0";
			$("#custType").trigger("chosen:updated");	
			document.getElementById("ageRange").value ="0";
		    $("#ageRange").trigger("chosen:updated");
			$('.chosen-select').trigger('chosen:updated');
			document.getElementById("add_cust_head_name").innerHTML = "Add Customer";
			$("#isbuissnessdiv").hide();
		}

	</script>
<script type="text/javascript">
		$(document).ready(function() {
			$('#addcust').popup({
				focusdelay : 400,
				outline : true,
				vertical : 'top'
			});
		});
	</script>
	<script>
	function openMyModal(modalId) {
	 var modal1 = document.getElementById(modalId);
	 modal1.style.display = "block"; 
	 clearAddCustomerpopup();
	}
	function closeMyModal(modalId) {
		 
		 var modal1 = document.getElementById(modalId);
		 modal1.style.display = "none";
		}
	function isBuissness(value) {

		if (value == 1) {
			$("#isbuissnessdiv").show();
		} else {
			$("#isbuissnessdiv").hide();
		}

	}
	function isBuissnessEdit(value) {

		if (value == 1) {
			$("#isbuissnessdivedit").show();
		} else {
			$("#isbuissnessdivedit").hide();
		}

	}
	</script>
<script type="text/javascript">
/* $(document).ready(function() {
	
	
    $('#menu').change( */
            function onSearch() {
    	
    	var isValid=validation();
    	if(isValid){
    	var type = $('.type:checked').val();
    	var delType=$('#delType').val();
    	var ordertype = $('.order:checked').val();
       // document.getElementById("myCheck").checked = true;alert("ji7")
        var isChecked = $('#isDairyMart').is(':checked');
        var delDate=null;
		 if(delType==3)
		   delDate=$('#delDate').val();	
        var isDairyMart=0;
        if(isChecked==true)
        	{
        	isDairyMart=1;
        
        	document.getElementById("dailyFlagMart1").value = isDairyMart;

        	}
        
    	$('#table_grid td').remove();
    
          	 $('#loader').show();
          	
                $.getJSON('${findItemsByCatId}', {
                    menuId:$('#menu').val(),
                    frId:$('#fr_id').val(),
                    by:type,
                    ordertype:ordertype,
                    isDairyMart:isDairyMart,
                    delType:delType,
                    delDate:delDate,
                    ajax : 'true'
                }, function(data) {
                		 $('#loader').hide();
             		var len = data.length;
             		document.getElementById("submitorder").disabled = false;
             		document.getElementById("submitbill").disabled = false;
             		$('#table_grid td').remove();

             		$.each(data,function(key, item) {


             			var tr = $('<tr></tr>');

             		  	tr.append($('<td></td>').html(key+1));

             		  	tr.append($('<td></td>').html(item.itemName));
             		  	if(isDairyMart==1){
                 		  	tr.append($('<td></td>').html(item.orderStatus+'<input type="hidden" value='+item.orderStatus+'	id=limqty'+item.itemId+""+item.frId+'  />'));

             		  	}
              		  	tr.append($('<td></td>').html(item.minQty+'<input type="hidden" value='+item.minQty+'	id=minqty'+item.itemId+""+item.frId+'  />'));

             		  	if(isDairyMart==0){
             		  		if(ordertype==1){
                         		tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChangeBill('+item.orderRate+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+' > '));
                     		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderRate+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+' > '));
                     		  	}
                     		  	else
                     		  		{
                         		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChange('+item.orderRate+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+' > '));

                         		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderRate+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+' > '));

                     		  		}
             		  	}else{
             		  		
             		  		if(ordertype==1){
                         		tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChangeBill('+item.orderMrp+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+' > '));
                     		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderMrp+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+' > '));
                     		  	}
                     		  	else
                     		  		{
                         		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChange('+item.orderMrp+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+' > '));

                         		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderMrp+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+' > '));

                     		  		}
             		  		
             		  	}
             		  	
             		  
             		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderMrp.toFixed(2)));
             		  	
             		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderRate.toFixed(2)));
             		  	var total=(item.orderQty*item.orderRate)-(item.isPositive*((item.orderQty*item.orderRate)/100));
             		  	tr.append($('<td class="col-md-1-2" style="text-align:right;" id=total'+item.itemId+""+item.frId+' ></td>').html(total.toFixed(2)));
             		  	
             		  
             			$('#table_grid tbody').append(tr);
             		}); });
    	}
    	  document.getElementById("flagRate").value=1;
            }
  function onSearchMulFr() {
    	
    	var isValid=validation1();
    	if(isValid){
    		
    	var flagRate = $('#flagRate').val();
    	var type = $('.type:checked').val();
    	var ordertype = $('.order:checked').val();//alert(ordertype);
    	var itemId = $('#itemId').val();
    	var qty = $('#qty').val();
    	var frId =$('#fr_id1').val();
    	var delType=$('#delType').val();
    
    	 var delDate=null;
 		 if(delType==3)
 		   delDate=$('#delDate').val();	
 		 var isChecked = $('#isDairyMart').is(':checked');
         var isDairyMart=0;
         if(isChecked==true)
         	{
         	isDairyMart=1;
        	document.getElementById("dailyFlagMart1").value = isDairyMart;

         	}
          	 $('#loader').show();
          
                $.getJSON('${findItemsByCatIdForMulFr}', {
                    menuId:$('#menu').val(),
                    frIdStr:JSON.stringify(frId),
                    by:type,
                    ordertype:ordertype,
                    itemId:itemId,
                    qty:qty,
                    flagRate:flagRate,
                    isDairyMart:isDairyMart,
                    delDate:delDate,
                    ajax : 'true'
                }, function(data) {
                	$('#loader').hide();
             		var len = data.length;
             		document.getElementById("submitorder").disabled = false;
             		document.getElementById("submitbill").disabled = false;
             		$('#table_grid td').remove();

             		$.each(data,function(key, item) {


             			var tr = $('<tr></tr>');

             		  	tr.append($('<td></td>').html(key+1));

             		  	tr.append($('<td></td>').html(item.itemName));
             		  	if(isDairyMart==1){
                 		  	tr.append($('<td></td>').html(item.orderStatus+'<input type="hidden" value='+item.orderStatus+'	id=limqty'+item.itemId+""+item.frId+'  />'));
                 			}
             		
             		  	tr.append($('<td></td>').html(item.minQty+'<input type="hidden" value='+item.minQty+'	id=minqty'+item.itemId+""+item.frId+'  />'));
             			
             		  	
             		  	if(isDairyMart==0){ 
             		  		//Without DM
             		  	
              		  	if(ordertype==1 || ordertype==2){
                 		tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChangeBill('+item.orderRate+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+'  > '));
             		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderRate+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+'  > '));
             		  	}
             		  	else
             		  		{
                 		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChange('+item.orderRate+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+'   > '));

                 		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderRate+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+'  > '));


             		  		}
             		  	}
             		  	
             		  	else{
             		  		
             		  	//With  DM
             		  	 
             		  		if(ordertype==1 || ordertype==2){
                         		tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChangeBill('+item.orderMrp+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+'  > '));
                     		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderMrp+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+'  > '));
                     		  	}
                     		  	else
                     		  		{
                         		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control" onchange="onChange('+item.orderMrp+','+item.itemId+','+item.frId+')"   width=20px;  name=qty'+item.itemId+""+item.frId+' id=qty'+item.itemId+""+item.frId+' value='+item.orderQty+'   > '));

                         		  	tr.append($('<td style="text-align:right;" class="col-md-1"></td>').html('<input type="number" class="form-control"  min="0"  width=20px; onchange="onChangeBill('+item.orderMrp+','+item.itemId+','+item.frId+')"  name=discper'+item.itemId+""+item.frId+' id=discper'+item.itemId+""+item.frId+' value='+item.isPositive+'  > '));


                     		  		}
             		  	
             		  	
             		  	}
             		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderMrp.toFixed(2)));
             		  	
             		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderRate.toFixed(2)));
             		  	var total=(item.orderQty*item.orderRate)-(item.isPositive*((item.orderQty*item.orderRate)/100));

             		  	tr.append($('<td style="text-align:right;" id=total'+item.itemId+""+item.frId+' ></td>').html(total.toFixed(2)));
             		  	
             		  
             			$('#table_grid tbody').append(tr);
             		}); });
    	}
    	  document.getElementById("flagRate").value=0;
            }
</script> 


<!--for Regular  -->

<script type="text/javascript">
		function onChange(rate, id, frId) {

			var qty = parseInt($('#qty' + id + '' + frId).val());
			var discPer = parseFloat($('#discper' + id + '' + frId).val());
			var minqty = parseInt($('#minqty' + id + '' + frId).val());
			var limqty = parseInt($('#limqty' + id + '' + frId).val());
			//alert(limqty);

			var isChecked = $('#isDairyMart').is(':checked');
			var isDairyMart = 0;
			if (isChecked == true) {
				isDairyMart = 1;
			}
			if (isDairyMart == 0) {
				if (qty % minqty == 0 && qty > 0
						&& discPer >=0) {
					var total = (rate * qty) - (discPer * ((rate * qty) / 100));
					total = total.toFixed(2)
					$('#total' + id + '' + frId).html(total);
				} else {
					var total = 0;
					alert("Please Enter Qty Multiple of Minimum Qty or Discount Properly");
					$('#qty' + id + '' + frId).val(0);
					$('#total' + id + '' + frId).html(total);
					$('#qty' + id + '' + frId).focus();
				}
				calTotal(2);
			} else {

				if (qty % minqty == 0
						&&  qty  >=  limqty  && discPer >=0) {
					var total = (rate * qty) - (discPer * ((rate * qty) / 100));
					total = total.toFixed(2)
					$('#total' + id + '' + frId).html(total);
				} else {
					var total = 0;
					alert("Please Enter Qty Multiple of Minimum Qty and Less than or Equal to Limit Qty or Discount Properly ");
					$('#qty' + id + '' + frId).val(0);
					$('#total' + id + '' + frId).html(total);
					$('#qty' + id + '' + frId).focus();
				}
				calTotal(2);
			}
		}
		
		function calTotal(flag)
		{
			var sum = 0;
			    $("#table_grid").find(".col-md-1-2").each(function (index, element) {
			        sum += parseFloat($(element).text());
			    });
			 $('#calTotal'+flag).text(sum);
	 		 document.getElementById("fintotal"+flag).value = sum;
	 		 document.getElementById("remainAmt"+flag).value = sum;
	 		document.getElementById("advanceAmt"+flag).value = 0.00;
	 		
		}
		function setAmt(flag){ 
			
			var  adv=$("#advanceAmt"+flag).val();
			var tot=$("#fintotal"+flag).val();
			
			//alert("hii");
			if(parseFloat(adv) <= parseFloat(tot)){
				//alert("if");
				var rem=parseFloat(tot)-parseFloat(adv);
				document.getElementById("remainAmt"+flag).value = rem;
			}
			else{
				//alert("else");
				alert("Enter Advance Amount Less than Total Amount");
				document.getElementById("advanceAmt"+flag).value = 0.00;
				document.getElementById("remainAmt"+flag).value = tot;
				//document.getElementById("remainAmt"+flag).value = 0.00;
			}
			
		}
	</script>
	<script type="text/javascript">
		function onChangeBill(rate, id, frId) {

			//calculate total value  
			var qty =parseInt( $('#qty' + id + '' + frId).val());
			var discper =parseFloat( $('#discper' + id + '' + frId).val());

			var minqty = parseInt($('#minqty' + id + '' + frId).val());
			var limqty = parseInt($('#limqty' + id + '' + frId).val());
		//	alert(limqty);
			var isChecked = $('#isDairyMart').is(':checked');
			var isDairyMart = 0;
			if (isChecked == true) {
				isDairyMart = 1;
			}

			if (isDairyMart == 0) {
				if (qty % minqty == 0 &&  qty > 0
						&& discper >= 0) {
					var total = rate * qty;
					var disc = (total * discper) / 100;
					total = total - disc;
					$('#total' + id + '' + frId).html(total.toFixed(2));
				} else {
					var total = 0;

					alert("Please Enter Qty Multiple of Minimum Qty or Discount Properly");
					$('#qty' + id + '' + frId).val(0);

					$('#total' + id + '' + frId).html(total);
					$('#qty' + id + '' + frId).focus();
				}
			} else {
				if (qty % minqty == 0
						 &&  qty >= limqty && discper >= 0 )  {
					var total = rate * qty;
					var disc = (total * discper) / 100;
					total = total - disc;
					$('#total' + id + '' + frId).html(total.toFixed(2));
				} else {
					var total = 0;

					alert("Please Enter Qty Multiple of Minimum Qty and Less than or Equal to Limit Qty or Discount Properly ");
					$('#qty' + id + '' + frId).val(0);

					$('#total' + id + '' + frId).html(total);
					$('#qty' + id + '' + frId).focus();
				}

			}
		}
	</script>


	<!--for Regular  ends  -->
	
	<!--for Regular  advance -->

	<!--for Regular  advance  ends -->
<!-- <script type="text/javascript">
$(document).ready(function() {
	
	
    $('#menu').change(
            function() {
            	
                $.getJSON('${findItemsByCatId}', {
                    menuId : $(this).val(),
                    ajax : 'true'
                }, function(data) {
                    var len = data.length;

					$('#items')
				    .find('option')
				    .remove()
				    .end()
				    $("#items").append(
                                 $("<option></option>").attr(
                                     "value","0").text("Select Item")
                             );
                    for ( var i = 0; i < len; i++) {
                    	 
                                
                        $("#items").append(
                                $("<option></option>").attr(
                                    "value", data[i].id).text(data[i].name)
                            );
                    }

                    $("#items").trigger("chosen:updated");
                });
            });
});
</script> -->


<script type="text/javascript">
$(document).ready(function() { 
	
	  $('#limQtyCol').hide();
	
	
 
	$('#fr_id').change(
		
			function() {	
				$('#table_grid td').remove();
				$.getJSON('${findAllMenus}', {
					fr_id : $(this).val(),
					ajax : 'true'
				}, function(data) {
					var html = '<option value="0">Menu</option>';
				
					var len = data.length;
					
					$('#menu')
				    .find('option')
				    .remove()
				    .end()
				    
				 $("#menu").append(
                                $("<option></option>").attr(
                                    "value", "0").text("Select Menu")
                            );
					
					for ( var i = 0; i < len; i++) {
                        $("#menu").append(
                                $("<option></option>").attr(
                                    "value", data[i].menuId).text(data[i].menuTitle)
                            );
					}
					   $("#menu").trigger("chosen:updated");
				});
			});
});
</script>
<script type="text/javascript">

$(document).ready(function() {
	$("#add").click(function() {
		
	  var isValid = validation();
	if (isValid) {  
		
 	var frId = $('#fr_id option:selected').val();
	var menuId = $('#menu option:selected').val();
	var itemId=$('#items option:selected').val();
	var qty=$("#qty").val();
	

	 $('#loader').show();

	$.getJSON('${insertItem}', {
		frId : frId,
		menuId:menuId,
		itemId:itemId,
		qty:qty,
		ajax : 'true',
		
	},  function(data) { 
 
		 $('#loader').hide();
		var len = data.length;
		document.getElementById("Submit").disabled = false;

		$('#table_grid td').remove();

		$.each(data,function(key, item) {

		var tr = $('<tr></tr>');

	  	tr.append($('<td></td>').html(key+1));

	  	tr.append($('<td></td>').html(item.itemName));

	  	tr.append($('<td style="text-align:right;"></td>').html(item.orderQty));
	  	
	  	tr.append($('<td style="text-align:right;"></td>').html(item.orderMrp));
	  	
	  	tr.append($('<td style="text-align:right;"></td>').html(item.orderRate+'<input type="hidden" value='+item.minQty+' id=minqty'+item.itemId+' />'));
	  	var total=item.orderQty*item.orderRate;
	  	tr.append($('<td style="text-align:right;"></td>').html(total.toFixed(2)));
	  	
	 	tr.append($('<td style="text-align:center;"></td>').html("<a href='#' class='action_btn' onclick=deleteItem("+key+")><i class='fa fa-trash-o  fa-lg'></i></a>"));
	  
		$('#table_grid tbody').append(tr);
	 
	 }); 
	
	});
	//document.getElementById("fr_id").selectedIndex = "0";
	//$("#fr_id").trigger("chosen:updated");
	//document.getElementById("menu").selectedIndex = "0";
	//$('#menu')
   // .find('option')
   // .remove()
   // .end()
	//$("#menu").trigger("chosen:updated");
	document.getElementById("items").selectedIndex = "0";
/* 	$('#items')
    .find('option')
    .remove()
    .end() */
	$("#items").trigger("chosen:updated");
	

	document.getElementById("qty").value =0;


	}
});

});
</script>
<script type="text/javascript">
function validation() {
	
	var frId = $('#fr_id').val();
	var menuId = $('#menu').val();
	var delType= $('#delType').val();

	//var itemId=$('#items').val();
	//var qty=$("#qty").val();
    var sectionId=$('#sectionId').val();
	var isValid = true;
	if (frId == ""||frId==0) { 
		isValid = false;
		alert("Please Select Franchisee");
	} else if (menuId == ""||menuId ==0) {
		isValid = false;
		alert("Please Select Menu ");
	}else if (sectionId == ""||sectionId ==0) {
		isValid = false;
		alert("Please Select Section ");
	}else if (delType == ""||delType ==0) {
		isValid = false;
		alert("Please Select Delivery Type ");
	}else if(delType==3)
		{
		var delDate= $('#delDate').val();
		if(delDate=="" || delDate==null)
			{
			isValid = false;
			alert("Please Select Delivery Date ");
			}
		}
	return isValid;
}
function validation1() {
	
	var frId = $('#fr_id1').val();
	var menuId = $('#menu').val();
	var itemId=$('#itemId').val();
	var qty=$("#qty").val();
    var sectionId=$('#sectionId').val();
	var delType= $('#delType').val();
	var isValid = true;
	if (frId == ""||frId==0) { 
		isValid = false;
		alert("Please Select Franchisee");
	} else if (menuId == ""||menuId ==0) {
		isValid = false;
		alert("Please Select Menu ");
	}else if (sectionId == ""||sectionId ==0) {
		isValid = false;
		alert("Please Select Section ");
	}else if (delType == ""||delType ==0) {
		isValid = false;
		alert("Please Select Delivery Type ");
	}else if(delType==3)
		{
		var delDate= $('#delDate').val();
		if(delDate=="" || delDate==null)
			{
			isValid = false;
			alert("Please Select Delivery Date ");
			}
		}
	else if (itemId == ""||itemId ==0) {
		isValid = false;
		alert("Please Select Item ");
	}
	else if (qty == ""||qty ==0) {
		isValid = false;
		alert("Please Enter valid Qty ");
	}
	return isValid;
}
</script>
<script type="text/javascript">
function deleteItem(key){
	var isDel=confirm('Are you sure want to delete this record');
	if(isDel==true)
	{
	$.getJSON('${deleteItems}', {
		
		key:key,
	
		ajax : 'true',

	}, function(data) {
		
		var len = data.length;
        if(len==0)
        	{
    		document.getElementById("Submit").disabled = true;

        	}
		$('#table_grid td').remove();

		$.each(data,function(key, item) {
			
			var tr = $('<tr></tr>');

		  	tr.append($('<td></td>').html(key+1));

		  	tr.append($('<td></td>').html(item.itemName));

		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderQty));
		  	
		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderMrp));
		  	
		  	tr.append($('<td style="text-align:right;"></td>').html(item.orderRate));
		  	var total=item.orderQty*item.orderRate;
		  	tr.append($('<td style="text-align:right;"class="col-md-1-2"></td>').html(total.toFixed(2)));
		  	
		 	tr.append($('<td style="text-align:center;"></td>').html("<a href='#' class='action_btn' onclick=deleteItem("+key+")><abbr title='Delete'><i class='fa fa-trash-o  fa-lg'></i></abbr></a>"));
		  
			$('#table_grid tbody').append(tr);
			
		});
	});
	}
}
</script>
<script type="text/javascript">
function generateBill()
{
	$('#loader1').show();

	$.getJSON(
					'${generateManualBill}',
					{
						ajax : 'true'
					},
					function(data) {
						$('#table_grid td').remove();
						if(data.length!=0)
							{
                       alert("Orders Inserted Successfully");
               		document.getElementById("Submit").disabled = true;

							}
						$('#loader1').hide();
						
					});
	
}


</script>
<script type="text/javascript">
function findFranchiseeData(frId)
{
	$('#table_grid td').remove();
	$.getJSON('${findAllMenus}', {
		fr_id :frId,
		ajax : 'true'
	}, function(data) {
		var html = '<option value="0">Menu</option>';
	
		var len = data.length;
		
		$('#menu')
	    .find('option')
	    .remove()
	    .end()
	    
	 $("#menu").append(
                    $("<option></option>").attr(
                        "value", "0").text("Select Menu")
                );
		
		for ( var i = 0; i < len; i++) {
            $("#menu").append(
                    $("<option></option>").attr(
                        "value", data[i].menuId).text(data[i].menuTitle)
                );
		}
		   $("#menu").trigger("chosen:updated");
	});
	 if($('#or3').is(':checked')==false) { 
	$.getJSON(
					'${findFranchiseeData}',
					{
						fr_id:frId,
						ajax : 'true'
					},
					function(data) {
						if(data.length!=0)
							{
                              document.getElementById("frName").value=data.frName;
                              document.getElementById("gstin").value=data.frGstNo;
                              document.getElementById("address").value=data.frAddress;
							}
						
					});
	 }
}

function findShipFranchiseeData(frId)
{

	 if($('#or3').is(':checked')==false) { 
	$.getJSON(
					'${findFranchiseeData}',
					{
						fr_id:frId,
						ajax : 'true'
					},
					function(data) {
						if(data.length!=0)
							{
                              document.getElementById("frName").value=data.frName;
                              document.getElementById("gstin").value=data.frGstNo;
                              document.getElementById("address").value=data.frAddress;
							}
						
					});
	 }
}
</script>
<script type="text/javascript">
function showPdf(billNo)
{
	
	if(billNo!=0)
		{
        window.open('${pageContext.request.contextPath}/pdf?url=pdf/showBillPdf/By-Road/0/'+billNo,'_blank');

		}
	

}
</script>
<script type="text/javascript">
function checkCheckedStatus()
{
	   if($('#or1').is(':checked')) { 
		   document.getElementById("searchBtn").disabled = false;
		   document.getElementById("submitbill").style.display = "none";
		   document.getElementById("submitorder").disabled = true;
		   	 $("#submitorder").show();
		     document.getElementById("flagRate").value=1;
   		document.getElementById("submitorder").style.backgroundColor = "blue";
   	 $("#mulFr").hide();
	   $("#singleFr").show();
	   $("#mulOrder").hide();
	   $("#singleOrder").show();
		$('#table_grid td').remove();
		var frId=document.getElementById("fr_id").value;
		if (frId != ""&&frId!=0) { 
		findFranchiseeData(frId);
		}
	  // document.getElementById("fr_id").selectedIndex = "0";
	   //	$("#fr_id").trigger("chosen:updated");
   	// document.getElementById("submitbill").style.backgroundColor = "#ffeadd";
	   }else
	   if($('#or2').is(':checked')) { 
		   document.getElementById("searchBtn").disabled = false;
		   document.getElementById("submitbill").disabled = true;
		   $("#submitbill").show();
		   document.getElementById("flagRate").value=1;
		   document.getElementById("submitbill").style.backgroundColor = "blue";
		  // document.getElementById("submitorder").style.backgroundColor = "#ffeadd";
		   document.getElementById("submitorder").style.display = "none";
		   $("#mulFr").hide();
		   $("#singleFr").show();
		   $("#mulOrder").hide();
		   $("#singleOrder").show();
			$('#table_grid td').remove();
			var frId=document.getElementById("fr_id").value;
			if (frId != ""&&frId!=0) { 
			findFranchiseeData(frId);
			}
		   //document.getElementById("fr_id").selectedIndex = "0";
		   //	$("#fr_id").trigger("chosen:updated");
	   }else
		   if($('#or3').is(':checked')) { 
			   document.getElementById("searchBtn").disabled = false;
			   document.getElementById("submitbill").disabled = true;
			   $("#submitbill").show();
				$('#table_grid td').remove();
				 document.getElementById("flagRate").value=1;
				  document.getElementById("qty").value=0;
				  $('#itemId')
				    .find('option')
				    .remove()
				    .end()
				  $("#itemId").trigger("chosen:updated");
				 
			   document.getElementById("submitbill").style.backgroundColor = "blue";
			  // document.getElementById("submitorder").style.backgroundColor = "#ffeadd";
			   document.getElementById("submitorder").style.display = "none";
			   $("#singleFr").hide();
			   $("#mulFr").show();
			   $("#mulOrder").show();
			   $("#singleOrder").hide();
			   //document.getElementById("fr_id").selectedIndex = "0";
			   //	$("#fr_id").trigger("chosen:updated");
			   document.getElementById("frName").value="-";
               document.getElementById("gstin").value="-";
               document.getElementById("address").value="-";
               
               
           	$.getJSON('${getAllMenu}', {
				ajax : 'true'
			}, function(data) {
				var html = '<option value="0">Menu</option>';
			
				var len = data.length;
				
				$('#menu')
			    .find('option')
			    .remove()
			    .end()
			    
			 $("#menu").append(
                            $("<option></option>").attr(
                                "value", "0").text("Select Menu")
                        );
				
				for ( var i = 0; i < len; i++) {
                    $("#menu").append(
                            $("<option></option>").attr(
                                "value", data[i].menuId).text(data[i].menuTitle)
                        );
				}
				   $("#menu").trigger("chosen:updated");
			});
		   }
	   
	
}
function checkOrderByStatus()
{
	    var isConfirm=confirm('Do you want to change order By ?');
		var ordertype = $('.order:checked').val();
	 if(isConfirm){
	   if($('#t1').is(':checked')) { 
		   
	       if(ordertype==2){
	    	   document.getElementById("flagRate").value=1;
	    	   onSearchMulFr();
	    	   document.getElementById("flagRate").value=0;
	       }else{
		   onSearch();
	       }
	   }else
	   if($('#t2').is(':checked')) { 
 if(ordertype==2){
	 document.getElementById("flagRate").value=1;
	 onSearchMulFr();
	 document.getElementById("flagRate").value=0;
	       }else{
		   onSearch();
	       }
	   }
      }
}
</script>
<script type="text/javascript">
function onCatIdChangeForManOrder(menuId) {
	
	if(parseInt(menuId)==42){
		   document.getElementById("advOrderTotal").style = "visible";
		   document.getElementById("custOrder").style = "visible";
		    document.getElementById("custSelDiv").style = "visible";
			document.getElementById("dailyMartDiv").style = "visible";
			document.getElementById("shipToFr").style = "visible";
				document.getElementById("dt").style = "visible";
			   		$('#table_grid td').remove();

			document.getElementById("delDate").required = true;
			$("#delType option[value='1']").attr("disabled","disabled");
			$("#delType option[value='2']").attr("disabled","disabled");
	   		$("#delType option[value='3']").attr("disabled",false);

			 document.getElementById("delType").value=3 ;
			   $("#delType").trigger("chosen:updated");
			  //ocument.getElementById("delType").disabled=true;
			   $('#limQtyCol').hide();
	} else {
		
		   document.getElementById("advOrderTotal").style = "display:none";
		    $("#isDairyMart").prop('checked', false);
   		  $('#limQtyCol').hide();
   		  $('#table_grid td').remove();
			$("#delType option[value='3']").attr("disabled","disabled");

   		$("#delType option[value='1']").attr("disabled",false);
		$("#delType option[value='2']").attr("disabled",false);
		    document.getElementById("custOrder").style = "display:none";
		    document.getElementById("custSelDiv").style = "display:none"; 
			document.getElementById("dailyMartDiv").style = "display:none"
				document.getElementById("shipToFr").style = "display:none";
			document.getElementById("dt").style = "display:none"
			document.getElementById("delDate").required = false;
			document.getElementById("delType").value="";
			$("#delType").trigger("chosen:updated");
		}
	 /* var isChecked = $('#isDairyMart').is(':checked');
  	 var isDairyMart=0;
     if(isChecked==true)
     	{
     	isDairyMart=1;
     	}
	 */
	/* $.getJSON('${getItemsByCatIdManOrder}', {
		menuId : menuId,
		isDairyMart:isDairyMart,
		ajax : 'true'
	}, function(data) {
		var len = data.length;
		$('#itemId')
	    .find('option')
	    .remove()
	    .end()
	    
	 $("#itemId").append(
                    $("<option></option>").attr(
                        "value", "0").text("Select Item")
                );
		
		for ( var i = 0; i < len; i++) {
            $("#itemId").append(
                    $("<option></option>").attr(
                        "value", data[i].id).text(data[i].itemName+"--MinQty: "+data[i].minQty)
                );
		}
		   $("#itemId").trigger("chosen:updated");

	}); */
	
}
</script>
<script type="text/javascript">
function onDairyMartCheck()
{
	
	  
     var isDairyMart=0;
	 var isChecked = $('#isDairyMart').is(':checked');
     if(isChecked==true)
     	{
     	isDairyMart=1;
     
     	document.getElementById("dailyFlagMart1").value = isDairyMart;
     	 $('#limQtyCol').show();

     	}else{
     		  $('#limQtyCol').hide();
     	}
	
	
	
	
 
	   var ordertype = $('.order:checked').val();
       if(ordertype==2)
    	  onSearchMulFr();
       else
     	  onSearch();  
}
function onDelChange(type)
{
	if(type==3) {
	$('#dt').show();
	}else
		{
		$('#dt').hide();
		}

}
</script>
<script>
function myFunction() {
  var input, filter, table, tr, td,td1, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("table_grid");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    td1 = tr[i].getElementsByTagName("td")[1];
    if (td || td1) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      }else if (td1.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      }  else {
        tr[i].style.display = "none";
      }
    }       
  }//end of for
}


</script>
</body>
</html>