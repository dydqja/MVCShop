package com.side.mvcshop.purchase;

import com.side.mvcshop.common.Search;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Value("${pageSize}")
    int pageSize;

    //Method
    @Override
    public void addPurchase(Purchase purchase) throws Exception {
        System.out.println("PurchaseServiceImpl에서 addPurchase 실행됨");

        String date = purchase.getDlvyDate();
        String updateDate = removeHyphen(date);
        System.out.println(updateDate);
        purchase.setDlvyDate(updateDate);


        purchaseDao.addPurchase(purchase);

    }

    @Override
    public Map<String, Object> getList(Search search) throws Exception {
        System.out.println("PurchaseServiceImpl에서 getList 실행됨");

        List<Purchase> list = purchaseDao.getList(search);
        int totalCount = purchaseDao.getTotalCount(search);

        int totalPage = totalCount / pageSize;

        if(totalCount%9 != 0) {
            totalPage++;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("totalCount", totalCount);
        map.put("totalPage", totalPage);

        return map;
    }

    @Override
    public Map<String, Object> getSaleList(Search search) throws Exception {
        System.out.println("PurchaseServiceImpl에서 getSaleList 실행됨");

        List<Purchase> list = purchaseDao.getSaleList(search);
        int totalCount = purchaseDao.getTotalCount(search);

        int totalPage = totalCount / pageSize;

        if(totalCount%9 != 0) {
            totalPage++;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("totalCount", totalCount);
        map.put("totalPage", totalPage);

        return map;
    }

    //dlvyDate '-' 빼기
    public String removeHyphen(String date) throws Exception {

        return date.replace("-","");
    }
}
