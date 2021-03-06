
package com.ats.adminpanel.model;

import java.util.Date;

public class GetOrder {

   
    private Integer orderId;
   
    private String frName;
   
    private String catName;
   
    private String itemName;
   
    private float orderQty;
    
    private int id;
   
    private String deliveryDate;
    
    private Integer isEdit;
    
    private Integer isPositive;
   
    private Integer editQty;
    
    private float advQty;

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getFrName() {
		return frName;
	}

	public void setFrName(String frName) {
		this.frName = frName;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public float getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(float orderQty) {
		this.orderQty = orderQty;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public Integer getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(Integer isEdit) {
		this.isEdit = isEdit;
	}

	public Integer getIsPositive() {
		return isPositive;
	}

	public void setIsPositive(Integer isPositive) {
		this.isPositive = isPositive;
	}

	public Integer getEditQty() {
		return editQty;
	}

	public void setEditQty(Integer editQty) {
		this.editQty = editQty;
	}

	public float getAdvQty() {
		return advQty;
	}

	public void setAdvQty(float advQty) {
		this.advQty = advQty;
	}

	@Override
	public String toString() {
		return "GetOrder [orderId=" + orderId + ", frName=" + frName + ", catName=" + catName + ", itemName=" + itemName
				+ ", orderQty=" + orderQty + ", id=" + id + ", deliveryDate=" + deliveryDate + ", isEdit=" + isEdit
				+ ", isPositive=" + isPositive + ", editQty=" + editQty + ", advQty=" + advQty + "]";
	}

   

}
