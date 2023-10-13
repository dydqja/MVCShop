package com.side.mvcshop.purchase;

import com.side.mvcshop.common.Search;

import java.util.Map;

public interface PurchaseService {

    //상품구매
    public void addPurchase(Purchase purchase) throws Exception;

    //구매리스트
    public Map<String, Object> getList(Search search) throws Exception;

    public Map<String, Object> getSaleList(Search search) throws Exception;
}
