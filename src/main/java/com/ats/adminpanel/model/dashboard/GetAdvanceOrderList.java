package com.ats.adminpanel.model.dashboard;
 
 
public class GetAdvanceOrderList {
	 
	private int advHeaderId;

	private float advanceAmt;

	private float remainingAmt;

	private int frId;

	private float total;

	private int custId;

	private int isDailyMart;

	private int delStatus;

	private String exVar1;

	private String orderDate;

	private String prodDate;

	private String deliveryDate;

	private float discAmt;

	private String frName;

	private String custName;
	private String phoneNumber;
	
	private String exVar2;//Sac
	private int isBillGenerated;//Sac
	
	
	
	public String getExVar2() {
		return exVar2;
	}
	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}
	public int getIsBillGenerated() {
		return isBillGenerated;
	}
	public void setIsBillGenerated(int isBillGenerated) {
		this.isBillGenerated = isBillGenerated;
	}
	public int getAdvHeaderId() {
		return advHeaderId;
	}
	public void setAdvHeaderId(int advHeaderId) {
		this.advHeaderId = advHeaderId;
	}
	public float getAdvanceAmt() {
		return advanceAmt;
	}
	public void setAdvanceAmt(float advanceAmt) {
		this.advanceAmt = advanceAmt;
	}
	public float getRemainingAmt() {
		return remainingAmt;
	}
	public void setRemainingAmt(float remainingAmt) {
		this.remainingAmt = remainingAmt;
	}
	public int getFrId() {
		return frId;
	}
	public void setFrId(int frId) {
		this.frId = frId;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public int getIsDailyMart() {
		return isDailyMart;
	}
	public void setIsDailyMart(int isDailyMart) {
		this.isDailyMart = isDailyMart;
	}
	public int getDelStatus() {
		return delStatus;
	}
	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}
	public String getExVar1() {
		return exVar1;
	}
	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getProdDate() {
		return prodDate;
	}
	public void setProdDate(String prodDate) {
		this.prodDate = prodDate;
	}
	public String getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	public float getDiscAmt() {
		return discAmt;
	}
	public void setDiscAmt(float discAmt) {
		this.discAmt = discAmt;
	}
	public String getFrName() {
		return frName;
	}
	public void setFrName(String frName) {
		this.frName = frName;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	@Override
	public String toString() {
		return "GetAdvanceOrderList [advHeaderId=" + advHeaderId + ", advanceAmt=" + advanceAmt + ", remainingAmt="
				+ remainingAmt + ", frId=" + frId + ", total=" + total + ", custId=" + custId + ", isDailyMart="
				+ isDailyMart + ", delStatus=" + delStatus + ", exVar1=" + exVar1 + ", orderDate=" + orderDate
				+ ", prodDate=" + prodDate + ", deliveryDate=" + deliveryDate + ", discAmt=" + discAmt + ", frName="
				+ frName + ", custName=" + custName + ", phoneNumber=" + phoneNumber + ", exVar2=" + exVar2
				+ ", isBillGenerated=" + isBillGenerated + "]";
	}
 
}
