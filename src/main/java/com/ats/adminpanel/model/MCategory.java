package com.ats.adminpanel.model;

import java.util.List;

import com.ats.adminpanel.model.item.SubCategory;


public class MCategory {
	  private int catId;
	    private String catName;
	    private Integer isSameDay;
	    private Integer delStatus;
	    private String itemImage;
		private int seqNo;

	    private List<SubCategory> subCategory;
		
	    public int getCatId() {
			return catId;
		}
		public void setCatId(int catId) {
			this.catId = catId;
		}
		public String getCatName() {
			return catName;
		}
		public void setCatName(String catName) {
			this.catName = catName;
		}
		public Integer getIsSameDay() {
			return isSameDay;
		}
		public void setIsSameDay(Integer isSameDay) {
			this.isSameDay = isSameDay;
		}
		public Integer getDelStatus() {
			return delStatus;
		}
		public void setDelStatus(Integer delStatus) {
			this.delStatus = delStatus;
		}
		public List<SubCategory> getSubCategory() {
			return subCategory;
		}
		public void setSubCategory(List<SubCategory> subCategory) {
			this.subCategory = subCategory;
		}
		
		public String getItemImage() {
			return itemImage;
		}
		public void setItemImage(String itemImage) {
			this.itemImage = itemImage;
		}
		public int getSeqNo() {
			return seqNo;
		}
		public void setSeqNo(int seqNo) {
			this.seqNo = seqNo;
		}
		@Override
		public String toString() {
			return "MCategory [catId=" + catId + ", catName=" + catName + ", isSameDay=" + isSameDay + ", delStatus="
					+ delStatus + ", subCategory=" + subCategory + "]";
		}

	    
}
