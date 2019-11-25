package com.ats.adminpanel.model.billing;

  
public class BillTransaction {
 	 
 	private int billTransId;
 	
	private int billHeadId;
	
 	private String  billNo; 
	
	private String billAmt;
  	
	private String paidAmt;
 	
	private String pendingAmt ;
 	
 	private int  isClosed;
 	
 	private int  frId;
 	
	private int exInt1 ;
 	
	private int exInt2;
 	
	private int exInt3;
 	
	private int exInt4 ;
 	
	private String  exVar1 ;
 	
	private String  exVar2;
 	
	private String  exVar3;
 	
	private String  exVar4 ;
	
	
	private int  delStatus;
 	
	private String  billDate ;


	public int getBillTransId() {
		return billTransId;
	}

	public void setBillTransId(int billTransId) {
		this.billTransId = billTransId;
	}

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

	public int getIsClosed() {
		return isClosed;
	}

	public void setIsClosed(int isClosed) {
		this.isClosed = isClosed;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
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

	public int getExInt3() {
		return exInt3;
	}

	public void setExInt3(int exInt3) {
		this.exInt3 = exInt3;
	}

	public int getExInt4() {
		return exInt4;
	}

	public void setExInt4(int exInt4) {
		this.exInt4 = exInt4;
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

	public String getExVar3() {
		return exVar3;
	}

	public void setExVar3(String exVar3) {
		this.exVar3 = exVar3;
	}

	public String getExVar4() {
		return exVar4;
	}

	public void setExVar4(String exVar4) {
		this.exVar4 = exVar4;
	}

	
	
	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	@Override
	public String toString() {
		return "BillTransaction [billTransId=" + billTransId + ", billHeadId=" + billHeadId + ", billNo=" + billNo
				+ ", billAmt=" + billAmt + ", paidAmt=" + paidAmt + ", pendingAmt=" + pendingAmt + ", isClosed="
				+ isClosed + ", frId=" + frId + ", exInt1=" + exInt1 + ", exInt2=" + exInt2 + ", exInt3=" + exInt3
				+ ", exInt4=" + exInt4 + ", exVar1=" + exVar1 + ", exVar2=" + exVar2 + ", exVar3=" + exVar3
				+ ", exVar4=" + exVar4 + ", delStatus=" + delStatus + ", billDate=" + billDate + "]";
	}

	

}
