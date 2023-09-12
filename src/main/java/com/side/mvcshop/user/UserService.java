package com.side.mvcshop.user;

import java.util.Map;

import com.side.mvcshop.common.Search;
import com.side.mvcshop.user.User;


//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition
public interface UserService {

	// ȸ������
	public void addUser(User user) throws Exception;

	// ������Ȯ�� / �α���
	public User getUser(String userId) throws Exception;

	// ȸ����������Ʈ
	public Map<String , Object> getList(Search search) throws Exception;

	// ȸ����������
	public void updateUser(User user) throws Exception;

	// ȸ�� ID �ߺ� Ȯ��
	public boolean checkDuplication(String userId) throws Exception;

}
