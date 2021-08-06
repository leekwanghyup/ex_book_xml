<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<form class="form_inner">
	<h2 class="text-center">회원가입</h2>
	<div class="form-group" >
		<label for="" class="control-label">아이디</label>
		<div>
			<input type="text" class="form-control py-4" 
				placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="30">
		</div>
	</div>
	<div class="form-group" >
		<label for="" class="control-label">패스워드</label>
		<div>
			<input type="password" class="form-control py-4" 
				placeholder="패스워드" maxlength="30">
		</div>
	</div>
	<div class="form-group">
		<label for="" class="control-label">패스워드 확인</label>
		<div>
			<input type="password" class="form-control py-4" 
				placeholder="패스워드 확인" maxlength="30">
		</div>
	</div>
	<div class="form-group">
		<label for="" class="control-label">이름</label>
		<div>
			<input type="text" class="form-control py-4" 
				placeholder="한글만 입력 가능합니다." maxlength="15">
		</div>
	</div>

	<div class="form-group" >
		<label for="" class="control-label">별명</label>
		<div>
			<input type="text" class="form-control py-4" placeholder="별명"
				maxlength="15">
		</div>
	</div>

	<div class="form-group" >
		<label for="" class="control-label">이메일</label>
		<div>
			<input type="email" class="form-control py-4" id="email"
				placeholder="이메일" maxlength="40">
		</div>
	</div>
	<div class="form-group" >
		<label for="" class="control-label">휴대폰 번호</label>
		<div>
			<input type="tel" class="form-control  py-4" 
				placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
		</div>
	</div>
	<div class="form-group">
		<label for="" class="control-label">성별</label>
		<div>
			<select class="form-control py-4">
				<option value="male" selected>남</option>
				<option value="female">여</option>
			</select>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmailReceiveYn" class="control-label">이메일
			수신여부</label>
		<div>
			<label class="radio-inline"> <input type="radio" 
				name="" value="Y" checked> 동의합니다.
			</label> <label class="radio-inline"> <input type="radio" 
				name="" value="N"> 동의하지 않습니다.
			</label>
		</div>
	</div>
	<div class="form-group">
		<label for="inputPhoneNumber" class="control-label">SMS 수신여부</label>
		<div>
			<label class="radio-inline"> <input type="radio"
				name="" value="Y" checked> 동의합니다.
			</label> <label class="radio-inline"> <input type="radio"
				name="" value="N"> 동의하지 않습니다.
			</label>
		</div>
	</div>
	<div class="form-group">
		<div class="sign-in text-center">
			<button type="submit" class="btn btn-primary registMember">가입하기</button>
		</div>
	</div>
</form>

<%@ include file="../includes/footer.jsp"%>