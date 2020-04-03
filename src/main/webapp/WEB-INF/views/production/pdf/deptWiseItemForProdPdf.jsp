
<%@page contentType="text/html; charset=ISO8859_1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.lang.*"%>
<%@ page import="com.ats.adminpanel.commons.Constants"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Production List</title>

<style type="text/css">
table {
	border-collapse: collapse;
	font-size: 10;
	width: 100%;
	page-break-inside: auto !important
}
</style>
</head>
<body>

	<c:forEach items="${dateList}" var="date" varStatus="count">

		<%-- <div style="text-align: center; font-size: 12px;">
			Production Date : <b>${date}</b>
		</div> --%>

		<c:forEach items="${deptIdList}" var="dept" varStatus="count">

			<c:set value="0" var="isNotEmpty"></c:set>
			<c:forEach items="${itemList}" var="item" varStatus="count">
				<c:if test="${date==item.productionDate && dept==item.deptId}">
					<c:set value="1" var="isNotEmpty"></c:set>
				</c:if>
			</c:forEach>


			<c:if test="${isNotEmpty==1}">


				<c:forEach items="${allDept}" var="deptMaster" varStatus="count">

					<c:if test="${dept==deptMaster.deptId}">

						<div
							style="text-align: center; font-size: 18px; margin-top: 35px; margin-bottom: 30px;">

							<h4
								style="color: #000; font-size: 16px; text-align: center; margin: 0px;">${company}</h4>
							<p
								style="color: #000; font-size: 10px; text-align: center; margin: 0px;">
								Fact.Address: ${address}</p>

						</div>

						<c:set var="currentDate" value="2020-01-04" />
						<fmt:parseDate value="${currentDate}" var="parsedCurrentDate"
							pattern="yyyy-MM-dd" />

						<div
							style="text-align: center; font-size: 15px; margin-top: 35px; margin-bottom: 30px;">
							Production Date : <b><fmt:formatDate pattern="dd/MM/yyyy"
									value="${parsedCurrentDate}" /></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							Department : <b>${deptMaster.deptName}</b>
						</div>
					</c:if>

				</c:forEach>

				<table width="100%" border="1" cellpadding="0" cellspacing="0"
					style="border-top: 1px solid #313131; border-right: 1px solid #313131;">
					<tr>
						<td width="5%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: center;">No.</td>
						<td width="55%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: center;">Product
							Name</td>
						<td width="20%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: center;">Order Quantity
						</td>
						<td width="20%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: center;">Production Quantity</td>
					</tr>


					<c:set value="1" var="srno"></c:set>

					<c:set value="0" var="total"></c:set>

					<c:forEach items="${itemList}" var="item" varStatus="count">


						<c:if test="${date==item.productionDate && dept==item.deptId}">

							<tr>
								<td width="5%"
									style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px;">${srno}</td>
								<td width="55%"
									style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px;">${item.itemName}</td>
								<td width="20%"
									style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: right;">${item.qty}</td>
								<td width="20%"
									style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px;"></td>
							</tr>

							<c:set value="#{srno+1}" var="srno"></c:set>
							<c:set value="${total+item.qty}" var="total"></c:set>

						</c:if>

					</c:forEach>

					<tr>
						<td width="5%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px;"></td>
						<td width="55%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px;"><b>Total</b></td>
						<td width="20%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: right;"><b>${total}</b></td>
						<td width="20%"
							style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px;"></td>
					</tr>

				</table>

			</c:if>





			<div style="page-break-after: always;"></div>
		</c:forEach>

		

		
	</c:forEach>
</body>
</html>
