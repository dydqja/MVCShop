package com.side.mvcshop.purchase;

import com.side.mvcshop.product.Product;
import com.side.mvcshop.product.ProductService;
import com.side.mvcshop.user.User;
import com.side.mvcshop.user.UserService;
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
    private UserService userService;

    //Constructor
    @Autowired
    public PurchaseController(PurchaseService purchaseService, ProductService productService, UserService userService) {
        System.out.println(this.getClass());

        this.purchaseService = purchaseService;
        this.productService = productService;
        this.userService = userService;
    }

    //method
    @RequestMapping(value = "addPurchase", method = RequestMethod.GET)
    public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

        System.out.println("/purchase/addPurchase :: GET");

        Product product = productService.getProduct(prodNo);

        model.addAttribute("product",product);

        return "/purchase/addPurchaseView.jsp";
    }

    @RequestMapping(value = "addPurchase", method = RequestMethod.POST)
    public void addPurchase(@ModelAttribute("purchase") Purchase purchase,
                              @RequestParam("prodNo") int prodNo,
                              @RequestParam("buyerId") String userId) throws Exception {

        System.out.println("/purchase/addPurchase :: POST");
        System.out.println("판매상품번호 = [ "+prodNo+" ]");
        System.out.println("구매자아이디 = [ "+userId+" ]");
        System.out.println("판매상품정보 = [ "+purchase.toString()+" ]");

        if(purchase.getTranCode() == null || purchase.getTranCode() == "") {
            purchase.setTranCode("배송전");
        }

        User user = userService.getUser(userId);
        Product product = productService.getProduct(prodNo);

        purchase.setBuyer(user);
        purchase.setPurchaseProd(product);

        purchaseService.addPurchase(purchase);

    }


}
