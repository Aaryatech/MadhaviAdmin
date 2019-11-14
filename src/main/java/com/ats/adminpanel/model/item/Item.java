package com.ats.adminpanel.model.item;


public class Item {

int id;

private String itemId;

private String itemName;

private int itemGrp1;

private int itemGrp2;

private int itemGrp3;

private float itemRate1;

private float itemRate2;

private float itemMrp1;

private float itemMrp2;

private float itemMrp3;

private String itemImage;

private float itemTax1;

private float itemTax2;

private float itemTax3;

private int itemIsUsed;

private float itemSortId;

private int grnTwo;

private int delStatus;

private int minQty;

private float itemRate3;

private int shelfLife;

private int isSaleable;

private int isStockable;

private int isFactOrFr;

private int extInt1;

private int extInt2;

private float extFloat1;

private float extFloat2;

private String extVar1;

private String extVar2;

private String extVar3;

public int getIsSaleable() {
	return isSaleable;
}


public void setIsSaleable(int isSaleable) {
	this.isSaleable = isSaleable;
}


public int getIsStockable() {
	return isStockable;
}


public void setIsStockable(int isStockable) {
	this.isStockable = isStockable;
}


public int getIsFactOrFr() {
	return isFactOrFr;
}


public void setIsFactOrFr(int isFactOrFr) {
	this.isFactOrFr = isFactOrFr;
}


public int getExtInt1() {
	return extInt1;
}


public void setExtInt1(int extInt1) {
	this.extInt1 = extInt1;
}


public int getExtInt2() {
	return extInt2;
}


public void setExtInt2(int extInt2) {
	this.extInt2 = extInt2;
}


public float getExtFloat1() {
	return extFloat1;
}


public void setExtFloat1(float extFloat1) {
	this.extFloat1 = extFloat1;
}


public float getExtFloat2() {
	return extFloat2;
}


public void setExtFloat2(float extFloat2) {
	this.extFloat2 = extFloat2;
}


public String getExtVar1() {
	return extVar1;
}


public void setExtVar1(String extVar1) {
	this.extVar1 = extVar1;
}


public String getExtVar2() {
	return extVar2;
}


public void setExtVar2(String extVar2) {
	this.extVar2 = extVar2;
}


public String getExtVar3() {
	return extVar3;
}


public void setExtVar3(String extVar3) {
	this.extVar3 = extVar3;
}


public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public String getItemId() {
	return itemId;
}


public void setItemId(String itemId) {
	this.itemId = itemId;
}


public String getItemName() {
	return itemName;
}


public void setItemName(String itemName) {
	this.itemName = itemName;
}


public int getItemGrp1() {
	return itemGrp1;
}


public void setItemGrp1(int itemGrp1) {
	this.itemGrp1 = itemGrp1;
}


public int getItemGrp2() {
	return itemGrp2;
}


public void setItemGrp2(int itemGrp2) {
	this.itemGrp2 = itemGrp2;
}


public int getItemGrp3() {
	return itemGrp3;
}


public void setItemGrp3(int itemGrp3) {
	this.itemGrp3 = itemGrp3;
}


public float getItemRate1() {
	return itemRate1;
}


public void setItemRate1(float itemRate1) {
	this.itemRate1 = itemRate1;
}


public float getItemRate2() {
	return itemRate2;
}


public void setItemRate2(float itemRate2) {
	this.itemRate2 = itemRate2;
}


public float getItemMrp1() {
	return itemMrp1;
}


public void setItemMrp1(float itemMrp1) {
	this.itemMrp1 = itemMrp1;
}


public float getItemMrp2() {
	return itemMrp2;
}


public void setItemMrp2(float itemMrp2) {
	this.itemMrp2 = itemMrp2;
}


public float getItemMrp3() {
	return itemMrp3;
}


public void setItemMrp3(float itemMrp3) {
	this.itemMrp3 = itemMrp3;
}


public String getItemImage() {
	return itemImage;
}


public void setItemImage(String itemImage) {
	this.itemImage = itemImage;
}


public float getItemTax1() {
	return itemTax1;
}


public void setItemTax1(float itemTax1) {
	this.itemTax1 = itemTax1;
}


public float getItemTax2() {
	return itemTax2;
}


public void setItemTax2(float itemTax2) {
	this.itemTax2 = itemTax2;
}


public float getItemTax3() {
	return itemTax3;
}


public void setItemTax3(float itemTax3) {
	this.itemTax3 = itemTax3;
}


public int getItemIsUsed() {
	return itemIsUsed;
}


public void setItemIsUsed(int itemIsUsed) {
	this.itemIsUsed = itemIsUsed;
}


public float getItemSortId() {
	return itemSortId;
}


public void setItemSortId(float itemSortId) {
	this.itemSortId = itemSortId;
}


public int getGrnTwo() {
	return grnTwo;
}


public void setGrnTwo(int grnTwo) {
	this.grnTwo = grnTwo;
}


public int getDelStatus() {
	return delStatus;
}


public void setDelStatus(int delStatus) {
	this.delStatus = delStatus;
}


public int getMinQty() {
	return minQty;
}


public void setMinQty(int minQty) {
	this.minQty = minQty;
}


public float getItemRate3() {
	return itemRate3;
}


public void setItemRate3(float itemRate3) {
	this.itemRate3 = itemRate3;
}


public int getShelfLife() {
	return shelfLife;
}


public void setShelfLife(int shelfLife) {
	this.shelfLife = shelfLife;
}

@Override
public String toString() {
	return "Item [id=" + id + ", itemId=" + itemId + ", itemName=" + itemName + ", itemGrp1=" + itemGrp1 + ", itemGrp2="
			+ itemGrp2 + ", itemGrp3=" + itemGrp3 + ", itemRate1=" + itemRate1 + ", itemRate2=" + itemRate2
			+ ", itemMrp1=" + itemMrp1 + ", itemMrp2=" + itemMrp2 + ", itemMrp3=" + itemMrp3 + ", itemImage="
			+ itemImage + ", itemTax1=" + itemTax1 + ", itemTax2=" + itemTax2 + ", itemTax3=" + itemTax3
			+ ", itemIsUsed=" + itemIsUsed + ", itemSortId=" + itemSortId + ", grnTwo=" + grnTwo + ", delStatus="
			+ delStatus + ", minQty=" + minQty + ", itemRate3=" + itemRate3 + ", shelfLife=" + shelfLife
			+ ", isSaleable=" + isSaleable + ", isStockable=" + isStockable + ", isFactOrFr=" + isFactOrFr
			+ ", extInt1=" + extInt1 + ", extInt2=" + extInt2 + ", extFloat1=" + extFloat1 + ", extFloat2=" + extFloat2
			+ ", extVar1=" + extVar1 + ", extVar2=" + extVar2 + ", extVar3=" + extVar3 + "]";
}
}
