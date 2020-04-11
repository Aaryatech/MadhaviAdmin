package com.ats.adminpanel.model.chart;

public class FrWiseSaleForItem {

	private int frId;
	private String frName;
	private float total;

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	@Override
	public String toString() {
		return "FrWiseSaleForItem [frId=" + frId + ", frName=" + frName + ", total=" + total + "]";
	}

}
