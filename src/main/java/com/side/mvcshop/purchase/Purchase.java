package com.side.mvcshop.purchase;

import com.side.mvcshop.product.Product;
import com.side.mvcshop.user.User;

import java.util.Date;

public class Purchase {

    private User buyer; //구매자 정보
    private String dlvyAddr; //배송지 주소
    private String dlvyDate; //배송 희망 날짜
    private String dlvyRequest; //배송시 요구사항
    private Date orderDate; //구매 일자
    private String paymentOption; //지불 방식
    private Product purchaseProd; //구매 물품 정보
    private String receiverName; //받는사람 이름
    private String receiverPhone; //받는사람 전화번호
    private String tranCode; //구매상태 코드
    private int tranNo; //구매 번호

    public Purchase() {

    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public String getDlvyAddr() {
        return dlvyAddr;
    }

    public void setDlvyAddr(String dlvyAddr) {
        this.dlvyAddr = dlvyAddr;
    }

    public String getDlvyDate() {
        return dlvyDate;
    }

    public void setDlvyDate(String dlvyDate) {
        this.dlvyDate = dlvyDate;
    }

    public String getDlvyRequest() {
        return dlvyRequest;
    }

    public void setDlvyRequest(String dlvyRequest) {
        this.dlvyRequest = dlvyRequest;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getPaymentOption() {
        return paymentOption;
    }

    public void setPaymentOption(String paymentOption) {
        this.paymentOption = paymentOption;
    }

    public Product getPurchaseProd() {
        return purchaseProd;
    }

    public void setPurchaseProd(Product purchaseProd) {
        this.purchaseProd = purchaseProd;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getTranCode() {
        return tranCode;
    }

    public void setTranCode(String tranCode) {
        this.tranCode = tranCode;
    }

    public int getTranNo() {
        return tranNo;
    }

    public void setTranNo(int tranNo) {
        this.tranNo = tranNo;
    }

    @Override
    public String toString() {
        return "Purchase{" +
                "buyer=" + buyer +
                ", dlvyAddr='" + dlvyAddr + '\'' +
                ", dlvyDate='" + dlvyDate + '\'' +
                ", dlvyRequest='" + dlvyRequest + '\'' +
                ", orderDate=" + orderDate +
                ", paymentOption='" + paymentOption + '\'' +
                ", purchaseProd=" + purchaseProd +
                ", receiverName='" + receiverName + '\'' +
                ", receiverPhone='" + receiverPhone + '\'' +
                ", tranCode='" + tranCode + '\'' +
                ", tranNo=" + tranNo +
                '}';
    }
}
