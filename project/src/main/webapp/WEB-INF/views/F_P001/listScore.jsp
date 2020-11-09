<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>

<script type = "text/javascript">
	var loopSearch = true;
	function user_idSearch(){
		if(loopSearch == false)
			return;
			var value = document.frmSearch.searchUser.value;
				$.ajax({
					type   : "get",
					async  : "${contextPath}/F/F_P001/searchUser.page",
					data   : {user_id:value},
					succes : function(data, textStatus){
						var jsonInfo = JSON.parse(data);
						displayResult(jsonInfo);
					},
					error : function(data, textStatus){
						alert("에러가 발생했습니다." + data);
					},
					complete : function(data, textStatus){
					}
				});
		}
</script>

  <meta charset="UTF-8">
 

<style>
.score_table {margin:auto; align: center; width:70%;table-layout:fixed; paddding-left:50px; background-color:#ededed;border:solid 1px #cdd2d2;}
.score_header{height:41px;padding:0;border-bottom:1px solid #cdd2d2;background:#f2f2f2;line-height:17px;font-size:14px;text-align:center;color:#444b4b;font-weight:normal;}
.score_cell{border-bottom:1px solid #cdd2d2;height:54px;line-height:16px;font-family:Helvetica,AppleSDGothic,"Apple SD Gothic Neo",AppleGothic,Arial,Tahoma;font-size:14px;}
.score_highest_list{text-align:center;margin-bottom:20px;}
.score_highest_box{position:relative;display:inline-block;padding:14px 18px;border:2px solid #bdbbbb;width:220px;background:#fff;box-sizing:border-box;text-align:left;margin-top:30px;margin-left:30px;}.ranking-highest__item a{text-decoration:none;}
.score_highest_box_big{display:block;width:800px;margin:0 auto;padding:35px 40px;border-width:5px;}
.score_highest_box_big+score_highest_box{margin:0;}
.score_highest_box:after{visibility:hidden;display:block;font-size:0;content:"";clear:both;height:0;}
.score_highest_rank{width:30px;background:#bdbbbb;padding:3px 0;line-height:24px;font-family:Helvetica,AppleSDGothic,"Apple SD Gothic Neo",AppleGothic,Arial,Tahoma;font-size:21px;text-align:center;color:#fff;}.ranking-highest__item .ranking-highest__rank{position:absolute;top:0;left:0;margin-top:-2px;margin-left:-2px;}
.highest-rank{border-radius: 100px; }
</style>

<link href="<c:url value="/resources/css/rankScore.css" />" rel="stylesheet">
  <title>랭킹</title>
</head>
	<div  style ="align: center; width: 1100px; margin:auto; color:#5573C9;">
		<h1>PRACTICE EVERYDAY RANKING</h1>
		<h2>ALL USER SCORE</h2>
	</div>	
	<br>
<body>
	<div style ="align: center; width: 1100px; margin:auto;">
		<ul class="score_highest_list">
			<li class="ranking-highest__item ranking-highest__item--big">
				<c:forEach
					var="score" items="${scoreList}" begin="0" end="0">
					<div class="ranking-highest__rank">1</div>
					<div class="ranking-highest__icon">
						<img src="${contextPath}/resources/image/${score.user_image}"
						 	 class="ranking-highest__image">
					</div>
					<div>
						<table>
							<thead>
								<tr>
									<a href="${contextPath}/F/F_P001/viewUser_score.page?user_id=${score.user_id}">
									<h3>${score.user_id}</h3>
									</a>
								</tr>
								<tr>
								<c:forEach var = "userInfo" items = "${userInfo}">
									<c:if test = "${score.user_id eq userInfo.user_id}">
										<th>가  입  일: </th><td> &nbsp; &nbsp;${userInfo.user_signdate}</td>
									</c:if>
								</c:forEach>		
								</tr>
								<tr>
									<th>종 합 점 수: </th><td class="ranking-highest-champion__winratio--red"> &nbsp; &nbsp;${score.score_totalPoint}</td>
								</tr>
								<tr>
								<c:forEach var="category1" items="${categoryList1}">
									<c:if test="${score.user_id eq category1.user_id}">
										<th>문제출제점수: </th><td> &nbsp; &nbsp;${category1.score_totalPoint}</td>
									</c:if>
								</c:forEach>
								</tr>
								<tr>
								<c:forEach var="category2" items="${categoryList2}">
									<c:if test="${score.user_id eq category2.user_id}">
										<th>문제풀이점수: </th><td> &nbsp; &nbsp;${category2.score_totalPoint}</td>
									</c:if>
								</c:forEach>		
								</tr>
							</thead>
						</table>
					</div>
				</c:forEach>
			</li>
		</ul>
	</div>
<div style ="width: 1100px; margin:auto;">
	<li class="ranking-highest__item">
		<c:forEach var="score" items="${scoreList}" begin="1" end="1">
			<div class="ranking-highest__rank">2</div>
			<div class="ranking-highest__icon" >
				<img src="${contextPath}/resources/image/${score.user_image}"  class="ranking-highest__image"
				 	onerror="this.src='//opgg-static.akamaized.net/images/profile_icons/profileIcondefault.jpg';" >
			</div>
			<div class="ranking-highest-champions">
				<div class="ranking-highest-champion">
					<table>
						<tr>
							<a href="${contextPath}/F/F_P001/viewUser_score.page?user_id=${score.user_id}">&nbsp;${score.user_id}</a>
						</tr>
						<tr>
							<th>종&nbsp;합&nbsp;점&nbsp;수: </th>
							<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--red">&nbsp;${score.score_totalPoint}</td>
						</tr>
						<tr>
							<c:forEach var="category1" items="${categoryList1}">
								<c:if test="${score.user_id eq category1.user_id}">
									<th>문제출제점수: </th>
										<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--blue">&nbsp;${category1.score_totalPoint}</td>
								</c:if>
							</c:forEach>
						</tr>
						<tr>					
						<c:forEach var="category2" items="${categoryList2}">
							<c:if test="${score.user_id eq category2.user_id}">
								<th>문제풀이점수: </th>
									<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--green">&nbsp;${category2.score_totalPoint}</td>
							</c:if>
						</c:forEach>
						</tr>
					</table>
				</div>
			</div>
		</c:forEach>
	</li>

	<li class="ranking-highest__item">
		<c:forEach var="score"
			items="${scoreList}" begin="2" end="2">
			<div class="ranking-highest__rank">3</div>
			<div class="ranking-highest__icon" >
				<img src="${contextPath}/resources/image/${score.user_image}"  class="ranking-highest__image"
				 	onerror="this.src='//opgg-static.akamaized.net/images/profile_icons/profileIcondefault.jpg';" >
			</div>
			<div class="ranking-highest-champions">
				<div class="ranking-highest-champion">
					<table>
						<tr>
							<a href="${contextPath}/F/F_P001/viewUser_score.page?user_id=${score.user_id}">&nbsp;${score.user_id}</a>
						</tr>
						<tr>
							<th>종&nbsp;합&nbsp;점&nbsp;수: </th>
							<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--red">&nbsp;${score.score_totalPoint}</td>
						</tr>
						<tr>
							<c:forEach var="category1" items="${categoryList1}">
								<c:if test="${score.user_id eq category1.user_id}">
									<th>문제출제점수: </th>
										<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--blue">&nbsp;${category1.score_totalPoint}</td>
								</c:if>
							</c:forEach>
						</tr>
						<tr>					
						<c:forEach var="category2" items="${categoryList2}">
							<c:if test="${score.user_id eq category2.user_id}">
								<th>문제풀이점수: </th>
									<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--green">&nbsp;${category2.score_totalPoint}</td>
							</c:if>
						</c:forEach>
						</tr>
					</table>	
				</div>
			</div>
		</c:forEach>
	</li>

	<li class="ranking-highest__item"> 
		<c:forEach var="score"
			items="${scoreList}" begin="3" end="3">
			<div class="ranking-highest__rank">4</div>
			<div class="ranking-highest__icon" >
				<img src="${contextPath}/resources/image/${score.user_image}"  class="ranking-highest__image"
				 	onerror="this.src='//opgg-static.akamaized.net/images/profile_icons/profileIcondefault.jpg';" >
			</div>
			<div class="ranking-highest-champions">
				<div class="ranking-highest-champion">
					<table>
						<tr>
							<a href="${contextPath}/F/F_P001/viewUser_score.page?user_id=${score.user_id}">&nbsp;${score.user_id}</a>
						</tr>
						<tr>
							<th>종&nbsp;합&nbsp;점&nbsp;수: </th>
							<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--red">&nbsp;${score.score_totalPoint}</td>
						</tr>
						<tr>
							<c:forEach var="category1" items="${categoryList1}">
								<c:if test="${score.user_id eq category1.user_id}">
									<th>문제출제점수: </th>
										<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--blue">&nbsp;${category1.score_totalPoint}</td>
								</c:if>
							</c:forEach>
						</tr>
						<tr>					
						<c:forEach var="category2" items="${categoryList2}">
							<c:if test="${score.user_id eq category2.user_id}">
								<th>문제풀이점수: </th>
									<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--green">&nbsp;${category2.score_totalPoint}</td>
							</c:if>
						</c:forEach>
						</tr>
					</table>	
				</div>
			</div>
		</c:forEach>
	</li>

	<li class="ranking-highest__item"> 
		<c:forEach var="score"
			items="${scoreList}" begin="4" end="4">
			<div class="ranking-highest__rank">5</div>
			<div class="ranking-highest__icon" >
				<img src="${contextPath}/resources/image/${score.user_image}"  class="ranking-highest__image"
				 	onerror="this.src='//opgg-static.akamaized.net/images/profile_icons/profileIcondefault.jpg';" >
			</div>
			<div class="ranking-highest-champions">
				<div class="ranking-highest-champion">
					<table>
						<tr>
							<a href="${contextPath}/F/F_P001/viewUser_score.page?user_id=${score.user_id}">&nbsp;${score.user_id}</a> 
						</tr>
						<tr>
							<th>종&nbsp;합&nbsp;점&nbsp;수: </th>
							<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--red">&nbsp;${score.score_totalPoint}</td>
						</tr>
						<tr>
							<c:forEach var="category1" items="${categoryList1}">
								<c:if test="${score.user_id eq category1.user_id}">
									<th>문제출제점수: </th>
										<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--blue">&nbsp;${category1.score_totalPoint}</td>
								</c:if>
							</c:forEach>
						</tr>
						<tr>					
						<c:forEach var="category2" items="${categoryList2}">
							<c:if test="${score.user_id eq category2.user_id}">
								<th>문제풀이점수: </th>
									<td class="ranking-highest-champion__winratio ranking-highest-champion__winratio--green">&nbsp;${category2.score_totalPoint}</td>
							</c:if>
						</c:forEach>
						</tr>
					</table>	
				</div>
			</div>
		</c:forEach>
	</li>
</div>	
	<div style ="align: center; width: 1100px; margin:auto;">
		<br> <br>
		<table class="score_table">	
			<thead>
				<tr>
					<th class="score_header">순위</th>
					<th class="score_header">아이디</th>
					<th class="score_header">총 점수</th>
					<th class="score_header">획득정보</th>
				</tr>
			</thead>
			<c:set var="num" value="" />
			<c:choose>
				<c:when test="${scoreList !=null }">
					<c:forEach var="score" items="${scoreList }" varStatus="scoreNum"
						begin="5">
						<tr align="center">
							<td class="score_cell">${score.score_rank}</td>
							<td class="score_cell">${score.user_id }</td>
							<td class="score_cell">${score.score_totalPoint}</td>
							<td class="score_cell"><a
								href="${contextPath}/F/F_P001/viewUser_score.page?user_id=${score.user_id }">보기</a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</div>
	
<div style ="align: center; width: 1100px; margin:auto;"><br>
    <table>
    	<div>
    		<a href ="${contextPath}/F/F_P001/categoryScore.page?score_category=1" >문제출제랭킹</a>
    		<a href = "${contextPath}/F/F_P001/listScore.page" >전체랭킹</a>
    		<a href ="${contextPath}/F/F_P001/categoryScore.page?score_category=2" >문제풀이랭킹</a>
    	</div>
    	<div id = "search">
    		<form name = "frmSearch" action = "${contextPath}/F/F_P001/searchUser.page">
    			<input name = "searchUser" type = "text" style="width:200px;" placeholder = "유저 아이디를 입력하세요." onKeyUp = "user_idSearch()" />
    			<input type = "submit" name = "search" value = "검 색" />
    		</form>
 		</div>
    </table>
</div>    
</body>
</html>