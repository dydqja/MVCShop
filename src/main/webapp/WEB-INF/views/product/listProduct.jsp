<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--    
<%@ page import="java.util.*"  %>

<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="com.model2.mvc.service.domain.Product"%>

	
	

<%
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");

	Search search = (Search)request.getAttribute("search");
	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());

/*	HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map");
	Search search=(Search)request.getAttribute("search");
	
	int total=0;
	ArrayList<Product> list=null;
	if(map != null){
		total=((Integer)map.get("count")).intValue();
		list=(ArrayList<Product>)map.get("list");
	}
	
	int currentPage=search.getCurrentPage();
	
	int totalPage=0;
	if(total > 0) {
		totalPage= total / search.getPageSize() ;
		if(total%search.getPageSize() >0)
			totalPage += 1;
	} */
	
%> --%>

<!DOCTYPE html>

<html>

<head>
	<meta charset="EUC-KR">
	<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> <!-- autocomplete �߰� -->

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>	<!-- autocomplete �߰� -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	<!-- autocomplete �߰� -->

<script type="text/javascript">

	//=====����Code �ּ� ó�� ��  jQuery ���� ======//
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
   		//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
	}
	//===========================================//
	//==> �߰��Ⱥκ� : "�˻�" ,  userId link  Event ���� �� ó��
	 $(function() {
			 
			//==> �˻� Event ����ó���κ�
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
			$( "td.ct_btn01:contains('�˻�')" ).on("click", function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
					
					fncGetList(${ search.currentPage })		
			});
			
			$("#searchBox").on("keydown", function(e) {
				  if (e.keyCode == 13) {
					    e.preventDefault();
					    fncGetList(${ search.currentPage })		
					  };
			});
	 
			
			//==> prodName LINK Event ����ó��
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
			$( ".ct_list_pop td:nth-child(3)" ).on("click", function() {					
				//Debug..				
				//console.log( $(this) ); // <== �� ���� �̿��ؼ�, �ڽĿ��� ����?
										  // <== this�� �����ϴ°� �ƴ�, �ش� �±׷� �ٷ�
										  //	 �����ϸ� �ѹ����� �����Ź���.										  
				//alert( $(this).children('input').val()); // this�� ����. prodNo �������				
				//alert( $(this).children('input').attr('value')); // this�� ����. prodNo �������
																   // .val() == .attr('value') ??? 
				//alert( $('#input[name="product"]').val()); // undefined ����. �����±� �߸����Ͱ���.
				//alert( $('input[name="product"]').attr('value')); // �ش� �±׷� �ٷ� ����
					  	/*										    // prodNo�� ��µǳ�, �����Ź���.
						if(${menu=='manage'}) {					
							self.location ="/product/updateProductView?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()					
											
						}else{					
							self.location ="/product/getProduct?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()				
					
						}
			});
						*/
						
						var prodNo = $(this).children('input').val();
						var menu = $($(this).children('input')[1]).val();
						var prodName = $($(this).children('input')[2]).val();
					
						//alert
						if(${menu=='manage'}) {							
							self.location ="/product/updateProduct?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()
						}else{
							$.ajax(
									{
										url : "/product/json/getProduct/"+prodNo ,
										method : "GET" ,
										dataType : "json" ,
										headers : {
											"Accept" : "application/json" ,
											"Content-Type" : "application/json"
										} ,
										success : function(JSONData , status) {
											
											//Debug...
											//alert(status);
											//Debug...
											//alert("JSONData : \n"+JSONData);
																						
											var displayValue = "<h3>"
																	+"��ǰ��ȣ :"+JSONData.prodNo+"<br/>"
																	+"��ǰ�� : "+JSONData.prodName+"<br/>"
																	+"��ǰ�̹��� : "+JSONData.fileName+"<br/>"
																	+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
																	+"�������� : "+JSONData.manuDate+"<br/>"
																	+"���� : "+JSONData.price+"<br/>"
																	+"������� : "+JSONData.regDateString+"<br/>"
															  +"</h3>";
											//Debug...									
											//alert(displayValue);																		
											$("h3").remove();
											$("#"+prodName+"").html(displayValue);
											//$("#"+product.prodName+"").html(displayValue);
											
										}
									});
						}
			
			});
			
	 
			//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});
			
			
		//AutoComplete �߰��κ�
		$(function() {
			
			$('#searchBox').autocomplete({				
				source : function(request, response) { //source: searchBox�� ���� ���
					$.ajax({
						url : "/product/json/autoComplete/" ,
						type : "POST" ,
						dataType : "JSON" ,
						data : {value: request.term} , //�Է��� ���� value�� �Ѿ. Controller ���� request.getParameter("value")
						success : function(data) {	   //�Ǵ� @RequestParam("value") String value�� ���� ���� �� ����.							
							response(
								$.map(data.acList, function(item) { //acList ==> Business Logic ���� return�� ��� ����. Controller���� ����
									return {
										label : item.PROD_NAME , // ��Ͽ� ǥ�õǴ� ��.
										value : item.PROD_NAME   // ���ý� valueâ�� ǥ�õǴ� ��
										//idx : item.SEQ // index
									};
								})									
							);
						}
						,error : function(){
							alert("error");
						}
					});					
				}
				,focus : function(event, ui) { // ����Ű�� �ڵ��ϼ��ܾ� �����ϴ� ���
					return false;
				}
				,minLength : 1 //�ּ� ���ڼ�
				,autoFocus : true // true => ù��° �׸� �ڵ����� ���� ������
				,delay : 100 // autocomplete ������ �ð�(ms)
				,select : function(evt, ui) { // ������ ���ý� ����. ui.item �� ���õ� �׸��� ��Ÿ���� ��ü,
											  // lavel,value,idx�� ����.
				}			
			});
		});
	 

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<%--<% if(menu.equals("manage")) {%>				
					<td width="93%" class="ct_ttl01">��ǰ ����</td>
					<%}else{ %>
					<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
					<%} %> --%>
					
					<c:choose>
						<c:when test = "${menu=='manage' }">
						<td width="93%" class="ct_ttl01">��ǰ ����</td>
						</c:when>
						<c:otherwise>
						<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
						</c:otherwise>
					</c:choose>					
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">		
			<%--<option value="0" <%= (searchCondition.equals("0") ? "selected" : "") %>>��ǰ��</option>
				<option value="0" <%= (searchCondition.equals("1") ? "selected" : "") %>>��ǰ�ڵ�</option> --%>
				
				<option value="0" ${ ! empty searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��</option>
				<option value="1" ${ ! empty searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ�ڵ�</option>				
			</select>
		<%--<input 	type="text" name="searchKeyword"  value="<%= searchKeyword %>" --%> 
			<input id="searchBox"	type="text" name="searchKeyword" 
					value="${ ! empty search.searchKeyword ? search.searchKeyword :""}"
							class="ct_input_g" style="width:200px; height:19px" >
		</td>	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					<%--<a href="javascript:fncGetProductList('<%=search.getCurrentPage()%>');">�˻�</a> --%>
					<!--	<a href="javascript:fncGetList('${ search.currentPage }');">�˻�</a> -->
					�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>		
		<%--��ü  <%= resultPage.getTotalCount() %> �Ǽ�, ���� <%= resultPage.getCurrentPage() %> ������ --%>
		<td colspan="11" >
			��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��<br>
		<c:choose>
			<c:when test = "${menu=='manage'}">
				<h7 >(��ǰ�� click<br>:��ǰ����)</h7>
			</c:when>
			<c:otherwise>
				<h7 >(��ǰ�� click<br>:������)</h7>
			</c:otherwise>
		</c:choose>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	
<%--<% 	
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
	%>		
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>
		<td align="left">
	<% if(menu.equals("manage")) {%>
		<a href="/updateProductView.do?prodNo=<%=vo.getProdNo() %>&menu=<%= menu %>"><%=vo.getProdName() %></a>		
	<%}else{ %>		
		<a href="/getProduct.do?prodNo=<%=vo.getProdNo() %>&menu=<%= menu %>"><%=vo.getProdName() %></a>			
		</td>
	<%} %>
		<td></td>
		<td align="left"><%= vo.getPrice() %></td>
		<td></td>
		<td align="left"><%= vo.getManuDate() %></td>
		<td></td>
		<td align="left"><%= vo.getProTranCode() %>		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %> --%>	
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}" >
		
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
			<input type="hidden" id="product" name="product" value="${product.prodNo}"/>			
			<input type="hidden" id="menu" name="menu" value="${param.menu}"/>
			<input type="hidden" id="product" name="product" value="${product.prodName}"/>
			
			<!--			
	 		<c:choose>
				<c:when test = "${menu=='manage'}">
				<td align="left"><a href="/product/updateProductView?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a></td>
				</c:when>
				<c:otherwise>
				
				<td align="left"><a href="/product/getProduct?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a></td>
				</c:otherwise>
			</c:choose>
			 -->
			 ${product.prodName}
			 </td>
			<td></td>
		<td align="left">${ product.price }</td>
		<td></td>
		<td align="left">${ product.manuDate }</td>
		<td></td>
		<td align="left">${ product.proTranCode }		
		</td>
	</tr>
	<tr>
	<td id="${product.prodName}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%--<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %> --%>
		<%--###### pageNavigator if�� �������� ���� ######
 		<jsp:include page="../common/pageNavigator.jsp?uri=${ uri }"/>
		--%>	
		<jsp:include page="../common/pageNavigator_new.jsp"/>
    	</td>
	</tr>
</table>

</form>

</div>
</body>
</html>
    