package com.ats.adminpanel.model.franchisee;

import java.util.List;

public class AdvanceOrderHeader {

	private int advHeaderId;

	private float advanceAmt;

	private float remainingAmt;

	private float total;

	private int custId;

	private int isDailyMart;

	private int delStatus;

	private int exInt1;

	private int exInt2;

	private String exVar1;

	private String exVar2;

	private float exFloat1;

	private float exFloat2;

	private int frId;

	private float discAmt;

	private String orderDate;

	private String prodDate;

	private String deliveryDate;

	List<AdvanceOrderDetail> detailList;
	
	
	private int isBillGenerated;
	
	private int isSellBillGenerated;

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public float getDiscAmt() {
		return discAmt;
	}

	public void setDiscAmt(float discAmt) {
		this.discAmt = discAmt;
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

	public List<AdvanceOrderDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<AdvanceOrderDetail> detailList) {
		this.detailList = detailList;
	}

	
	
	public int getIsBillGenerated() {
		return isBillGenerated;
	}

	public void setIsBillGenerated(int isBillGenerated) {
		this.isBillGenerated = isBillGenerated;
	}

	public int getIsSellBillGenerated() {
		return isSellBillGenerated;
	}

	public void setIsSellBillGenerated(int isSellBillGenerated) {
		this.isSellBillGenerated = isSellBillGenerated;
	}

	@Override
	public String toString() {
		return "AdvanceOrderHeader [advHeaderId=" + advHeaderId + ", advanceAmt=" + advanceAmt + ", remainingAmt="
				+ remainingAmt + ", total=" + total + ", custId=" + custId + ", isDailyMart=" + isDailyMart
				+ ", delStatus=" + delStatus + ", exInt1=" + exInt1 + ", exInt2=" + exInt2 + ", exVar1=" + exVar1
				+ ", exVar2=" + exVar2 + ", exFloat1=" + exFloat1 + ", exFloat2=" + exFloat2 + ", frId=" + frId
				+ ", discAmt=" + discAmt + ", orderDate=" + orderDate + ", prodDate=" + prodDate + ", deliveryDate="
				+ deliveryDate + ", detailList=" + detailList + ", isBillGenerated=" + isBillGenerated
				+ ", isSellBillGenerated=" + isSellBillGenerated + "]";
	}

	 

}
