package com.ats.adminpanel.model.production;

import java.sql.Date;

public class GetOrderItemQty {

	int orderId;
	private float qty;
	private float advQty;
	private String itemId;
	private int menuId;
	private Date productionDate;
	private int itemGrp1;
	private String itemName;
	private float curClosingQty;// new Field Added Sachin
	private float curOpeQty;// new fiedl
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public float getQty() {
		return qty;
	}
	public void setQty(float qty) {
		this.qty = qty;
	}
	public float getAdvQty() {
		return advQty;
	}
	public void setAdvQty(float advQty) {
		this.advQty = advQty;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public Date getProductionDate() {
		return productionDate;
	}
	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
	}
	public int getItemGrp1() {
		return itemGrp1;
	}
	public void setItemGrp1(int itemGrp1) {
		this.itemGrp1 = itemGrp1;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
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
		return "GetOrderItemQty [orderId=" + orderId + ", qty=" + qty + ", advQty=" + advQty + ", itemId=" + itemId
				+ ", menuId=" + menuId + ", productionDate=" + productionDate + ", itemGrp1=" + itemGrp1 + ", itemName="
				+ itemName + ", curClosingQty=" + curClosingQty + ", curOpeQty=" + curOpeQty + "]";
	}

	
}
