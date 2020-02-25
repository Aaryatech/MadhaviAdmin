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
<title>SubCategory Summary Report PDF</title>
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
		<h5>SubCategory Summary Report &nbsp;&nbsp;&nbsp;&nbsp; From
			&nbsp; ${fromDate} &nbsp;To &nbsp; ${toDate}</h5>
	</div>


	<c:choose>

		<c:when test="${billType==1}">

			<table align="center" border="1" cellspacing="0" cellpadding="1"
				id="table_grid" class="table table-bordered">
				<thead>
					<tr class="bgpink">
						<th style="text-align: center;">Sr.No.</th>
						<th style="text-align: center;">Sub Category Name</th>
						<th style="text-align: center;">Sold Qty</th>
						<th style="text-align: center;">Sold Amt</th>
						<th style="text-align: center;">Var Qty</th>
						<th style="text-align: center;">Var Amt</th>
						<th style="text-align: center;">Ret Qty</th>
						<th style="text-align: center;">Ret Amt</th>
						<th style="text-align: center;">Net Qty</th>
						<th style="text-align: center;">Net Amt</th>
						<th style="text-align: center;">Ret Amt</th>
					</tr>
				</thead>
				<tbody>

					<c:set var="totalSoldQty" value="${0}" />
					<c:set var="totalSoldAmt" value="${0}" />
					<c:set var="totalVarQty" value="${0}" />
					<c:set var="totalVarAmt" value="${0}" />
					<c:set var="totalRetQty" value="${0}" />
					<c:set var="totalRetAmt" value="${0}" />
					<c:set var="totalNetQty" value="${0}" />
					<c:set var="totalNetAmt" value="${0}" />
					<c:set var="retAmtPer" value="${0}" />
					<tr>


					</tr>
					<c:forEach items="${subCatReportList}" var="report"
						varStatus="count">
						<tr>

							<td><c:out value="${count.index+1}" /></td>
							<td><c:out value="${report.subCatName}" /></td>
							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.soldQty}" /></td>

							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.soldAmt}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.varQty}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.varAmt}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.retQty}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.retAmt}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.netQty}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.netAmt}" /></td>

							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.retAmtPer}" /></td>


							<c:set var="totalSoldQty"
								value="${totalSoldQty+(report.soldQty)}" />
							<c:set var="totalSoldAmt"
								value="${totalSoldAmt+(report.soldAmt)}" />
							<c:set var="totalVarQty" value="${totalVarQty+(report.varQty)}" />
							<c:set var="totalVarAmt" value="${totalVarAmt+(report.varAmt)}" />
							<c:set var="totalRetQty" value="${totalRetQty+(report.retQty)}" />
							<c:set var="totalRetAmt" value="${totalRetAmt+(report.retAmt)}" />
							<c:set var="totalNetQty" value="${totalNetQty+(report.netQty)}" />
							<c:set var="totalNetAmt" value="${totalNetAmt+(report.netAmt)}" />
							<c:set var="retAmtPer" value="${retAmtPer+(report.retAmtPer)}" />




						</tr>

					</c:forEach>

					<tr>

						<td></td>

						<td colspan='1'><b>Total</b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalSoldQty}" /></b></td>

						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalSoldAmt}" /></b></td>
						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalVarQty}" /></b></td>

						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalVarAmt}" /></b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalRetQty}" /></b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalRetAmt}" /></b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetQty}" /></b></td>



						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetAmt}" /></b></td>

						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${retAmtPer}" /></b></td>



						<!--  <td><b>Total</b></td> -->
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
						<th style="text-align: center;">Sub Category Name</th>
						<th style="text-align: center;">Sold Qty</th>
						<th style="text-align: center;">Sold Amt</th>
						<th style="text-align: center;">CRN Qty</th>
						<th style="text-align: center;">CRN Amt</th>
						<th style="text-align: center;">Net Qty</th>
						<th style="text-align: center;">Net Amt</th>
					</tr>
				</thead>
				<tbody>

					<c:set var="totalSoldQty" value="${0}" />
					<c:set var="totalSoldAmt" value="${0}" />
					<c:set var="totalVarQty" value="${0}" />
					<c:set var="totalVarAmt" value="${0}" />
					<c:set var="totalRetQty" value="${0}" />
					<c:set var="totalRetAmt" value="${0}" />
					<c:set var="totalNetQty" value="${0}" />
					<c:set var="totalNetAmt" value="${0}" />
					<c:set var="retAmtPer" value="${0}" />
					<tr>


					</tr>
					<c:forEach items="${subCatReportList}" var="report"
						varStatus="count">
						<tr>

							<td><c:out value="${count.index+1}" /></td>
							<td><c:out value="${report.subCatName}" /></td>
							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.soldQty}" /></td>

							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.soldAmt}" /></td>





							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.retQty}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.retAmt}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.netQty}" /></td>


							<td align="right"><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${report.netAmt}" /></td> 


							<c:set var="totalSoldQty"
								value="${totalSoldQty+(report.soldQty)}" />
							<c:set var="totalSoldAmt"
								value="${totalSoldAmt+(report.soldAmt)}" />
							<c:set var="totalVarQty" value="${totalVarQty+(report.varQty)}" />
							<c:set var="totalVarAmt" value="${totalVarAmt+(report.varAmt)}" />
							<c:set var="totalRetQty" value="${totalRetQty+(report.retQty)}" />
							<c:set var="totalRetAmt" value="${totalRetAmt+(report.retAmt)}" />
							<c:set var="totalNetQty" value="${totalNetQty+(report.netQty)}" />
							<c:set var="totalNetAmt" value="${totalNetAmt+(report.netAmt)}" />
							<c:set var="retAmtPer" value="${retAmtPer+(report.retAmtPer)}" />

						</tr>

					</c:forEach>

					<tr>

						<td></td>

						<td colspan='1'><b>Total</b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalSoldQty}" /></b></td>

						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalSoldAmt}" /></b></td>



						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalRetQty}" /></b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalRetAmt}" /></b></td>


						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetQty}" /></b></td>



						<td align="right"><b><fmt:formatNumber type="number"
									maxFractionDigits="2" minFractionDigits="2"
									value="${totalNetAmt}" /></b></td>




						<!--  <td><b>Total</b></td> -->
					</tr>


				</tbody>
			</table>

		</c:otherwise>
	</c:choose>



	<!-- END Main Content -->

</body>
</html>