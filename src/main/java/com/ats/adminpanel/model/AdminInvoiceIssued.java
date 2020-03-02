package com.ats.adminpanel.model;

public class AdminInvoiceIssued {

	private String id;
	private int frId;
	private String fromInvoice;
	private String toInvoice;
	private int totalNumber;
	private int totalDeleted;
	private String deletedInvoice;
	private int netIssued;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public String getFromInvoice() {
		return fromInvoice;
	}

	public void setFromInvoice(String fromInvoice) {
		this.fromInvoice = fromInvoice;
	}

	

	public String getToInvoice() {
		return toInvoice;
	}

	public void setToInvoice(String toInvoice) {
		this.toInvoice = toInvoice;
	}

	public int getTotalNumber() {
		return totalNumber;
	}

	public void setTotalNumber(int totalNumber) {
		this.totalNumber = totalNumber;
	}

	public int getTotalDeleted() {
		return totalDeleted;
	}

	public void setTotalDeleted(int totalDeleted) {
		this.totalDeleted = totalDeleted;
	}

	public String getDeletedInvoice() {
		return deletedInvoice;
	}

	public void setDeletedInvoice(String deletedInvoice) {
		this.deletedInvoice = deletedInvoice;
	}

	public int getNetIssued() {
		return netIssued;
	}

	public void setNetIssued(int netIssued) {
		this.netIssued = netIssued;
	}

	
	
	@Override
	public String toString() {
		return "AdminInvoiceIssued [id=" + id + ", frId=" + frId + ", fromInvoice=" + fromInvoice + ", toInvoice="
				+ toInvoice + ", totalNumber=" + totalNumber + ", totalDeleted=" + totalDeleted + ", deletedInvoice="
				+ deletedInvoice + ", netIssued=" + netIssued + "]";
	}
	
}
