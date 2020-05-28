<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/commander.css">
    <title>Insert title here</title>
    <script>
        deleteUser=function(id){
            //用户安全提示
            if(confirm("您确定要删除吗？")){
                //访问路径
                location.href="${pageContext.request.contextPath}/User/delUserServlet?id="+id+" ";
            }
        }
        $(function(){

            selectAll=function(obj){
                //获取下边的复选框
                $(".itemSelect").prop("checked",obj.checked);
            }
            //给删除选中按钮添加单击事件
            $("#delSelected").click(function () {
                if(confirm("您确定要删除选中？")) {
                    var flag = false;
                    //判断是否有选中条目
                    var cbs = $(".itemSelect");
                    for (var i = 0; i < cbs.length; i++) {
                        if (cbs[i].checked) {
                            //有一个条目选中了
                            flag = true;
                            break;
                        }
                    }
                    if (flag) {//有条目被选中
                        //表单提交
                        $("#form").submit();
                    }
                    else{
                        alert("未选中");
                    }
                }
            })

        })

    </script>
</head>
<body>


<div class="container">
    <h3 style="text-align: center">用户信息列表</h3>
    <div style="float: left;">
        <form class="form-inline" action="${pageContext.request.contextPath}/FindUserByPageServlet?condition=1" method="post">
            <div class="form-group">
                <label >&nbsp;&nbsp;&nbsp;&nbsp;团长名称 ：</label>
                <input type="text" class="form-control" id="exampleInputEmail3" placeholder="名称、电话、邮箱">
            </div>

            <button type="submit" class="btn btn-default">搜索</button>
        </form>
    </div>
    <div style="float: right;margin: 5px;">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/addShop.jsp">添加联系人</a>
        <a class="btn btn-primary" href="javascript:void(0);" id="delSelected">删除选中</a>

    </div>
    <form id="form" targer="center" action="${pageContext.request.contextPath}/User/delSelectedServlet" method="post">
        <table border="1" class="table table-bordered table-hover">
            <tr class="success">
                <th><input type="checkbox" id="firstCb" onclick="selectAll(this)"></th>
                <th>编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>地址</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>操作</th>
            </tr>

            <c:forEach items="${pb.list}" var="user" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="uid" class="itemSelect" value="${user.id}"></td>
                    <td>${s.count}</td>
                    <td>${user.name}</td>
                    <td>${user.sex}</td>
                    <td>${user.age}</td>
                    <td>4</td>
                    <td>${user.phone}</td>
                    <td>${user.email}</td>
                    <td><a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/User/FindUserServlet?id=${user.id}">修改</a>&nbsp;
                        <a class="btn btn-default btn-sm" href="javascript:deleteUser(${user.id});">删除</a></td>
                </tr>

            </c:forEach>


        </table>
    </form>
    <div>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${pb.currentPage == 1}">
                <li class="disabled">

                    </c:if>

                    <c:if test="${pb.currentPage != 1}">
                <li>
                    </c:if>
                    <a href="javascript:void(0)" onclick="showAtRight('${pageContext.request.contextPath}/User/FindUserByPageServlet?currentPage=${pb.currentPage - 1}&rows=5')" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>


                </li>


                <c:forEach begin="1" end="${pb.totalPage}" var="i" >


                    <c:if test="${pb.currentPage == i}">
                        <li class="active"><a href="#" onclick="showAtRight('${pageContext.request.contextPath}/User/FindUserByPageServlet?currentPage=${i}&rows=5')">${i}</a></li>
                    </c:if>
                    <c:if test="${pb.currentPage != i}">
                        <li><a href="javascript:void(0)" onclick="showAtRight('${pageContext.request.contextPath}/User/FindUserByPageServlet?currentPage=${i}&rows=5')">${i}</a></li>
                    </c:if>

                </c:forEach>

                <c:if test="${pb.totalPage == pb.currentPage}">
                <li class="disabled">
                    <a href="javascript:return false;" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        </c:if>

                        <c:if test="${pb.currentPage !=pb.totalPage }">
                <li>

                    <a href="javascript:void(0)" onclick="showAtRight('${pageContext.request.contextPath}/User/FindUserByPageServlet?currentPage=${pb.currentPage + 1}&rows=5')" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a></c:if>
                </li>
                <span style="color:#337ab7; font-size: 25px;margin-left: 5px;">
                    共${pb.totalCount}条记录，共${pb.totalPage}页
                </span>

            </ul>
        </nav>

    </div>


</div>


</body>
</html>
