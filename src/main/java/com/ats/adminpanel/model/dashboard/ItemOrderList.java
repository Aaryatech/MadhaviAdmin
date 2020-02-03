package com.ats.adminpanel.model.dashboard;

import java.util.List;

public class ItemOrderList {
	List<ItemOrderHis> itemOrderListt;
	ErrorMessage errorMessage;

	public List<ItemOrderHis> getItemOrderListt() {
		return itemOrderListt;
	}

	public void setItemOrderListt(List<ItemOrderHis> itemOrderListt) {
		this.itemOrderListt = itemOrderListt;
	}

	public ErrorMessage getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(ErrorMessage errorMessage) {
		this.errorMessage = errorMessage;
	}

	@Override
	public String toString() {
		return "ItemOrderList [itemOrderListt=" + itemOrderListt + ", errorMessage=" + errorMessage + "]";
	}

}
