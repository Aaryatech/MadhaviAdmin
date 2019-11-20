package com.ats.adminpanel.model.ewaybill;

import java.util.List;

public class ReqEwayBill {

	private String supplyType; // min max 1 "enum": [ "O","I" ],
	private String subSupplyType; //
	private String subSupplyDesc; // "maxLength": 20,
	private String docType; // "enum": [ "INV", "CHL", "BIL","BOE","CNT","OTH" ],
	private String docNo; // maxLength": 16,"description": "Document Number (Alphanumeric with / and - are
							// allowed)"
	private String docDate; // "pattern": "[0-3][0-9]/[0-1][0-9]/[2][0][1-2][0-9]",
	private String fromGstin; // "maxLength": 15, "minLength": 15,"pattern": "[0-9]{2}[0-9|A-Z]{13}",
	private String fromTrdName; // "maxLength": 100,
	private String fromAddr1; // "maxLength": 120,
	private String fromAddr2; // maxLength": 120,
	private String fromPlace; // "maxLength": 50,
	private int fromPincode; // "maximum": 999999,"minimum": 100000,
	private int actFromStateCode;// "maximum": 99,
	private int fromStateCode;// "maximum": 99,
	private String toGstin;// "maxLength": 15, "minLength": 15, "pattern": "[0-9]{2}[0-9|A-Z]{13}",
	private String toTrdName; // "maxLength": 100,
	private String toAddr1;// "maxLength": 120,
	private String toAddr2;// "maxLength": 120,
	private String toPlace;// "maxLength": 50,
	private int toPincode; //
	private int actToStateCode;
	private int toStateCode;
	private int transactionType; // regular ,billto ship to
	private String dispatchFromGSTIN; //
	private String dispatchFromTradeName;
	private String shipToGSTIN;
	private String shipToTradeName;

	private float otherValue;
	private float totalValue;
	private float cgstValue;
	private float sgstValue;
	private float igstValue;
	private float cessValue;
	private float cessNonAdvolValue;
	private float totInvValue;

	private String transporterId;
	private String transporterName;
	private String transDocNo;
	private String transMode;
	private String transDistance;
	private String transDocDate;

	private String vehicleNo;
	private String vehicleType;
	
	
	List<EwayItemList> itemList;
	
	

	public List<EwayItemList> getItemList() {
		return itemList;
	}

	public void setItemList(List<EwayItemList> itemList) {
		this.itemList = itemList;
	}

	public String getSupplyType() {
		return supplyType;
	}

	public void setSupplyType(String supplyType) {
		this.supplyType = supplyType;
	}

	public String getSubSupplyType() {
		return subSupplyType;
	}

	public void setSubSupplyType(String subSupplyType) {
		this.subSupplyType = subSupplyType;
	}

	public String getSubSupplyDesc() {
		return subSupplyDesc;
	}

