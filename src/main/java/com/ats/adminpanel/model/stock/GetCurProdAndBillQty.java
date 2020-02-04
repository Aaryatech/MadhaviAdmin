package com.ats.adminpanel.model.stock;

public class GetCurProdAndBillQty {
	
	
	int id;
	
	String itemName;
	
	float prodQty;
	float rejectedQty;
	float billQty;
	float damagedQty;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	public float getProdQty() {
		return prodQty;
	}
	public void setProdQty(float prodQty) {
		this.prodQty = prodQty;
	}
	public float getRejectedQty() {
		return rejectedQty;
	}
	public void setRejectedQty(float rejectedQty) {
		this.rejectedQty = rejectedQty;
	}
	public float getBillQty() {
		return billQty;
	}
	public void setBillQty(float billQty) {
		this.billQty = billQty;
	}
	public float getDamagedQty() {
		return damagedQty;
	}
	public void setDamagedQty(float damagedQty) {
		this.damagedQty = damagedQty;
	}
	@Override
	public String toString() {
		return "GetCurProdAndBillQty [id=" + id + ", itemName=" + itemName + ", prodQty=" + prodQty + ", rejectedQty="
				+ rejectedQty + ", billQty=" + billQty + ", damagedQty=" + damagedQty + "]";
	}
	
	

}
