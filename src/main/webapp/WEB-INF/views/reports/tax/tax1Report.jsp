<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body>

	<jsp:include page="/WEB-INF/views/include/logout.jsp"></jsp:include>

	<c:url var="getBillList" value="/getSaleBillwise"></c:url>

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
					<i class="fa fa-bars"></i>Bill Wise Tax Slab Wise Report
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
						<div class="form-group">

							<label class="col-sm-3 col-lg-2 control-label"><b></b>Select
								Bill Type </label>
							<div class="col-sm-6 col-lg-4">

								<select data-placeholder="Select Bill Type "
									class="form-control chosen" tabindex="6" id="type_id"
									name="type_id">

									<c:choose>

										<c:when test="${typeId==0}">
											<option value="0" selected="selected">All</option>
											<option value="1" >Franchise Bill</option>
											<option value="3">Company Outlet Bill</option>
										</c:when>
										<c:when test="${typeId==1}">
											<option value="0">All</option>
											<option value="1" selected="selected">Franchise Bill</option>
											<option value="3">Company Outlet Bill</option>
										</c:when>
										<c:when test="${typeId==3}">
											<option value="0">All</option>
											<option value="1">Franchise Bill</option>
											<option value="3" selected="selected">Company Outlet
												Bill</option>
										</c:when>
										<c:otherwise>
											<option value="0">All</option>
											<option value="1">Franchise Bill</option>
											<option value="3">Company Outlet Bill</option>
										</c:otherwise>

									</c:choose>

								</select>

							</div>


							<label class="col-sm-3 col-lg-2 control-label"><b></b>Select
								Bill Type Option </label>
							<div class="col-sm-6 col-lg-4">

								<input type="radio" id="rd1" name="rd" value="1"
									${bType==1 ? 'checked' : ''} checked="checked"
									onchange="billTypeSelection(this.value)">&nbsp;B2B
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="rd2"
									${bType==2 ? 'checked' : ''} name="rd" value="2"
									onchange="billTypeSelection(this.value)">&nbsp;B2C

							</div>


						</div>
					</div>

					<br>
					<div class="row">
						<div class="form-group" style="text-align: center;">
							<input type="submit" class="btn btn-info" value="Search" />
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



						<c:choose>
						
						<c:when test="${typeId==0 && bType==1}">

								<table class="table table-bordered table-striped fill-head "
									style="width: 100%" id="table_grid">
									<thead style="background-color: #f95d64;">
										<tr>
											<th style="text-align: center;">Sr.No.</th>
											<th style="text-align: center;">Bill Date</th>
											<th style="text-align: center;">Invoice No</th>
											<th style="text-align: center;">Franchise</th>
											<th style="text-align: center;">Party Name</th>
											<th style="text-align: center;">Party GST</th>
											<th style="text-align: center;">CGST %</th>
											<th style="text-align: center;">SGST %</th>
											<th style="text-align: center;">CGST Amt</th>
											<th style="text-align: center;">SGST Amt</th>
											<th style="text-align: center;">Taxable Amt</th>
											<th style="text-align: center;">Total Tax</th>
											<th style="text-align: center;">Grand Total</th>

										</tr>
									</thead>
									<tbody>
										<c:set var="totalCgstAmt" value="0" />
										<c:set var="totalIgstAmt" value="0" />
										<c:set var="totalTaxableAmt" value="0" />
										<c:set var="totalTax" value="0" />
										<c:set var="totalGrandTotal" value="0" />
										<c:forEach items="${taxReportList}" var="taxList"
											varStatus="count">
											<tr>
												<c:set var="totalCgstAmt"
													value="${totalCgstAmt+taxList.cgstAmt}" />
												<c:set var="totalIgstAmt"
													value="${totalIgstAmt+taxList.sgstAmt}" />
												<c:set var="totalTaxableAmt"
													value="${totalTaxableAmt+taxList.taxableAmt}" />
												<c:set var="totalTax" value="${totalTax+taxList.totalTax}" />
												<c:set var="totalGrandTotal"
													value="${totalGrandTotal+taxList.grandTotal}" />


												<td><c:out value="${count.index+1}" /></td>
												<td><c:out value="${taxList.billDate}" /></td>
												<td><c:out value="${taxList.invoiceNo}" /></td>
												<td><c:out value="${taxList.shipToName}" /></td>
												<td><c:out value="${taxList.billToName}" /></td>
												<td><c:out value="${taxList.billToGst}" /></td>

												<td style="text-align: right;"><c:out
														value="${taxList.cgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.cgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.taxableAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.totalTax}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.grandTotal}" /></td>

											</tr>
										</c:forEach>

										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>

											<td style="text-align: left;">Total</td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalCgstAmt}" /></td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalIgstAmt}" /></td>

											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTaxableAmt}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTax}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalGrandTotal}" /></td>

										</tr>


									</tbody>
								</table>

							</c:when>
							
							
							<c:when test="${typeId==0 && bType==2}">

								<table class="table table-bordered table-striped fill-head "
									style="width: 100%" id="table_grid">
									<thead style="background-color: #f95d64;">
										<tr>
											<th style="text-align: center;">Sr.No.</th>
											<th style="text-align: center;">Franchise</th>
											<th style="text-align: center;">CGST %</th>
											<th style="text-align: center;">SGST %</th>
											<th style="text-align: center;">CGST Amt</th>
											<th style="text-align: center;">SGST Amt</th>
											<th style="text-align: center;">Taxable Amt</th>
											<th style="text-align: center;">Total Tax</th>
											<th style="text-align: center;">Grand Total</th>

										</tr>
									</thead>
									<tbody>
										<c:set var="totalCgstAmt" value="0" />
										<c:set var="totalIgstAmt" value="0" />
										<c:set var="totalTaxableAmt" value="0" />
										<c:set var="totalTax" value="0" />
										<c:set var="totalGrandTotal" value="0" />
										<c:forEach items="${taxReportList}" var="taxList"
											varStatus="count">
											<tr>
												<c:set var="totalCgstAmt"
													value="${totalCgstAmt+taxList.cgstAmt}" />
												<c:set var="totalIgstAmt"
													value="${totalIgstAmt+taxList.sgstAmt}" />
												<c:set var="totalTaxableAmt"
													value="${totalTaxableAmt+taxList.taxableAmt}" />
												<c:set var="totalTax" value="${totalTax+taxList.totalTax}" />
												<c:set var="totalGrandTotal"
													value="${totalGrandTotal+taxList.grandTotal}" />


												<td><c:out value="${count.index+1}" /></td>
												<td><c:out value="${taxList.frName}" /></td>

												<td style="text-align: right;"><c:out
														value="${taxList.cgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.cgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.taxableAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.totalTax}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.grandTotal}" /></td>

											</tr>
										</c:forEach>

										<tr>
											<td></td>
											<td></td>
											<td></td>


											<td style="text-align: left;">Total</td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalCgstAmt}" /></td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalIgstAmt}" /></td>

											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTaxableAmt}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTax}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalGrandTotal}" /></td>

										</tr>


									</tbody>
								</table>

							</c:when>
						
						
						
							<c:when test="${typeId==1 && bType==1}">

								<table class="table table-bordered table-striped fill-head "
									style="width: 100%" id="table_grid">
									<thead style="background-color: #f95d64;">
										<tr>
											<th style="text-align: center;">Sr.No.</th>
											<th style="text-align: center;">Bill Date</th>
											<th style="text-align: center;">Invoice No</th>
											<th style="text-align: center;">Franchise</th>
											<th style="text-align: center;">Party Name</th>
											<th style="text-align: center;">Party GST</th>
											<th style="text-align: center;">CGST %</th>
											<th style="text-align: center;">SGST %</th>
											<th style="text-align: center;">CGST Amt</th>
											<th style="text-align: center;">SGST Amt</th>
											<th style="text-align: center;">Taxable Amt</th>
											<th style="text-align: center;">Total Tax</th>
											<th style="text-align: center;">Grand Total</th>

										</tr>
									</thead>
									<tbody>
										<c:set var="totalCgstAmt" value="0" />
										<c:set var="totalIgstAmt" value="0" />
										<c:set var="totalTaxableAmt" value="0" />
										<c:set var="totalTax" value="0" />
										<c:set var="totalGrandTotal" value="0" />
										<c:forEach items="${taxReportList}" var="taxList"
											varStatus="count">
											<tr>
												<c:set var="totalCgstAmt"
													value="${totalCgstAmt+taxList.cgstAmt}" />
												<c:set var="totalIgstAmt"
													value="${totalIgstAmt+taxList.sgstAmt}" />
												<c:set var="totalTaxableAmt"
													value="${totalTaxableAmt+taxList.taxableAmt}" />
												<c:set var="totalTax" value="${totalTax+taxList.totalTax}" />
												<c:set var="totalGrandTotal"
													value="${totalGrandTotal+taxList.grandTotal}" />


												<td><c:out value="${count.index+1}" /></td>
												<td><c:out value="${taxList.billDate}" /></td>
												<td><c:out value="${taxList.invoiceNo}" /></td>
												<td><c:out value="${taxList.shipToName}" /></td>
												<td><c:out value="${taxList.billToName}" /></td>
												<td><c:out value="${taxList.billToGst}" /></td>

												<td style="text-align: right;"><c:out
														value="${taxList.cgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.cgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.taxableAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.totalTax}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.grandTotal}" /></td>

											</tr>
										</c:forEach>

										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>

											<td style="text-align: left;">Total</td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalCgstAmt}" /></td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalIgstAmt}" /></td>

											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTaxableAmt}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTax}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalGrandTotal}" /></td>

										</tr>


									</tbody>
								</table>

							</c:when>

							<c:when test="${typeId==1 && bType==2}">

								<table class="table table-bordered table-striped fill-head "
									style="width: 100%" id="table_grid">
									<thead style="background-color: #f95d64;">
										<tr>
											<th style="text-align: center;">Sr.No.</th>
											<th style="text-align: center;">CGST %</th>
											<th style="text-align: center;">SGST %</th>
											<th style="text-align: center;">CGST Amt</th>
											<th style="text-align: center;">SGST Amt</th>
											<th style="text-align: center;">Taxable Amt</th>
											<th style="text-align: center;">Total Tax</th>
											<th style="text-align: center;">Grand Total</th>

										</tr>
									</thead>
									<tbody>
										<c:set var="totalCgstAmt" value="0" />
										<c:set var="totalIgstAmt" value="0" />
										<c:set var="totalTaxableAmt" value="0" />
										<c:set var="totalTax" value="0" />
										<c:set var="totalGrandTotal" value="0" />
										<c:forEach items="${taxReportList}" var="taxList"
											varStatus="count">
											<tr>
												<c:set var="totalCgstAmt"
													value="${totalCgstAmt+taxList.cgstAmt}" />
												<c:set var="totalIgstAmt"
													value="${totalIgstAmt+taxList.sgstAmt}" />
												<c:set var="totalTaxableAmt"
													value="${totalTaxableAmt+taxList.taxableAmt}" />
												<c:set var="totalTax" value="${totalTax+taxList.totalTax}" />
												<c:set var="totalGrandTotal"
													value="${totalGrandTotal+taxList.grandTotal}" />


												<td><c:out value="${count.index+1}" /></td>

												<td style="text-align: right;"><c:out
														value="${taxList.cgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.cgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.taxableAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.totalTax}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.grandTotal}" /></td>

											</tr>
										</c:forEach>

										<tr>
											<td></td>
											<td></td>

											<td style="text-align: left;">Total</td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalCgstAmt}" /></td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalIgstAmt}" /></td>

											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTaxableAmt}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTax}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalGrandTotal}" /></td>

										</tr>


									</tbody>
								</table>

							</c:when>

							<c:when test="${typeId==3 && bType==1}">

								<table class="table table-bordered table-striped fill-head "
									style="width: 100%" id="table_grid">
									<thead style="background-color: #f95d64;">
										<tr>
											<th style="text-align: center;">Sr.No.</th>
											<th style="text-align: center;">Bill Date</th>
											<th style="text-align: center;">Invoice No</th>
											<th style="text-align: center;">Franchise</th>
											<th style="text-align: center;">Party Name</th>
											<th style="text-align: center;">Party GST</th>
											<th style="text-align: center;">CGST %</th>
											<th style="text-align: center;">SGST %</th>
											<th style="text-align: center;">CGST Amt</th>
											<th style="text-align: center;">SGST Amt</th>
											<th style="text-align: center;">Taxable Amt</th>
											<th style="text-align: center;">Total Tax</th>
											<th style="text-align: center;">Grand Total</th>

										</tr>
									</thead>
									<tbody>
										<c:set var="totalCgstAmt" value="0" />
										<c:set var="totalIgstAmt" value="0" />
										<c:set var="totalTaxableAmt" value="0" />
										<c:set var="totalTax" value="0" />
										<c:set var="totalGrandTotal" value="0" />
										<c:forEach items="${taxReportList}" var="taxList"
											varStatus="count">
											<tr>
												<c:set var="totalCgstAmt"
													value="${totalCgstAmt+taxList.cgstAmt}" />
												<c:set var="totalIgstAmt"
													value="${totalIgstAmt+taxList.sgstAmt}" />
												<c:set var="totalTaxableAmt"
													value="${totalTaxableAmt+taxList.taxableAmt}" />
												<c:set var="totalTax" value="${totalTax+taxList.totalTax}" />
												<c:set var="totalGrandTotal"
													value="${totalGrandTotal+taxList.grandTotal}" />


												<td><c:out value="${count.index+1}" /></td>
												<td><c:out value="${taxList.billDate}" /></td>
												<td><c:out value="${taxList.invoiceNo}" /></td>
												<td><c:out value="${taxList.frName}" /></td>
												<td><c:out value="${taxList.billToName}" /></td>
												<td><c:out value="${taxList.billToGst}" /></td>

												<td style="text-align: right;"><c:out
														value="${taxList.cgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.cgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.taxableAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.totalTax}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.grandTotal}" /></td>

											</tr>
										</c:forEach>

										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>

											<td style="text-align: left;">Total</td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalCgstAmt}" /></td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalIgstAmt}" /></td>

											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTaxableAmt}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTax}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalGrandTotal}" /></td>

										</tr>


									</tbody>
								</table>

							</c:when>

							<c:when test="${typeId==3 && bType==2}">

								<table class="table table-bordered table-striped fill-head "
									style="width: 100%" id="table_grid">
									<thead style="background-color: #f95d64;">
										<tr>
											<th style="text-align: center;">Sr.No.</th>
											<th style="text-align: center;">Franchise</th>
											<th style="text-align: center;">CGST %</th>
											<th style="text-align: center;">SGST %</th>
											<th style="text-align: center;">CGST Amt</th>
											<th style="text-align: center;">SGST Amt</th>
											<th style="text-align: center;">Taxable Amt</th>
											<th style="text-align: center;">Total Tax</th>
											<th style="text-align: center;">Grand Total</th>

										</tr>
									</thead>
									<tbody>
										<c:set var="totalCgstAmt" value="0" />
										<c:set var="totalIgstAmt" value="0" />
										<c:set var="totalTaxableAmt" value="0" />
										<c:set var="totalTax" value="0" />
										<c:set var="totalGrandTotal" value="0" />
										<c:forEach items="${taxReportList}" var="taxList"
											varStatus="count">
											<tr>
												<c:set var="totalCgstAmt"
													value="${totalCgstAmt+taxList.cgstAmt}" />
												<c:set var="totalIgstAmt"
													value="${totalIgstAmt+taxList.sgstAmt}" />
												<c:set var="totalTaxableAmt"
													value="${totalTaxableAmt+taxList.taxableAmt}" />
												<c:set var="totalTax" value="${totalTax+taxList.totalTax}" />
												<c:set var="totalGrandTotal"
													value="${totalGrandTotal+taxList.grandTotal}" />


												<td><c:out value="${count.index+1}" /></td>
												<td><c:out value="${taxList.frName}" /></td>

												<td style="text-align: right;"><c:out
														value="${taxList.cgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstPer}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.cgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.sgstAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.taxableAmt}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.totalTax}" /></td>
												<td style="text-align: right;"><c:out
														value="${taxList.grandTotal}" /></td>

											</tr>
										</c:forEach>

										<tr>
											<td></td>
											<td></td>
											<td></td>


											<td style="text-align: left;">Total</td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalCgstAmt}" /></td>
											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalIgstAmt}" /></td>

											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTaxableAmt}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalTax}" /></td>


											<td style="text-align: right;"><fmt:formatNumber
													type="number" maxFractionDigits="2" minFractionDigits="2"
													value="${totalGrandTotal}" /></td>

										</tr>


									</tbody>
								</table>

							</c:when>


						</c:choose>


					</div>
					<div class="form-group" id="range">



						<div class="col-sm-3  controls">
							<input type="button" id="expExcel" class="btn btn-primary"
								value="EXPORT TO Excel" onclick="exportToExcel();">
						</div>

						<div class="col-sm-3  controls">
							<input type="button" id="expExcelTally" class="btn btn-primary"
								value="EXPORT TO Excel For Tally"
								onclick="exportToExcelTally();">
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
			} 
			/* else if (a == 0) {
				alert("Please Select Bill Type");
				return false;
			} */

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