<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="bean.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
    <!-- No film chosen -->
    <c:if test="${requestScope.film eq null}">
        <!-- Alert function invalid-->
        <script>alert("Choose a film")</script>
        <c:redirect url="/film/keySearch.do"/>
    </c:if>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>${requestScope.film.fname}_电影详情</title>
<jsp:include page="dir.jsp" flush="true" />
<meta content="webkit" name="renderer" /><meta name="applicable-device" content="pc"><meta http-equiv="X-UA-Compatible" content="IE=8" /><link rel="stylesheet" href="css/3.css" />
<link rel="stylesheet" href="css/2.css" />
<script>
function reply(cno, fno, name) {
    window.open("reply.jsp?cno="+cno+"&fno="+fno+"&name="+name,"@","height=400, width=800, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}
</script>
</head>
<body class="movie-page">
<div class="whole">

    <div id="title-wrapper" class="wrapper movie-title-wrapper">
        <div class="inner-wrapper">
            <div class="movie-title-mpic">
                <a href="/" title="${requestScope.film.fname}电影海报">
                    <img src="image/${requestScope.film.pic}" alt="${requestScope.film.fname}电影海报"/>
                </a>

            </div>
            <h1 class="movie-name" title="${requestScope.film.fname}">${requestScope.film.fname}</h1>
            <div class="movie-title-detail">
                <p>
                    <span class="detail-title">类型：</span>
                    <a href="/country/中国大陆" title="中国大陆电影" target="_blank">${requestScope.film.country}</a> /
                    <a href="/movietype/喜剧" target="_blank">${requestScope.film.type}</a> <br/>
                    <span class="detail-title">上映：</span>${requestScope.film.ontime}<br/>
                    <span class="detail-title">时长：</span>${requestScope.film.duration} &nbsp; &nbsp;
                    <span class="detail-title">主演：</span>${requestScope.film.actor}
                    <br/>
                    <span class="detail-title">剧情：</span>
                    ${requestScope.film.intro}
                </p>
                <div class="movie-quickplay">
                    <a href="cinema/searchByFilm.do?fno=${requestScope.film.fno }" class="btn-big btn-green">去购票</a>
                    <a href="javascript:history.back()" class="btn-big btn-red">返回</a>
                </div>
            </div>

        </div>
    </div>
<a name="content-anchor" id="content-anchor" href="#"></a>
<div class="wrapper nav-wrapper">
    <div class="inner-wrapper">
<a href="/movie/29139" title="《${requestScope.film.fname}》预告片" class="current">预告片 <span class="shownum">1</span></a>
    </div>
</div>
<div class="wrapper">
    <div class="inner-wrapper">
    <div class="inner-2col-main">
            <h2 class="list-title">
                ${requestScope.film.fname}预告片
<div id="trailer-fromurl-filter" class="list-title-filter"></div>
            </h2>

   <video id="video" controls preload="auto" width="400px" height="300px">
 <source src="./videos/${requestScope.film.fname}.mp4" type="video/mp4">
</video>
<script>
 layer.open({
 type: 1,
 title: false,
 shadeClose: true,
 area: ['400px', '350px'],
 content: $('#box'),
 success: function(layero){
     //layer样式layer-anim导致全屏样式错乱，移除该样式即可
     setTimeout(function() {
      $(layero).removeClass('layer-anim');
     }, 0);
 }
 });
</script>
        </div>    
        <div class="inner-2col-side">
          
            <div class="side-box">
    <h3 class="list-title">
       广告栏位 <span class="align-right"><a href="/?view=bbs_post&bid=1&mid=29139" target="_blank">广告商</a></span>
    </h3>
<table class="tlist">
    <tr><td><a href="/" target="_blank">淘宝</a></td><td class="tlist-addtime">12-16</td></tr>
    <tr><td><a href="/" target="_blank">顺丰</a></td><td class="tlist-addtime">12-13</td></tr>
    <tr><td><a href="/" target="_blank">京东</a></td><td class="tlist-addtime">12-12</td></tr>
    <tr><td><a href="/" target="_blank">天猫</a></td><td class="tlist-addtime">12-10</td></tr>
</table>            </div>
      </div>
    </div>
</div>
    <div id="movie-preview-bg" class="movie-preview-bg"></div>
<div id="movie-preview-wrapper" class="movie-preview-wrapper">
    <div id="movie-preview-close" class="movie-preview-close">关闭</div>
    <div id="movie-preview-player" class="movie-preview-player"></div>
</div>

<!-- 都还没搞提交按钮 -->
        <div class="comment-block">
            <form action="personal/addcomment.do?fno=${requestScope.film.fno}" method="post">
                <textarea name="content" id="" cols="30" rows="3" placeholder="发表你的评论..."></textarea>
                 <input type="submit" value="评论">
            </form>
        </div>
    <!-- Display comments -->
    <c:forEach items="${requestScope.comment_list}" var="comment">
        <div class="comment-wrap">
            <div class="comment-block">
                <p class="comment-text">
                        ${comment.user.uname} <c:if
                        test="${comment.replyno != 1}"> @${comment.comment.user.uname}</c:if>
                    ：${comment.content}
                </p>
                <div class="bottom-comment">
                    <div class="comment-date">${comment.ctime}
                    </div>
                    <ul class="comment-actions">
                        <li class="complain">Complain</li>
                        <li class="reply">

                            <button onclick="reply(${comment.cno},${requestScope.film.fno},'${comment.user.uname}')">
                                replay
                            </button>

                            <script>
                                function openWin(url, text, winInfo) {
                                    var winObj = window.open(url, text, winInfo);
                                    var loop = setInterval(function () {
                                        if (winObj.closed) {
                                            clearInterval(loop);
                                            //alert('closed');
                                            parent.location.reload();
                                        }
                                    }, 1);
                                }
                            </script>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </c:forEach>
    <!-- If no comments -->
    <c:if test="${requestScope.comment_list eq null}">
        <p>暂无评论</p>
    </c:if>
</div>
</body>
</html>

