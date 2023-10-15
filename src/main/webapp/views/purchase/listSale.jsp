<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>


	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/views/css/animate.min.css" rel="stylesheet">
   <link href="/views/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/views/javascript/bootstrap-dropdownhover.min.js"></script>


   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//=============    검색 / page 두가지 경우 모두  Event  처리 =============
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listSale").submit();
		}


		//============= "검색"  Event  처리 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//$( "button.btn.btn-default" ).on("click" , function() {
			//	fncGetUserList(1);
			//});
			$("#search").on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
				fncGetList(${ search.currentPage })
		 	});

			$("#searchKeyword").on("keydown", function(e) {
				if (e.keyCode == 13) {
					e.preventDefault();
					fncGetList(${ search.currentPage })
				};
			});
		 });


		//============= userId 에 회원정보보기  Event  처리(Click) =============
		 $(function() {

			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)" ).on("click" , function() {
				 self.location ="/user/getUser?userId="+$(this).text().trim();
			});

			//==> userId LINK Event End User 에게 보일수 있도록
			$( "td:nth-child(2)" ).css("color" , "red");

		});


		//============= userId 에 회원정보보기  Event  처리 (double Click)=============
		 $(function() {

			//==> userId LINK Event End User 에게 보일수 있도록
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");

			//==> 아래와 같이 정의한 이유는 ??
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		});

		$(function() {
			//배송하기 버튼 Event
			$(".dlvy").on("click", function () {

				// let dlvyProdNo = parseInt($(this).find(".inputClassNo").val());
				// let tranCode = $(this).find(".inputTranCode").val();
				let dlvyProdNo = parseInt($(this).closest("tr").find(".inputClassNo").val());
				let tranCode = $(this).closest("tr").find(".inputTranCode").val();
				console.log(dlvyProdNo);
				console.log(tranCode);


				$.ajax({
					url: "/purchase/json/updateTranCode",
					type: "POST",
					contentType: "application/json; charset=utf-8",
					data: JSON.stringify({
						prodNo: dlvyProdNo,
						tranCode: tranCode
					}),
					dataType: "text",
					success: function(response) {
						console.log(response.tranCode.val());

					},
					error: function(error) {
						alert("ajax 에러");
					}
				});
				// self.location = "/purchase/updateTranCode?prodNo="+dlvyProdNo;
			})
		})


	</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/views/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

		<div class="page-header text-info">
	       <h3>배송 관리</h3>
	    </div>

	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">

		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>

		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">

				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>현재상태</option>
					</select>
				  </div>

				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>

				  <button type="button" class="btn btn-default" id="search">검색</button>

				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>

				</form>
	    	</div>

		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->


      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >

        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
          </tr>
        </thead>

		<tbody>

		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left">${ i }</td>
			  <td align="left">${purchase.purchaseProd.prodName}</td>
			  <td align="left">${purchase.purchaseProd.price}</td>
			  <td align="left">${purchase.purchaseProd.regDate}</td>
			  <c:if test="${purchase.tranCode == null}"	>
			  <td align="left">판매중</td>
			  </c:if>
			  <c:if test="${purchase.tranCode != null}">
			  <td align="left">${purchase.tranCode}
				  <c:if test="${purchase.tranCode eq '배송전'}">
					  <input type="button" class="dlvy" value="배송하기">
					  <input type="hidden" id="prodNo" value="${purchase.purchaseProd.prodNo}" class="inputClassNo"/>
					  <input type="hidden" id="tranCode" value="${purchase.tranCode}" class="inputTranCode"/>
				  </c:if>
			  </td>

			  </c:if>
			</tr>
          </c:forEach>

        </tbody>

      </table>
	  <!--  table End /////////////////////////////////////-->

 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->


 	<!-- PageNavigation Start... -->
	<jsp:include page="/views/common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>

</html>
