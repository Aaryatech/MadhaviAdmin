package com.ats.adminpanel.model;

public class FrConfig {

	private int frConfigId;

	private int frId;
	private int frType;
	private int cityIds;
	private String areaIds;
	private String pincodes;
	private double fromLatitude;
	private double toLatitude;
	private double fromLongitude;
	private double toLongitude;
	private float kmAreaCovered;
	private int compId;
	private int isActive;
	private int delStatus;
	private int exInt1;
	private int exInt2;
	private int exInt3;
	private String exVar1;
	private String exVar2;
	private String exVar3;
	private float exFloat1;
	private float exFloat2;
	private float exFloat3;

	public int getFrConfigId() {
		return frConfigId;
	}

	public void setFrConfigId(int frConfigId) {
		this.frConfigId = frConfigId;
	}

	public int getFrId() {
		return frId;
	}

	public void setFrId(int frId) {
		this.frId = frId;
	}

	public int getFrType() {
		return frType;
	}

	public void setFrType(int frType) {
		this.frType = frType;
	}

	public int getCityIds() {
		return cityIds;
	}

	public void setCityIds(int cityIds) {
		this.cityIds = cityIds;
	}

	public String getAreaIds() {
		return areaIds;
	}

	public void setAreaIds(String areaIds) {
		this.areaIds = areaIds;
	}

	public String getPincodes() {
		return pincodes;
	}

	public void setPincodes(String pincodes) {
		this.pincodes = pincodes;
	}

	public double getFromLatitude() {
		return fromLatitude;
	}

	public void setFromLatitude(double fromLatitude) {
		this.fromLatitude = fromLatitude;
	}

	public double getToLatitude() {
		return toLatitude;
	}

	public void setToLatitude(double toLatitude) {
		this.toLatitude = toLatitude;
	}

	public double getFromLongitude() {
		return fromLongitude;
	}

	public void setFromLongitude(double fromLongitude) {
		this.fromLongitude = fromLongitude;
	}

	public double getToLongitude() {
		return toLongitude;
	}

	public void setToLongitude(double toLongitude) {
		this.toLongitude = toLongitude;
	}

	public float getKmAreaCovered() {
		return kmAreaCovered;
	}

	public void setKmAreaCovered(float kmAreaCovered) {
		this.kmAreaCovered = kmAreaCovered;
	}

	public int getCompId() {
		return compId;
	}

	public void setCompId(int compId) {
		this.compId = compId;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public int getExInt1() {
		return exInt1;
	}

	public void setExInt1(int exInt1) {
		this.exInt1 = exInt1;
	}

	public int getExInt2() {
		return exInt2;
	}

	public void setExInt2(int exInt2) {
		this.exInt2 = exInt2;
	}

	public int getExInt3() {
		return exInt3;
	}

	public void setExInt3(int exInt3) {
		this.exInt3 = exInt3;
	}

	public String getExVar1() {
		return exVar1;
	}

	public void setExVar1(String exVar1) {
		this.exVar1 = exVar1;
	}

	public String getExVar2() {
		return exVar2;
	}

	public void setExVar2(String exVar2) {
		this.exVar2 = exVar2;
	}

	public String getExVar3() {
		return exVar3;
	}

	public void setExVar3(String exVar3) {
		this.exVar3 = exVar3;
	}

	public float getExFloat1() {
		return exFloat1;
	}

	public void setExFloat1(float exFloat1) {
		this.exFloat1 = exFloat1;
	}

	public float getExFloat2() {
		return exFloat2;
	}

	public void setExFloat2(float exFloat2) {
		this.exFloat2 = exFloat2;
	}

	public float getExFloat3() {
		return exFloat3;
	}

	public void setExFloat3(float exFloat3) {
		this.exFloat3 = exFloat3;
	}

	@Override
	public String toString() {
		return "FrConfig [frConfigId=" + frConfigId + ", frId=" + frId + ", frType=" + frType + ", cityIds=" + cityIds
				+ ", areaIds=" + areaIds + ", pincodes=" + pincodes + ", fromLatitude=" + fromLatitude + ", toLatitude="
				+ toLatitude + ", fromLongitude=" + fromLongitude + ", toLongitude=" + toLongitude + ", kmAreaCovered="
				+ kmAreaCovered + ", compId=" + compId + ", isActive=" + isActive + ", delStatus=" + delStatus
				+ ", exInt1=" + exInt1 + ", exInt2=" + exInt2 + ", exInt3=" + exInt3 + ", exVar1=" + exVar1
				+ ", exVar2=" + exVar2 + ", exVar3=" + exVar3 + ", exFloat1=" + exFloat1 + ", exFloat2=" + exFloat2
				+ ", exFloat3=" + exFloat3 + "]";
	}

}
