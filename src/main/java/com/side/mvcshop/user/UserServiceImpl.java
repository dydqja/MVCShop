package com.side.mvcshop.user;

import java.net.URI;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;

import com.side.mvcshop.common.Search;
import com.side.mvcshop.user.User;
import com.side.mvcshop.user.UserDao;
import com.side.mvcshop.user.UserService;
import org.springframework.web.client.RestTemplate;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;


//==> ȸ������ ���� ����
@Service("userServiceImpl")
public class UserServiceImpl implements UserService{

	///Field
	private UserDao userDao;

	///Constructor
	@Autowired
	public UserServiceImpl(UserDao userDao) {
		System.out.println(this.getClass());

		this.userDao = userDao;
	}

	@Value("${naver-cloud-sms.accessKey}")
	private String accessKey;

	@Value("${naver-cloud-sms.secretKey}")
	private String secretKey;

	@Value("${naver-cloud-sms.serviceId}")
	private String serviceId;

	@Value("${naver-cloud-sms.senderPhone}")
	private String phone;

	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
	}

	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	public Map<String , Object > getList(Search search) throws Exception {

		List<User> list= userDao.getList(search);
		int totalCount = userDao.getTotalCount(search);
		System.out.println(list);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}

	@Override
	public String getSignature(String time) throws Exception {

		System.out.println("getSignature method ����� ==========================================");

		String space = " ";
		String newLine = "\n";
		String method = "POST";
		String url = "/sms/v2/services/"+ this.serviceId+"/messages";
		String accessKey = this.accessKey;
		String secretKey = this.secretKey;

		String message = new StringBuilder()
				.append(method)
				.append(space)
				.append(url)
				.append(newLine)
				.append(time)
				.append(newLine)
				.append(accessKey)
				.toString();

		SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
		mac.init(signingKey);

		byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		//String encodeBase64String = Base64.encodeBase64String(rawHmac); ==> org.apache.hc.client5.http.utils.Base64 ���̺귯���� �̿��ѹ��.
		String encodeBase64String = new String(Base64.getEncoder().encode(rawHmac)); // ==> java.util.Base64 ���̺귯���� �̿��ѹ��.

		return encodeBase64String;
	}

	@Override
	public SmsResponseDto sendSms(MessageDto messageDto) throws Exception{

		System.out.println("UserServiceImpl에서 sendSms 실행됨.");

		String time = Long.toString(System.currentTimeMillis());

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("x-ncp-apigw-timestamp", time);
		headers.set("x-ncp-iam-access-key", accessKey);
		headers.set("x-ncp-apigw-signature-v2", getSignature(time)); // signature ����

		System.out.println("1========"+headers);

		List<MessageDto> messages = new ArrayList<>();
		messages.add(messageDto);

		final String smsConfirmNum = createSmsKey();//�޴��� ���� ��ȣ
		System.out.println("������ ���� ������ȣ = [" + smsConfirmNum + "]");

		SmsRequestDto request = new SmsRequestDto.Builder()
				.type("SMS")
				.contentType("COMM")
				.countryCode("82")
				.from(phone)
				.content("MVCShop 인증번호 [" + smsConfirmNum + "]를 입력해주세요.")
				.messages(messages)
				.build();

		System.out.println("2========"+request);

		//���� �ٵ� ���̽� ���·� ��ȯ
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule()); // LocalDateTime ��ü ��'����ȭ ���з� ���� �߰�����
		String body = objectMapper.writeValueAsString(request);

		// jsonBody�� ��� ����
		HttpEntity<String> httpBody = new HttpEntity<>(body, headers);
		System.out.println("3. body+header ����? ==========" + httpBody);

		CloseableHttpClient httpClient = HttpClients.createDefault(); // <= HttpClients�� �����ϸ鼭 �������ִ���, �� �޼��� ����ϸ� creating bean ���� ��
		//	�� �ʿ���̺귯�� ���� ���������ν� �ذ�.
		//CloseableHttpClient httpClient = HttpClientBuilder.create().build();

//        RequestConfig requestConfig = RequestConfig.custom()
//        	    .setConnectTimeout(5000) // ���� �ð� �ʰ��� 5�ʷ� ����
//        	    .setSocketTimeout(5000) // ���� �ð� �ʰ��� 5�ʷ� ����
//        	    .build();
//
//        	CloseableHttpClient httpClient = HttpClients.custom()
//        	    .setDefaultRequestConfig(requestConfig)
//        	    .build();

		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(httpClient);
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setRequestFactory(factory);

//        restTemplate.setRequestFactory Ȯ�ο�(�����ص� ��������)
		ClientHttpRequestFactory currentFactory = restTemplate.getRequestFactory();
		if (currentFactory instanceof HttpComponentsClientHttpRequestFactory) {
			System.out.println("HttpComponentsClientHttpRequestFactory is configured");
		} else {
			System.out.println("HttpComponentsClientHttpRequestFactory is not configured");
		}

		//restTemplate�� post ��û ������ ������ ������ 202�ڵ� ��ȯ
		//SmsResponseDto smsResponseDto = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+ serviceId +"/messages"), httpBody, SmsResponseDto.class);
		//HttpEntity<?> httpEntity = new HttpEntity<>(httpBody, headers);
		String url = "https://sens.apigw.ntruss.com/sms/v2/services/" + serviceId + "/messages";
		System.out.println("url�� Ȯ�ο� =====> " + url);
		//System.out.println("httpEntity: " + httpEntity);

		ResponseEntity<String> responseEntity = restTemplate.exchange(new URI(url), HttpMethod.POST, httpBody, String.class);
		System.out.println("responseEntity Ȯ�ο� =====> " + responseEntity);
		// JSON ������ ���ڿ��� Ȯ��
		String jsonResponse = responseEntity.getBody();
		System.out.println("JSON ����: " + jsonResponse);
		// ���� �ʿ��� ��� ���ڿ� ������ JSON ������ SmsResponseDto ��ü�� ��ȯ�� �� �ֽ��ϴ�.
//        SmsResponseDto smsResponseDto = objectMapper.readValue(jsonResponse, SmsResponseDto.class);

		ObjectNode jsonNode = objectMapper.readValue(jsonResponse, ObjectNode.class);
		jsonNode.put("smsConfirmNum", smsConfirmNum);
		SmsResponseDto smsResponseDto = objectMapper.treeToValue(jsonNode, SmsResponseDto.class);

		SmsResponseDto responseDto = new SmsResponseDto(smsConfirmNum);
//        redisUtil.setDataExpire(smsConfirmNum, messageDto.getTo(), 60 * 3L); // ��ȿ�ð� 3��

		return smsResponseDto;

	}


	// �����ڵ� �����
	public String createSmsKey() {
		StringBuilder key = new StringBuilder();

		for (int i = 0; i < 6; i++) { // �����ڵ� 6�ڸ�
			key.append(ThreadLocalRandom.current().nextInt(10));
		}

		return key.toString();
	}

	//������ȣ Ȯ��
	public String phCodeConfirm(String phCodeConfirm, String smsConfirmNum) throws Exception {
		boolean result=false;

		System.out.println("phCodeConfirm ==> ["+phCodeConfirm+"]");
		System.out.println("smsConfirmNum ==> ["+smsConfirmNum+"]");

		if(phCodeConfirm != null && phCodeConfirm.equals(smsConfirmNum)) {
			result = true;
		}

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result);

		return jsonObject.toString();

	}
}
