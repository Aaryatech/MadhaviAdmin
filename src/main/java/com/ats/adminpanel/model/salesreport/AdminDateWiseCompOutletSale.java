package com.ats.adminpanel.model.salesreport;

public class AdminDateWiseCompOutletSale {

	private String id;
	private String billDate;
	private int frId;
	private String frName;
	private float billTotal;
	private float discTotal;
	private float trTotal;
	private float advTotal;
	private float expTotal;
	private float creditTotal;
	private float withdrawlTotal;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	public float getBillTotal() {
		return billTotal;
	}

	public void setBillTotal(float billTotal) {
		this.billTotal = billTotal;
	}

	public float getDiscTotal() {
		return discTotal;
	}

	public void setDiscTotal(float discTotal) {
		this.discTotal = discTotal;
	}

	public float getTrTotal() {
		return trTotal;
	}

	public void setTrTotal(float trTotal) {
		this.trTotal = trTotal;
	}

	public float getAdvTotal() {
		return advTotal;
	}

	public void setAdvTotal(float advTotal) {
		this.advTotal = advTotal;
	}

	public float getExpTotal() {
		return expTotal;
	}

	public void setExpTotal(float expTotal) {
		this.expTotal = expTotal;
	}

	public float getCreditTotal() {
		return creditTotal;
	}

	public void setCreditTotal(float creditTotal) {
		this.creditTotal = creditTotal;
	}

	public float getWithdrawlTotal() {
		return withdrawlTotal;
	}

	public void setWithdrawlTotal(float withdrawlTotal) {
		this.withdrawlTotal = withdrawlTotal;
	}

	@Override
	public String toString() {
		return "AdminDateWiseCompOutletSale [id=" + id + ", billDate=" + billDate + ", frId=" + frId + ", frName="
				+ frName + ", billTotal=" + billTotal + ", discTotal=" + discTotal + ", trTotal=" + trTotal
				+ ", advTotal=" + advTotal + ", expTotal=" + expTotal + ", creditTotal=" + creditTotal
				+ ", withdrawlTotal=" + withdrawlTotal + "]";
	}
	
}
