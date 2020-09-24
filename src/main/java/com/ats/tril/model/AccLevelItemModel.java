package com.ats.tril.model;

public class AccLevelItemModel {

	private int id;
	private float rate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public float getRate() {
		return rate;
	}

	public void setRate(float rate) {
		this.rate = rate;
	}

	@Override
	public String toString() {
		return "AccLevelItemModel [id=" + id + ", rate=" + rate + "]";
	}

}
