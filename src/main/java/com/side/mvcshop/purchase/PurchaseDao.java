package com.side.mvcshop.purchase;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseDao {

    public void addPurchase(Purchase purchase) throws Exception;
}
