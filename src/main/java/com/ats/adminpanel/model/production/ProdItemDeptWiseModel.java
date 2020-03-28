package com.ats.adminpanel.model.production;

public class ProdItemDeptWiseModel {

	private String id;
	private int productionDetailId;
	private String productionDate;
	private int itemId;
	private String itemName;
	private int deptId;
	private String deptName;
	private String catName;
	private float planQty;
	private float orderQty;
	private float productionQty;
	private float openingQty;
	private float qty;
	
	

	public String getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(String productionDate) {
		this.productionDate = productionDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public float getQty() {
		return qty;
	}

	public void setQty(float qty) {
		this.qty = qty;
	}

	public int getProductionDetailId() {
		return productionDetailId;
	}

	public void setProductionDetailId(int productionDetailId) {
		this.productionDetailId = productionDetailId;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
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

	
	@Override
	public String toString() {
		return "ProdItemDeptWiseModel [id=" + id + ", productionDetailId=" + productionDetailId + ", productionDate="
				+ productionDate + ", itemId=" + itemId + ", itemName=" + itemName + ", deptId=" + deptId
				+ ", deptName=" + deptName + ", catName=" + catName + ", planQty=" + planQty + ", orderQty=" + orderQty
				+ ", productionQty=" + productionQty + ", openingQty=" + openingQty + ", qty=" + qty + "]";
	}

}
