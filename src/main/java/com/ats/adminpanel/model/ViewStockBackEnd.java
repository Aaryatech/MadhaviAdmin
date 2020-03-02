package com.ats.adminpanel.model;

import java.util.List;

public class ViewStockBackEnd {

	List<ViewFrStockBackEnd> currentStockDetailList;

	List<ItemNameId> itemList;

	List<FrIdNames> frIdNamesList;

	public List<ViewFrStockBackEnd> getCurrentStockDetailList() {
		return currentStockDetailList;
	}

	public void setCurrentStockDetailList(List<ViewFrStockBackEnd> currentStockDetailList) {
		this.currentStockDetailList = currentStockDetailList;
	}

	public List<ItemNameId> getItemList() {
		return itemList;
	}

	public void setItemList(List<ItemNameId> itemList) {
		this.itemList = itemList;
	}

	public List<FrIdNames> getFrIdNamesList() {
		return frIdNamesList;
	}

	public void setFrIdNamesList(List<FrIdNames> frIdNamesList) {
		this.frIdNamesList = frIdNamesList;
	}

	@Override
	public String toString() {
		return "ViewStockBackEnd [currentStockDetailList=" + currentStockDetailList + ", itemList=" + itemList
				+ ", frIdNamesList=" + frIdNamesList + "]";
	}

}
