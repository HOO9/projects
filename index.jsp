<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/include/taglib.jsp"%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>VEMANAGER | 리브테크놀로지</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<meta name="format-detection" content="telephone=no,address=no,email=no">
	<link rel="shortcut icon" type="image/x-icon" href="${ctx}/resources/images/common/img_logo_icon.png">
	<link rel="stylesheet" href="${ctx}/resources/css/style_user.css">
	<!--[if lt IE 9]><link rel="stylesheet" href="css/ie8.css"><![endif]-->
	<script src="${ctx}/resources/js/jquery.js"></script>
	<script src="${ctx}/resources/js/default.js"></script>


<script language="javascript">
	function goFocus(){
	    if(event.keyCode == 13)
	    {
	        event.returnValue = false;
	        document.all.USER_PWD.focus();
	    }
	    return false;
	}
	
	function goDefault( userGb ) {
		$("#USER_ID").val('');
		$("#USER_PWD").val('');
		
		if(userGb == "Y") {
		      document.loginForm.action = "${ctx}/system/basicInfoPage.do";
		} else {
		 // document.loginForm.action = "${ctx}/users/userMainPage.do";	
	//	document.loginForm.action = "${ctx}/pages/mainPage.do";	
		  document.loginForm.action = "${ctx}/pages/getScheduleList.do";
		}
        document.loginForm.submit();
	}
	
	function isValidate() {
		var frm = document.loginForm;

		if(frm.USER_ID.value == "") {
			alert('<spring:message code="login.alert_check_id"/>');
			return false;
		}
		if(frm.USER_PWD.value == "") {
			alert('<spring:message code="login.alert_check_pw"/>');
			return false;
		}
		return true;
	}
	function goLogin() {

		if(isValidate() == false) return false;
		
		var loginUrl = "${ctx}/login.do?locale=" + $("#locale option:selected").val();
		var params = $('#loginForm input').serialize();
		
		$.ajax({ url:loginUrl,
			data : params,
			type : "POST",
			dataType: "json",
			success : function(data) {
				if(data.SUCCESS_YN == "Y") {
					goDefault(data.CHK);
				} else {
					if(data.ErrorCode =='LOGIN_001') {
						idError(data.ErrorMsg);
					}
					else if(data.ErrorCode =='LOGIN_002') {
						pwdError(data.ErrorMsg);
					} else {
						alert('<spring:message code="login.alert_loing_dismatch"/>');
					}
				}
			},
			error :  function(xhr, testStatus, errorThrown) {
				alert('<spring:message code="login.alert_loing_error"/>' + (errorThrown ? errorThrown : xhr.status));
			}
		});
	}
	
	
	
	function idError( errMsg ){ 
	    alert(errMsg);
		$("#USER_ID").val('');
		$("#USER_PWD").val('');
	}
	function pwdError( errMsg ){ 
	    alert(errMsg);
		$("#USER_PWD").val('');	    
	}	
	
</script>	
</head>
<body class="login">
<form id="loginForm" name="loginForm" method="post">
	<div id="wrap">
		<div class="login_box">            
		    <img src="${ctx}/resources/images/logo_vemanager.png">
		    <select class="sel" id="locale" name="locale">
	            <option value='en'><spring:message code="login.selection.en"/></option>
	            <option value='ko' selected="selected"><spring:message code="login.selection.ko"/></option>
            </select>
			<h1><spring:message code="login.title"/></h1>
			<img src="${ctx}/resources/images/login_bg003.png">
			<div class="login_tit">
			    <p><spring:message code="login.textbox_title"/></p>
			    <p><spring:message code="login.textbox_content"/></p>
            </div>
            <div class="login_input">
                <ul>
                    <li>
                        <label><spring:message code="login.inputbox_id"/></label>
                        <input name="USER_ID" id="USER_ID" type="text" value="" placeholder="<spring:message code="login.inputbox_id_placeholder"/>" onkeydown="javascript:if(event.keyCode == 13) {goFocus();}">
                    </li>
                    <li>
                        <label><spring:message code="login.inputbox_pw"/></label>
                        <input name="USER_PWD" id="USER_PWD" type="password" value="" placeholder="<spring:message code="login.inputbox_pw_placeholder"/>" onkeydown="javascript:if(event.keyCode == 13) {goLogin();}">
                    </li>                                    
                </ul>
                <a href="#" onClick="javascript:goLogin()"><spring:message code="login.button_login"/></a>           
			</div>
			<div class="rem_id">
			    <input type="checkbox"><label><spring:message code="login.checkbox_content"/></label>
            </div>
		</div>
	</div>
	 
</form>	
</body>
</html>