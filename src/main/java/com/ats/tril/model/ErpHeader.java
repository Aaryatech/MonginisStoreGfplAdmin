package com.ats.tril.model;


public class ErpHeader {
	
	private int mrnId; 
	private String mrnDate; 
	private String MrnNo; 
	private String BillNo; 
	private String Billdate; 
	private int MrnStatus;
	private int vendorId; 
	private String vendorName; 
	
	
	public int getMrnId() {
		return mrnId;
	}
	public void setMrnId(int mrnId) {
		this.mrnId = mrnId;
	}
	public String getMrnDate() {
		return mrnDate;
	}
	public void setMrnDate(String mrnDate) {
		this.mrnDate = mrnDate;
	}
	public String getMrnNo() {
		return MrnNo;
	}
	public void setMrnNo(String mrnNo) {
		MrnNo = mrnNo;
	}
	
	public String getBillNo() {
		return BillNo;
	}
	public void setBillNo(String billNo) {
		BillNo = billNo;
	}
	public String getBilldate() {
		return Billdate;
	}
	public void setBilldate(String billdate) {
		Billdate = billdate;
	}
	public int getMrnStatus() {
		return MrnStatus;
	}
	public void setMrnStatus(int mrnStatus) {
		MrnStatus = mrnStatus;
	}
    
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	
	
	@Override
	public String toString() {
		return "ERPHeader [mrnId=" + mrnId + ", mrnDate=" + mrnDate + ", MrnNo=" + MrnNo +" BillNo=" + BillNo + ", Billdate=" + Billdate + ", MrnStatus=" + MrnStatus + ", vendorid="
				+ vendorId + ", vendorName=" + vendorName + "]";
	}

}
