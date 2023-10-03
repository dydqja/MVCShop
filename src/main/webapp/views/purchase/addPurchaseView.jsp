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

    <title>상품 구매</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

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

    </style>

</head>
<body>

<form name="detailForm" method="post">

    <div class="container">

        <div class="header_div" >
            <img src="/views/images/ct_ttl_img01.gif" dwith="15" height="37"/>상품구매
        </div>

        <br/>
        <hr/>

        <div class="row">
            <label class="col-xs-4 col-md-2"><strong>상품번호</strong></label>
            <div class="col-xs-8 col-md-4">${product.prodNo}</div>
            <input type="hidden" name="prodNo" value="${product.prodNo}"/>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
            <div class="col-xs-8 col-md-4">${product.prodName}</div>
        </div>

        <hr/>

<%--        <div class="row">--%>
<%--            <div class="col-xs-4 col-md-2"><strong>이미지</strong></div>--%>
<%--            <div style="max-width: 100%; height: 200px; overflow: hidden; text-align: left; ">--%>
<%--                <c:if test="${product.fileName eq null || product.fileName eq ''}">--%>
<%--                    <img src="/views/images/no-image.png" style="width: 100%; height: 100%; object-fit: contain; display: block; margin: 0; " class="imgFile">--%>
<%--                </c:if>--%>
<%--                <c:if test="${not empty product.fileName}">--%>
<%--                    <img src="/views/images/uploadFiles/${product.fileName}" style="width: 100%; height: 100%; object-fit: contain; display: block; margin: 0;" class="imgFile">--%>
<%--                </c:if>--%>
<%--            </div>--%>
<%--            </td>--%>
<%--        </div>--%>

<%--        <hr/>--%>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>상세정보</strong></div>
            <div class="col-xs-8 col-md-4">${product.prodDetail}</div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
            <div class="col-xs-8 col-md-4">${product.manuDate}</div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>가격</strong></div>
            <div class="col-xs-8 col-md-4">${product.price}</div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
            <div class="col-xs-8 col-md-4">${product.regDate}</div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>구매자아이디</strong></div>
            <div class="col-xs-8 col-md-4">${sessionScope.user.userId}</div>
            <input type="hidden" name="buyerId" value="${sessionScope.user.userId}"/>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
            <div class="col-xs-8 col-md-4">
                <select id="paymentOption">
                    <option value="selectPayment">::선택::</option>
                    <option value="bankTransfer">무통장입금</option>
                    <option value="cardPayment">카드</option>
                </select>
            </div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>구매자이름</strong></div>
            <div class="col-xs-8 col-md-4">
                <input type="text" id="receiverName" name="receiverName">
            </div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>구매자연락처</strong></div>
            <div class="col-xs-8 col-md-4">
                <input type="text" id="receiverPhone" name="receiverPhone">
                <label> 특수문자 제외 숫자만 입력</label>
            </div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>구매자주소</strong></div>
            <div class="col-xs-8 col-md-4">
                <input type="text" id="dlvyAddr" name="dlvyAddr">
            </div>
        </div>

        <hr/>

        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>구매요청사항</strong></div>
            <div class="col-xs-8 col-md-4">
                <input type="text" id="dlvyRequest" name="dlvyRequest">
            </div>
        </div>

        <hr/>

        <div class="form-group ct_write manuDate">
            <label>제조일자 &nbsp;<img src="/views/images/ct_icon_date.gif" width="15" height="15"
                                   onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>&nbsp;
                <img src="/views/images/ct_icon_red.gif">
            </label>
            <input type="text" class="form-control ct_input_g" id="manuDate" name="manuDate" placeholder="달력을 클릭해 입력.." readonly>
        </div>


    </div>

</form>

<script type="text/javascript" src="../views/javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

</body>
</html>
