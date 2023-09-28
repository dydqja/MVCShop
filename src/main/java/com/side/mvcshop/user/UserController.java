package com.side.mvcshop.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ch.qos.logback.core.CoreConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.side.mvcshop.common.Page;
import com.side.mvcshop.common.Search;
import com.side.mvcshop.user.User;
import com.side.mvcshop.user.UserService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/user/*")
public class UserController {

	///Field
	private UserService userService;

	//Constructor
	@Autowired
	public UserController(UserService userService){
		System.out.println(this.getClass());

		this.userService = userService;
	}

	@Value("${pageUnit}")
	int pageUnit;
	@Value("${pageSize}")
	int pageSize;

	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{

		System.out.println("/user/addUser : GET");

		return "/user/addUserView.jsp";
	}

	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);

		return "/user/loginView.jsp";
	}


	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {

		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);

		return "user/getUser.jsp";
	}


	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);

		return "/user/updateUser.jsp";
	}

	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		User updateUser = userService.getUser(user.getUserId());

		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(updateUser.getUserId())){
			session.setAttribute("user", updateUser);
			System.out.println("session에 담긴 user정보 = : [ "+updateUser+" ]");
		}

		return "/user/getUser.jsp";
	}


	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{

		System.out.println("/user/login : GET");

		return "user/loginView.jsp";
	}

	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{

		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());

		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			System.out.println("session에 담긴 user정보 = : [ "+dbUser+" ]");
		}

		return "/main.jsp";
	}


	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{

		System.out.println("/user/logout : POST");

		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping( value="checkDuplication", method=RequestMethod.GET)
	public String checkDuplication() throws Exception {
		System.out.println("/user/checkDuplication : GET");

		return "/user/checkDuplication.jsp";
	}


	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		System.out.println("111111111111111111111111111111111111111111111111111111111");
		// Model �� View ����
		System.out.println(result);
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "/user/checkDuplication.jsp";
	}


	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception {

		System.out.println("/user/listUser : GET / POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic ����
		Map<String, Object> map = userService.getList(search);

		Page resultPage = new Page(search.getCurrentPage(), (Integer) map.get("totalPage"), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "/user/listUser.jsp";
	}

	@RequestMapping( value="phCodeConfirm", method=RequestMethod.GET )
	public String phCodeConfirm() throws Exception {

		return "/user/phCodeConfirm.jsp";
	}
}
