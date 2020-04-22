package com.ats.adminpanel.model;

public class BillReceiptHeaderDisplay {

	private int billReceiptId;

	private String receiptNo;

	private String receiptDate;

	private int frId;
	private String frName;

	private int expId;
	private String remark;
	private float expAmt;
	private String expDate;
	private String chalanNo;

	public int getBillReceiptId() {
		return billReceiptId;
	}

	public void setBillReceiptId(int billReceiptId) {
		this.billReceiptId = billReceiptId;
	}

	public String getReceiptNo() {
		return receiptNo;
	}

	public void setReceiptNo(String receiptNo) {
		this.receiptNo = receiptNo;
	}

	public String getReceiptDate() {
		return receiptDate;
	}

	public void setReceiptDate(String receiptDate) {
		this.receiptDate = receiptDate;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	public int getExpId() {
		return expId;
	}

	public void setExpId(int expId) {
		this.expId = expId;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public float getExpAmt() {
		return expAmt;
	}

	public void setExpAmt(float expAmt) {
		this.expAmt = expAmt;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getChalanNo() {
		return chalanNo;
	}

	public void setChalanNo(String chalanNo) {
		this.chalanNo = chalanNo;
	}

	@Override
	public String toString() {
		return "BillReceiptHeaderDisplay [billReceiptId=" + billReceiptId + ", receiptNo=" + receiptNo
				+ ", receiptDate=" + receiptDate + ", frId=" + frId + ", frName=" + frName + ", expId=" + expId
				+ ", remark=" + remark + ", expAmt=" + expAmt + ", expDate=" + expDate + ", chalanNo=" + chalanNo + "]";
	}
	
}
