package com.ats.adminpanel.model.billing;

public class BillReceiptDetail {

	private int billReceiptDetailId;

	private int billReceiptId;

	private int billNo;
	private String invoiceNo;
	private float billAmt;
	private float paidAmt;

	private int exInt1;
	private int exInt2;
	private String exVar1;
	private String exVar2;
	private float exFloat1;
	private float exFloat2;
	
	

	public BillReceiptDetail(int billReceiptDetailId, int billReceiptId, int billNo, String invoiceNo, float billAmt,
			float paidAmt, int exInt1, int exInt2, String exVar1, String exVar2, float exFloat1, float exFloat2) {
		super();
		this.billReceiptDetailId = billReceiptDetailId;
		this.billReceiptId = billReceiptId;
		this.billNo = billNo;
		this.invoiceNo = invoiceNo;
		this.billAmt = billAmt;
		this.paidAmt = paidAmt;
		this.exInt1 = exInt1;
		this.exInt2 = exInt2;
		this.exVar1 = exVar1;
		this.exVar2 = exVar2;
		this.exFloat1 = exFloat1;
		this.exFloat2 = exFloat2;
	}

	public BillReceiptDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getBillReceiptDetailId() {
		return billReceiptDetailId;
	}

	public void setBillReceiptDetailId(int billReceiptDetailId) {
		this.billReceiptDetailId = billReceiptDetailId;
	}

	public int getBillReceiptId() {
		return billReceiptId;
	}

	public void setBillReceiptId(int billReceiptId) {
		this.billReceiptId = billReceiptId;
	}

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

	public float getBillAmt() {
		return billAmt;
	}

	public void setBillAmt(float billAmt) {
		this.billAmt = billAmt;
	}

	public float getPaidAmt() {
		return paidAmt;
	}

	public void setPaidAmt(float paidAmt) {
		this.paidAmt = paidAmt;
	}

	public int getExInt1() {
		return exInt1;
	}

	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}

	public int getExInt2() {
		return exInt2;
	}

	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}

	public String getExVar1() {
		return exVar1;
	}

	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}

	public String getExVar2() {
		return exVar2;
	}

	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}

	public float getExFloat1() {
		return exFloat1;
	}

	public void setExFloat1(float exFloat1) {
		this.exFloat1 = exFloat1;
	}

	public float getExFloat2() {
		return exFloat2;
	}

	public void setExFloat2(float exFloat2) {
		this.exFloat2 = exFloat2;
	}

	@Override
	public String toString() {
		return "BillReceiptDetail [billReceiptDetailId=" + billReceiptDetailId + ", billReceiptId=" + billReceiptId
				+ ", billNo=" + billNo + ", invoiceNo=" + invoiceNo + ", billAmt=" + billAmt + ", paidAmt=" + paidAmt
				+ ", exInt1=" + exInt1 + ", exInt2=" + exInt2 + ", exVar1=" + exVar1 + ", exVar2=" + exVar2
				+ ", exFloat1=" + exFloat1 + ", exFloat2=" + exFloat2 + "]";
	}

}
