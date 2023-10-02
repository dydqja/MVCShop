package com.side.mvcshop.purchase;

import com.side.mvcshop.product.Product;
import com.side.mvcshop.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

    //Field
    private PurchaseService purchaseService;
    private ProductService productService;

    //Constructor
    @Autowired
    public PurchaseController(PurchaseService purchaseService, ProductService productService) {
        System.out.println(this.getClass());

        this.purchaseService = purchaseService;
        this.productService = productService;
    }

    //method
    @RequestMapping(value = "addPurchase", method = RequestMethod.GET)
    public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

        System.out.println("/purchase/addPurchase :: GET");

        Product product = productService.getProduct(prodNo);

        model.addAttribute("product",product);

        return "/purchase/addPurchaseView.jsp";
    }


}
