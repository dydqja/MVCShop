<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<title>��ǰ���</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

	<script type="text/javascript" src="../javascript/calendar.js"></script>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
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
    
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=====����Code �ּ� ó�� ��  jQuery ���� ======//
		function fncAddProduct(){
			//Form ��ȿ�� ����
 			//var name = document.detailForm.prodName.value;
			//var detail = document.detailForm.prodDetail.value;
			//var manuDate = document.detailForm.manuDate.value;
			//var price = document.detailForm.price.value;
			
			var name=$("input[name='prodName']").val();
			var detail=$("input[name='prodDetail']").val();
			var manuDate=$("input[name='manuDate']").val();
			var price=$("input[name='price']").val();
			

			if(name == null || name.length<1){
				alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
				return;
			}
			
			if(manuDate == null || manuDate.length<1){
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(price == null || price.length<1){
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}

			//document.detailForm.action='/product/addProduct';
			//document.detailForm.submit();
			$("form").attr("method","POST").attr("enctype","multipart/form-data").attr("action","/product/addProduct").submit();
		}
		//===========================================//
		//==> �߰��Ⱥκ� : "��ǰ���"  Event ����
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( ".submit" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('���')" ).html() );
				fncAddProduct();
			});
		//==> �߰��Ⱥκ� : "���"  Event ó�� ��  ����
			 $( ".cancel" ).on("click" , function() {
				 $("form")[0].reset();
			
		 		});
			 });
			
		
		
		/*============= jQuery ���� �ּ�ó�� =============
		function resetData(){
			document.detailForm.reset();
		}========================================	*/
	
	</script>
	
</head>

<body bgcolor="#ffffff" text="#000000">


<form class="form-inline" name="detailForm">
<!-- div �������� -->


<div class="header_div" >
	<img src="/images/ct_ttl_img01.gif" dwith="15" height="37"/>��ǰ���		
</div>
<br/><br/>
 
<div class="form-group ct_write">
	<label for="prodName">��ǰ��&nbsp;<img src="/images/ct_icon_red.gif"></label>
	<input type="text" class="form-control ct_input_g" id="prodName" name="prodName" >
</div>
<br/><br/>

<div class="form-group ct_write">
	<label for="prodDetail">��ǰ������&nbsp;<img src="/images/ct_icon_red.gif"></label>
	<input type="text" class="form-control ct_input_g" id="prodDetail" name="prodDetail" >
</div>
<br/><br/>
 
<div class="form-group ct_write manuDate">
	<label>�������� &nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"
							   onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>&nbsp;
						  <img src="/images/ct_icon_red.gif">
	</label>
	<input type="text" class="form-control ct_input_g" id="manuDate" name="manuDate" placeholder="�޷��� Ŭ���� �Է�.." readonly>	
</div>
<br/><br/>

<div class="form-group ct_write">
	<label for="price">����&nbsp;<img src="/images/ct_icon_red.gif"></label>
	<input type="text" class="form-control ct_input_g" id="price" name="price" >
</div>
<br/><br/>
 
<div class="form-group ct_write">
    <label for="uploadFiles">��ǰ�̹���</label>
    <input type="file" id="uploadFiles" name="uploadFiles" multiple="multiple">
    <p class="help-block">�ִ�뷮 ��¼��</p>
</div>
<br/><br/>
<br/><br/>

<div>
<button class="btn btn-primary submit" >���</button>
<button class="btn btn-danger cancel" >���</button>
</div>






<!-- div �������� �� -->




</form>


</body>
</html>
