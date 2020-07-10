package com.ats.adminpanel.model.tally;

import java.util.List;


public class SalesInvoices {

	private String billNo;
	List<BillInfo> billInfo;

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public List<BillInfo> getBillInfo() {
		return billInfo;
	}

	public void setBillInfo(List<BillInfo> billInfo) {
		this.billInfo = billInfo;
	}

	@Override
	public String toString() {
		return "SalesInvoices [billNo=" + billNo + ", billInfo=" + billInfo + "]";
	}
	
}
