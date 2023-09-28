package com.side.mvcshop.user;

import java.util.List;

import com.side.mvcshop.common.Search;
import com.side.mvcshop.user.User;
import org.apache.ibatis.annotations.Mapper;


//==> ȸ���������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
@Mapper
public interface UserDao {

	// INSERT
	public void addUser(User user) throws Exception ;

	// SELECT ONE
	public User getUser(String userId) throws Exception ;

	// SELECT LIST
	public List<User> getList(Search search) throws Exception ;

	// UPDATE
	public void updateUser(User user) throws Exception ;

	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;


}
