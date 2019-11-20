package com.ats.adminpanel.model.ewaybill;

public class EwayItemList {

	private String productName;
	private String productDesc;
	private int hsnCode;
	private float quantity;
	private String qtyUnit; // maxLen 3 char
	private float cgstRate;
	private float sgstRate;
	private float igstRate;
	private float cessRate;
	private float cessNonAdvol;
	private float taxableAmount;

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDesc() {
		return productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}

	public int getHsnCode() {
		return hsnCode;
	}

	public void setHsnCode(int hsnCode) {
		this.hsnCode = hsnCode;
	}

	public float getQuantity() {
		return quantity;
	}

	public void setQuantity(float quantity) {
		this.quantity = quantity;
	}

	public String getQtyUnit() {
		return qtyUnit;
	}

	public void setQtyUnit(String qtyUnit) {
		this.qtyUnit = qtyUnit;
	}

	public float getCgstRate() {
		return cgstRate;
	}

	public void setCgstRate(float cgstRate) {
		this.cgstRate = cgstRate;
	}

	public float getSgstRate() {
		return sgstRate;
	}

	public void setSgstRate(float sgstRate) {
		this.sgstRate = sgstRate;
	}

	public float getIgstRate() {
		return igstRate;
	}

	public void setIgstRate(float igstRate) {
		this.igstRate = igstRate;
	}

	public float getCessRate() {
		return cessRate;
	}

	public void setCessRate(float cessRate) {
		this.cessRate = cessRate;
	}

	public float getCessNonAdvol() {
		return cessNonAdvol;
	}

	public void setCessNonAdvol(float cessNonAdvol) {
		this.cessNonAdvol = cessNonAdvol;
	}

	public float getTaxableAmount() {
		return taxableAmount;
	}

	public void setTaxableAmount(float taxableAmount) {
		this.taxableAmount = taxableAmount;
	}

	@Override
	public String toString() {
		return "EwayItemList [productName=" + productName + ", productDesc=" + productDesc + ", hsnCode=" + hsnCode
				+ ", quantity=" + quantity + ", qtyUnit=" + qtyUnit + ", cgstRate=" + cgstRate + ", sgstRate="
				+ sgstRate + ", igstRate=" + igstRate + ", cessRate=" + cessRate + ", cessNonAdvol=" + cessNonAdvol
				+ ", taxableAmount=" + taxableAmount + "]";
	}

}
