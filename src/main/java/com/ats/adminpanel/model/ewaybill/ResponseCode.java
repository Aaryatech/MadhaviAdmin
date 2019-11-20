package com.ats.adminpanel.model.ewaybill;

public class ResponseCode {

	private String statusCd;
	private Error error;
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public Error getError() {
		return error;
	}
	public void setError(Error error) {
		this.error = error;
	}
	@Override
	public String toString() {
		return "ResponseCode [statusCd=" + statusCd + ", error=" + error + "]";
	}
	
}
