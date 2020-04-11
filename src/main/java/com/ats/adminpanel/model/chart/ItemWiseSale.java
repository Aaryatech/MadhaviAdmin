package com.ats.adminpanel.model.chart;

public class ItemWiseSale {

	private int itemId;
	private String itemName;
	private float total;

	public ItemWiseSale() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ItemWiseSale(int itemId, String itemName, float total) {
		super();
		this.itemId = itemId;
		this.itemName = itemName;
		this.total = total;
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

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	@Override
	public String toString() {
		return "ItemWiseSale [itemId=" + itemId + ", itemName=" + itemName + ", total=" + total + "]";
	}

}
