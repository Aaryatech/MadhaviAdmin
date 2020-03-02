package com.ats.adminpanel.model;

public class ViewFrStockBackEnd {

	
	int frId;
	
	int itemId;
	
	String itemName;

	float regCurStock;

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
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

	public float getRegCurStock() {
		return regCurStock;
	}

	public void setRegCurStock(float regCurStock) {
		this.regCurStock = regCurStock;
	}

	@Override
	public String toString() {
		return "ViewFrStockBackEnd [frId=" + frId + ", itemId=" + itemId + ", itemName=" + itemName + ", regCurStock="
				+ regCurStock + "]";
	}
	

	

}
