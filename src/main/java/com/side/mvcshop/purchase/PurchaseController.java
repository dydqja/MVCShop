package com.side.mvcshop.purchase;

import com.side.mvcshop.common.Page;
import com.side.mvcshop.common.Search;
import com.side.mvcshop.product.Product;
import com.side.mvcshop.product.ProductService;
import com.side.mvcshop.user.User;
import com.side.mvcshop.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

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

    @Value("${pageUnit}")
    int pageUnit;
    @Value("${pageSize}")
    int pageSize;

    //method
    @RequestMapping(value = "addPurchase", method = RequestMethod.GET)
    public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

        System.out.println("/purchase/addPurchase :: GET");

        Product product = productService.getProduct(prodNo);

        model.addAttribute("product",product);

        return "/purchase/addPurchaseView.jsp";
    }

    @RequestMapping(value = "addPurchase", method = RequestMethod.POST)
    public String addPurchase(@ModelAttribute("purchase") Purchase purchase,
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

        return "/purchase/listPurchaseView.jsp";

    }

    @RequestMapping(value = "listPurchase")
    public String listPurchase(@ModelAttribute("search") Search search, HttpServletRequest request, Model model) throws Exception {
        System.out.println("/purchase/listPurchase :: GET/POST");

        if(search.getCurrentPage() == 0) {
            search.setCurrentPage(1);
        }

        search.setPageSize(pageSize);

        Map<String, Object> map = purchaseService.getList(search);

        Page resultPage = new Page( search.getCurrentPage(), (Integer)map.get("totalPage"), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("resultPage", resultPage);
        model.addAttribute("search", search);

        return "/purchase/listPurchase.jsp";
    }


}
