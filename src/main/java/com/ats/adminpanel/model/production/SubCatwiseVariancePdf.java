package com.ats.adminpanel.model.production;

public class SubCatwiseVariancePdf {
	
	String subCatName;
	
	
	float opBalance;
	
	float planQty;
	
	float prodQty;
	
	float total;
	
	float orderQty;
	
	float variance;
	
	float clBal;
	
	
	
	

	public String getSubCatName() {
		return subCatName;
	}

	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}

	
	public float getOpBalance() {
		return opBalance;
	}

	public void setOpBalance(float opBalance) {
		this.opBalance = opBalance;
	}

	
	
	public float getPlanQty() {
		return planQty;
	}

	public void setPlanQty(float planQty) {
		this.planQty = planQty;
	}

	public float getProdQty() {
		return prodQty;
	}

	public void setProdQty(float prodQty) {
		this.prodQty = prodQty;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	

	

	public float getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(float orderQty) {
		this.orderQty = orderQty;
	}

	public float getVariance() {
		return variance;
	}

	public void setVariance(float variance) {
		this.variance = variance;
	}

	

	public float getClBal() {
		return clBal;
	}

	public void setClBal(float clBal) {
		this.clBal = clBal;
	}

	@Override
	public String toString() {
		return "SubCatwiseVariancePdf [subCatName=" + subCatName + ", opBalance=" + opBalance + ", planQty=" + planQty
				+ ", prodQty=" + prodQty + ", total=" + total + ", orderQty=" + orderQty + ", variance=" + variance
				+ ", clBal=" + clBal + "]";
	}


}
