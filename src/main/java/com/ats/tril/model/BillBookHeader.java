package com.ats.tril.model;

import java.util.List;


public class BillBookHeader {

	private int billId;
	private int billType;
	private String billNo;
	private String billDate;
	private int vendId;
	private String vendQuation;
	private String vendQuationDate;
	private float billBasicValue;
	private float discValue;
	private int billTaxId;
	private float billTaxPer;
	private float billTaxValue;
	private float billPackPer;
	private float billPackVal;
	private String billPackRemark;
	private float billInsuPer;
	private float billInsuVal;
	private String billInsuRemark;
	private float billFrtPer;
	private float billFrtVal;
	private String billFrtRemark;
	private float otherChargeBefore;
	private String otherChargeBeforeRemark;
	private float otherChargeAfter;
	private String otherChargeAfterRemark;
	private float totalValue;
	private int deliveryId;
	private int dispatchId;
	private int paymentTermId;
	private String billRemark;
	private int billStatus;
	private int prnStatus;
	private int prnCopies;
	private int mrnId;
	private String mrnNo;
	private int userId;
	private int delStatus;
	private int approvStatus;

	List<BillBookDetail> billBookDetail;
	
	

	public BillBookHeader() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	

	public BillBookHeader(int billId, int billType, String billNo, String billDate, int vendId, String vendQuation,
			String vendQuationDate, float billBasicValue, float discValue, int billTaxId, float billTaxPer,
			float billTaxValue, float billPackPer, float billPackVal, String billPackRemark, float billInsuPer,
			float billInsuVal, String billInsuRemark, float billFrtPer, float billFrtVal, String billFrtRemark,
			float otherChargeBefore, String otherChargeBeforeRemark, float otherChargeAfter,
			String otherChargeAfterRemark, float totalValue, int deliveryId, int dispatchId, int paymentTermId,
			String billRemark, int billStatus, int prnStatus, int prnCopies, int mrnId, String mrnNo, int userId,
			int delStatus, int approvStatus, List<BillBookDetail> billBookDetail) {
		super();
		this.billId = billId;
		this.billType = billType;
		this.billNo = billNo;
		this.billDate = billDate;
		this.vendId = vendId;
		this.vendQuation = vendQuation;
		this.vendQuationDate = vendQuationDate;
		this.billBasicValue = billBasicValue;
		this.discValue = discValue;
		this.billTaxId = billTaxId;
		this.billTaxPer = billTaxPer;
		this.billTaxValue = billTaxValue;
		this.billPackPer = billPackPer;
		this.billPackVal = billPackVal;
		this.billPackRemark = billPackRemark;
		this.billInsuPer = billInsuPer;
		this.billInsuVal = billInsuVal;
		this.billInsuRemark = billInsuRemark;
		this.billFrtPer = billFrtPer;
		this.billFrtVal = billFrtVal;
		this.billFrtRemark = billFrtRemark;
		this.otherChargeBefore = otherChargeBefore;
		this.otherChargeBeforeRemark = otherChargeBeforeRemark;
		this.otherChargeAfter = otherChargeAfter;
		this.otherChargeAfterRemark = otherChargeAfterRemark;
		this.totalValue = totalValue;
		this.deliveryId = deliveryId;
		this.dispatchId = dispatchId;
		this.paymentTermId = paymentTermId;
		this.billRemark = billRemark;
		this.billStatus = billStatus;
		this.prnStatus = prnStatus;
		this.prnCopies = prnCopies;
		this.mrnId = mrnId;
		this.mrnNo = mrnNo;
		this.userId = userId;
		this.delStatus = delStatus;
		this.approvStatus = approvStatus;
		this.billBookDetail = billBookDetail;
	}




	public int getBillId() {
		return billId;
	}

	public void setBillId(int billId) {
		this.billId = billId;
	}

	public int getBillType() {
		return billType;
	}

