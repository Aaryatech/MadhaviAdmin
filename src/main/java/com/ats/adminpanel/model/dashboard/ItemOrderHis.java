package com.ats.adminpanel.model.dashboard;

import java.io.Serializable;

import java.util.Date;
 

 public class ItemOrderHis    {

	 private int orderId;
		private String orderDate;
		private int frId;
		private int orderType;
		private int orderSubType;
		private int refId;
		private String itemId;
		private float orderQty;
		private double orderRate;
		private double orderMrp;
		private int orderStatus;
		private String orderDatetime;
		private String productionDate;
		private String deliveryDate;
		private int isEdit;
		private float editQty;
		private int userId;
		private float isPositive;//discPer
		private int menuId;
		private String menuTitle;
		private String itemName;
		public int getOrderId() {
			return orderId;
		}
		public String getOrderDate() {
			return orderDate;
		}
		public int getFrId() {
			return frId;
		}
		public int getOrderType() {
			return orderType;
		}
		public int getOrderSubType() {
			return orderSubType;
		}
		public int getRefId() {
			return refId;
		}
		public String getItemId() {
			return itemId;
		}
	
		public double getOrderRate() {
			return orderRate;
		}
		public double getOrderMrp() {
			return orderMrp;
		}
		public int getOrderStatus() {
			return orderStatus;
		}
		public String getOrderDatetime() {
			return orderDatetime;
		}
		public String getProductionDate() {
			return productionDate;
		}
		public String getDeliveryDate() {
			return deliveryDate;
		}
		public int getIsEdit() {
			return isEdit;
		}
	
		public int getUserId() {
			return userId;
		}
		
		public int getMenuId() {
			return menuId;
		}
		public String getMenuTitle() {
			return menuTitle;
		}
		public String getItemName() {
			return itemName;
		}
		public void setOrderId(int orderId) {
			this.orderId = orderId;
		}
		public void setOrderDate(String orderDate) {
			this.orderDate = orderDate;
		}
		public void setFrId(int frId) {
			this.frId = frId;
		}
		public void setOrderType(int orderType) {
			this.orderType = orderType;
		}
		public void setOrderSubType(int orderSubType) {
			this.orderSubType = orderSubType;
		}
		public void setRefId(int refId) {
			this.refId = refId;
		}
		public void setItemId(String itemId) {
			this.itemId = itemId;
		}
		
		public void setOrderRate(double orderRate) {
			this.orderRate = orderRate;
		}
		public void setOrderMrp(double orderMrp) {
			this.orderMrp = orderMrp;
		}
		public void setOrderStatus(int orderStatus) {
			this.orderStatus = orderStatus;
		}
		public void setOrderDatetime(String orderDatetime) {
			this.orderDatetime = orderDatetime;
		}
		public void setProductionDate(String productionDate) {
			this.productionDate = productionDate;
		}
		public void setDeliveryDate(String deliveryDate) {
			this.deliveryDate = deliveryDate;
		}
		
		public void setEditQty(int editQty) {
			this.editQty = editQty;
		}
		public void setUserId(int userId) {
			this.userId = userId;
		}
		
		public void setMenuId(int menuId) {
			this.menuId = menuId;
		}
		public void setMenuTitle(String menuTitle) {
			this.menuTitle = menuTitle;
		}
		public void setItemName(String itemName) {
			this.itemName = itemName;
		}
		
		
		
		public float getIsPositive() {
			return isPositive;
		}
		public void setIsPositive(float isPositive) {
			this.isPositive = isPositive;
		}
		
		
		
		
		public float getOrderQty() {
			return orderQty;
		}
		public void setOrderQty(float orderQty) {
			this.orderQty = orderQty;
		}
		public float getEditQty() {
			return editQty;
		}
		public void setEditQty(float editQty) {
			this.editQty = editQty;
		}
		public void setIsEdit(int isEdit) {
			this.isEdit = isEdit;
		}
		@Override
		public String toString() {
			return "ItemOrderHis [orderId=" + orderId + ", orderDate=" + orderDate + ", frId=" + frId + ", orderType="
					+ orderType + ", orderSubType=" + orderSubType + ", refId=" + refId + ", itemId=" + itemId
					+ ", orderQty=" + orderQty + ", orderRate=" + orderRate + ", orderMrp=" + orderMrp
					+ ", orderStatus=" + orderStatus + ", orderDatetime=" + orderDatetime + ", productionDate="
					+ productionDate + ", deliveryDate=" + deliveryDate + ", isEdit=" + isEdit + ", editQty=" + editQty
					+ ", userId=" + userId + ", isPositive=" + isPositive + ", menuId=" + menuId + ", menuTitle="
					+ menuTitle + ", itemName=" + itemName + "]";
		}
		
	
	
}
