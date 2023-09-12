package com.side.mvcshop.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


//==>��ǰ���� Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	//Field
	private ProductService productService;
	//setter Method ���� X

	@Autowired
	public ProductRestController(ProductService productService) {
		System.out.println(this.getClass());

		this.productService = productService;
	}

	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;

//	 ��ǰ������δ� ajax �Ⱦ��Ͱ���
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST)
	public void addProduct( @RequestBody Product product, Model model, HttpServletRequest request ) throws Exception {


		System.out.println("/product/json/addProduct :: POST");
		//Business Logic
		productService.addProduct(product);
		//Model �� View ����
//		System.out.println(request.getParameter("menu"));
//		model.addAttribute("product",product);
//		model.addAttribute("menu",request.getParameter("menu"));

//		return "forward:/product/readProduct.jsp";
	}


	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct( @PathVariable int prodNo ) throws Exception {

		System.out.println("/product/json/getProduct :: GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model �� View ����
		System.out.println("----------------");
		System.out.println(product);
//		model.addAttribute("product",product);
//		model.addAttribute("menu",request.getParameter("menu"));

//		return "forward:/product/updateProduct.jsp";
		return productService.getProduct(prodNo);
	}

	//AutoComplete �߰��κ�
	@RequestMapping( value="/json/autoComplete", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> autoComplete(@RequestParam Map<String, Object> paramMap) throws Exception {

		System.out.println("/product/json/autoComplete :: POST");

		List<Map<String,Object>> acList = productService.autoComplete(paramMap);
		paramMap.put("acList", acList);

		return paramMap;
	}

	/*
	@RequestMapping("listProduct")
	public String listProduct( @ModelAttribute("search") Search search, HttpServletRequest request, Model model) throws Exception {
		System.out.println("-------------------------------------");
		System.out.println(request.getParameter("menu"));

		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		//Business logic ����
		Map<String, Object> map=productService.getList(search);

		Page resultPage	= new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		//Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu",request.getParameter("menu"));
//		model.addAttribute("uri",request.getRequestURI());	==> pageNavigator if�� �������� ����

		return "forward:/product/listProduct.jsp";
	}
	*/
	/*
	@RequestMapping("updateProduct")
	public String updateProduct( @ModelAttribute("product") Product product, HttpServletRequest request) throws Exception {

		System.out.println("/product/updateProduct");
		//Business logic
		productService.updateProduct(product);

//		model.addAttribute("product", product);

		return "forward:/product/getProduct";
	}

	@RequestMapping("updateProductView")
	public String updateProductView( @RequestParam("prodNo") int prodNo, Model model, HttpServletRequest request ) throws Exception {

		System.out.println("/product/updateProductView");
		//Business logic
		Product product = productService.getProduct(prodNo);
		//Model �� View ����
		model.addAttribute("product",product);
		model.addAttribute("menu",request.getParameter("menu"));

		return "forward:/product/updateProductView.jsp";
	}
	*/
}
