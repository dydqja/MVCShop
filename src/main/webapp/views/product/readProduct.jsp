<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%--
<%
	Product vo = (Product)request.getAttribute("vo");
	System.out.println("여기는 return readProduct.jsp 내부");
	System.out.println(vo);
%>
 --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품등록</title>


	<link rel="stylesheet" href="/views/css/admin.css" type="text/css">

	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">



		//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
		 $(function() {

			//확인 Event 연결
			$( "#confirm" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
				self.location ="/product/listProduct?menu=manage";
			});
			//추가등록 Event 연결
			$( "#addition" ).on("click" , function() {

				self.location ="/product/addProduct"
			});

		 });

	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/views/images/ct_ttl_img01.gif" 	width="15" height="37"/>
		</td>
		<td background="/views/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품등록</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/views/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/views/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<%--<td width="105"><%=vo.getProdName()%></td> --%>
					<td width="105">${product.prodName}</td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img  src="/views/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
	<%--<td class="ct_write01"><%= vo.getProdDetail() %></td>--%>
		<td class="ct_write01">${product.prodDetail}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">
			제조일자<img	src="/views/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
	<%--<td class="ct_write01"><%= vo.getManuDate() %></td> --%>
		<td class="ct_write01">${product.manuDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			가격<img 	src="/views/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
	<%--<td class="ct_write01"><%= vo.getPrice() %></td> --%>
		<td class="ct_write01">${product.price}</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">상품이미지</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<!-- 테이블 시작 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="26">
						<c:if test = "${product.fileName eq null}">
						등록된 이미지가 없습니다.
						</c:if>
						<c:if test = "${not empty product.fileName}">
						<img src="/views/images/uploadFiles/${product.fileName}" width="100" height="100"/>
						</c:if>
					</td>
				<%--<td class="ct_write01"><%= vo.getFileName() %></td> --%>
					<td class="ct_write01">${product.fileName}</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/views/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" id="confirm" style="padding-top:3px;">
					<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
						<a href="/product/listProduct?menu=manage">확인</a>
						////////////////////////////////////////////////////////////////////////////////////////////////// -->
						확인
					</td>
					<td width="14" height="23">
						<img src="/views/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="17" height="23">
						<img src="/views/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" id="addition" style="padding-top:3px;">
					<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
						<a href="../product/addProductView.jsp;">추가등록</a>
						////////////////////////////////////////////////////////////////////////////////////////////////// -->
						추가등록
					</td>
					<td width="14" height="23">
						<img src="/views/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>
