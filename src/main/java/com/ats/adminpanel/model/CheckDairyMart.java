package com.ats.adminpanel.model;

public class CheckDairyMart {

	private int custId;
	private int isDairyMart;

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	public int getIsDairyMart() {
		return isDairyMart;
	}

	public void setIsDairyMart(int isDairyMart) {
		this.isDairyMart = isDairyMart;
	}

	@Override
	public String toString() {
		return "CheckDairyMart [custId=" + custId + ", isDairyMart=" + isDairyMart + "]";
	}

}
