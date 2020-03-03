package com.ats.adminpanel.model.stock;

public class PostFrItemStockDetail {

	private int openingStockDetailId;

	private int openingStockHeaderId;

	private int itemId;

	private float regOpeningStock;

	private float spOpeningStock;

	private float physicalStock;

	private float stockDifference;

	private float regTotalPurchase;

	private float spTotalPurchase;

	private float regTotalGrnGvn;

	private float regTotalSell;

	private float spTotalSell;

	private String remark;

	private String itemName;

	private String itemCode;

	public int getOpeningStockDetailId() {
		return openingStockDetailId;
	}

	public void setOpeningStockDetailId(int openingStockDetailId) {
		this.openingStockDetailId = openingStockDetailId;
	}

	public int getOpeningStockHeaderId() {
		return openingStockHeaderId;
	}

	public void setOpeningStockHeaderId(int openingStockHeaderId) {
		this.openingStockHeaderId = openingStockHeaderId;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public float getRegOpeningStock() {
		return regOpeningStock;
	}

	public void setRegOpeningStock(float regOpeningStock) {
		this.regOpeningStock = regOpeningStock;
	}

	public float getSpOpeningStock() {
		return spOpeningStock;
	}

	public void setSpOpeningStock(float spOpeningStock) {
		this.spOpeningStock = spOpeningStock;
	}

	public float getPhysicalStock() {
		return physicalStock;
	}

	public void setPhysicalStock(float physicalStock) {
		this.physicalStock = physicalStock;
	}

	public float getStockDifference() {
		return stockDifference;
	}

	public void setStockDifference(float stockDifference) {
		this.stockDifference = stockDifference;
	}

	public float getRegTotalPurchase() {
		return regTotalPurchase;
	}

	public void setRegTotalPurchase(float regTotalPurchase) {
		this.regTotalPurchase = regTotalPurchase;
	}

	public float getSpTotalPurchase() {
		return spTotalPurchase;
	}

	public void setSpTotalPurchase(float spTotalPurchase) {
		this.spTotalPurchase = spTotalPurchase;
	}

	public float getRegTotalGrnGvn() {
		return regTotalGrnGvn;
	}

	public void setRegTotalGrnGvn(float regTotalGrnGvn) {
		this.regTotalGrnGvn = regTotalGrnGvn;
	}

	public float getRegTotalSell() {
		return regTotalSell;
	}

	public void setRegTotalSell(float regTotalSell) {
		this.regTotalSell = regTotalSell;
	}

	public float getSpTotalSell() {
		return spTotalSell;
	}

	public void setSpTotalSell(float spTotalSell) {
		this.spTotalSell = spTotalSell;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	@Override
	public String toString() {
		return "PostFrItemStockDetail [openingStockDetailId=" + openingStockDetailId + ", openingStockHeaderId="
				+ openingStockHeaderId + ", itemId=" + itemId + ", regOpeningStock=" + regOpeningStock
				+ ", spOpeningStock=" + spOpeningStock + ", physicalStock=" + physicalStock + ", stockDifference="
				+ stockDifference + ", regTotalPurchase=" + regTotalPurchase + ", spTotalPurchase=" + spTotalPurchase
				+ ", regTotalGrnGvn=" + regTotalGrnGvn + ", regTotalSell=" + regTotalSell + ", spTotalSell="
				+ spTotalSell + ", remark=" + remark + ", itemName=" + itemName + ", itemCode=" + itemCode + "]";
	}

}
