<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	//==> null 을 ""(nullString)으로 변경
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
	<meta charset="UTF-8">
	<title>상품 목록조회</title>

<link rel="stylesheet" href="/views/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> <!-- autocomplete 추가 -->

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>	<!-- autocomplete 추가 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	<!-- autocomplete 추가 -->
<!--   jQuery , Bootstrap CDN  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<script type="text/javascript">

	let currentPage = ${resultPage.currentPage};
	let totalPage = ${resultPage.totalPage};

	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
   		//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
	}
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	 $(function() {

			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.
			$( "td.ct_btn01:contains('검색')" ).on("click", function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('검색')" ).html() );

					fncGetList(${ search.currentPage })
			});

			$("#searchBox").on("keydown", function(e) {
				  if (e.keyCode == 13) {
					    e.preventDefault();
					    fncGetList(${ search.currentPage })
					  };
			});


			//==> prodName LINK Event 연결처리
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
			$( ".imgFile" ).on("click", function() {
				console.log("imgFile 클릭됨.");
				//Debug..
				//console.log( $(this) ); // <== 이 값을 이용해서, 자식에게 접근?
										  // <== this로 접근하는게 아닌, 해당 태그로 바로
										  //	 접근하면 넘버값이 고정돼버림.
				//alert( $(this).children('input').val()); // this로 접근. prodNo 정상출력
				//alert( $(this).children('input').attr('value')); // this로 접근. prodNo 정상출력
																   // .val() == .attr('value') ???
				//alert( $('#input[name="product"]').val()); // undefined 나옴. 접근태그 잘못쓴것같음.
				//alert( $('input[name="product"]').attr('value')); // 해당 태그로 바로 접근
					  	/*										    // prodNo는 출력되나, 고정돼버림.
						if(${menu=='manage'}) {
							self.location ="/product/updateProductView?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()

						}else{
							self.location ="/product/getProduct?prodNo="+$(this).children('input').val()+"&menu="+$($(this).children('input')[1]).val()

						}
			});
						*/

						let parentDiv = $(this).closest('.product-item');


						let prodNo = parentDiv.find('.inputClassNo').val();
						// let menu = parentDiv.find('#menu').val();
						// let prodName = parentDiv.find('#prodName').val();


						console.log("11111"+prodNo);
						// var menu = parentDiv.find('input').eq(1).val();
						// var prodName = parentDiv.find('input').eq(2).val();
						// console.log(parentDiv.find('input').eq(0).val()+","+parentDiv.find('input').eq(1).val()+","+parentDiv.find('input').eq(3).val());


						//alert


						// self.location = "/product/updateProduct?prodNo=" + $(this).attr('prodNo') + "&menu=" + menu
						console.log($($(this).siblings('input')[1]).val());


						// 	$.ajax(
						// 			{
						// 				url : "/product/json/getProduct/"+prodNo ,
						// 				method : "GET" ,
						// 				dataType : "json" ,
						// 				headers : {
						// 					"Accept" : "application/json" ,
						// 					"Content-Type" : "application/json"
						// 				} ,
						// 				success : function(JSONData , status) {
						//
						// 					//Debug...
						// 					//alert(status);
						// 					//Debug...
						// 					//alert("JSONData : \n"+JSONData);
						//
						// 					var displayValue = "<h3>"
						// 											+"상품번호 :"+JSONData.prodNo+"<br/>"
						// 											+"상품명 : "+JSONData.prodName+"<br/>"
						// 											+"상품이미지 : "+"<br/>"
						// 											+"<img src='/views/images/uploadFiles/" + JSONData.fileName + "' width='100' height='100'/><br/>"
						// 											+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
						// 											+"제조일자 : "+JSONData.manuDate+"<br/>"
						// 											+"가격 : "+JSONData.price+"<br/>"
						// 											+"등록일자 : "+JSONData.regDateString+"<br/>"
						// 									  +"</h3>";
						// 					//Debug...
						// 					//alert(displayValue);
						// 					$("h3").remove();
						// 					$("#"+prodName+"").html(displayValue);
						// 					//$("#"+product.prodName+"").html(displayValue);
						//
						// 				}
						// 			});
						// }

			});


			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");

			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		})




		//AutoComplete 추가부분
		$(function() {

			$('#searchBox').autocomplete({
				source : function(request, response) { //source: searchBox에 보일 목록
					$.ajax({
						url : "/product/json/autoComplete/" ,
						type : "POST" ,
						dataType : "JSON" ,
						data : {value: request.term} , //입력한 값이 value로 넘어감. Controller 에서 request.getParameter("value")
						success : function(data) {	   //또는 @RequestParam("value") String value로 값을 꺼낼 수 있음.
							response(
								$.map(data.acList, function(item) { //acList ==> Business Logic 이후 return값 담는 변수. Controller에서 선언
									return {
										label : item.PROD_NAME , // 목록에 표시되는 값.
										value : item.PROD_NAME   // 선택시 value창에 표시되는 값
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
				,focus : function(event, ui) { // 방향키로 자동완성단어 선택하는 기능
					return false;
				}
				,minLength : 1 //최소 글자수
				,autoFocus : true // true => 첫번째 항목에 자동으로 초점 맞춰짐
				,delay : 100 // autocomplete 딜레이 시간(ms)
				,select : function(evt, ui) { // 아이템 선택시 실행. ui.item 이 선택된 항목을 나타내는 객체,
											  // lavel,value,idx를 가짐.
				}
			});
		});

	let loading = false; // 무한스크롤 로딩 판단

	//InfiniteScroll 추가부분
	$(function() {
		$(window).on("scroll", function () {
			console.log("scroll event 실행됨");


			let scrollTop = $(window).scrollTop(); // 스크롤 된 길이
			let windowHeight = $(window).height(); // 웹 브라우저 높이
			let documentHeight = $(document).height(); // 문서 전체 높이
			let bottom = scrollTop + windowHeight + 10 >= documentHeight; // 스크롤이 바닥인지 판단

			if (bottom) {
				console.log("scroll이 바닥일 때 실행.");
				if(currentPage >= totalPage) {
					console.log("if문 실행됨 return false");
					console.log("currentPage = [ "+currentPage+" ]");
					console.log("totalPage = [ "+totalPage+" ]");
					return false;
				} else{
					// loading = true; // 로딩상태 true
					// $("#loading").show; // 로딩바 표시 // 로딩바표시 할거면 로딩div 만들어야함
					currentPage++;
					getListAjax(currentPage);
				}
			}
		})
	})

	function getListAjax(currentPage) {
		console.log("getListAjax 실행됨. currentPage = [ "+currentPage+" ]");
		$.ajax({
			type: "get",
			url: "/product/json/listProduct?menu=${menu}",
			data: {
				"currentPage" : currentPage
			},
			success : function(data) {
				// console.log("11111" +data[1]);
				// $("#product-container").append(data)
				// $("#loading").hide() // 로딩바 숨기기
				// loading = false; // 로딩상태 false

				// 각각의 데이터 항목을 반복하여 처리
				$.each(data[0], function(index, productData) {
					// 새로운 상품 아이템을 생성합니다
					let productItem = $('<div class="product-item" style="flex: 0 1 calc(33.33% - 10px); margin: 5px; max-width: 100%;"></div>');

					// 상품 정보 컨테이너를 생성합니다
					let productInfoContainer = $('<div style="box-sizing: border-box; text-align: center;"></div>');

					// input 요소를 생성하고 설정합니다
					let prodNoInput = $('<input type="hidden" id="prodNo" name="product" value="' + productData.prodNo + '">');
					let menuInput = $('<input type="hidden" id="menu" name="menu" value="' + data[1] + '">');
					let prodNameInput = $('<input type="hidden" id="prodName" name="product" value="' + productData.prodName + '">');

					// 상품 이미지를 생성하고 설정합니다
					let productImage = $('<div style="max-width: 100%; height: 200px; overflow: hidden;"></div>');

					console.log("파일이름 = "+productData.fileName);
					let img = $('<img style="width: 100%; height: 100%; object-fit: contain;" id="imgFile">');

					if (!productData.fileName) {
						img.attr('src', '/views/images/no-image.png');
					} else {
						img.attr('src', '/views/images/uploadFiles/' + productData.fileName);
					}
					productImage.append(img);

					// 상품 정보를 생성하고 설정합니다
					let productName = $('<div>상품이름: ' + productData.prodName + '</div>');
					let productPrice = $('<div>상품가격: ' + productData.price + '원</div>');

					// 인풋 요소와 상품 이미지와 정보를 상품 정보 컨테이너에 추가합니다
					productInfoContainer.append(prodNoInput);
					productInfoContainer.append(menuInput);
					productInfoContainer.append(prodNameInput);
					productInfoContainer.append(productImage);
					productInfoContainer.append(productName);
					productInfoContainer.append(productPrice);

					// 상품 정보 컨테이너를 상품 아이템에 추가합니다
					productItem.append(productInfoContainer);

					// 상품 아이템을 product-container에 추가합니다
					$("#product-container").append(productItem);

					if ((index + 1) % 3 !== 0 && index === data.length - 1) {
						for (let i = 0; i < 3 - (index + 1) % 3; i++) {
							let emptyDiv = $('<div style="flex: 0 1 calc(33.33% - 10px); margin: 5px; max-width: 100%;"></div>');
							$("#product-container").append(emptyDiv);
						}
					}
				});
			},
			error : function() {
				alert("error");
			}
		})
	}





</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/views/layout/toolbar.jsp" />

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0" style="margin-top: 70px">
	<tr>
		<td width="15" height="37">
			<img src="/views/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/views/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<%--<% if(menu.equals("manage")) {%>
					<td width="93%" class="ct_ttl01">상품 관리</td>
					<%}else{ %>
					<td width="93%" class="ct_ttl01">상품 목록조회</td>
					<%} %> --%>

					<c:choose>
						<c:when test = "${menu=='manage' }">
						<td width="93%" class="ct_ttl01">상품 관리</td>
						</c:when>
						<c:otherwise>
						<td width="93%" class="ct_ttl01">상품 목록조회</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/views/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<%--<option value="0" <%= (searchCondition.equals("0") ? "selected" : "") %>>상품명</option>
				<option value="0" <%= (searchCondition.equals("1") ? "selected" : "") %>>상품코드</option> --%>

				<option value="0" ${ ! empty searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
				<option value="1" ${ ! empty searchCondition && search.searchCondition==1 ? "selected" : "" }>상품코드</option>
			</select>
		<%--<input 	type="text" name="searchKeyword"  value="<%= searchKeyword %>" --%>
			<input id="searchBox"	type="text" name="searchKeyword"
					value="${ ! empty search.searchKeyword ? search.searchKeyword :""}"
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/views/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/views/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
					<%--<a href="javascript:fncGetProductList('<%=search.getCurrentPage()%>');">검색</a> --%>
					<!--	<a href="javascript:fncGetList('${ search.currentPage }');">검색</a> -->
					검색
					</td>
					<td width="14" height="23">
						<img src="/views/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
<%--	<tr>--%>
<%--		&lt;%&ndash;전체  <%= resultPage.getTotalCount() %> 건수, 현재 <%= resultPage.getCurrentPage() %> 페이지 &ndash;%&gt;--%>
<%--		<td colspan="11" >--%>
<%--			전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지--%>
<%--		</td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td class="ct_list_b" width="100">No</td>--%>
<%--		<td class="ct_line02"></td>--%>
<%--		<td class="ct_list_b" width="150">상품명<br>--%>
<%--		<c:choose>--%>
<%--			<c:when test = "${menu=='manage'}">--%>
<%--				<h7 >(상품명 click<br>:상품수정)</h7>--%>
<%--			</c:when>--%>
<%--			<c:otherwise>--%>
<%--				<h7 >(상품명 click<br>:상세정보)</h7>--%>
<%--			</c:otherwise>--%>
<%--		</c:choose>--%>
<%--		</td>--%>
<%--		<td class="ct_line02"></td>--%>
<%--		<td class="ct_list_b" width="150">가격</td>--%>
<%--		<td class="ct_line02"></td>--%>
<%--		<td class="ct_list_b" width="150">등록일</td>--%>
<%--		<td class="ct_line02"></td>--%>
<%--		<td class="ct_list_b" width="150">현재상태</td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td colspan="11" bgcolor="808285" height="1"></td>--%>
<%--	</tr>--%>


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

	<div style="display: flex; flex-wrap: wrap; justify-content: space-between; margin-right: 5%; margin-left: 5%;" id="product-container">
		<c:forEach var="product" items="${list}" varStatus="loopStatus">
			<div class="product-item" style="flex: 0 1 calc(33.33% - 10px); margin: 5px; max-width: 100%;">
				<div style=" box-sizing: border-box; text-align: center;">

					<input type="hidden" id="prodNo" name="product" value="${product.prodNo}" class="inputClassNo"/>
					<input type="hidden" id="menu" name="menu" value="${param.menu}"/>
					<input type="hidden" id="prodName" name="product" value="${product.prodName}"/>

					<div style="max-width: 100%; height: 200px; overflow: hidden;">
						<c:if test="${product.fileName eq null || product.fileName eq ''}">
                            <img src="/views/images/no-image.png" style="width: 100%; height: 100%; object-fit: contain;" class="imgFile">
						</c:if>
						<c:if test="${not empty product.fileName}">
                        <img src="/views/images/uploadFiles/${product.fileName}" style="width: 100%; height: 100%; object-fit: contain;" class="imgFile">
							$(this).parent
						</c:if>
					</div>
					<div>상품이름: ${product.prodName}</div>
					<div>상품가격: ${product.price}원</div>
				</div>
			</div>

			<c:if test="${loopStatus.index % 3 == 2 or loopStatus.last}">
				<!-- Insert empty divs if the current row is incomplete -->
				<script>
					$(document).ready(function() {
						const productContainer = $('#product-container');
						const productItems = productContainer.find('.product-item');
						const itemCount = productItems.length;

						// 원하는 열 개수 설정 (여기서는 3개)
						const desiredColumns = 3;

						// Calculate the number of empty divs needed to complete the row
						const emptyDivsNeeded = desiredColumns - (itemCount % desiredColumns);

						// Insert empty divs
						for (let i = 0; i < emptyDivsNeeded; i++) {
							productContainer.append('<div style="flex: 0 1 calc(33.33% - 10px); margin: 5px; max-width: 100%;"></div>');
						}
					});
				</script>
			</c:if>
		</c:forEach>
	</div>









<%--	<c:set var="i" value="0" />--%>
<%--	<c:forEach var="product" items="${list}" >--%>

<%--		<c:set var="i" value="${ i+1 }" />--%>
<%--		<tr class="ct_list_pop">--%>
<%--			<td align="center">${ i }</td>--%>
<%--			<td></td>--%>
<%--			<td align="left">--%>
<%--			<input type="hidden" id="product" name="product" value="${product.prodNo}"/>--%>
<%--			<input type="hidden" id="menu" name="menu" value="${param.menu}"/>--%>
<%--			<input type="hidden" id="product" name="product" value="${product.prodName}"/>--%>

<%--			<!----%>
<%--	 		<c:choose>--%>
<%--				<c:when test = "${menu=='manage'}">--%>
<%--				<td align="left"><a href="/product/updateProductView?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a></td>--%>
<%--				</c:when>--%>
<%--				<c:otherwise>--%>

<%--				<td align="left"><a href="/product/getProduct?prodNo=${ product.prodNo }&menu=${ menu }">${ product.prodName }</a></td>--%>
<%--				</c:otherwise>--%>
<%--			</c:choose>--%>
<%--			 -->--%>
<%--			 ${product.prodName}--%>
<%--			 </td>--%>
<%--			<td></td>--%>
<%--		<td align="left">${ product.price }</td>--%>
<%--		<td></td>--%>
<%--		<td align="left">${ product.manuDate }</td>--%>
<%--		<td></td>--%>
<%--		<td align="left">${ product.proTranCode }--%>
<%--		</td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--	<td id="${product.prodName}" colspan="11" bgcolor="D6D7D6" height="1"></td>--%>
<%--	</tr>--%>
<%--	</c:forEach>--%>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%--<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>

			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %> --%>
		<%--###### pageNavigator if문 돌려보기 실패 ######
 		<jsp:include page="../common/pageNavigator.jsp?uri=${ uri }"/>
		--%>
<%--		<jsp:include page="/views/common/pageNavigator_new.jsp"/>--%>
    	</td>
	</tr>
</table>

</form>

</div>
</body>
</html>
