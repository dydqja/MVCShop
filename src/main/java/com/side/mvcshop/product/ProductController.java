package com.side.mvcshop.product;

import com.side.mvcshop.common.Page;
import com.side.mvcshop.common.Search;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.io.File;
import java.util.*;

//==>��ǰ���� Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	//Field
	private ProductService productService;
	//setter Method ���� X

	@Autowired
	public ProductController(ProductService productService) {
		System.out.println(this.getClass());

		this.productService = productService;
	}

	@Value("${pageUnit}")
	int pageUnit;
	@Value("${pageSize}")
	int pageSize;

	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct :: GET");

		return "product/addProductView.jsp";
	}

	@RequestMapping( value="addProduct", method=RequestMethod.POST, consumes="multipart/form-data")
	public String addProduct( @ModelAttribute Product product, Model model, HttpServletRequest request ) throws Exception {

		System.out.println("/product/addProduct :: POST");

		System.out.println("client에서 입력받은 product :: [ "+product.toString()+" ]");

		//file upload
		String fileName = null;
		//upload �� file�� �̸��� �����´�.
		System.out.println(product);
		List<MultipartFile> uploadFiles = product.getUploadFiles();
		//upload �� file�� �̸��� empty�� �ƴ϶�� true / empty��� false

		if (!uploadFiles.isEmpty()) {

			List<Map<String,String>> fileList = new ArrayList<>();
			// file ������ġ ����
			String filePath = "C:\\Projects\\MVCShop\\src\\main\\webapp\\views\\images\\uploadFiles";

			for(int i = 0; i<uploadFiles.size(); i++) {

			// getOriginalFilename => form���� ���� ������ ���ϸ� return
			String originalFileName = uploadFiles.get(i).getOriginalFilename();
			// file Ȯ���ڸ� ���ϴ��۾�
			String ext = FilenameUtils.getExtension(originalFileName);
			// UUID ���ϴ��۾�(����id)
//			UUID uuid = UUID.randomUUID();
			// �����̸� = ����id.Ȯ����
//			fileName = uuid.toString()+"."+ext;
			fileName = UUID.randomUUID().toString()+"."+ext;
			//����id.Ȯ���� map���� �ֱ�
			Map<String,String> map = new HashMap<>();
			map.put("fileName", fileName);
			fileList.add(map);
			}
			//transferTo => ���ε� �� ���� data�� ������ ���Ͽ� �����Ѵ�.
			for (int i = 0; i<uploadFiles.size(); i++) {

				uploadFiles.get(i).transferTo(new File(filePath+"\\"+fileList.get(i).get("fileName")));
			}
		}
		product.setFileName(fileName);

		//Business Logic
		productService.addProduct(product);

		//Model �� View ����
		System.out.println(request.getParameter("menu"));
		model.addAttribute("product",product);
		model.addAttribute("menu",request.getParameter("menu"));

		return "/product/readProduct.jsp";
	}

	@RequestMapping( value="getProduct", method=RequestMethod.POST)
	public String getProduct( @RequestParam("prodNo") int prodNo, Model model, HttpServletRequest request ) throws Exception {

		System.out.println("/product/getProduct :: POST");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model �� View ����
		System.out.println("----------------");
		System.out.println(product);
		System.out.println("menu값은? : [ "+request.getParameter("menu")+" ]");

		model.addAttribute("product",product);
		model.addAttribute("menu",request.getParameter("menu"));

		return "/product/updateProduct.jsp";
	}

	@RequestMapping( value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search, HttpServletRequest request, Model model) throws Exception {
		System.out.println("/product/listProduct :: GET/POST");
		System.out.println(request.getParameter("menu"));

		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		//Business logic ����
		Map<String, Object> map=productService.getList(search);
		System.out.println("map = "+map);

		Page resultPage	= new Page( search.getCurrentPage(), (Integer) map.get("totalPage"), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage = ["+resultPage+" ]");
		System.out.println(map.get("list"));

		//Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu",request.getParameter("menu"));
//		model.addAttribute("uri",request.getRequestURI());	==> pageNavigator if�� �������� ����

		return "/product/listProduct.jsp";
	}

	@RequestMapping( value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, HttpServletRequest request) throws Exception {

		System.out.println("/product/updateProduct :: POST");
		System.out.println("updateProduct에서의 prodNo 값은? [ "+request.getParameter("prodNo")+" ]");
		System.out.println("updateProduct에서의 menu 값은? [ "+request.getParameter("menu")+" ]");

		//file upload
		String fileName = null;
		//upload �� file�� �̸��� �����´�.
		List<MultipartFile> uploadFiles = product.getUploadFiles();
		//upload �� file�� �̸��� empty�� �ƴ϶�� true / empty��� false
		if (!uploadFiles.isEmpty()) {

			List<Map<String,String>> fileList = new ArrayList<>();
			// file ������ġ ����
			String filePath = "C:\\work\\fileUpload";

			for(int i = 0; i<uploadFiles.size(); i++) {

			// getOriginalFilename => form���� ���� ������ ���ϸ� return
			String originalFileName = uploadFiles.get(i).getOriginalFilename();
			// file Ȯ���ڸ� ���ϴ��۾�
			String ext = FilenameUtils.getExtension(originalFileName);
			// UUID ���ϴ��۾�(����id)
//			UUID uuid = UUID.randomUUID();
			// �����̸� = ����id.Ȯ����
//			fileName = uuid.toString()+"."+ext;
			fileName = UUID.randomUUID().toString()+"."+ext;
			//����id.Ȯ���� map���� �ֱ�
			Map<String,String> map = new HashMap<>();
			map.put("fileName", fileName);
			fileList.add(map);
			}
			//transferTo => ���ε� �� ���� data�� ������ ���Ͽ� �����Ѵ�.
			for (int i = 0; i<uploadFiles.size(); i++) {

				uploadFiles.get(i).transferTo(new File(filePath+"\\"+fileList.get(i).get("fileName")));
			}
		}
		product.setFileName(fileName);

		//Business logic
		productService.updateProduct(product);

//		model.addAttribute("product", product);

		return "forward:/product/getProduct";
	}

	@RequestMapping( value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo, Model model, HttpServletRequest request ) throws Exception {

		System.out.println("/product/updateProduct :: GET");
		System.out.println("prodNo = " + prodNo);
		System.out.println("menu = " + request.getParameter("menu"));
		//Business logic
		Product product = productService.getProduct(prodNo);
		//Model �� View ����
		model.addAttribute("product", product);
		model.addAttribute("menu", request.getParameter("menu"));

		String menu = request.getParameter("menu");

		if (menu.equals("manage")) {
			System.out.println("manage if문 내부");
			return "/product/updateProductView.jsp";

		} else if (menu.equals("search")) {
			System.out.println("search if문 내부");
			return "/product/updateProduct.jsp";

		}

		return null;
	}

}
