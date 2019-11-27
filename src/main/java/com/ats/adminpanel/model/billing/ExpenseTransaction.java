package com.ats.adminpanel.model.billing;

  
public class ExpenseTransaction {
  
	private int expTransId;
	
	private int billHeadId;
	
	private int  frId ;
	
	private int expId;
 	
	private String billAmt; 
	
	
	private String paidAmt; 
	
	private String  billNo; 
	
	private int  billClose ;
  	
	private String delivarableDate ;  	
 	
	private int exInt1 ;
 	
	private int exInt2;
 	
	private int exInt3;
 	
	private int exInt4 ;
 	
	private String  exVar1 ;
 	
	private String  exVar2;
 	
	private String  exVar3;
 	
	private String  exVar4 ;

	public int getExpTransId() {
		return expTransId;
	}

	public void setExpTransId(int expTransId) {
		this.expTransId = expTransId;
	}

	public int getBillHeadId() {
		return billHeadId;
	}

	public void setBillHeadId(int billHeadId) {
		this.billHeadId = billHeadId;
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

	public String getBillAmt() {
		return billAmt;
	}

	public void setBillAmt(String billAmt) {
		this.billAmt = billAmt;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public int getBillClose() {
		return billClose;
	}

	public void setBillClose(int billClose) {
		this.billClose = billClose;
	}

	public String getDelivarableDate() {
		return delivarableDate;
	}

	public void setDelivarableDate(String delivarableDate) {
		this.delivarableDate = delivarableDate;
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
	
	

	public String getPaidAmt() {
		return paidAmt;
	}

	public void setPaidAmt(String paidAmt) {
		this.paidAmt = paidAmt;
	}

	@Override
	public String toString() {
		return "ExpenseTransaction [expTransId=" + expTransId + ", billHeadId=" + billHeadId + ", frId=" + frId
				+ ", expId=" + expId + ", billAmt=" + billAmt + ", paidAmt=" + paidAmt + ", billNo=" + billNo
				+ ", billClose=" + billClose + ", delivarableDate=" + delivarableDate + ", exInt1=" + exInt1
				+ ", exInt2=" + exInt2 + ", exInt3=" + exInt3 + ", exInt4=" + exInt4 + ", exVar1=" + exVar1
				+ ", exVar2=" + exVar2 + ", exVar3=" + exVar3 + ", exVar4=" + exVar4 + "]";
	}

	 
	
}
