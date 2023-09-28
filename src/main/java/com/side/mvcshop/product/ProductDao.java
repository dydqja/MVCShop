package com.side.mvcshop.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.side.mvcshop.common.Search;
import com.side.mvcshop.product.Product;
import com.side.mvcshop.user.User;


//==> ȸ���������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
@Mapper
public interface ProductDao {

	// INSERT
	public void addProduct(Product product) throws Exception ;

	// SELECT ONE
	public Product getProduct(int prodNo) throws Exception ;

	// SELECT LIST
	public List<Product> getList(Search search) throws Exception ;

	// UPDATE
	public void updateProduct(Product product) throws Exception ;

	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;

	// AutoComplete �߰��κ�
	public List<Map<String,Object>> autoComplete(Map<String,Object> paramMap) throws Exception ;







}
