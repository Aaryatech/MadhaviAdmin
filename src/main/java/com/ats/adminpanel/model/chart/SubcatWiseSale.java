package com.ats.adminpanel.model.chart;

public class SubcatWiseSale {
	
	private int subCatId;
	private String subCatName;
	private float total;
	
	
	
	public SubcatWiseSale() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public SubcatWiseSale(int subCatId, String subCatName, float total) {
		super();
		this.subCatId = subCatId;
		this.subCatName = subCatName;
		this.total = total;
	}


	public int getSubCatId() {
		return subCatId;
	}
	public void setSubCatId(int subCatId) {
		this.subCatId = subCatId;
	}
	public String getSubCatName() {
		return subCatName;
	}
	public void setSubCatName(String subCatName) {
		this.subCatName = subCatName;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	
	
	@Override
	public String toString() {
		return "SubcatWiseSale [subCatId=" + subCatId + ", subCatName=" + subCatName + ", total=" + total + "]";
	}
	
	
	

}
