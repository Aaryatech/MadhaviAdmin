package com.ats.adminpanel.model.tally;

public class BillInfo {

	private String billNo;
	private String date;
	private String eWayBillNo;
	private String eWayBillDate;

	private String customerName;
	private String gstNo;
	private String address;
	private String state;
	private String stateCode;

	private String shipToCustomerName;
	private String shipToGstNo;
	private String shipToAddress;
	private String shipToState;
	private String shipToStateCode;

	private String productName;
	private String partNo;
	private String qty;
	private String unit;
	private String hsn;
	private String gstPer;
	private String rate;
	private String discount;
	private String amount;

	private String cgst;
	private String sgst;
	private String igst;

	private String otherLedger;
	private String rateTotal;
	private String roundOff;
	private String totalAmount;

	private String accountType;

	public BillInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BillInfo(String billNo, String date, String eWayBillNo, String eWayBillDate, String customerName,
			String gstNo, String address, String state, String stateCode, String shipToCustomerName, String shipToGstNo,
			String shipToAddress, String shipToState, String shipToStateCode, String productName, String partNo,
			String qty, String unit, String hsn, String gstPer, String rate, String discount, String amount,
			String cgst, String sgst, String igst, String otherLedger, String rateTotal, String roundOff,
			String totalAmount, String accountType) {
		super();
		this.billNo = billNo;
		this.date = date;
		this.eWayBillNo = eWayBillNo;
		this.eWayBillDate = eWayBillDate;
		this.customerName = customerName;
		this.gstNo = gstNo;
		this.address = address;
		this.state = state;
		this.stateCode = stateCode;
		this.shipToCustomerName = shipToCustomerName;
		this.shipToGstNo = shipToGstNo;
		this.shipToAddress = shipToAddress;
		this.shipToState = shipToState;
		this.shipToStateCode = shipToStateCode;
		this.productName = productName;
		this.partNo = partNo;
		this.qty = qty;
		this.unit = unit;
		this.hsn = hsn;
		this.gstPer = gstPer;
		this.rate = rate;
		this.discount = discount;
		this.amount = amount;
		this.cgst = cgst;
		this.sgst = sgst;
		this.igst = igst;
		this.otherLedger = otherLedger;
		this.rateTotal = rateTotal;
		this.roundOff = roundOff;
		this.totalAmount = totalAmount;
		this.accountType = accountType;
	}

	public BillInfo(String billNo, String date, String eWayBillNo, String eWayBillDate, String customerName,
			String gstNo, String address, String state, String stateCode, String shipToCustomerName, String shipToGstNo,
			String shipToAddress, String shipToState, String shipToStateCode, String productName, String partNo,
			String qty, String unit, String hsn, String gstPer, String rate, String discount, String amount,
			String cgst, String sgst, String igst, String otherLedger, String rateTotal, String roundOff,
			String totalAmount) {
		super();
		this.billNo = billNo;
		this.date = date;
		this.eWayBillNo = eWayBillNo;
		this.eWayBillDate = eWayBillDate;
		this.customerName = customerName;
		this.gstNo = gstNo;
		this.address = address;
		this.state = state;
		this.stateCode = stateCode;
		this.shipToCustomerName = shipToCustomerName;
		this.shipToGstNo = shipToGstNo;
		this.shipToAddress = shipToAddress;
		this.shipToState = shipToState;
		this.shipToStateCode = shipToStateCode;
		this.productName = productName;
		this.partNo = partNo;
		this.qty = qty;
		this.unit = unit;
		this.hsn = hsn;
		this.gstPer = gstPer;
		this.rate = rate;
		this.discount = discount;
		this.amount = amount;
		this.cgst = cgst;
		this.sgst = sgst;
		this.igst = igst;
		this.otherLedger = otherLedger;
		this.rateTotal = rateTotal;
		this.roundOff = roundOff;
		this.totalAmount = totalAmount;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String geteWayBillNo() {
		return eWayBillNo;
	}

	public void seteWayBillNo(String eWayBillNo) {
		this.eWayBillNo = eWayBillNo;
	}

	public String geteWayBillDate() {
		return eWayBillDate;
	}

	public void seteWayBillDate(String eWayBillDate) {
		this.eWayBillDate = eWayBillDate;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getGstNo() {
		return gstNo;
	}

	public void setGstNo(String gstNo) {
		this.gstNo = gstNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public String getShipToCustomerName() {
		return shipToCustomerName;
	}

	public void setShipToCustomerName(String shipToCustomerName) {
		this.shipToCustomerName = shipToCustomerName;
	}

	public String getShipToGstNo() {
		return shipToGstNo;
	}

	public void setShipToGstNo(String shipToGstNo) {
		this.shipToGstNo = shipToGstNo;
	}

	public String getShipToAddress() {
		return shipToAddress;
	}

	public void setShipToAddress(String shipToAddress) {
		this.shipToAddress = shipToAddress;
	}

	public String getShipToState() {
		return shipToState;
	}

	public void setShipToState(String shipToState) {
		this.shipToState = shipToState;
	}

	public String getShipToStateCode() {
		return shipToStateCode;
	}

	public void setShipToStateCode(String shipToStateCode) {
		this.shipToStateCode = shipToStateCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getPartNo() {
		return partNo;
	}

	public void setPartNo(String partNo) {
		this.partNo = partNo;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getHsn() {
		return hsn;
	}

	public void setHsn(String hsn) {
		this.hsn = hsn;
	}

	public String getGstPer() {
		return gstPer;
	}

	public void setGstPer(String gstPer) {
		this.gstPer = gstPer;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getCgst() {
		return cgst;
	}

	public void setCgst(String cgst) {
		this.cgst = cgst;
	}

	public String getSgst() {
		return sgst;
	}

	public void setSgst(String sgst) {
		this.sgst = sgst;
	}

	public String getIgst() {
		return igst;
	}

	public void setIgst(String igst) {
		this.igst = igst;
	}

	public String getOtherLedger() {
		return otherLedger;
	}

	public void setOtherLedger(String otherLedger) {
		this.otherLedger = otherLedger;
	}

	public String getRoundOff() {
		return roundOff;
	}

	public void setRoundOff(String roundOff) {
		this.roundOff = roundOff;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getRateTotal() {
		return rateTotal;
	}

	public void setRateTotal(String rateTotal) {
		this.rateTotal = rateTotal;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	@Override
	public String toString() {
		return "BillInfo [billNo=" + billNo + ", date=" + date + ", eWayBillNo=" + eWayBillNo + ", eWayBillDate="
				+ eWayBillDate + ", customerName=" + customerName + ", gstNo=" + gstNo + ", address=" + address
				+ ", state=" + state + ", stateCode=" + stateCode + ", shipToCustomerName=" + shipToCustomerName
				+ ", shipToGstNo=" + shipToGstNo + ", shipToAddress=" + shipToAddress + ", shipToState=" + shipToState
				+ ", shipToStateCode=" + shipToStateCode + ", productName=" + productName + ", partNo=" + partNo
				+ ", qty=" + qty + ", unit=" + unit + ", hsn=" + hsn + ", gstPer=" + gstPer + ", rate=" + rate
				+ ", discount=" + discount + ", amount=" + amount + ", cgst=" + cgst + ", sgst=" + sgst + ", igst="
				+ igst + ", otherLedger=" + otherLedger + ", rateTotal=" + rateTotal + ", roundOff=" + roundOff
				+ ", totalAmount=" + totalAmount + ", accountType=" + accountType + "]";
	}
	
}
