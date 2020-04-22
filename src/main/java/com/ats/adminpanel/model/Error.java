package com.ats.adminpanel.model;

public class Error {

	private int errorCodes;

	public int getErrorCodes() {
		return errorCodes;
	}

	public void setErrorCodes(int errorCodes) {
		this.errorCodes = errorCodes;
	}

	@Override
	public String toString() {
		return "Error [errorCodes=" + errorCodes + "]";
	}

}
