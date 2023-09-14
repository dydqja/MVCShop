package com.side.mvcshop.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.side.mvcshop.user.User;
import com.side.mvcshop.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {

	///Field
	private UserService userService;
	//setter Method ���� ����

	//Constructor
	@Autowired
	public UserRestController(UserService userService){
		System.out.println(this.getClass());

		this.userService = userService;
	}

	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{

		System.out.println("/user/json/getUser : GET");

		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{

		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());

		////////////////////////////////////////////////////////////////////////////////
		// ���̵� ���ٸ�.
		if( dbUser==null ) {
		dbUser = new User();
		}
		/////////////////////////////////////////////////////////////////////////////////

		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}

		return dbUser;
	}

	@RequestMapping( value="/send", method=RequestMethod.POST )
	public SmsResponseDto sendSms( @RequestBody MessageDto messageDto) throws Exception {

		System.out.println("/user/send :: POST");

		SmsResponseDto responseDto = userService.sendSms(messageDto);

		System.out.println("controller�� return�� SmsResponseDto����? ==> " + responseDto);

		return responseDto;
	}

	@RequestMapping( value="/phCodeConfirm", method=RequestMethod.POST )
	public String phCodeConfirm( @RequestBody PhCodeConfirmRequest request) throws Exception{

		System.out.println("/user/phCodeConfirm : POST");

		String phCodeConfirm = request.getPhCodeConfirm();
		String smsConfirmNum = request.getSmsConfirmNum();

		System.out.println("smsConfirmNum ========= " + smsConfirmNum);

		String result=userService.phCodeConfirm(phCodeConfirm,smsConfirmNum);

		System.out.println("controller�� return�� result����? ==> " + result);

		return result;
	}
}
