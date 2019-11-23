package com.ats.adminpanel.model.ewaybill;

import java.util.ArrayList;
import java.util.List;

public class BillHeadEwayBill {
	
	
	private int billNo;
	
	private String invoiceNo;
	
	private String billDate;
	private int frId;
	
	private String frCode;
	
	private double taxableAmt;
	private double grandTotal;
	
	private double sgstSum;
	private double cgstSum;
	private double igstSum;
	
	ArrayList<EwayItemList> itemList;
			
	public int getBillNo() {
		return billNo;
	}
	public void setBillNo(int billNo) {
		this.billNo = billNo;
	}
	public String getInvoiceNo() {
		return invoiceNo;
	}
	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}
	public String getBillDate() {
		return billDate;
	}
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	public int getFrId() {
		return frId;
	}
	public void setFrId(int frId) {
		this.frId = frId;
	}
	public String getFrCode() {
		return frCode;
	}
	public void setFrCode(String frCode) {
		this.frCode = frCode;
	}
	public double getTaxableAmt() {
		return taxableAmt;
	}
	public void setTaxableAmt(double taxableAmt) {
		this.taxableAmt = taxableAmt;
	}
	public double getGrandTotal() {
		return grandTotal;
	}
	public void setGrandTotal(double grandTotal) {
		this.grandTotal = grandTotal;
	}
	public double getSgstSum() {
		return sgstSum;
	}
	public void setSgstSum(double sgstSum) {
		this.sgstSum = sgstSum;
	}
	public double getCgstSum() {
		return cgstSum;
	}
	public void setCgstSum(double cgstSum) {
		this.cgstSum = cgstSum;
	}
	public double getIgstSum() {
		return igstSum;
	}
	public void setIgstSum(double igstSum) {
		this.igstSum = igstSum;
	}
	
	public ArrayList<EwayItemList> getItemList() {
		return itemList;
	}
	public void setItemList(ArrayList<EwayItemList> itemList) {
		this.itemList = itemList;
	}
	
	@Override
	public String toString() {
		return "BillHeadEwayBill [billNo=" + billNo + ", invoiceNo=" + invoiceNo + ", billDate=" + billDate + ", frId="
				+ frId + ", frCode=" + frCode + ", taxableAmt=" + taxableAmt + ", grandTotal=" + grandTotal
				+ ", sgstSum=" + sgstSum + ", cgstSum=" + cgstSum + ", igstSum=" + igstSum + ", itemList=" + itemList
				+ "]";
	}
	
	
	
	/*
	 * SELECT
	 * t_bill_header.bill_no,t_bill_header.invoice_no,t_bill_header.bill_date,
	 * t_bill_header.fr_id,t_bill_header.fr_code,t_bill_header.taxable_amt,
	 * t_bill_header.grand_total,
	 * t_bill_header.sgst_sum,t_bill_header.cgst_sum,t_bill_header.igst_sum FROM
	 * t_bill_header WHERE t_bill_header.bill_no IN(1)
	 */

}
