package com.ats.adminpanel.model.storetally;

public class BillInfo {

	private int billDetailId;
	private int billId;
	private String vendor;
	private int vendorCreditDays;
	private String billBookNo;
	private String date;
	private String billNo;
	private String billDate;
	private String productName;
	private String uom;
	private String rate;
	private String qty;
	private String rateTotal;
	private String cgst;
	private String sgst;
	private String igst;
	private String otherCharges;
	private String discValue;
	private String totalAmount;

	public int getBillDetailId() {
		return billDetailId;
	}

	public void setBillDetailId(int billDetailId) {
		this.billDetailId = billDetailId;
	}

	public int getBillId() {
		return billId;
	}

	public void setBillId(int billId) {
		this.billId = billId;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

	public int getVendorCreditDays() {
		return vendorCreditDays;
	}

	public void setVendorCreditDays(int vendorCreditDays) {
		this.vendorCreditDays = vendorCreditDays;
	}

	public String getBillBookNo() {
		return billBookNo;
	}

	public void setBillBookNo(String billBookNo) {
		this.billBookNo = billBookNo;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getUom() {
		return uom;
	}

	public void setUom(String uom) {
		this.uom = uom;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getRateTotal() {
		return rateTotal;
	}

	public void setRateTotal(String rateTotal) {
		this.rateTotal = rateTotal;
	}

	public String getCgst() {
		return cgst;
	}

	public void setCgst(String cgst) {
		this.cgst = cgst;
	}

	public String getSgst() {
		return sgst;
	}

	public void setSgst(String sgst) {
		this.sgst = sgst;
	}

	public String getIgst() {
		return igst;
	}

	public void setIgst(String igst) {
		this.igst = igst;
	}

	public String getOtherCharges() {
		return otherCharges;
	}

	public void setOtherCharges(String otherCharges) {
		this.otherCharges = otherCharges;
	}

	public String getDiscValue() {
		return discValue;
	}

	public void setDiscValue(String discValue) {
		this.discValue = discValue;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	@Override
	public String toString() {
		return "BillInfo [billDetailId=" + billDetailId + ", billId=" + billId + ", vendor=" + vendor
				+ ", vendorCreditDays=" + vendorCreditDays + ", billBookNo=" + billBookNo + ", date=" + date
				+ ", billNo=" + billNo + ", billDate=" + billDate + ", productName=" + productName + ", uom=" + uom
				+ ", rate=" + rate + ", qty=" + qty + ", rateTotal=" + rateTotal + ", cgst=" + cgst + ", sgst=" + sgst
				+ ", igst=" + igst + ", otherCharges=" + otherCharges + ", discValue=" + discValue + ", totalAmount="
				+ totalAmount + "]";
	}
	
}