	public void setBillType(int billType) {
		this.billType = billType;
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

	public String getVendQuation() {
		return vendQuation;
	}

	public void setVendQuation(String vendQuation) {
		this.vendQuation = vendQuation;
	}

	public String getVendQuationDate() {
		return vendQuationDate;
	}

	public void setVendQuationDate(String vendQuationDate) {
		this.vendQuationDate = vendQuationDate;
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

	public int getBillTaxId() {
		return billTaxId;
	}

	public void setBillTaxId(int billTaxId) {
		this.billTaxId = billTaxId;
	}

	public float getBillTaxPer() {
		return billTaxPer;
	}

	public void setBillTaxPer(float billTaxPer) {
		this.billTaxPer = billTaxPer;
	}

	public float getBillTaxValue() {
		return billTaxValue;
	}

	public void setBillTaxValue(float billTaxValue) {
		this.billTaxValue = billTaxValue;
	}

	public float getBillPackPer() {
		return billPackPer;
	}

	public void setBillPackPer(float billPackPer) {
		this.billPackPer = billPackPer;
	}

	public float getBillPackVal() {
		return billPackVal;
	}

	public void setBillPackVal(float billPackVal) {
		this.billPackVal = billPackVal;
	}

	public String getBillPackRemark() {
		return billPackRemark;
	}

	public void setBillPackRemark(String billPackRemark) {
		this.billPackRemark = billPackRemark;
	}

	public float getBillInsuPer() {
		return billInsuPer;
	}

	public void setBillInsuPer(float billInsuPer) {
		this.billInsuPer = billInsuPer;
	}

	public float getBillInsuVal() {
		return billInsuVal;
	}

	public void setBillInsuVal(float billInsuVal) {
		this.billInsuVal = billInsuVal;
	}

	public String getBillInsuRemark() {
		return billInsuRemark;
	}

	public void setBillInsuRemark(String billInsuRemark) {
		this.billInsuRemark = billInsuRemark;
	}

	public float getBillFrtPer() {
		return billFrtPer;
	}

	public void setBillFrtPer(float billFrtPer) {
		this.billFrtPer = billFrtPer;
	}

	public float getBillFrtVal() {
		return billFrtVal;
	}

	public void setBillFrtVal(float billFrtVal) {
		this.billFrtVal = billFrtVal;
	}

	public String getBillFrtRemark() {
		return billFrtRemark;
	}

	public void setBillFrtRemark(String billFrtRemark) {
		this.billFrtRemark = billFrtRemark;
	}

	public float getOtherChargeBefore() {
		return otherChargeBefore;
	}

	public void setOtherChargeBefore(float otherChargeBefore) {
		this.otherChargeBefore = otherChargeBefore;
	}

	public String getOtherChargeBeforeRemark() {
		return otherChargeBeforeRemark;
	}

	public void setOtherChargeBeforeRemark(String otherChargeBeforeRemark) {
		this.otherChargeBeforeRemark = otherChargeBeforeRemark;
	}

	public float getOtherChargeAfter() {
		return otherChargeAfter;
	}

	public void setOtherChargeAfter(float otherChargeAfter) {
		this.otherChargeAfter = otherChargeAfter;
	}

	public String getOtherChargeAfterRemark() {
		return otherChargeAfterRemark;
	}

	public void setOtherChargeAfterRemark(String otherChargeAfterRemark) {
		this.otherChargeAfterRemark = otherChargeAfterRemark;
	}

	public float getTotalValue() {
		return totalValue;
	}

	public void setTotalValue(float totalValue) {
		this.totalValue = totalValue;
	}

	public int getDeliveryId() {
		return deliveryId;
	}

	public void setDeliveryId(int deliveryId) {
		this.deliveryId = deliveryId;
	}

	public int getDispatchId() {
		return dispatchId;
	}

	public void setDispatchId(int dispatchId) {
		this.dispatchId = dispatchId;
	}

	public int getPaymentTermId() {
		return paymentTermId;
	}

	public void setPaymentTermId(int paymentTermId) {
		this.paymentTermId = paymentTermId;
	}

	public String getBillRemark() {
		return billRemark;
	}

	public void setBillRemark(String billRemark) {
		this.billRemark = billRemark;
	}

	public int getBillStatus() {
		return billStatus;
	}

	public void setBillStatus(int billStatus) {
		this.billStatus = billStatus;
	}

	public int getPrnStatus() {
		return prnStatus;
	}

	public void setPrnStatus(int prnStatus) {
		this.prnStatus = prnStatus;
	}

	public int getPrnCopies() {
		return prnCopies;
	}

	public void setPrnCopies(int prnCopies) {
		this.prnCopies = prnCopies;
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

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getDelStatus() {
		return delStatus;
	}

	public void setDelStatus(int delStatus) {
		this.delStatus = delStatus;
	}

	public int getApprovStatus() {
		return approvStatus;
	}

	public void setApprovStatus(int approvStatus) {
		this.approvStatus = approvStatus;
	}

	public List<BillBookDetail> getBillBookDetail() {
		return billBookDetail;
	}

	public void setBillBookDetail(List<BillBookDetail> billBookDetail) {
		this.billBookDetail = billBookDetail;
	}

	@Override
	public String toString() {
		return "BillBookHeader [billId=" + billId + ", billType=" + billType + ", billNo=" + billNo + ", billDate="
				+ billDate + ", vendId=" + vendId + ", vendQuation=" + vendQuation + ", vendQuationDate="
				+ vendQuationDate + ", billBasicValue=" + billBasicValue + ", discValue=" + discValue + ", billTaxId="
				+ billTaxId + ", billTaxPer=" + billTaxPer + ", billTaxValue=" + billTaxValue + ", billPackPer="
				+ billPackPer + ", billPackVal=" + billPackVal + ", billPackRemark=" + billPackRemark + ", billInsuPer="
				+ billInsuPer + ", billInsuVal=" + billInsuVal + ", billInsuRemark=" + billInsuRemark + ", billFrtPer="
				+ billFrtPer + ", billFrtVal=" + billFrtVal + ", billFrtRemark=" + billFrtRemark
				+ ", otherChargeBefore=" + otherChargeBefore + ", otherChargeBeforeRemark=" + otherChargeBeforeRemark
				+ ", otherChargeAfter=" + otherChargeAfter + ", otherChargeAfterRemark=" + otherChargeAfterRemark
				+ ", totalValue=" + totalValue + ", deliveryId=" + deliveryId + ", dispatchId=" + dispatchId
				+ ", paymentTermId=" + paymentTermId + ", billRemark=" + billRemark + ", billStatus=" + billStatus
				+ ", prnStatus=" + prnStatus + ", prnCopies=" + prnCopies + ", mrnId=" + mrnId + ", mrnNo=" + mrnNo
				+ ", userId=" + userId + ", delStatus=" + delStatus + ", approvStatus=" + approvStatus
				+ ", billBookDetail=" + billBookDetail + "]";
	}

	
}
