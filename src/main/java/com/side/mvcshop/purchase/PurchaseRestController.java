package com.side.mvcshop.purchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

    //Field
    private PurchaseService purchaseService;

    //Constructor
    @Autowired
    public PurchaseRestController(PurchaseService purchaseService) {
        System.out.println(this.getClass());

        this.purchaseService = purchaseService;
    }

    //method
    @RequestMapping(value = "json/updateTranCode", method = RequestMethod.POST)
    public Purchase updateTranCode(@RequestBody Map<String, Object> request) throws Exception {
        System.out.println("/purchase/json/updateTranCode :: POST");

        int prodNo = (int)request.get("prodNo");
        String tranCode = (String)request.get("tranCode");
        System.out.println("prodNo= "+prodNo+" / tranCode= "+tranCode);

        Map<String, Object> map = new HashMap<>();
        map.put("prodNo", prodNo);
        map.put("tranCode", tranCode);

        //해당 ProdNo에 해당되는 상품 tranCode 변경하고 구매정보 가져오기
        Purchase updateProd = purchaseService.updateTranCode(map);

        System.out.println(updateProd);

        return updateProd;


    }
}
