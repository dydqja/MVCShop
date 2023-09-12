package com.side.mvcshop.product;

import com.side.mvcshop.common.Search;

import java.util.List;
import java.util.Map;




//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition
public interface ProductService {

	// ��ǰ���
	public void addProduct(Product product) throws Exception;


	// ��ǰ������
	public Product getProduct(int prodNo) throws Exception;

	// ��ǰ����Ʈ
	public Map<String , Object> getList(Search search) throws Exception;

	// ��ǰ����
	public void updateProduct(Product product) throws Exception;

	// AutoComplete �߰�
	public List<Map<String , Object>> autoComplete(Map<String, Object> paramMap) throws Exception;


}
