package com.ats.tril.model.mrn;

public class MrnDetailForBillBook {

	private int mrnDetailId;
	private int mrnId;
	private String itemCode;
	private String itemName;
	private float mrnQty;
	private float approveQty;

	// PO DETAIL
	private int poId;
	private int itemId;
	private String itemUom;
	private float itemRate;
	private float poMrnQty;
	private float discPer;
	private float discValue;
	private int schDays;
	private String schDate;
	private String schRemark;
	private float basicValue;
	private float packValue;
	private float insu;
	private float otherChargesBefor;
	private float taxValue;
	private String freightValue;
	private float otherChargesAfter;
	private float landingCost;
	private float cgst;
	private float sgst;
	private float igst;

	public int getMrnDetailId() {
		return mrnDetailId;
	}

	public void setMrnDetailId(int mrnDetailId) {
		this.mrnDetailId = mrnDetailId;
	}

	public int getMrnId() {
		return mrnId;
	}

	public void setMrnId(int mrnId) {
		this.mrnId = mrnId;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getPoId() {
		return poId;
	}

	public void setPoId(int poId) {
		this.poId = poId;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemUom() {
		return itemUom;
	}

	public void setItemUom(String itemUom) {
		this.itemUom = itemUom;
	}

	public float getItemRate() {
		return itemRate;
	}

	public void setItemRate(float itemRate) {
		this.itemRate = itemRate;
	}

	public float getMrnQty() {
		return mrnQty;
	}

	public void setMrnQty(float mrnQty) {
		this.mrnQty = mrnQty;
	}

	public float getDiscPer() {
		return discPer;
	}

	public void setDiscPer(float discPer) {
		this.discPer = discPer;
	}

	public float getDiscValue() {
		return discValue;
	}

	public void setDiscValue(float discValue) {
		this.discValue = discValue;
	}

	public int getSchDays() {
		return schDays;
	}

	public void setSchDays(int schDays) {
		this.schDays = schDays;
	}

	public String getSchDate() {
		return schDate;
	}

	public void setSchDate(String schDate) {
		this.schDate = schDate;
	}

	public String getSchRemark() {
		return schRemark;
	}

	public void setSchRemark(String schRemark) {
		this.schRemark = schRemark;
	}

	public float getBasicValue() {
		return basicValue;
	}

	public void setBasicValue(float basicValue) {
		this.basicValue = basicValue;
	}

	public float getPackValue() {
		return packValue;
	}

	public void setPackValue(float packValue) {
		this.packValue = packValue;
	}

	public float getInsu() {
		return insu;
	}

	public void setInsu(float insu) {
		this.insu = insu;
	}

	public float getOtherChargesBefor() {
		return otherChargesBefor;
	}

	public void setOtherChargesBefor(float otherChargesBefor) {
		this.otherChargesBefor = otherChargesBefor;
	}

	public float getTaxValue() {
		return taxValue;
	}

	public void setTaxValue(float taxValue) {
		this.taxValue = taxValue;
	}

	public String getFreightValue() {
		return freightValue;
	}

	public void setFreightValue(String freightValue) {
		this.freightValue = freightValue;
	}

	public float getOtherChargesAfter() {
		return otherChargesAfter;
	}

	public void setOtherChargesAfter(float otherChargesAfter) {
		this.otherChargesAfter = otherChargesAfter;
	}

	public float getLandingCost() {
		return landingCost;
	}

	public void setLandingCost(float landingCost) {
		this.landingCost = landingCost;
	}

	public float getCgst() {
		return cgst;
	}

	public void setCgst(float cgst) {
		this.cgst = cgst;
	}

	public float getSgst() {
		return sgst;
	}

	public void setSgst(float sgst) {
		this.sgst = sgst;
	}

	public float getIgst() {
		return igst;
	}

	public void setIgst(float igst) {
		this.igst = igst;
	}

	public float getApproveQty() {
		return approveQty;
	}

	public void setApproveQty(float approveQty) {
		this.approveQty = approveQty;
	}

	public float getPoMrnQty() {
		return poMrnQty;
	}

	public void setPoMrnQty(float poMrnQty) {
		this.poMrnQty = poMrnQty;
	}

	@Override
	public String toString() {
		return "MrnDetailForBillBook [mrnDetailId=" + mrnDetailId + ", mrnId=" + mrnId + ", itemCode=" + itemCode
				+ ", itemName=" + itemName + ", mrnQty=" + mrnQty + ", approveQty=" + approveQty + ", poId=" + poId
				+ ", itemId=" + itemId + ", itemUom=" + itemUom + ", itemRate=" + itemRate + ", poMrnQty=" + poMrnQty
				+ ", discPer=" + discPer + ", discValue=" + discValue + ", schDays=" + schDays + ", schDate=" + schDate
				+ ", schRemark=" + schRemark + ", basicValue=" + basicValue + ", packValue=" + packValue + ", insu="
				+ insu + ", otherChargesBefor=" + otherChargesBefor + ", taxValue=" + taxValue + ", freightValue="
				+ freightValue + ", otherChargesAfter=" + otherChargesAfter + ", landingCost=" + landingCost + ", cgst="
				+ cgst + ", sgst=" + sgst + ", igst=" + igst + "]";
	}

	
	
}
