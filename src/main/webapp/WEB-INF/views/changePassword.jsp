<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/img/favicon.png" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/util.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<style type="text/css">
.bg-overlay {
	background: linear-gradient(rgba(228, 202, 17, 0.4),
		rgba(255, 77, 23, 0.4)),
		url("${pageContext.request.contextPath}/resources/img/bodybg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	color: #fff;
	height: auto;
	width: auto;
	padding-top: 0px;
}
</style>
</head>
<body class="bg-overlay">
	<img src="${pageContext.request.contextPath}/resources/img/Logo.png"></img>
	<div class="limiter">
		<div class="container-login100">

			
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-50">
			
			<div style="color: red; text-align: center;">
				<h4><c:out value="${sessionScope.loginError}" /></h4>
			</div>
			<br><br>
			
			
				<form class="login100-form validate-form" id="form-login"
					action="changeToNewPassword" method="post">

					<span class="login100-form-title p-b-33"> <!-- <img src="/adminpanel/resources/img/Madhvi_Logo(4).jpg"></img> -->Change
						Password
					</span>

					<div class="wrap-input100 validate-input"
						data-validate="Enter New Password"
						style="border-radius: 25px;">
						<input class="input100" type="password" id="newPass" name="newPass"
							placeholder="Enter New Password" style="border-radius: 25px;"> <span
							class="focus-input100-1"></span> <span class="focus-input100-2"></span>
							  <span class="error_form text-danger" id="error_newPass"
									style="display: none; color: red;">This field is required</span>
					</div>
					<br>
					
					<div class="wrap-input100 validate-input"
						data-validate="Enter Confirm Password"
						style="border-radius: 25px;">
						<input class="input100" type="password" id="confrmPass" name="confrmPass"
							placeholder="Confirfm New Password" style="border-radius: 25px;" onkeyup="checkPassword()"> <span
							class="focus-input100-1"></span> <span class="focus-input100-2"></span>
							 <span class="error_form text-danger" id="error_confirmPass"
								style="display: none; color: red;">This field is required</span>
							<span class="error_form text-danger" id="error_match"
								style="display: none; color: red;">New password not matched with confirm password</span>
					</div>

					<div class="container-login100-form-btn m-t-20"
						style="border-radius: 25px;">
						<button class="login100-form-btn" style="border-radius: 25px;" id="pass_btn" type="submit" disabled="disabled">
							Change Password</button>
					</div>
					<input type="hidden" id="userId" name="userId" value="${userId}">
					<c:if test="${not empty loginResponseMessage}">
						<!-- here would be a message with a result of processing -->
						<div style="color: white;">${loginResponseMessage}</div>

					</c:if>

					<div class="text-center p-t-45 p-b-4">

						<span class="txt1" >
							<!-- Forgot -->
							<a href="${pageContext.request.contextPath}/login"><span class="links" style="color:white;">
							Back To Login</span></a>
						</span>
					</div>

					<div class="text-center">
						<span class="txt1"> <!-- Create an account? -->
						</span> <a href="#" class="txt2 hov1"> <!-- Sign up -->
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

<script>
function checkPassword(){
	var npass= $("#newPass").val();
	var cpass = $("#confrmPass").val();
	//alert("---"+npass+" "+cpass)
if (npass != cpass) {   
	
		$("#error_match")
		.show()
		document.getElementById("pass_btn").disabled = true;
		return false;
	}else {
		$("#error_match")
			.hide()
			document.getElementById("pass_btn").disabled = false;
			return true;
			
	}
}

/* $(document)
.ready(
		function($) {

			$("#form-login")
					.submit(
							function(e) {
								var isError = false;
								alert($("#newPass").val());

								if (!$("#newPass").val()) {

									isError = true;
								
									$("#error_newPass")
											.show()
									//return false;
								} else {
									$("#error_newPass")
											.hide()
								}
								
								
								if (!$("#confrmPass").val()) {

									isError = true;
								
									$("#error_confrmPass")
											.show()
									//return false;
								} else {
									$("#error_confrmPass")
											.hide()
								}

								if ($("#newPass").val() != $("#confirmPass").val()) { 
									
									isError = true; 
									
									$("#error_match")
									.show()
									
								}else {
									$("#error_match")
										.hide()
								}
								

								if (!isError) {

									var x = confirm("Do you really want to submit the form?");
									if (x == true) {

										document
												.getElementById("sub1").disabled = true;
										document
												.getElementById("sub2").disabled = true; 
										return true;
									}
								}
								return false;
							});
		}); */
</script>

	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<!--===============================================================================================-->
	<script
		src="${pageContext.request.contextPath}/resources/vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/js/mains.js"></script>

</body>
</html>
