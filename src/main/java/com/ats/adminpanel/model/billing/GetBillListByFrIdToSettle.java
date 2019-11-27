package com.ats.adminpanel.model.billing;

import java.util.Date;

 

 public class GetBillListByFrIdToSettle {

 	private int billHeadId;

	private String billNo;

	private String billDate;

	private int frId;

	private String billAmt;

	private String paidAmt;

	private String pendingAmt;

	private String frName;

	public int getBillHeadId() {
		return billHeadId;
	}

	public void setBillHeadId(int billHeadId) {
		this.billHeadId = billHeadId;
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

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public String getBillAmt() {
		return billAmt;
	}

	public void setBillAmt(String billAmt) {
		this.billAmt = billAmt;
	}

	public String getPaidAmt() {
		return paidAmt;
	}

	public void setPaidAmt(String paidAmt) {
		this.paidAmt = paidAmt;
	}

	public String getPendingAmt() {
		return pendingAmt;
	}

	public void setPendingAmt(String pendingAmt) {
		this.pendingAmt = pendingAmt;
	}

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	@Override
	public String toString() {
		return "GetBillListByFrIdToSettle [billHeadId=" + billHeadId + ", billNo=" + billNo + ", billDate=" + billDate
				+ ", frId=" + frId + ", billAmt=" + billAmt + ", paidAmt=" + paidAmt + ", pendingAmt=" + pendingAmt
				+ ", frName=" + frName + "]";
	}

}
