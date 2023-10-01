package com.side.mvcshop.product;

import com.side.mvcshop.common.Page;
import com.side.mvcshop.common.Search;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

	//InfiniteScroll 추가
	@RequestMapping( value="/json/listProduct", method=RequestMethod.GET)
	public List<Object> listProduct( @ModelAttribute("currentPage") int currentPage, Search search, Model model, HttpServletRequest request) throws Exception {
		System.out.println("/product/json/listProduct :: GET");
		System.out.println("currentPage 값은? [ "+currentPage+" ]");
		String menu = request.getParameter("menu");

		if(currentPage == 0) {
			System.out.println("currentPage 값이 0이라 1로 바꿈.");
			search.setCurrentPage(1);
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);

		//Business logic
		Map<String, Object> map = productService.getList(search);
		System.out.println("map 안에 key값들 = "+map.keySet());
		List<Object> prodmenu = new ArrayList<>();
		prodmenu.add(map.get("list"));
		prodmenu.add(menu);


		Page resultPage	= new Page( search.getCurrentPage(), (Integer) map.get("totalPage"), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println(map.get("list"));

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return prodmenu;

	}


}
