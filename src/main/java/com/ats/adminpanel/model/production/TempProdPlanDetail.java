package com.ats.adminpanel.model.production;

public class TempProdPlanDetail {
	
	
private int productionDetailId;
	
	private int productionHeaderId;

	private float planQty;
	
	private float orderQty;
	
	private float openingQty;
	
	private float rejectedQty;
	
	private float productionQty;
	 
	private int itemId;

	private String productionBatch;
	
	private String productionDate;
	
	private int int4;
	
	
	private float  curClosingQty;//new Field Added Sachin
	
	
	 private float curOpeQty;//new fiedl


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


	public float getProductionQty() {
		return productionQty;
	}


	public void setProductionQty(float productionQty) {
		this.productionQty = productionQty;
	}


	public int getItemId() {
		return itemId;
	}


	public void setItemId(int itemId) {
		this.itemId = itemId;
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


	public int getInt4() {
		return int4;
	}


	public void setInt4(int int4) {
		this.int4 = int4;
	}


	public float getCurClosingQty() {
		return curClosingQty;
	}


	public void setCurClosingQty(float curClosingQty) {
		this.curClosingQty = curClosingQty;
	}


	public float getCurOpeQty() {
		return curOpeQty;
	}


	public void setCurOpeQty(float curOpeQty) {
		this.curOpeQty = curOpeQty;
	}


	@Override
	public String toString() {
		return "TempProdPlanDetail [productionDetailId=" + productionDetailId + ", productionHeaderId="
				+ productionHeaderId + ", planQty=" + planQty + ", orderQty=" + orderQty + ", openingQty=" + openingQty
				+ ", rejectedQty=" + rejectedQty + ", productionQty=" + productionQty + ", itemId=" + itemId
				+ ", productionBatch=" + productionBatch + ", productionDate=" + productionDate + ", int4=" + int4
				+ ", curClosingQty=" + curClosingQty + ", curOpeQty=" + curOpeQty + "]";
	}
	 
	 

}
