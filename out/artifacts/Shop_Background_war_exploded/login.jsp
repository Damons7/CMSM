<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/3/10
  Time: 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8">
    <title>社区团购商城后台登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/check_form.js"></script>
    <script type="text/javascript">
        //切换验证码
        function refreshCode(){
            //1.获取验证码图片对象
            var vcode = document.getElementById("vcode");

            //2.设置其src属性，加时间戳
            vcode.src = "${pageContext.request.contextPath}/admin/CheckCodeServlet?time="+new Date().getTime();
        }
    </script>
</head>

<body  onload="Text1.focus();">

<div class="content">
    <div class="form sign-in">
        <h2>社区团购商城后台</h2>
        <form action="${pageContext.request.contextPath}/admin/LoginServlet" method="post">
        <label>
            <span>帐号</span>
            <input type="text"  name="username" id="Text1" onblur="this.focus();"/>
        </label>
        <label>
            <span>密码</span>
            <input type="password" name="password"/>
        </label>
        <p class="forgot-pass"><a href="javascript:alert('自己想办法');">忘记密码？</a></p>
        <button type="submit" class="submit">登 录</button>
        <button type="button" class="fb-btn">手机 <span>短信验证</span> 登录</button>
        </form>

        <!-- 出错显示的信息框 -->
        <div style="color:red;position: absolute; right: 120px; top: 370px;">
            <button type="button" class="close" data-dismiss="alert" >
                <span>&times;</span>
            </button>
            <strong>${login_msg}</strong>
        </div>

    </div>



    <div class="sub-cont">
        <div class="img">
            <div class="img__text m--up">
                <h2>还未注册？</h2>
                <p>立即注册，发现大量机会！</p>
            </div>
            <div class="img__text m--in">
                <h2>已有帐号？</h2>
                <p>有帐号就登录吧，好久不见了！</p>
            </div>
            <div class="img__btn">
                <span class="m--up">注 册</span>
                <span class="m--in">登 录</span>
            </div>
        </div>
        <div class="form sign-up">
            <h2>立即注册</h2>
            <form action="${pageContext.request.contextPath}/admin/RegisterServlet" method="post"
                  onsubmit="return check()">
            <label>
                <span>帐号</span>
                <input type="text" name="username" id="registername" class="registername"/>
                <span class="reg_sp1" id="reg_sp1"></span>

            </label>

            <label>
                <span>密码</span>
                <input type="password"  name="password" id="password" class="password"/>
                <span class="reg_sp2" id="reg_sp2"></span>
            </label>
                <label>
                    <span>邮箱</span>
                    <input type="email" name="email" id="email" class="email"/>
                    <span class="reg_sp5" id="reg_sp5"></span>
                </label>
            <label>
                <span>验证码</span>
                <input type="text" name="verifycode" class="verifycode" id ="verifycode"/>
                <span class="reg_sp3"><a href="javascript:refreshCode();">
                <img src="${pageContext.request.contextPath}/admin/CheckCodeServlet" title="看不清点击刷新" id="vcode"/>
            </a>
                </span>
                <span class="reg_sp4" id="reg_sp4"></span>
            </label>
            <button type="submit" class="submit">注 册</button>
            <button type="button" class="fb-btn">手机 <span>短信验证</span> 注册</button>
            </form>
        </div>
    </div>
</div>

<script src="js/script.js"></script>

</body>

</html>
