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
  <meta charset="UTF-8">
  <title>랭킹</title>
</head>

	<h1>PRACTICE EVERYDAY RANKING</h1>
	<br>
<body>
	<div>
		<ul class="score_highest_list">
			<li class="ranking-highest__item ranking-highest__item--big"> <!-- 유저 정보 -->
				<c:forEach
					var="score" items="${scoreList}" begin="0" end="0">
					<div class="ranking-highest__rank">1</div>
					<div class="ranking-highest__icon">
					<img src="${contextPath}/resources/image/${score.user_image}"
						 class="ranking-highest__image">
						<h3 align= "center">${score.user_id}</h3> <!-- 유저 아이디 -->
					</div>
					<div>
						<table>
							<thead>
								<tr>
								<c:forEach var = "userInfo" items = "${userInfo}">
									<c:if test = "${score.user_id eq userInfo.user_id}">
										<th>가  입  일: </th><td> &nbsp; &nbsp;${userInfo.user_signdate}</td>
									</c:if>
								</c:forEach>		
								</tr>
								<tr>
									<th>종 합 점 수: </th><td> &nbsp; &nbsp;${score.score_totalPoint}</td>
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




	<div>	<!-- 카테고리1 리스트 -->
		<h3>문제출제정보</h3>
		<table class="score_table">	<!-- 6위부터의 정보 -->
				<tr>
					<th class="score_header">구분</th>
					<th class="score_header">문제내역</th>
					<th class="score_header">획득점수</th>
					<th class="score_header">획득날짜</th>
				</tr>

			<c:choose>
				<c:when test="${categoryInfo1 !=null }">
					<c:forEach var="list1" items="${categoryInfo1}" varStatus="scoreNum">
						<tr align="center">
							<td class="score_cell">${scoreNum.count}</td>			<!-- 구분 -->
							<td class="score_cell">${list1.score_content}</td>		<!-- 문제내역 -->
							<td class="score_cell">${list1.score_point}</td>		<!-- 획득점수 -->
							<td class="score_cell">${list1.score_date}</td>				<!-- 획득날짜 -->
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		</div>
<br>

	<div>	<!-- 카테고리2 리스트 -->
		<br> <br>
		<h3>문제풀이정보</h3>
		<table class="score_table">	<!-- 6위부터의 정보 -->
				<tr>
					<th class="score_header">구분</th>
					<th class="score_header">문제내역</th>
					<th class="score_header">획득점수</th>
					<th class="score_header">획득날짜</th>
				</tr>

			<c:choose>
				<c:when test="${categoryInfo2 !=null }">
					<c:forEach var="list2" items="${categoryInfo2 }" varStatus="scoreNum">
						<tr align="center">
							<td class="score_cell">${scoreNum.count}</td>			<!-- 구분 -->
							<td class="score_cell">${list.score_content}</td>		<!-- 문제내역 -->
							<td class="score_cell">${list2.score_point}</td>		<!-- 획득점수 -->
							<td class="score_cell">${list2.score_date}</td>				<!-- 획득날짜 -->
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		</div>
    <br>
    		<a href ="${contextPath}/F/F_P001/categoryScore.page?score_category=1" >문제출제랭킹</a>
    		<a href = "${contextPath}/F/F_P001/listScore.page" >전체랭킹</a>
    		<a href ="${contextPath}/F/F_P001/categoryScore.page?score_category=2" >문제풀이랭킹</a>
    	<div id = "search">
    		<form name = "frmSearch" action = "${contextPath}/F/F_P001/searchUser.page">
    			<input name = "searchUser" type = "text" style="width:200px;" placeholder = "유저 아이디를 입력하세요." onKeyUp = "user_idSearch()" />
    			<input type = "submit" name = "search" value = "검 색" />
    		</form>
 		</div>
</body>
</html>