	public void setSubSupplyDesc(String subSupplyDesc) {
		this.subSupplyDesc = subSupplyDesc;
	}

	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}

	public String getDocNo() {
		return docNo;
	}

	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}

	public String getDocDate() {
		return docDate;
	}

	public void setDocDate(String docDate) {
		this.docDate = docDate;
	}

	public String getFromGstin() {
		return fromGstin;
	}

	public void setFromGstin(String fromGstin) {
		this.fromGstin = fromGstin;
	}

	public String getFromTrdName() {
		return fromTrdName;
	}

	public void setFromTrdName(String fromTrdName) {
		this.fromTrdName = fromTrdName;
	}

	public String getFromAddr1() {
		return fromAddr1;
	}

	public void setFromAddr1(String fromAddr1) {
		this.fromAddr1 = fromAddr1;
	}

	public String getFromAddr2() {
		return fromAddr2;
	}

	public void setFromAddr2(String fromAddr2) {
		this.fromAddr2 = fromAddr2;
	}

	public String getFromPlace() {
		return fromPlace;
	}

	public void setFromPlace(String fromPlace) {
		this.fromPlace = fromPlace;
	}

	public int getFromPincode() {
		return fromPincode;
	}

	public void setFromPincode(int fromPincode) {
		this.fromPincode = fromPincode;
	}

	public int getActFromStateCode() {
		return actFromStateCode;
	}

	public void setActFromStateCode(int actFromStateCode) {
		this.actFromStateCode = actFromStateCode;
	}

	public int getFromStateCode() {
		return fromStateCode;
	}

	public void setFromStateCode(int fromStateCode) {
		this.fromStateCode = fromStateCode;
	}

	public String getToGstin() {
		return toGstin;
	}

	public void setToGstin(String toGstin) {
		this.toGstin = toGstin;
	}

	public String getToTrdName() {
		return toTrdName;
	}

	public void setToTrdName(String toTrdName) {
		this.toTrdName = toTrdName;
	}

	public String getToAddr1() {
		return toAddr1;
	}

	public void setToAddr1(String toAddr1) {
		this.toAddr1 = toAddr1;
	}

	public String getToAddr2() {
		return toAddr2;
	}

	public void setToAddr2(String toAddr2) {
		this.toAddr2 = toAddr2;
	}

	public String getToPlace() {
		return toPlace;
	}

	public void setToPlace(String toPlace) {
		this.toPlace = toPlace;
	}

	public int getToPincode() {
		return toPincode;
	}

	public void setToPincode(int toPincode) {
		this.toPincode = toPincode;
	}

	public int getActToStateCode() {
		return actToStateCode;
	}

	public void setActToStateCode(int actToStateCode) {
		this.actToStateCode = actToStateCode;
	}

	public int getToStateCode() {
		return toStateCode;
	}

	public void setToStateCode(int toStateCode) {
		this.toStateCode = toStateCode;
	}

	public int getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(int transactionType) {
		this.transactionType = transactionType;
	}

	public String getDispatchFromGSTIN() {
		return dispatchFromGSTIN;
	}

	public void setDispatchFromGSTIN(String dispatchFromGSTIN) {
		this.dispatchFromGSTIN = dispatchFromGSTIN;
	}

	public String getDispatchFromTradeName() {
		return dispatchFromTradeName;
	}

	public void setDispatchFromTradeName(String dispatchFromTradeName) {
		this.dispatchFromTradeName = dispatchFromTradeName;
	}

	public String getShipToGSTIN() {
		return shipToGSTIN;
	}

	public void setShipToGSTIN(String shipToGSTIN) {
		this.shipToGSTIN = shipToGSTIN;
	}

	public String getShipToTradeName() {
		return shipToTradeName;
	}

	public void setShipToTradeName(String shipToTradeName) {
		this.shipToTradeName = shipToTradeName;
	}

	public float getOtherValue() {
		return otherValue;
	}

	public void setOtherValue(float otherValue) {
		this.otherValue = otherValue;
	}

	public float getTotalValue() {
		return totalValue;
	}

	public void setTotalValue(float totalValue) {
		this.totalValue = totalValue;
	}

	public float getCgstValue() {
		return cgstValue;
	}

	public void setCgstValue(float cgstValue) {
		this.cgstValue = cgstValue;
	}

	public float getSgstValue() {
		return sgstValue;
	}

	public void setSgstValue(float sgstValue) {
		this.sgstValue = sgstValue;
	}

	public float getIgstValue() {
		return igstValue;
	}

	public void setIgstValue(float igstValue) {
		this.igstValue = igstValue;
	}

	public float getCessValue() {
		return cessValue;
	}

	public void setCessValue(float cessValue) {
		this.cessValue = cessValue;
	}

	public float getCessNonAdvolValue() {
		return cessNonAdvolValue;
	}

	public void setCessNonAdvolValue(float cessNonAdvolValue) {
		this.cessNonAdvolValue = cessNonAdvolValue;
	}

	public float getTotInvValue() {
		return totInvValue;
	}

	public void setTotInvValue(float totInvValue) {
		this.totInvValue = totInvValue;
	}

	public String getTransporterId() {
		return transporterId;
	}

	public void setTransporterId(String transporterId) {
		this.transporterId = transporterId;
	}

	public String getTransporterName() {
		return transporterName;
	}

	public void setTransporterName(String transporterName) {
		this.transporterName = transporterName;
	}

	public String getTransDocNo() {
		return transDocNo;
	}

	public void setTransDocNo(String transDocNo) {
		this.transDocNo = transDocNo;
	}

	public String getTransMode() {
		return transMode;
	}

	public void setTransMode(String transMode) {
		this.transMode = transMode;
	}

	public String getTransDistance() {
		return transDistance;
	}

	public void setTransDistance(String transDistance) {
		this.transDistance = transDistance;
	}

	public String getTransDocDate() {
		return transDocDate;
	}

	public void setTransDocDate(String transDocDate) {
		this.transDocDate = transDocDate;
	}

	public String getVehicleNo() {
		return vehicleNo;
	}

	public void setVehicleNo(String vehicleNo) {
		this.vehicleNo = vehicleNo;
	}

	public String getVehicleType() {
		return vehicleType;
	}

	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}

	@Override
	public String toString() {
		return "ReqEwayBill [supplyType=" + supplyType + ", subSupplyType=" + subSupplyType + ", subSupplyDesc="
				+ subSupplyDesc + ", docType=" + docType + ", docNo=" + docNo + ", docDate=" + docDate + ", fromGstin="
				+ fromGstin + ", fromTrdName=" + fromTrdName + ", fromAddr1=" + fromAddr1 + ", fromAddr2=" + fromAddr2
				+ ", fromPlace=" + fromPlace + ", fromPincode=" + fromPincode + ", actFromStateCode=" + actFromStateCode
				+ ", fromStateCode=" + fromStateCode + ", toGstin=" + toGstin + ", toTrdName=" + toTrdName
				+ ", toAddr1=" + toAddr1 + ", toAddr2=" + toAddr2 + ", toPlace=" + toPlace + ", toPincode=" + toPincode
				+ ", actToStateCode=" + actToStateCode + ", toStateCode=" + toStateCode + ", transactionType="
				+ transactionType + ", dispatchFromGSTIN=" + dispatchFromGSTIN + ", dispatchFromTradeName="
				+ dispatchFromTradeName + ", shipToGSTIN=" + shipToGSTIN + ", shipToTradeName=" + shipToTradeName
				+ ", otherValue=" + otherValue + ", totalValue=" + totalValue + ", cgstValue=" + cgstValue
				+ ", sgstValue=" + sgstValue + ", igstValue=" + igstValue + ", cessValue=" + cessValue
				+ ", cessNonAdvolValue=" + cessNonAdvolValue + ", totInvValue=" + totInvValue + ", transporterId="
				+ transporterId + ", transporterName=" + transporterName + ", transDocNo=" + transDocNo + ", transMode="
				+ transMode + ", transDistance=" + transDistance + ", transDocDate=" + transDocDate + ", vehicleNo="
				+ vehicleNo + ", vehicleType=" + vehicleType + ", itemList=" + itemList + "]";
	}

}
