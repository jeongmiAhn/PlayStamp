var idFlag = false;
var pwFlag = false;
var mailFlag = false;


function checkForm()
{
	if(idFlag==false) {
		alert("아이디를 다시 확인 해주세요.");
        return false;
    }
	 
	if(!$("#chkAll").prop("checked"))
	{
		$("#terms").text("체크해야 가입이 가넝");
		return false;
	}
}

$(function()
{	
	//-- 아이디 체크 시작
	$("#userId").on("input", function()
	{	
		var idRegex = /^[A-Za-z0-9]{4,12}$/;
		var userId = $("#userId").val();
		
		alert("dd");
		
		// 잘못된 형식일 때
		if(!idRegex.test(userId)){
			 $("#checkId").text("4~20 글자 사이 영문, 숫자만 입력 가능합니다.").css("color", "red");
			 idFlag = false;
		}
		
		// 올바른 형식일 때
		else {
			$("#checkId").text("유효한 아이디 형식입니다.").css("color", "green");
			idFlag = true;
			
			$("#idChkBtn").click(function() // 올바른 형식일 때 클릭해야 작동
			{
   				$.ajax(
   				{
   					url: "checkSignup.action"
   				  , type: "POST"
   				  , data: {"userId": $('#userId').val()}
   				  , success : function(data)
   				    {
   					  if (data=="YES") // 중복이 아닌 경우 = submit 가능
   					  {
   						  $("#idChkBtn").hide();
   						  $("#userId").css("border-color", "blue");
   						  alert($("#checkId").val());
   						  idFlag = true;
   					  }
   					  else if(data=="NO")
   					  {
   						  $("#checkId").text("이미 사용중인 아이디입니다.").css("color", "red");
   						  $("#userId").focus();
   						  idFlag = false;
   					  }
   					},
   					error : function(request,status,error)
   					{
   				        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
   				    }
   				});//-- ajax 끝

			});//-- 아이디 중복 체크 끝
			
		}//-- else 끝
		

	});//-- id 체크 끝
	
	
	//-- 이메일 체크 시작
	$("#userMail").on("input", function()
	{
		var mailRegex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(mailRegex.test($("#userMail").val())){
			 $("#checkMail").text("ㅈㅇㅇ");
		}
		else{
			 $("#checkMail").text("틀렸음").css("color", "red");
			 mailFlag = false;
		}

	});
	
	//-- 비밀번호 일치 확인
	$("#userPw2").blur(function()
	{
		
		if($('#userPw').val() != $('#userPw2').val())
		{
			$("#checkPw").text("비밀번호가 일치하지 않습니다.").css("color", "red");
		    
			$('#userPw2').val('');
			$('#userPw2').focus();
			$('#userPw2').css("border-color", "red");
			
			pwFlag = false;
		}
		else if($('#userPw').val() == $('#userPw2').val())
		{
			$("#checkPw").text("비밀번호가 일치합니다.").css("color", "green");
			pwFlag = true;
		}
		
	 }); //-- 비밀번호 체크 끝


	
});