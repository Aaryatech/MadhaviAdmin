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
<title>Sales Report Royalty</title>
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
		<h5>Product Wise Report (Category/Item wise)
			&nbsp;&nbsp;&nbsp;&nbsp; From &nbsp; ${fromDate} &nbsp;To &nbsp;
			${toDate}</h5>
	</div>
	<table align="center" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th style="text-align: center;">Sr.No.</th>
				<th style="text-align: center;">Item Name</th>
				<th style="text-align: center;">Sale Qty</th>
				<th style="text-align: center;">Sale Value</th>

				<c:choose>
					<c:when test="${billType==1}">
						<th style="text-align: center;">Discount</th>
						<th style="text-align: center;">GRN Qty</th>
						<th style="text-align: center;">GRN Value</th>
						<th style="text-align: center;">GVN Qty</th>
						<th style="text-align: center;">GVN Value</th>
					</c:when>
					<c:otherwise>
						<th style="text-align: center;">CRN Qty</th>
						<th style="text-align: center;">CRN Value</th>
					</c:otherwise>
				</c:choose>


				<th style="text-align: center;">Net Qty</th>
				<th style="text-align: center;">Net Value</th>
				<th style="text-align: center;">Contribution</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="sumSaleQty" value="${0}" />
			<c:set var="sumSaleValue" value="${0}" />
			<c:set var="sumGrnQty" value="${0}" />
			<c:set var="sumGrnValue" value="${0}" />
			<c:set var="sumGvnQty" value="${0}" />
			<c:set var="sumGvnValue" value="${0}" />
			<c:set var="sumNetQty" value="${0}" />
			<c:set var="sumNetValue" value="${0}" />
			<c:set var="sumDiscount" value="${0}" />


			<c:forEach items="${royaltyList.categoryList}" var="report"
				varStatus="count">
				<tr>

					<td><b>${report.catName}</b></td>

					<c:if test="${billType==1}">
						<td><c:out value="" /></td>
						<td><c:out value="" /></td>
						<td><c:out value="" /></td>
					</c:if>



					<td><c:out value="" /></td>
					<td><c:out value="" /></td>
					<td><c:out value="" /></td>
					<td><c:out value="" /></td>
					<td><c:out value="" /></td>
					<td><c:out value="" /></td>
					<td><c:out value="" /></td>
					<td><c:out value="" /></td>

					<c:set var="totalContri" value="0"></c:set>
					<c:forEach items="${royaltyList.salesReportRoyalty}" var="royalty"
						varStatus="count">

						<c:choose>
							<c:when test="${royalty.catId==report.catId}">
								<c:set var="totalContri"
									value="${totalContri+royalty.tBillTaxableAmt -(royalty.tGrnTaxableAmt+royalty.tGvnTaxableAmt)}"></c:set>
							</c:when>
						</c:choose>
					</c:forEach>



					<%-- <td><c:out value="${total}" /></td> --%>

					<%-- <td><fmt:formatNumber type="number"
								maxFractionDigits="2" value="${total}" /></td> --%>
				</tr>
				<c:set var="srNo" value="1"></c:set>
				<c:forEach items="${royaltyList.salesReportRoyalty}" var="royalty"
					varStatus="count">

					<c:choose>
						<c:when test="${royalty.catId==report.catId}">

							<tr>
								<td style="text-align: center;"><c:out value="${srNo}" /></td>
								<c:set var="srNo" value="${srNo+1}"></c:set>
								<td style="text-align: left;"><c:out
										value="${royalty.item_name}" /></td>
								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2"
										value="${royalty.tBillQty}" /></td>
								<%-- <td><c:out value="${royalty.tBillTaxableAmt}" /></td> --%>



								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2"
										value="${royalty.tBillTaxableAmt}" /></td>

								<c:if test="${billType==1}">

									<td align="right"><fmt:formatNumber type="number"
											maxFractionDigits="2" minFractionDigits="2"
											value="${royalty.discAmt}" /></td>

								</c:if>

								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2"
										value="${royalty.tGrnQty}" /></td>

								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2"
										value="${royalty.tGrnTaxableAmt}" /></td>

								<c:if test="${billType==1}">

									<td align="right"><fmt:formatNumber type="number"
											maxFractionDigits="2" minFractionDigits="2"
											value="${royalty.tGvnQty}" /></td>


									<td align="right"><fmt:formatNumber type="number"
											maxFractionDigits="2" minFractionDigits="2"
											value="${royalty.tGvnTaxableAmt}" /></td>

								</c:if>

								<c:set var="netQty"
									value="${royalty.tBillQty -(royalty.tGrnQty+royalty.tGvnQty)}"></c:set>

								<c:set var="netValue"
									value="${royalty.tBillTaxableAmt -(royalty.tGrnTaxableAmt+royalty.tGvnTaxableAmt)}"></c:set>

								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2" value="${netQty}" /></td>

								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2"
										value="${netValue}" /></td>

								<c:set var="contri" value="0.0"></c:set>

								<c:if test="${totalContri>0}">
									<c:set var="contri" value="${(netValue*100)/totalContri}"></c:set>
								</c:if>



								<td align="right"><fmt:formatNumber type="number"
										maxFractionDigits="2" minFractionDigits="2" value="${contri}" /></td>



								<c:set var="sumSaleQty" value="${royalty.tBillQty+sumSaleQty}"></c:set>
								<c:set var="sumSaleValue"
									value="${royalty.tBillTaxableAmt+sumSaleValue}"></c:set>

								<c:set var="sumGrnQty" value="${royalty.tGrnQty+sumGrnQty}"></c:set>

								<c:set var="sumGrnValue"
									value="${royalty.tGrnTaxableAmt+sumGrnValue}"></c:set>

								<c:set var="sumGvnQty" value="${royalty.tGvnQty+sumGvnQty}"></c:set>

								<c:set var="sumGvnValue"
									value="${royalty.tGvnTaxableAmt+sumGvnValue}"></c:set>

								<c:set var="sumNetQty" value="${sumNetQty+netQty}"></c:set>


								<c:set var="sumNetValue" value="${netValue+sumNetValue}"></c:set>

								<c:if test="${billType==1}">
									<c:set var="sumDiscount" value="${sumDiscount+royalty.discAmt}" />
								</c:if>

							</tr>
						</c:when>
					</c:choose>


				</c:forEach>


			</c:forEach>
			<tr>

				<td colspan='2'><b>Total</b></td>
				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2" value="${sumSaleQty}" /></b></td>
				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2"
							value="${sumSaleValue}" /></b></td>

				<c:if test="${billType==1}">
					<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2" value="${sumDiscount}" /></b></td>

				</c:if>

				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2" value="${sumGrnQty}" /></b></td>
				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2"
							value="${sumGrnValue}" /></b></td>

				<c:if test="${billType==1}">
					<td align="right"><b><fmt:formatNumber type="number"
								maxFractionDigits="2" minFractionDigits="2" value="${sumGvnQty}" /></b></td>

					<td align="right"><b><fmt:formatNumber type="number"
								maxFractionDigits="2" minFractionDigits="2"
								value="${sumGvnValue}" /></b></td>
				</c:if>

				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2" value="${sumNetQty}" /></b></td>

				<td align="right"><b><fmt:formatNumber type="number"
							maxFractionDigits="2" minFractionDigits="2"
							value="${sumNetValue}" /></b></td>

			</tr>
		</tbody>
	</table>


	<!-- END Main Content -->

</body>
</html>