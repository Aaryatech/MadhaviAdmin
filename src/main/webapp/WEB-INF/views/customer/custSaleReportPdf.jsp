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
<title>Customer Sales Report PDF</title>
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

		<c:set value="" var="typeName"></c:set>

		<c:choose>
			<c:when test="${type == '1,2'}">
				<c:set value=" (POS / Online)" var="typeName"></c:set>
			</c:when>

			<c:when test="${type == '1'}">
				<c:set value=" (POS)" var="typeName"></c:set>
			</c:when>

			<c:when test="${type == '2'}">
				<c:set value=" (Online)" var="typeName"></c:set>
			</c:when>

		</c:choose>

		<h4>Customer Sales Report</h4>
	</div>
	<table align="center" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th>Sr. No.</th>
				<th>Name</th>
				<th>Phone</th>
				<th>Added From</th>
				<th>Sell AMT</th>
				<th>Discount AMT</th>
				<th>Wallet AMT</th>
				<th>Extra Charges AMT</th>

			</tr>
		</thead>
		<tbody>

			<c:set value="0" var="totalSell"></c:set>
			<c:set value="0" var="totalDisc"></c:set>
			<c:set value="0" var="totalWallet"></c:set>
			<c:set value="0" var="totalExCh"></c:set>


			<c:forEach items="${custList}" var="cust" varStatus="count">
				<tr>
					<td>${count.index+1}</td>
					<td>${cust.custName}</td>
					<td style="text-align: center;">${cust.phoneNumber}</td>

					<c:choose>
						<c:when test="${cust.addedFromType == 1}">
							<td style="text-align: center;">POS</td>
						</c:when>
						<c:when test="${cust.addedFromType == 2}">
							<td style="text-align: center;">Online</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>

					<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${cust.payableAmt}" /></td>
					<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${cust.discAmt}" /></td>
					<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${cust.wallet}" /></td>
					<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${cust.extraCh}" /></td>

					<c:set value="${totalSell+cust.payableAmt}" var="totalSell"></c:set>
					<c:set value="${totalDisc+cust.discAmt}" var="totalDisc"></c:set>
					<c:set value="${totalWallet+cust.wallet}" var="totalWallet"></c:set>
					<c:set value="${totalExCh+cust.extraCh}" var="totalExCh"></c:set>

				</tr>

			</c:forEach>

			<tr>
				<td colspan=4>TOTAL</td>
				<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${totalSell}" /></td>
				<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${totalDisc}" /></td>
				<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${totalWallet}" /></td>
				<td style="text-align: right;"><fmt:formatNumber type="number"
							minFractionDigits="0" maxFractionDigits="2"
							value="${totalExCh}" /></td>
			</tr>


		</tbody>
	</table>


	<!-- END Main Content -->

</body>
</html>