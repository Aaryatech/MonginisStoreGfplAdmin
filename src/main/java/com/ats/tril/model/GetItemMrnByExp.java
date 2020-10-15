package com.ats.tril.model;

public class GetItemMrnByExp {
	
	
	
	private int mrnDetailId;
	
	private String batchNo;
	
	private String itemDesc;
	
	private String itemUom;
	
	private float remainingQty;
	
	private String expDate;

	public int getMrnDetailId() {
		return mrnDetailId;
	}

	public void setMrnDetailId(int mrnDetailId) {
		this.mrnDetailId = mrnDetailId;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getItemUom() {
		return itemUom;
	}

	public void setItemUom(String itemUom) {
		this.itemUom = itemUom;
	}

	public float getRemainingQty() {
		return remainingQty;
	}

	public void setRemainingQty(float remainingQty) {
		this.remainingQty = remainingQty;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	@Override
	public String toString() {
		return "GetItemMrnByExp [mrnDetailId=" + mrnDetailId + ", batchNo=" + batchNo + ", itemDesc=" + itemDesc
				+ ", itemUom=" + itemUom + ", remainingQty=" + remainingQty + ", expDate=" + expDate + "]";
	} 
	
	
	
	
	
	
	

}
