package com.beans;

import java.util.ArrayList;

public class NewCustDataBean {
	
	public String operatingSystem;
	public String environment;
	public int dbNo;
	public String prodType;
	public double prodPrice;
	public double totPrice;
	public double prodSuppCost;
	public double optSuppCost;
	ArrayList<String> optCost = new ArrayList<String>();
	ArrayList<String> optInstalled = new ArrayList<String>();
	
	
	public String getOperatingSystem() {
		return operatingSystem;
	}
	public void setOperatingSystem(String operatingSystem) {
		this.operatingSystem = operatingSystem;
	}
	public String getEnvironment() {
		return environment;
	}
	public void setEnvironment(String environment) {
		this.environment = environment;
	}
	public int getDbNo() {
		return dbNo;
	}
	public void setDbNo(int dbNo) {
		this.dbNo = dbNo;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public double getProdPrice() {
		return prodPrice;
	}
	public void setProdPrice(double prodPrice) {
		this.prodPrice = prodPrice;
	}
	public double getTotPrice() {
		return totPrice;
	}
	public void setTotPrice(double totPrice) {
		this.totPrice = totPrice;
	}
	public ArrayList<String> getOptCost() {
		return optCost;
	}
	public void setOptCost(ArrayList<String> optCost) {
		this.optCost = optCost;
	}
	public ArrayList<String> getOptInstalled() {
		return optInstalled;
	}
	public void setOptInstalled(ArrayList<String> optInstalled) {
		this.optInstalled = optInstalled;
	}
	
	public double getProdSuppCost() {
		return prodSuppCost;
	}
	public void setProdSuppCost(double prodSuppCost) {
		this.prodSuppCost = prodSuppCost;
	}
	public double getOptSuppCost() {
		return optSuppCost;
	}
	public void setOptSuppCost(double optSuppCost) {
		this.optSuppCost = optSuppCost;
	}
	
	
	public NewCustDataBean(String operatingSystem, String environment, int dbNo, String prodType, double prodPrice,
			double totPrice, double prodSuppCost, double optSuppCost, ArrayList<String> optCost,
			ArrayList<String> optInstalled) {
		super();
		this.operatingSystem = operatingSystem;
		this.environment = environment;
		this.dbNo = dbNo;
		this.prodType = prodType;
		this.prodPrice = prodPrice;
		this.totPrice = totPrice;
		this.prodSuppCost = prodSuppCost;
		this.optSuppCost = optSuppCost;
		this.optCost = optCost;
		this.optInstalled = optInstalled;
	}
	
	public NewCustDataBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "NewCustDataBean [operatingSystem=" + operatingSystem + ", environment=" + environment + ", dbNo=" + dbNo
				+ ", prodType=" + prodType + ", prodPrice=" + prodPrice + ", totPrice=" + totPrice + ", prodSuppCost="
				+ prodSuppCost + ", optSuppCost=" + optSuppCost + ", optCost=" + optCost + ", optInstalled="
				+ optInstalled + "]";
	}
	
	

}
