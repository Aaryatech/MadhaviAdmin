package com.ats.adminpanel.model;

public class SubCategory2 {

	    private int subCatId;
	    private String subCatName;
	    private int catId;
	    private int delStatus;
	    private String prefix;
		public int getSubCatId() {
			return subCatId;
		}
		public void setSubCatId(int subCatId) {
			this.subCatId = subCatId;
		}
		public String getSubCatName() {
			return subCatName;
		}
		public void setSubCatName(String subCatName) {
			this.subCatName = subCatName;
		}
		public int getCatId() {
			return catId;
		}
		public void setCatId(int catId) {
			this.catId = catId;
		}
		public int getDelStatus() {
			return delStatus;
		}
		public void setDelStatus(int delStatus) {
			this.delStatus = delStatus;
		}
		public String getPrefix() {
			return prefix;
		}
		public void setPrefix(String prefix) {
			this.prefix = prefix;
		}
		@Override
		public String toString() {
			return "SubCategory2 [subCatId=" + subCatId + ", subCatName=" + subCatName + ", catId=" + catId
					+ ", delStatus=" + delStatus + ", prefix=" + prefix + "]";
		}
	    
	    
}
