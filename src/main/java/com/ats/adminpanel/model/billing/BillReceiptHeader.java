package com.ats.adminpanel.model.billing;

import java.util.List;

public class BillReceiptHeader {

	private int billReceiptId;

	private String receiptNo;
	private String receiptDate;
	private int frId;
	private int expId;
	private float expAmt;

	private int exInt1;
	private int exInt2;
	private String exVar1;
	private String exVar2;
	private float exFloat1;
	private float exFloat2;
	
	

	List<BillReceiptDetail> billReceiptDetailList;
	
	

	public BillReceiptHeader(int billReceiptId, String receiptNo, String receiptDate, int frId, int expId, float expAmt,
			int exInt1, int exInt2, String exVar1, String exVar2, float exFloat1, float exFloat2,
			List<BillReceiptDetail> billReceiptDetailList) {
		super();
		this.billReceiptId = billReceiptId;
		this.receiptNo = receiptNo;
		this.receiptDate = receiptDate;
		this.frId = frId;
		this.expId = expId;
		this.expAmt = expAmt;
		this.exInt1 = exInt1;
		this.exInt2 = exInt2;
		this.exVar1 = exVar1;
		this.exVar2 = exVar2;
		this.exFloat1 = exFloat1;
		this.exFloat2 = exFloat2;
		this.billReceiptDetailList = billReceiptDetailList;
	}

	public BillReceiptHeader() {
		super();
		// TODO Auto-generated constructor stub
	}

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

	public int getExpId() {
		return expId;
	}

	public void setExpId(int expId) {
		this.expId = expId;
	}

	public float getExpAmt() {
		return expAmt;
	}

	public void setExpAmt(float expAmt) {
		this.expAmt = expAmt;
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

	public List<BillReceiptDetail> getBillReceiptDetailList() {
		return billReceiptDetailList;
	}

	public void setBillReceiptDetailList(List<BillReceiptDetail> billReceiptDetailList) {
		this.billReceiptDetailList = billReceiptDetailList;
	}

	@Override
	public String toString() {
		return "BillReceiptHeader [billReceiptId=" + billReceiptId + ", receiptNo=" + receiptNo + ", receiptDate="
				+ receiptDate + ", frId=" + frId + ", expId=" + expId + ", expAmt=" + expAmt + ", exInt1=" + exInt1
				+ ", exInt2=" + exInt2 + ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + ", exFloat1=" + exFloat1
				+ ", exFloat2=" + exFloat2 + ", billReceiptDetailList=" + billReceiptDetailList + "]";
	}

}
