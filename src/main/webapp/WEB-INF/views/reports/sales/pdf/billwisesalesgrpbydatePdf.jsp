<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Sales Report Billwise PDF</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->


<style type="text/css">
table {
	border-collapse: collapse;
	font-size: 10;
	width: 100%;
	page-break-inside: auto !important
}

p {
	color: black;
	font-family: arial;
	font-size: 60%;
	margin-top: 0;
	padding: 0;
}

h6 {
	color: black;
	font-family: arial;
	font-size: 80%;
}

th {
	background-color: #f95d64;
	color: white;
}
</style>

</head>
<body onload="myFunction()">
	<h3 align="center">${FACTORYNAME}</h3>
	<p align="center">${FACTORYADDRESS}</p>

	<div align="center">
		<h5>Sales Report (Group by Date Wise) &nbsp;&nbsp;&nbsp;&nbsp;
			From &nbsp; ${fromDate} &nbsp;To &nbsp; ${toDate}</h5>
	</div>


	<c:choose>

		<c:when test="${billType==1}">
			<table align="center" border="1" cellspacing="0" cellpadding="1"
				id="table_grid" class="table table-bordered">
				<thead>
					<!-- <tr class="bgpink">
						<th style="text-align: center;">Sr.No.</th>
						<th style="text-align: center;">Date</th>
						<th style="text-align: center;">Taxable Value</th>
						<th style="text-align: center;">Tax Value</th>
						<th style="text-align: center;">Grand Total</th>
						<th style="text-align: center;">GRN Taxable Value</th>
						<th style="text-align: center;">GRN Tax Value</th>
						<th style="text-align: center;">GRN Grand Total</th>
						<th style="text-align: center;">GVN Taxable Value</th>
						<th style="text-align: center;">GVN Tax Value</th>
						<th style="text-align: center;">GVN Grand Total</th>
						<th style="text-align: center;">NET Taxable Total</th>
						<th style="text-align: center;">NET Tax Total</th>
						<th style="text-align: center;">NET Grand Total</th>
					</tr> -->
					
					<tr class="bgpink">
						<th style="text-align: center;">Sr.No.</th>
						<th style="text-align: center;">Date</th>
						<th style="text-align: center;">Grand Total</th>
						<th style="text-align: center;">GRN Grand Total</th>
						<th style="text-align: center;">GVN Grand Total</th>
						<th style="text-align: center;">NET Grand Total</th>
					</tr>
					
				</thead>
				<%-- <tbody>

					<c:set var="totalGrandTotal" value="${0}" />
					<c:set var="totalTax" value="${0 }" />
					<c:set var="totalTaxableAmt" value="${0 }" />

					<c:set var="totalGrnGrandTotal" value="${0 }" />
					<c:set var="totalGrnTaxableAmt" value="${0}" />
					<c:set var="totalGrnTax" value="${0 }" />

					<c:set var="totalGvnGrandTotal" value="${0 }" />
					<c:set var="totalGvnTax" value="${0}" />
					<c:set var="totalGvnTaxableAmt" value="${0 }" />


					<c:set var="totalNetGrandTotal" value="${0 }" />
					<c:set var="totalNetTax" value="${0}" />
					<c:set var="totalNetTaxableAmt" value="${0 }" />
					<c:forEach items="${report}" var="report" varStatus="count">
						<tr>

							<c:set var="totalTaxableAmt"
								value="${totalTaxableAmt + report.taxableAmt}" />
							<c:set var="totalTax" value="${totalTax + report.totalTax}" />
							<c:set var="totalGrandTotal"
								value="${totalGrandTotal + report.grandTotal}" />


							<c:set var="totalGrnGrandTotal"
								value="${totalGrnGrandTotal + report.grnGrandTotal}" />
							<c:set var="totalGrnTaxableAmt"
								value="${totalGrnTaxableAmt + report.grnTaxableAmt}" />
							<c:set var="totalGrnTax"
								value="${totalGrnTax + report.grnTotalTax}" />



							<c:set var="totalGvnGrandTotal"
								value="${totalGvnGrandTotal + report.gvnGrandTotal}" />
							<c:set var="totalGvnTaxableAmt"
								value="${totalGvnTaxableAmt + report.gvnTaxableAmt}" />
							<c:set var="totalGvnTax"
								value="${totalGvnTax + report.gvnTotalTax}" />


							<c:set var="totalNetGrandTotal"
								value="${totalNetGrandTotal + report.netGrandTotal}" />
							<c:set var="totalNetTax"
								value="${totalNetTax + report.netTotalTax}" />
							<c:set var="totalNetTaxableAmt"
								value="${totalNetTaxableAmt + report.netTaxableAmt}" />


							<td  style="text-align: center;"><c:out value="${count.index+1}" /></td>
							<td  style="text-align: center;"><c:out value="${report.billDate}" /></td>
							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.taxableAmt}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.totalTax}" /></td>
							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.grandTotal}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.grnTaxableAmt}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.grnTotalTax}" /></td>


							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.grnGrandTotal}" /></td>


							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.gvnTaxableAmt}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.gvnTotalTax}" /></td>


							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.gvnGrandTotal}" /></td>





							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.netTaxableAmt}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.netTotalTax}" /></td>


							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.netGrandTotal}" /></td>



						</tr>

					</c:forEach>
					<tr>



						<td colspan='2' style="text-align: left;"><b>Total</b></td>


						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalTaxableAmt}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalTax}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGrandTotal}" /></b></td>



						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGrnTaxableAmt}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGrnTax}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGrnGrandTotal}" /></b></td>



						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGvnTaxableAmt}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGvnTax}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGvnGrandTotal}" /></b></td>



						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetTaxableAmt}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetTax}" /></b></td>
						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetGrandTotal}" /></b></td>

					</tr>
				</tbody> --%>
				
				<tbody>

					<c:set var="totalGrandTotal" value="${0}" />
					<c:set var="totalTax" value="${0 }" />
					<c:set var="totalTaxableAmt" value="${0 }" />

					<c:set var="totalGrnGrandTotal" value="${0 }" />
					<c:set var="totalGrnTaxableAmt" value="${0}" />
					<c:set var="totalGrnTax" value="${0 }" />

					<c:set var="totalGvnGrandTotal" value="${0 }" />
					<c:set var="totalGvnTax" value="${0}" />
					<c:set var="totalGvnTaxableAmt" value="${0 }" />


					<c:set var="totalNetGrandTotal" value="${0 }" />
					<c:set var="totalNetTax" value="${0}" />
					<c:set var="totalNetTaxableAmt" value="${0 }" />
					<c:forEach items="${report}" var="report" varStatus="count">
						<tr>

							<c:set var="totalTaxableAmt"
								value="${totalTaxableAmt + report.taxableAmt}" />
							<c:set var="totalTax" value="${totalTax + report.totalTax}" />
							<c:set var="totalGrandTotal"
								value="${totalGrandTotal + report.grandTotal}" />


							<c:set var="totalGrnGrandTotal"
								value="${totalGrnGrandTotal + report.grnGrandTotal}" />
							<c:set var="totalGrnTaxableAmt"
								value="${totalGrnTaxableAmt + report.grnTaxableAmt}" />
							<c:set var="totalGrnTax"
								value="${totalGrnTax + report.grnTotalTax}" />



							<c:set var="totalGvnGrandTotal"
								value="${totalGvnGrandTotal + report.gvnGrandTotal}" />
							<c:set var="totalGvnTaxableAmt"
								value="${totalGvnTaxableAmt + report.gvnTaxableAmt}" />
							<c:set var="totalGvnTax"
								value="${totalGvnTax + report.gvnTotalTax}" />


							<c:set var="totalNetGrandTotal"
								value="${totalNetGrandTotal + report.netGrandTotal}" />
							<c:set var="totalNetTax"
								value="${totalNetTax + report.netTotalTax}" />
							<c:set var="totalNetTaxableAmt"
								value="${totalNetTaxableAmt + report.netTaxableAmt}" />


							<td  style="text-align: center;"><c:out value="${count.index+1}" /></td>
							<td  style="text-align: center;"><c:out value="${report.billDate}" /></td>
							
							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.grandTotal}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.grnGrandTotal}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.gvnGrandTotal}" /></td>

							<td  style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.netGrandTotal}" /></td>


						</tr>

					</c:forEach>
					<tr>



						<td colspan='2' style="text-align: left;"><b>Total</b></td>


						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGrandTotal}" /></b></td>

						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGrnGrandTotal}" /></b></td>

						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalGvnGrandTotal}" /></b></td>

						<td  style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetGrandTotal}" /></b></td>

					</tr>
				</tbody>
				
			</table>
		</c:when>

		<c:otherwise>
			<table align="center" border="1" cellspacing="0" cellpadding="1"
				id="table_grid" class="table table-bordered">
				<thead>
					<tr class="bgpink">
						<th style="text-align: center;">Sr.No.</th>
						<th style="text-align: center;">Date</th>
						<th style="text-align: center;">Franchisee</th>
						<th style="text-align: center;">Bill Total</th>
						<th style="text-align: center;">Transaction Total</th>
						<th style="text-align: center;">Discount Total</th>
						<th style="text-align: center;">Advance Total</th>
						<th style="text-align: center;">Expense Total</th>
						<th style="text-align: center;">Credit Note Total</th>
						<th style="text-align: center;">Withdrawl Total</th>
					</tr>
				</thead>
				<tbody>

					<c:set var="totalBill" value="${0}" />
					<c:set var="totalTr" value="${0 }" />
					<c:set var="totalDisc" value="${0 }" />
					<c:set var="totalAdv" value="${0 }" />
					<c:set var="totalExp" value="${0}" />
					<c:set var="totalCredit" value="${0 }" />
					<c:set var="totalWithdrawl" value="${0 }" />

					<c:forEach items="${compReport}" var="report" varStatus="count">
						<tr>
							<c:set var="totalBill" value="${totalBill + report.billTotal}" />
							<c:set var="totalTr" value="${totalTr + report.trTotal}" />
							<c:set var="totalDisc" value="${totalDisc + report.discTotal}" />
							<c:set var="totalAdv" value="${totalAdv + report.advTotal}" />
							<c:set var="totalExp" value="${totalExp + report.expTotal}" />
							<c:set var="totalCredit" value="${totalCredit + report.creditTotal}" />
							<c:set var="totalWithdrawl" value="${totalWithdrawl + report.withdrawlTotal}" />

							<td style="text-align: center;"><c:out value="${count.index+1}" /></td>
							<td style="text-align: center;"><c:out value="${report.billDate}" /></td>
							<td style="text-align: left;"><c:out value="${report.frName}" /></td>

							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.billTotal}" /></td>
							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.trTotal}" /></td>

							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.discTotal}" /></td>

							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.advTotal}" /></td>


							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.expTotal}" /></td>


							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.creditTotal}" /></td>

							<td style="text-align: right;"><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${report.withdrawlTotal}" /></td>

						</tr>

					</c:forEach>
					<tr>



						<td colspan='3'><b>Total</b></td>


						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalBill}" /></b></td>
						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalTr}" /></b></td>
						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalDisc}" /></b></td>



						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalAdv}" /></b></td>
						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalExp}" /></b></td>
						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalCredit}" /></b></td>



						<td style="text-align: right;"><b><fmt:formatNumber
									type="number" maxFractionDigits="2" minFractionDigits="2"
									value="${totalWithdrawl}" /></b></td>
					</tr>
				</tbody>
			</table>
		</c:otherwise>

	</c:choose>




	<!-- END Main Content -->

</body>
</html>