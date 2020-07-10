package com.ats.adminpanel.model.storetally;

import java.util.List;


public class PurchaseInvoices {

	private String billBookNo;
	private List<BillInfo> billInfo;

	public String getBillBookNo() {
		return billBookNo;
	}

	public void setBillBookNo(String billBookNo) {
		this.billBookNo = billBookNo;
	}

	public List<BillInfo> getBillInfo() {
		return billInfo;
	}

	public void setBillInfo(List<BillInfo> billInfo) {
		this.billInfo = billInfo;
	}

	@Override
	public String toString() {
		return "PurchaseInvoices [billBookNo=" + billBookNo + ", billInfo=" + billInfo + "]";
	}
	
}
