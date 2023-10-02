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

    <div class="header_div" >
        <img src="/views/images/ct_ttl_img01.gif" dwith="15" height="37"/>상품구매
    </div>

</body>
</html>
