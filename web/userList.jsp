



<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commander.css">
	<title>会员信息</title>
	<script>
        deleteUser=function(id,currentPage,condition){
            //用户安全提示
            if(confirm("您确定要删除吗？")){
                //访问路径
                $.get("User/delUserServlet", {id:id}, function (a){
                    if(a!=0){
                        alert("删除成功！");
                        load(currentPage,condition);
                    }
                    else
                        alert("删除失败！");
                })}
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
                        var uids=[];
                        $('.itemSelect:checked').each(function(){
                            uids.push($(this).val());
                        });
                        var uid_json=JSON.stringify(uids)
                        $.get("User/delSelectedServlet", {uid:uid_json}, function (a1){
                            if(a1!=0){
                                alert("删除成功！");
                                load(1,null);
                            }
                            else
                                alert("删除失败！");
                        })
                    }
                    else{
                        alert("未选中");
                    }
                }
            })

        })


        load=function (currentPage,condition) {
//
            $.get("User/FindUserByPageServlet", {currentPage: currentPage,rows:5,condition:condition}, function (pb) {
                //解析pagebean数据，展示到页面上

                //1.分页工具条数据展示
                //1.1 展示总页码和总记录数
                var _page1='共'+pb.totalCount+'条记录，共'+pb.totalPage+'页';
                $("#_page").html(_page1);

                var lis = "";
                //计算上一页的页码
                var beforeNum =  pb.currentPage - 1;
                if(beforeNum <= 0){
                    beforeNum = 1;
                }

                if(pb.currentPage==1) {
                    var beforePage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                else{
                    var beforePage = '<li><a href="javascript:void(0)" onclick="load('+beforeNum+',\''+condition+'\')" aria-label="Previous">' +
                        '<span aria-hidden="true">&laquo;</span>' +
                        '</a></li>';
                }
                lis += beforePage;

                //1.2 展示分页页码
                /*
                    1.一共展示10个页码，能够达到前5后4的效果
                    2.如果前边不够5个，后边补齐10个
                    3.如果后边不足4个，前边补齐10个
                */

                // 定义开始位置begin,结束位置 end
                var begin; // 开始位置
                var end ; //  结束位置


                //1.要显示10个页码
                if(pb.totalPage < 10){
                    //总页码不够10页

                    begin = 1;
                    end = pb.totalPage;
                }else{
                    //总页码超过10页

                    begin = pb.currentPage - 5 ;
                    end = pb.currentPage + 4 ;

                    //2.如果前边不够5个，后边补齐10个
                    if(begin < 1){
                        begin = 1;
                        end = begin + 9;
                    }

                    //3.如果后边不足4个，前边补齐10个
                    if(end > pb.totalPage){
                        end = pb.totalPage;
                        begin = end - 9 ;
                    }
                }

                for (var i = begin; i <= end ; i++) {
                    var li;
                    //判断当前页码是否等于i
                    if(pb.currentPage == i){

                        li = '<li class="active"><a href="javascript:void(0)" onclick="load('+i+',\''+condition+'\')">'+i+'</a></li>';

                    }else{
                        //创建页码的li
                        li = '<li><a href="javascript:void(0)" onclick="load('+i+',\''+condition+'\')">'+i+'</a></li>';
                    }
                    //拼接字符串
                    lis += li;
                }

                var nextNum =  pb.currentPage +1;

                if(nextNum==pb.totalPage+1){
                    var nextPage = '<li class="disabled"><a href="javascript:void(0)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';

                }else {
                    var nextPage = '<li><a href="javascript:void(0)"  onclick="load(' + nextNum + ',\''+condition+'\')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
                }
                lis += nextPage;

                $("#pagination").html(lis);

				$(".trclass").remove();
                for (var i = 0; i < pb.list.length; i++) {
                    //获取{rid:1,rname:"xxx"}
                    var route2 = pb.list[i];
                    var li2 = '<tr class="trclass"><td><input type="checkbox" id="del" name="uid" class="itemSelect" value="'+route2.id+'">'+'</td>' +
                        '<td>' +route2.id+'</td>' +
                        '<td>' +route2.name+'</td>' +
                        '<td>' +route2.sex+'</td>' +
                        '<td>'+route2.age+'</td>' +
                        '<td>' +route2.address+'</td>' +
                        '<td>'+route2.phone+'</td>' +
                        '<td>'+route2.email+'</td>'+
                        '<td><a class="btn btn-default btn-sm" href="/User/FindUserServlet?id=1">修改</a>&nbsp;'+
                        '<a class="btn btn-default btn-sm" href="javascript:deleteUser('+route2.id+','+pb.currentPage+',\''+condition+'\');">删除</a></td></tr>'
                    ;
                    $("#trr").append(li2);
                }

            })
        }

        $(function () {
            load(1,null);
        });

	</script>
</head>
<body>


<div class="container">
	<h3 style="text-align: center">用户信息列表</h3>
	<div style="float: left;">
		<form class="form-inline" onsubmit="return false" id="forms">
			<div class="form-group">
				<label >&nbsp;&nbsp;&nbsp;&nbsp;会员名称 ：</label>
				<input type="text" class="form-control" name="condition" id="condition" placeholder="名称、电话、邮箱">
			</div>

			<button type="submit" class="btn btn-default" onclick="load(1,$('#condition').val())">搜索</button>
		</form>
	</div>
	<div style="float: right;margin: 5px;">
		<a class="btn btn-primary" href="${pageContext.request.contextPath}/addShop.jsp">添加联系人</a>
		<a class="btn btn-primary" href="javascript:void(0);" id="delSelected">删除选中</a>

	</div>
	<form id="form" onsubmit="return false" id="forms2">
		<table border="1" class="table table-bordered table-hover" id="trr">
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

		</table>
	</form>
	<div>
		<nav aria-label="Page navigation">
			<ul class="pagination" id="pagination">

			</ul>

		</nav>
		<span style="color:#337ab7; font-size: 25px;margin-left: 5px;"id="_page">
		</span>
	</div>


</div>


</body>
</html>
