package com.ats.adminpanel.model.ewaybill;

public class Error {

	private String errorCd;
	private String message;
	public String getErrorCd() {
		return errorCd;
	}
	public void setErrorCd(String errorCd) {
		this.errorCd = errorCd;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	@Override
	public String toString() {
		return "Error [errorCd=" + errorCd + ", message=" + message + "]";
	}
	
}
