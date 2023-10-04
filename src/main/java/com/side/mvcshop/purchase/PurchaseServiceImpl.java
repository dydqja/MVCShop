package com.side.mvcshop.purchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{

    //Field
    private PurchaseDao purchaseDao;

    //Constructor
    @Autowired
    public PurchaseServiceImpl(PurchaseDao purchaseDao) {
        System.out.println(this.getClass());

        this.purchaseDao = purchaseDao;
    }

    //Method
    @Override
    public void addPurchase(Purchase purchase) throws Exception {
        System.out.println("PurchaseServiceImpl에서 addPurchase 실행됨");

        String date = purchase.getDlvyDate();
        purchase.setDlvyAddr(removeHyphen(date));


        purchaseDao.addPurchase(purchase);

    }

    //dlvyDate '-' 빼기
    public String removeHyphen(String date) throws Exception {

        return date.replace("-","");
    }
}
