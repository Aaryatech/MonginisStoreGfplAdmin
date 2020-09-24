package com.ats.tril.model;

public class GetBillHeader {

	private int billId;

	private String billNo;
	private String billDate;
	private int vendId;
	private String vendorName;
	private float billBasicValue;
	private float discValue;
	private float billTaxValue;
	private float totalValue;
	private int mrnId;
	private String mrnNo;
	private int billStatus;

	public int getBillId() {
		return billId;
	}

	public void setBillId(int billId) {
		this.billId = billId;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public int getVendId() {
		return vendId;
	}

	public void setVendId(int vendId) {
		this.vendId = vendId;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public float getBillBasicValue() {
		return billBasicValue;
	}

	public void setBillBasicValue(float billBasicValue) {
		this.billBasicValue = billBasicValue;
	}

	public float getDiscValue() {
		return discValue;
	}

	public void setDiscValue(float discValue) {
		this.discValue = discValue;
	}

	public float getBillTaxValue() {
		return billTaxValue;
	}

	public void setBillTaxValue(float billTaxValue) {
		this.billTaxValue = billTaxValue;
	}

	public float getTotalValue() {
		return totalValue;
	}

	public void setTotalValue(float totalValue) {
		this.totalValue = totalValue;
	}

	public int getMrnId() {
		return mrnId;
	}

	public void setMrnId(int mrnId) {
		this.mrnId = mrnId;
	}

	public String getMrnNo() {
		return mrnNo;
	}

	public void setMrnNo(String mrnNo) {
		this.mrnNo = mrnNo;
	}

	public int getBillStatus() {
		return billStatus;
	}

	public void setBillStatus(int billStatus) {
		this.billStatus = billStatus;
	}

	@Override
	public String toString() {
		return "GetBillHeader [billId=" + billId + ", billNo=" + billNo + ", billDate=" + billDate + ", vendId="
				+ vendId + ", vendorName=" + vendorName + ", billBasicValue=" + billBasicValue + ", discValue="
				+ discValue + ", billTaxValue=" + billTaxValue + ", totalValue=" + totalValue + ", mrnId=" + mrnId
				+ ", mrnNo=" + mrnNo + ", billStatus=" + billStatus + "]";
	}

}
