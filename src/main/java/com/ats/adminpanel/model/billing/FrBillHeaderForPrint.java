package com.ats.adminpanel.model.billing;


public class FrBillHeaderForPrint {

	private Integer billNo;
	private String frName;
	private Integer taxApplicable;
	private String invoiceNo;
	private String billDate;
	private Integer frId;
	private String frCode;
	private float grandTotal;
	private float taxableAmt;
	private float totalTax;
	private Integer status;
	private String remark;
	private Integer delStatus;
	private int isSameState;
	private String frAddress;
	private String partyName;//new -08 feb 19
	private String partyGstin;//new -08 feb 19
	private String partyAddress;//new -08 feb 19
	
	private String vehNo;//new -02 july 19
	private String billTime;//new -02 july 19
	private String exVarchar1;//new -02 july 19
	private String exVarchar2;//new -02 july 19
	
	private String exVarchar3;
	private String exVarchar4;
	private String exVarchar5;
	
private String ewayBillNo;//Sachin 12-Dec-2019

private int isDairyMart;


	
	
	public String getExVarchar3() {
	return exVarchar3;
}

public void setExVarchar3(String exVarchar3) {
	this.exVarchar3 = exVarchar3;
}

public String getExVarchar4() {
	return exVarchar4;
}

public void setExVarchar4(String exVarchar4) {
	this.exVarchar4 = exVarchar4;
}

public String getExVarchar5() {
	return exVarchar5;
}

public void setExVarchar5(String exVarchar5) {
	this.exVarchar5 = exVarchar5;
}

	public int getIsDairyMart() {
	return isDairyMart;
}

public void setIsDairyMart(int isDairyMart) {
	this.isDairyMart = isDairyMart;
}

	public String getEwayBillNo() {
		return ewayBillNo;
	}

	public void setEwayBillNo(String ewayBillNo) {
		this.ewayBillNo = ewayBillNo;
	}
	
	Company company;
	
	
	
	public String getVehNo() {
		return vehNo;
	}

	public void setVehNo(String vehNo) {
		this.vehNo = vehNo;
	}

	public String getBillTime() {
		return billTime;
	}

	public void setBillTime(String billTime) {
		this.billTime = billTime;
	}

	public String getExVarchar1() {
		return exVarchar1;
	}

	public void setExVarchar1(String exVarchar1) {
		this.exVarchar1 = exVarchar1;
	}

	public String getExVarchar2() {
		return exVarchar2;
	}

	public void setExVarchar2(String exVarchar2) {
		this.exVarchar2 = exVarchar2;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getPartyGstin() {
		return partyGstin;
	}

	public void setPartyGstin(String partyGstin) {
		this.partyGstin = partyGstin;
	}

	public String getPartyAddress() {
		return partyAddress;
	}

	public void setPartyAddress(String partyAddress) {
		this.partyAddress = partyAddress;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Integer getBillNo() {
		return billNo;
	}

	public void setBillNo(Integer billNo) {
		this.billNo = billNo;
	}

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	public Integer getTaxApplicable() {
		return taxApplicable;
	}

	public void setTaxApplicable(Integer taxApplicable) {
		this.taxApplicable = taxApplicable;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	 

	public Integer getFrId() {
		return frId;
	}

	public void setFrId(Integer frId) {
		this.frId = frId;
	}

	public String getFrCode() {
		return frCode;
	}

	public void setFrCode(String frCode) {
		this.frCode = frCode;
	}

	public float getGrandTotal() {
		return grandTotal;
	}

	public void setGrandTotal(float grandTotal) {
		this.grandTotal = grandTotal;
	}

	public float getTaxableAmt() {
		return taxableAmt;
	}

	public void setTaxableAmt(float taxableAmt) {
		this.taxableAmt = taxableAmt;
	}

	public float getTotalTax() {
		return totalTax;
	}

	public void setTotalTax(float totalTax) {
		this.totalTax = totalTax;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(Integer delStatus) {
		this.delStatus = delStatus;
	}

	public String getFrAddress() {
		return frAddress;
	}

	public void setFrAddress(String frAddress) {
		this.frAddress = frAddress;
	}

	public int getIsSameState() {
		return isSameState;
	}

	public void setIsSameState(int isSameState) {
		this.isSameState = isSameState;
	}

	
	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	
	@Override
	public String toString() {
		return "FrBillHeaderForPrint [billNo=" + billNo + ", frName=" + frName + ", taxApplicable=" + taxApplicable
				+ ", invoiceNo=" + invoiceNo + ", billDate=" + billDate + ", frId=" + frId + ", frCode=" + frCode
				+ ", grandTotal=" + grandTotal + ", taxableAmt=" + taxableAmt + ", totalTax=" + totalTax + ", status="
				+ status + ", remark=" + remark + ", delStatus=" + delStatus + ", isSameState=" + isSameState
				+ ", frAddress=" + frAddress + ", partyName=" + partyName + ", partyGstin=" + partyGstin
				+ ", partyAddress=" + partyAddress + ", vehNo=" + vehNo + ", billTime=" + billTime + ", exVarchar1="
				+ exVarchar1 + ", exVarchar2=" + exVarchar2 + ", exVarchar3=" + exVarchar3 + ", exVarchar4="
				+ exVarchar4 + ", exVarchar5=" + exVarchar5 + ", ewayBillNo=" + ewayBillNo + ", isDairyMart="
				+ isDairyMart + ", company=" + company + "]";
	}
    
}
