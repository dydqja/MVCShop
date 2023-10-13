<%--
  Created by IntelliJ IDEA.
  User: LG
  Date: 2023-10-02
  Time: 오후 6:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>구매목록조회</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

    <style>
        body > div.container{
            border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
        .header_div {
            width: 100%;
            height: 37px;
            background-color: whitesmoke;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: auto;
            height: 20px;
        }
        .form-group label {
            margin-bottom: 5px
        }

        .manuDate {
            width: auto;
            height: 50px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .submit, .cancle {
            margin: 5px
        }

        body {
            font-family: Arial, sans-serif;
        }

        .board-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .post {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
        }

        .post-title {
            font-size: 18px;
            font-weight: bold;
        }

        .post-content {
            margin-top: 10px;
        }

        .post-meta {
            font-size: 12px;
            color: #666;
        }

        .btn {
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 3px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

    </style>

</head>
<body>

<jsp:include page="/views/layout/toolbar.jsp" />

<form name="addPurchaseForm" style="margin-top: 5%;">

    <div class="container">

        <div class="header_div" >
            <img src="/views/images/ct_ttl_img01.gif" dwith="15" height="37"/>구매 목록조회
        </div>

        <br/>
        <hr/>

        <div class="row">

            <div class="board-container">

                <p class="text-primary">
                    전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
                </p>

                <c:set var="i" value="0" />
                <c:forEach var="purchase" items="${list}">
                    <c:set var="i" value="${i+1}"/>
                    <div class="post">
                        <div class="post-title">상품명: ${purchase.purchaseProd.prodName}</div>

                        <div class="post-content">
                            배송지: ${purchase.dlvyAddr}
                        </div>

                        <div class="post-meta">
                            수취인: ${purchase.receiverName} | 전화번호: ${purchase.receiverPhone} | 배송현황: ${purchase.tranCode}
                        </div>
<%--                        후에 상품갯수까지 추가되면 구매상품정보 바로가기 만들기--%>
                        <a href="#" class="btn">바로 가기</a>
                    </div>



                </c:forEach>

            </div>

        </div>

    </div>

</form>



<script type="text/javascript" src="../views/javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>


<script type="text/javascript">

    function fncAddPurchase() {
        let paymentOption = $("#paymentOption").val();
        let receiverName = $("#receiverName").val();
        let receiverPhone = $("#receiverPhone").val();
        let dlvyAddr = $("#dlvyAddr").val();

        if(paymentOption == null || paymentOption == "selectPayment" ) {
            alert("구매방법을 선택해주세요.");
            return;
        }

        if(receiverName == null || receiverName.length<1) {
            alert("구매자이름을 입력해주세요.");
            return;
        }

        //나중에 휴대번호 인증으로 변경하기
        if(receiverPhone == null || receiverPhone.length<11) {
            alert("구매자연락처를 정확히 입력해주세요.");
            return;
        }

        //나중에 주소찾기 api 추가할것
        if(dlvyAddr == null || dlvyAddr.length<1) {
            alert("구매자주소를 입력해주세요.");
            return;
        }

        $("form").attr("method","POST").attr("action","/purchase/addPurchase").submit();


    }

    //구매 event
    $(function () {

        $(".submit").on("click", function () {

            fncAddPurchase();
        })
    })

        //취소 event
        $(function () {

            $(".cancel").on("click", function (){

                window.location.href = "/product/listProduct?menu=search"
            })
        })

</script>

</body>
</html>
