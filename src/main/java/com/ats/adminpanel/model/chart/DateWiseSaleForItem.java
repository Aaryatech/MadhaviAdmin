package com.ats.adminpanel.model.chart;

import java.util.Date;

public class DateWiseSaleForItem {

	private String uid;

	private String billDate;

	private float total;

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	@Override
	public String toString() {
		return "DateWiseSaleForItem [uid=" + uid + ", billDate=" + billDate + ", total=" + total + "]";
	}

}
