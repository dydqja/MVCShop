package com.side.mvcshop.purchase;

import com.side.mvcshop.common.Search;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface PurchaseDao {

    public void addPurchase(Purchase purchase) throws Exception;

    public List<Purchase> getList(Search search) throws Exception;

    public int getTotalCount(Search search) throws Exception;

    public List<Purchase> getSaleList(Search search) throws Exception;

    public void updateTranCode(Map<String,Object> map) throws Exception;

    public Purchase getPurchase(int ProdNo) throws Exception;

}
