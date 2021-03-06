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
<title>Customer Report PDF</title>
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
	
		<h5>Customer Report</h5>
	</div>
	<table align="center" border="1" cellspacing="0" cellpadding="1"
		id="table_grid" class="table table-bordered">
		<thead>
			<tr class="bgpink">
				<th>Sr. No.</th>
				<th>Name</th>
				<th>Phone</th>
				<th>Email</th>
				<th>Address</th>
				<th>Added From</th>
			</tr>
		</thead>
		<tbody>


			<c:forEach items="${custList}" var="cust" varStatus="count">
				<tr>
					<td>${count.index+1}</td>
					<td>${cust.custName}</td>
					<td style="text-align: center;">${cust.phoneNumber}</td>

					<c:choose>
						<c:when test="${cust.emailId != ''}">
							<td>${cust.emailId}</td>
						</c:when>
						<c:otherwise>
							<td>-</td>
						</c:otherwise>
					</c:choose>



					<c:choose>
						<c:when test="${cust.address != ''}">
							<td>${cust.address}</td>
						</c:when>
						<c:otherwise>
							<td>NA</td>
						</c:otherwise>
					</c:choose>


					<c:choose>
						<c:when test="${cust.addedFromType == 1}">
							<td>POS</td>
						</c:when>
						<c:when test="${cust.addedFromType == 2}">
							<td>Online</td>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
					</c:choose>

				</tr>

			</c:forEach>

		</tbody>
	</table>


	<!-- END Main Content -->

</body>
</html>