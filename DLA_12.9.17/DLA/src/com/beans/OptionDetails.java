package com.beans;

import java.util.Comparator;
import java.util.Date;

public class OptionDetails implements Comparable<OptionDetails> {
	
	
	private double productCost;
	private double totalCost;
	private String optionName;
	private String lastUsed;
	private String currentStatus;
	private double supportCost;
	private String prodType;
	private double licCount;
	
	public double getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}
	public double getProductCost() {
		return productCost;
	}
	public void setProductCost(double productCost) {
		this.productCost = productCost;
	}
	private String machineName;
	public OptionDetails(double productCost, double totalCost, String machineName, String optionName, String lastUsed,
			String currentStatus, double supportCost, String prodType, double licCount) {
		super();
		this.productCost = productCost;
		this.totalCost = totalCost;
		this.machineName = machineName;
		this.optionName = optionName;
		this.lastUsed = lastUsed;
		this.currentStatus = currentStatus;
		this.supportCost = supportCost;
		this.prodType = prodType;
		this.licCount = licCount;
	}
	public String getMachineName() {
		return machineName;
	}
	public void setMachineName(String machineName) {
		this.machineName = machineName;
	}

	public double getLicCount() {
		return licCount;
	}
	public void setLicCount(double licCount2) {
		this.licCount = licCount2;
	}
	public String getProdType() {
		return prodType;
	}
	public void setProdType(String prodType) {
		this.prodType = prodType;
	}
	public String getOptionName() {
		return optionName;
	}
	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	public String getLastUsed() {
		return lastUsed;
	}
	public void setLastUsed(String lastUsed) {
		this.lastUsed = lastUsed;
	}
	public String getCurrentStatus() {
		return currentStatus;
	}
	public void setCurrentStatus(String currentStatus) {
		this.currentStatus = currentStatus;
	}
	public double getSupportCost() {
		return supportCost;
	}
	public void setSupportCost(double supportCost) {
		this.supportCost = supportCost;
	}
	
	@Override
	public String toString() {
		return "OptionDetails [productCost=" + productCost + ", totalCost=" + totalCost + ", machineName=" + machineName
				+ ", optionName=" + optionName + ", lastUsed=" + lastUsed + ", currentStatus=" + currentStatus
				+ ", supportCost=" + supportCost + ", prodType=" + prodType + ", licCount=" + licCount + "]";
	}

	public OptionDetails() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public int compareTo(OptionDetails op1) {
		// TODO Auto-generated method stub
		return this.getCurrentStatus().length()-op1.getCurrentStatus().length();
	}
	
	
	
	
	
	
}
