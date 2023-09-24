package com.side.mvcshop.product;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;


//==>��ǰ������ �𵨸�(�߻�ȭ/ĸ��ȭ)�� Bean
public class Product {

	//Field
	private int prodNo;
	private int price;
	private String fileName;
	private String manuDate;
	private String prodDetail;
	private String prodName;
	private String proTranCode;
	private Timestamp regDate;
	// JSON ==> Domain Object  Binding�� ���� �߰��� �κ�
	private String regDateString;
	// fileUpload �߰� �κ�(����)
	private MultipartFile uploadFile;
	// fileUpload �߰� �κ�(����)
	private List<MultipartFile> uploadFiles;



	//Constructor
	public Product(){
	}

	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate.replaceAll("-","");
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	// JSON ==> Domain Object  Binding�� ���� �߰�
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;

		if(regDate !=null) {
			// JSON ==> Domain Object  Binding�� ���� �߰��� �κ�
			this.setRegDateString( regDate.toString().split("-")[0]
													+"-"+ regDate.toString().split("-")[1]
													+"-"+ regDate.toString().split("-")[2] );
		}
	}
	public String getRegDateString() {
		return regDateString;
	}

	public void setRegDateString(String regDateString) {
		this.regDateString = regDateString;
	}

	@Override
	public String toString() {
		return "Product : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[regDateString]" + regDateString;
	}

	//fileUpload �߰��κ�(����)
	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	//fileUpload �߰��κ�(����)
	public List<MultipartFile> getUploadFiles() {
		System.out.println("���������ߤѤ�11111"+uploadFiles);
		return uploadFiles;
	}

	public void setUploadFiles(List<MultipartFile> uploadFiles) {
		this.uploadFiles = uploadFiles;
		System.out.println("���������ߤѤ�"+uploadFiles);
	}

}
