package com.ats.adminpanel.model.production;

import java.io.Serializable;
import java.sql.Date;

public class GetOrderItemQty {

	int orderId;

	private float qty;
	private float advQty;

	private String itemId;

	private int menuId;

	private int itemGrp1;

	private Date productionDate;

	private String itemName;

	private float curClosingQty;// new Field Added Sachin

	private float curOpeQty;// new fiedl

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getItemGrp1() {
		return itemGrp1;
	}

	public void setItemGrp1(int itemGrp1) {
		this.itemGrp1 = itemGrp1;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public Date getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
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

	@Override
	public String toString() {
		return "GetOrderItemQty [orderId=" + orderId + ", qty=" + qty + ", advQty=" + advQty + ", itemId=" + itemId
				+ ", menuId=" + menuId + ", itemGrp1=" + itemGrp1 + ", productionDate=" + productionDate + ", itemName="
				+ itemName + ", curClosingQty=" + curClosingQty + ", curOpeQty=" + curOpeQty + "]";
	}

}
