package com.ats.adminpanel.model;

import java.util.List;

public class AddCustemerResponse {
	
	private int addCustomerId;
	private List<Customer> customerList;
	private boolean error;
	
	public int getAddCustomerId() {
		return addCustomerId;
	}
	public void setAddCustomerId(int addCustomerId) {
		this.addCustomerId = addCustomerId;
	}
	public List<Customer> getCustomerList() {
		return customerList;
	}
	public void setCustomerList(List<Customer> customerList) {
		this.customerList = customerList;
	}
	public boolean isError() {
		return error;
	}
	public void setError(boolean error) {
		this.error = error;
	}
	@Override
	public String toString() {
		return "AddCustemerResponse [addCustomerId=" + addCustomerId + ", customerList=" + customerList + ", error="
				+ error + "]";
	}
	
	

}
