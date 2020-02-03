package com.ats.adminpanel.model.production;



public class PostProductionDetail {
	

	private int productionDetailId;
	
	private int productionHeaderId;

	private float productionQty;
	
	private int itemId;
	
	private float openingQty;
	
	private float rejectedQty;

	private float planQty;
	
	private float orderQty;
	
	private String productionBatch;
	
	private String productionDate;

	public int getProductionDetailId() {
		return productionDetailId;
	}

	public void setProductionDetailId(int productionDetailId) {
		this.productionDetailId = productionDetailId;
	}

	public int getProductionHeaderId() {
		return productionHeaderId;
	}

	public void setProductionHeaderId(int productionHeaderId) {
		this.productionHeaderId = productionHeaderId;
	}

	

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	

	public float getProductionQty() {
		return productionQty;
	}

	public void setProductionQty(float productionQty) {
		this.productionQty = productionQty;
	}

	public float getOpeningQty() {
		return openingQty;
	}

	public void setOpeningQty(float openingQty) {
		this.openingQty = openingQty;
	}

	public float getRejectedQty() {
		return rejectedQty;
	}

	public void setRejectedQty(float rejectedQty) {
		this.rejectedQty = rejectedQty;
	}

	public float getPlanQty() {
		return planQty;
	}

	public void setPlanQty(float planQty) {
		this.planQty = planQty;
	}

	public float getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(float orderQty) {
		this.orderQty = orderQty;
	}

	public String getProductionBatch() {
		return productionBatch;
	}

	public void setProductionBatch(String productionBatch) {
		this.productionBatch = productionBatch;
	}

	public String getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(String productionDate) {
		this.productionDate = productionDate;
	}

	@Override
	public String toString() {
		return "PostProductionDetail [productionDetailId=" + productionDetailId + ", productionHeaderId="
				+ productionHeaderId + ", productionQty=" + productionQty + ", itemId=" + itemId + ", openingQty="
				+ openingQty + ", rejectedQty=" + rejectedQty + ", planQty=" + planQty + ", orderQty=" + orderQty
				+ ", productionBatch=" + productionBatch + ", productionDate=" + productionDate + "]";
	}

	 
	
	
}
