
<%@page contentType="text/html; charset=ISO8859_1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.lang.*"%>
<%@ page import="com.ats.adminpanel.commons.Constants"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FR Bill PDF</title>

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
<!-- c:forEach for multiple bills -->
	<c:forEach items="${billDetails}" var="frDetails" varStatus="count">
		<c:set var="srCnt" value="0" />
		<c:set var="totalRowCount" value="0" />
		<c:set var="maxRowCount" value="34" />
		<div style="text-align: center; font-size: 12px;">
			<b>TAX INVOICE</b>
		</div>
		<div style="text-align: right; font-size: 10px;">CIN :
			${frDetails.company.cinNo}</div>
			
			<!-- bill detail block start -->
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			style="border-left: 1px solid #313131; border-right: 1px solid #313131; border-top: 1px solid #313131;">
			<tr>
				<!-- <td colspan="2" width="20%"
					style="padding: 10px; color: #FFF; font-size: 15px;">&nbsp;</td> -->
				<td width="60%" colspan="6" rowspan="2"
					style="border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: left">
					<p
						style="color: #000; font-size: 10px; text-align: left; margin: 0px;">
						&nbsp;Name & Address of Licensee:<br></br>
					</p>
					<h4
						style="color: #000; font-size: 16px; text-align: left; margin: 0px;">&nbsp;${frDetails.company.compName}</h4>
					<p
						style="color: #000; font-size: 10px; text-align: left; margin: 0px;">
						&nbsp; Fact.Address: ${frDetails.company.factAddress} <br />&nbsp;
						Phone: ${frDetails.company.phoneNo1}, Email:
						${frDetails.company.email}
					</p>
					<br>
						<p
							style="color: #000; font-size: 13px; text-align: left; margin: 0px;">
							&nbsp; <b>GST No:</b>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${frDetails.company.gstin}

						</p>
				</td>
				<td colspan="4" width="40%"
					style="border-left: 1px solid #313131; border-right: 1px solid #313131; padding: 10px; color: #FFF; font-size: 15px;">
					<p
						style="color: #000; font-size: 9px; text-align: left; margin: 0px;">
						ORIGINAL - FOR BUYER <br /> DUPLICATE - FOR TRANSPORTER/ACESSEE
					</p>
				</td>

			</tr>
			<tr>
				<td colspan="4" width="40%"
					style="border-left: 1px solid #313131; border-top: 1px solid #313131; border-right: 1px solid #313131; padding: 10px; color: #FFF; font-size: 15px;">
					<p
						style="color: #000; font-size: 10px; text-align: left; margin: 0px;">
						Date Of Receiver (Bill To/Ship To)<br />
					</p>
					<p
						style="color: #000; font-size: 12px; text-align: left; margin: 0px;">
						<b>${frDetails.partyName}</b> <br /> <span
							style="font-size: 10px;"> ${frDetails.frAddress} </span><br></br>
						<span style="font-size: 10px;">GSTIN:
							${frDetails.partyGstin}</span>
					</p>
				</td>
			</tr>

			<tr>
				<td width="50%" colspan="6"
					style="border-top: 1px solid #313131; padding: 8px; color: #FFF; font-size: 14px;">

					<p
						style="color: #000; font-size: 13px; font-weight: bold; text-align: left; margin: 0px;">
						Invoice No: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>${frDetails.invoiceNo}</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date:
						&nbsp;&nbsp;&nbsp;<b>${frDetails.billDate}</b>
					</p>
					<p
						style="color: #000; font-size: 13px; text-align: left; margin: 0px;">
						<!-- Invoice  -->
						<b>Eway Bill No: ${frDetails.ewayBillNo}</b>
					</p>
				</td>

				<td width="50%" colspan="5"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 8px; color: #FFF; font-size: 15px;">

					<p
						style="color: #000; font-weight: bold; font-size: 13px; text-align: left; margin: 0px;">
						<%-- Place
						of supply: &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ${Constants.STATE}    &nbsp;&nbsp;&nbsp;&nbsp; --%>
						&nbsp; Date Of
						Remo.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${frDetails.billDate}&nbsp;&nbsp;${frDetails.billTime}
					</p>
				</td>
			</tr>

		</table>
		
		<!-- bill detail block ends -->
		
		
			<!-- bill item  block start -->

		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-right: 1px solid #313131">
			<tr>
				<td rowspan="2" width="2%"
					style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px;">No.</td>
				<td align="left" width="36%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 15px; color: #000; font-size: 10px; text-align: left">Item
					Description</td>
				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 0.2px; color: #000; font-size: 10px;">HSN
					Code</td>

				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Qty</td>
				<!--change <td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">UOM
				</td> -->
				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Rate</td>
				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">
					Disc %</td>
				<td align="center" width="10%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Taxable
					Amt</td>

				<td align="center" width="10%" colspan="2"
					style="border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">
					CGST</td>
				<td align="center" width="10%" colspan="2"
					style="border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">SGST</td>
				<td align="center" width="10%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Total</td>
			</tr>
			<tr>

				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Rate%
				</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Amount</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Rate%</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Amount</td>
			</tr>

			<c:set var="totalQty" value="0" />
			<c:set var="totalSpKgQty" value="0" />
			<c:set var="totalAmt" value="0" />
			<c:set var="totalCgst" value="0" />
			<c:set var="totalDisc" value="0" />
			<c:set var="totalSgst" value="0" />
			<c:set var="acttotal" value="0" />

			<c:forEach items="${frDetails.subCatList}" var="category">
				<c:set var="totalRowCount" value="${totalRowCount+1}" />

				<tr>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 10px;"><u><b>${category.subCatName}</b></u></td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>

					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>
					<td
						style="border-left: 1px solid #313131; padding: 3px 5px; color: white; font-size: 10px;">-</td>

				</tr>
				<c:forEach items="${frDetails.billDetailsList}" var="billDetails"
					varStatus="count">

					<c:choose>
						<c:when test="${category.subCatId eq billDetails.subCatId}">

							<c:choose>

								<c:when test="${totalRowCount eq maxRowCount}">
		</table>
		
		
		<!-- bill item  block start -->

		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			style="border-top: 1px solid #313131; border-right: 1px solid #313131;">



		</table>




		<div style="page-break-after: always;"></div>



		<div style="text-align: center; font-size: 12px;">
			<b>TAX INVOICE</b>
		</div>
		<div style="text-align: right; font-size: 10px;">CIN:
			${frDetails.company.cinNo}</div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			style="border-left: 1px solid #313131; border-right: 1px solid #313131; border-top: 1px solid #313131;">
			<tr>
				<!-- <td colspan="2" width="20%"
					style="padding: 10px; color: #FFF; font-size: 15px;">&nbsp;</td> -->
				<td width="60%" colspan="6" rowspan="2"
					style="border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 15px; text-align: left">
					<p
						style="color: #000; font-size: 10px; text-align: left; margin: 0px;">
						&nbsp;Name & Address of Licensee:<br></br>
					</p>
					<h4
						style="color: #000; font-size: 16px; text-align: left; margin: 0px;">&nbsp;${frDetails.company.compName}</h4>
					<p
						style="color: #000; font-size: 10px; text-align: left; margin: 0px;">
						&nbsp; Fact.Address: ${frDetails.company.factAddress} <br />&nbsp;
						Phone: ${frDetails.company.phoneNo1}, Email:
						${frDetails.company.email}
					</p>
					<br>
						<p
							style="color: #000; font-size: 13px; text-align: left; margin: 0px;">
							&nbsp; <b>GST No:</b>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${frDetails.company.gstin}

						</p>
				</td>
				<td colspan="4" width="40%"
					style="border-left: 1px solid #313131; border-right: 1px solid #313131; padding: 10px; color: #FFF; font-size: 15px;">
					<p
						style="color: #000; font-size: 9px; text-align: left; margin: 0px;">
						ORIGINAL - FOR BUYER <br /> DUPLICATE - FOR TRANSPORTER/ACESSEE
					</p>
				</td>

			</tr>
			<tr>
				<td colspan="4" width="40%"
					style="border-left: 1px solid #313131; border-top: 1px solid #313131; border-right: 1px solid #313131; padding: 10px; color: #FFF; font-size: 15px;">
					<p
						style="color: #000; font-size: 10px; text-align: left; margin: 0px;">
						Date Of Receiver (Bill To/Ship To)<br />
					</p>
					<p
						style="color: #000; font-size: 12px; text-align: left; margin: 0px;">
						<b>${frDetails.partyName}</b> <br /> <span
							style="font-size: 10px;"> ${frDetails.frAddress} </span><br></br>
						<span style="font-size: 10px;">GSTIN:
							${frDetails.partyGstin}</span>
					</p>
				</td>
			</tr>

			<tr>
				<td width="50%" colspan="6"
					style="border-top: 1px solid #313131; padding: 8px; color: #FFF; font-size: 14px;">

					<p
						style="color: #000; font-size: 13px; font-weight: bold; text-align: left; margin: 0px;">
						Invoice No: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>${frDetails.invoiceNo}</b>Eway
						Bill No: ${frDetails.ewayBillNo}
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date:
						&nbsp;&nbsp;&nbsp;<b>${frDetails.billDate}</b>
					</p>
				</td>

				<td width="50%" colspan="5"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 8px; color: #FFF; font-size: 15px;">

					<p
						style="color: #000; font-weight: bold; font-size: 13px; text-align: left; margin: 0px;">
						<%-- Place
						of supply: &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ${Constants.STATE}    &nbsp;&nbsp;&nbsp;&nbsp; --%>
						&nbsp; Date Of
						Remo.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${frDetails.billDate}&nbsp;&nbsp;${frDetails.billTime}
					</p>
				</td>
			</tr>

		</table>

		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			style="border-top: 1px solid #313131; border-right: 1px solid #313131">
			<tr>
				<td rowspan="2" width="2%"
					style="border-bottom: 1px solid #313131; border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px;">No.</td>
				<td align="left" width="36%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 15px; color: #000; font-size: 10px; text-align: left">Item
					Description</td>
				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 0.2px; color: #000; font-size: 10px;">HSN
					Code</td>


				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Qty</td>
				<!-- change	<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">UOM
				</td> -->
				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Rate</td>
				<td align="center" width="5%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">
					Disc %</td>
				<td align="center" width="10%" rowspan="2"
					style="border-bottom: 1px solid #313131; border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px;">Taxable
					Amt</td>

				<td align="center" width="10%" colspan="2"
					style="border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">
					CGST</td>
				<td align="center" width="10%" colspan="2"
					style="border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">SGST</td>
				<td align="center" width="10%" colspan="2"
					style="border-left: 1px solid #313131; padding: 10px; color: #000; font-size: 10px; text-align: center;">Total</td>
			</tr>
			<tr>

				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Rate%
				</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Amount</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Rate%</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">Amount</td>
			</tr>



			<c:set var="totalRowCount" value="0" />

			</c:when>
			</c:choose>
			<c:set var="srCnt" value="${srCnt+1}" />
			<c:set var="totalRowCount" value="${totalRowCount+1}" />
			<tr>
				<td
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;">${srCnt}</td>

				<c:choose>
					<c:when test="${billDetails.grnType==3}">
						<td
							style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;">${billDetails.itemName}
							[NR]</td>

					</c:when>
					<c:when test="${billDetails.grnType==4}">
						<td
							style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;">${billDetails.itemName}
							[R]</td>
					</c:when>
					<c:otherwise>

						<td
							style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;">${billDetails.itemName}</td>

					</c:otherwise>

				</c:choose>

				<td align="left"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;">${billDetails.itemHsncd}</td>
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;">
					<c:choose>
						<c:when test="${billDetails.catId==5}">
									${billDetails.remark} Kg
									<c:set var="spKg" value="${billDetails.remark}" />
							<%
								String spKgStr = (String) pageContext.getAttribute("spKg");
															float spKgFloat = Float.parseFloat(spKgStr.trim());
							%>
							<c:set var="spKgFloat" value="<%=spKgFloat%>" />
							<c:set var="totalSpKgQty" value="${spKgFloat+totalSpKgQty}" />
						</c:when>
						<c:otherwise>
							<fmt:formatNumber type="number" maxFractionDigits="2"
								minFractionDigits="2" value="${billDetails.billQty}" />
							<c:set var="totalQty" value="${totalQty+billDetails.billQty}" />
						</c:otherwise>
					</c:choose>
				</td>

				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 4px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.baseRate}" /></td>
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.discPer}" /></td>
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 4px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.taxableAmt}" /></td>
				<c:set var="totalAmt" value="${totalAmt+billDetails.taxableAmt}" />

				<%-- <td align="right"
									style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"> <fmt:formatNumber
										type="number" maxFractionDigits="2" minFractionDigits="2"
										value="${billDetails.discAmt}" /> </td> --%>
				<c:set var="totalDisc" value="${totalDisc+billDetails.discAmt}" />
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.cgstPer}" /></td>
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.cgstRs}" /></td>
				<c:set var="totalCgst" value="${totalCgst+billDetails.cgstRs}" />
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.sgstPer}" /></td>
				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${billDetails.sgstRs}" /></td>
				<c:set var="totalSgst" value="${totalSgst+billDetails.sgstRs}" />

				<td align="right"
					style="border-left: 1px solid #313131; padding: 3px 5px; color: #000; font-size: 12px;"><fmt:formatNumber
						type="number" maxFractionDigits="2" minFractionDigits="2"
						value="${(billDetails.sgstRs)+(billDetails.cgstRs)+(billDetails.taxableAmt)}" /></td>
				<c:set var="acttotal"
					value="${acttotal+(billDetails.sgstRs)+(billDetails.cgstRs)+(billDetails.taxableAmt)}" />
			</tr>
			</c:when>
			</c:choose>
			</c:forEach>
			</c:forEach>
			<tr>
				<td align="left"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td align="left"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b>Total</b></td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;">SP
					<b>${totalSpKgQty} Kg</b>
				</td>
				<td align="right"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b><fmt:formatNumber
							type="number" maxFractionDigits="2" minFractionDigits="2"
							value="${totalQty}" /></b></td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>

				<td align="right"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b><fmt:formatNumber
							type="number" maxFractionDigits="2" minFractionDigits="2"
							value="${totalAmt}" /></b></td>


				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>

				<td align="right"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b><fmt:formatNumber
							type="number" maxFractionDigits="2" minFractionDigits="2"
							value="${totalCgst}" /></b></td>
				<td align="center"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td align="right"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b><fmt:formatNumber
							type="number" maxFractionDigits="2" minFractionDigits="2"
							value="${totalSgst}" /></b></td>
				<td align="right"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b><fmt:formatNumber
							type="number" maxFractionDigits="2" minFractionDigits="2"
							value="${acttotal}" /></b></td>
			</tr>
			<tr>

				<fmt:formatNumber type="number" minFractionDigits="0"
					groupingUsed="false" maxFractionDigits="0"
					value="${totalAmt+totalCgst+totalSgst}" var="totAmt" />

				<td align="right"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td align="right"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td
					style="border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>

				<td
					style="border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 12px;"><b>&nbsp;Round
						off:</b></td>
				<td align="right"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b>
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" groupingUsed="false"
							value="${totAmt-(totalAmt+totalCgst+totalSgst)}" />

				</b></td>
			</tr>
			<tr>
				<c:set var="finalAmt" value="${totalAmt+totalCgst+totalSgst}"></c:set>
				<%
					double fAmt = 0;// (Double)pageContext.getAttribute("finalAmt");
						fAmt = Math.round(fAmt);
				%>
				<c:set var="finalAmtActual" value="${fAmt}"></c:set>

				<td align="right"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td align="right"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td
					style="border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>

				<td
					style="border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 0px;">-</td>
				<td style="border-bottom: 1px solid #313131; font-size: 12px;"><b>&nbsp;Total:</b></td>
				<td align="right"
					style="border-left: 1px solid #313131; border-bottom: 1px solid #313131; padding: 4px; color: #000; font-size: 12px;"><b>
						<fmt:formatNumber type="number" value="${frDetails.grandTotal}" />
				</b></td>
			</tr>
		</table>

		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			style="border-right: 1px solid #313131; border-top: 1px solid #313131">
			<tr>
				<td align="center" width="9%" colspan="2"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">HSNCD</td>
				<td align="center" width="9%" colspan="1"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">Bill
					Qty</td>

				<td align="center" width="9%" colspan="1"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">Tax(%)</td>
				<td align="center" width="9%" colspan="2"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">Taxable
					Amount</td>

				<td align="center" width="9%" colspan="2"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">CGST
					Amount</td>
				<td align="center" width="9%" colspan="2"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">SGST
					Amount</td>
				<td align="center" width="9%" colspan="2"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">Total
					Tax</td>
				<td align="center" width="9%" colspan="2"
					style="border-left: 1px solid #313131; padding: 2px; color: #000; font-size: 10px; text-align: center;">Total
					Amount</td>

			</tr>
			<c:forEach items="${slabwiseBillList}" var="slabwiseBills"
				varStatus="count">

				<c:choose>
					<c:when test="${slabwiseBills.billNo==frDetails.billNo}">

						<c:forEach items="${slabwiseBills.slabwiseBill}"
							var="slabwiseBill" varStatus="count">
							<tr>
								<td align="right" width="9%" colspan="2"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right">${slabwiseBill.itemHsncd}</td>
								<td align="right" width="9%" colspan="1"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right">${slabwiseBill.billQty}</td>

								<td align="right" width="9%" colspan="1"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right">${slabwiseBill.taxPer}</td>
								<td align="right" width="9%" colspan="2"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right"><fmt:formatNumber
										type="number" maxFractionDigits="2" minFractionDigits="2"
										value="${slabwiseBill.taxableAmt}" /></td>

								<td align="right" width="9%" colspan="2"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right"><fmt:formatNumber
										type="number" maxFractionDigits="2" minFractionDigits="2"
										value="${slabwiseBill.cgstAmt}" /></td>
								<td align="right" width="9%" colspan="2"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right"><fmt:formatNumber
										type="number" maxFractionDigits="2" minFractionDigits="2"
										value="${slabwiseBill.sgstAmt}" /></td>
								<td align="right" width="9%" colspan="2"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right"><fmt:formatNumber
										type="number" maxFractionDigits="2" minFractionDigits="2"
										value="${slabwiseBill.totalTax}" /></td>
								<td align="right" width="9%" colspan="2"
									style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 10px; text-align: right"><fmt:formatNumber
										type="number" maxFractionDigits="2" minFractionDigits="2"
										value="${slabwiseBill.grandTotal}" /></td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
		</table>

		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			style="border-top: 1px solid #313131; border-right: 1px solid #313131;">
			<tr>
				<td colspan="10" width="100%"
					style="border-left: 1px solid #313131; padding: 4px; color: #000; font-size: 10px;">
					<p
						style="color: #000; font-size: 12px; text-align: left; margin: 0px;">FDA
						Declaration:${frDetails.company.fdaDeclaration} FDA Lic. No:
						${frDetails.company.fdaLicenceNo}</p>
				</td>


				<td colspan="11" width="40%" rowspan="2"
					style="color: #000; font-size: 10px;"></td>
			</tr>

			<tr>
				<td colspan="8" width="60%"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 5px; color: #000; font-size: 12px;"><p>
						<b>Invoice Value in Rs.</b> ${frDetails.amtInWords}
					</p> </br> <%-- <p>
						<b>User Id : </b>${user}
					</p> --%></td>
				<td colspan="5" width="40%"
					style="border-top: 1px solid #313131; border-left: 1px solid #313131; padding: 8px; color: #000; font-size: 15px;">

					<table width="100%" border="0" align="left" cellpadding="0"
						cellspacing="0" style="border-right: 0px solid #313131">
						<tr>
							<td align="center" width="9%" colspan="2"
								style="border-top: 0px solid #313131; padding: 2px; color: #000; font-size: 13px; text-align: center;"><b>Grand
									Total: Rs. </b>&nbsp;&nbsp;<b><fmt:formatNumber type="number"
										value="${frDetails.grandTotal}" /></b></td>
						</tr>

					</table>

				</td>
			</tr>
			<tr>
				<td colspan="8" width="50%"
					style="border-bottom: 1px solid #313131; border-top: 1px solid #313131; border-left: 1px solid #313131; padding-top: 4px; color: #000; font-size: 8px;">
					<p
						style="color: #000; font-size: 9px; text-align: left; margin: 0px;">&nbsp;&nbsp;
						Subject to ${Constants.CITY} Jurisdiction
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Receiver's
						Signature</p>
				</td>

				<td align="center" colspan="5" width="38%"
					style="border-bottom: 1px solid #313131; border-top: 1px solid #313131; border-left: 1px solid #313131; padding-top: 4px; color: #000; font-size: 9px;"><p>
						<b>For ${frDetails.company.compName}<br></br> <br></br> <br></br>
							Authorised Signatory
						</b>
					</p></td>
			</tr>

		</table>

		<div style="page-break-after: always;"></div>
	</c:forEach>
	
	<!-- c:forEach for multiple bills -->
</body>
</html>
