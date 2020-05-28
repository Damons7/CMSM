<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<!DOCTYPE html PUBLIC "-//WL 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">   <%-- 在IE运行最新的渲染模式 --%>
		<meta name="viewport" content="width=device-width, initial-scale=1">   <%-- 初始化移动浏览显示 --%>
		<meta name="Author" content="Dreamer-1.">

		<!-- 引入各种CSS样式表 -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-change.css">	<!-- 将默认字体从宋体换成微软雅黑 -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index2.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/update_check_form.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/echarts/echarts.js"></script>

		<title>- 后台管理系统 -</title>

		<script>

            $(function () {
                $(".dropdown").mouseover(function () {
                    $(this).addClass("open");
                });

                $(".dropdown").mouseleave(function () {$(this).removeClass("open");
                })

				//图的数据
                var myOrderCharts = echarts.init($("#order_chart").get(0));
                var myUserCharts = echarts.init($("#user_chart").get(0));

                var Orderoption = {
                    title: {
                        text: "订单分布图",
                        subtext: '2020-02-28'
                    },
                    legend: {
                        data: ["柱状图","折线图"]
                    },
                    tooltip: {
                    },
                    xAxis: {
                        data: ["已收货","待发货","待收货","退款中","已退款"]
                    },
                    yAxis: {},
                    series: [{
                        type: 'bar',
                        name: '柱状图'
                    },
                        {
                            type: 'line',
                            name: '折线图'
                        }

                    ]
                };
                var Usersoption = {
                    title: {
                        text: "会员男女比例图",
                        subtext: '2020年度'
                    },
                    legend: {
                        bottom: '2%',
                        data:  ["男性","女性"]
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c} ({d}%)'
                    },
                    series: [{
                        type: 'pie',
                        name: '性别'
                    }]
                };

                myOrderCharts.setOption(Orderoption);
                $.get("Deal/orderConditionsServlet", {}, function (orderConditions) {
                    myOrderCharts.setOption({
                        series: [{
                            data: [orderConditions[0],orderConditions[1],orderConditions[2],orderConditions[3],orderConditions[4]]
                        },
                            {
                                data: [orderConditions[0],orderConditions[1],orderConditions[2],orderConditions[3],orderConditions[4]]
                            }
                        ]
                    })
                });
                myUserCharts.setOption(Usersoption);
                $.get("Deal/userDataServlet", {}, function (userData) {
                    myUserCharts.setOption({
                        series: [{
                            data: [{value:userData[1], name:"男性"},
                                {value:userData[2], name:"女性"}]
                        }
                        ]
                    })
					$("#userNumber").html(userData[0]);//获取会员人数
                });
				//获取团长人数
                $.get("Deal/headManDataServlet", {}, function (headManData) {
                    $("#headManNumber").html(headManData);
                });
				//今日订单量
				var date=new Date();
				var year=date.getFullYear();
				var month=date.getMonth()+1;
				month=month<10?"0"+month:month;
                var day=date.getDate();
            	day=day<10?"0"+day:day;
            	var nowTime=year+"-"+month+"-"+day;
                $.get("Deal/dateOrderNumberServlet", {date:nowTime}, function (nowNumber) {
                    $("#orderNumber").html(nowNumber[0]);
                    $("#income").html(nowNumber[1]);
                });
				//获取商品排名
                $.get("Deal/goodsRankServlet", {}, function (rankByGoods) {
					for (var i=0;i<5;i++) {
					    var lidd='<tr><td>' + (i + 1) + '</td>' +
                            '<td>' + rankByGoods[i].goodsname + '</td>' +
                            '<td>' + rankByGoods[i].salesVolume + '</td>' +
                            '<td>' + rankByGoods[i].types + '</td></tr>';
                        $("#trr").append(lidd);
                    }
                });
            })
            function ExitLogin() {
                if(confirm('确定退出？')==false)
                    return false;
                else
                    window.location.href=('${pageContext.request.contextPath}/admin/ExitServlet');
            }

            aa=function () {
                $("#open_modal").trigger("click");
            }
            bb=function () {
                $("#open_modal").trigger("click");
                $("#up_password").trigger("click");
            }

            var w1=1;var w2=1;
           update_information=function () {

               $("#up_email"), $("#up_phone").toggle(0,"swing",function () {
                   if(w1===1){
                       $("#up_phone").css("display","inline");
                       $("#up_email").css("display","inline");
                       $("#phone").css("display","none");
                       $("#email").css("display","none");
                       $("#up_information").html("返回");
                       $("#up_password").css("display","none");
                       $("#up_information_sumbit").css("display","inline");
                       w1=0;
                   }
                   else
                   {
                       $("#up_phone").css("display","none");
                       $("#up_email").css("display","none");
                       $("#phone").css("display","inline");
                       $("#email").css("display","inline");
                       $("#up_information").html("修改信息");
                       $("#up_password").css("display","inline");
                       $("#up_information_sumbit").css("display","none");
                       w1=1;
                   }
               })
           }
            update_password=function () {
                $("#information").toggle(0,"swing",function () {
                    if(w2===1){
                        $("#information").css("display","none");
                        $("#upd_password").css("display","inline");
                        $("#up_password").html("返回");
                        $("#up_password_sumbit").css("display","inline")
                        $("#up_information").css("display","none")
                        w2=0;
                    }
                    else
                    {
                        $("#information").css("display","inline");
                        $("#upd_password").css("display","none");
                        $("#up_password").html("修改密码");
                        $("#up_password_sumbit").css("display","none");
                        $("#up_information").css("display","inline");
                        w2=1;
                    }
                })
            }
//			修改管理员信息
			update_information_sumbit=function () {
               var flag= true;
				flag=check_up_information();
               if(flag){
               var username="<%=session.getAttribute("username")%>";
                $.post("admin/Up_informationServlet", {
                    phone:$("#input_phone").val(),email:$("#input_email").val(),username:username}, function (a) {
							if(a!=0) {
                                alert("修改成功！");
                                aa();
                            }
                            else
							{
							    alert("修改失败！请检查后重试!");
                                aa();
							}
                })}
            };
            //			修改管理员密码
            update_password_sumbit=function () {
                var flag=true;
                flag=check_up_password();
                if(flag){
                var username="<%=session.getAttribute("username")%>";
                $.post("admin/Up_passwordServlet", {
                   old_password:$("#old_password").val(),new_password:$("#new_password").val(),username:username}, function (a) {
                    if(a!=0) {
                        alert("修改成功！");
                        aa();
                    }
                    else
                    {
                        $("#reg_sp66").text("原密码错误").css('color', '#f53808');
                    }
                })}
            }

		</script>

	</head>
	
	<body>

	<button id="open_modal" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">ddd</button>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×
					</button>
					<h4 class="modal-title" id="myModalLabel" style="text-align:center;">
						管理员信息
					</h4>
				</div>
				<%--显示管理员信息--%>
				<div class="modal-body" id="information">
						<div class="row" style="margin-top: 25px">
							<div class="col-md-5"style="text-align: right">帐号：</div>
							<div class="col-md-7" style="text-align:left;"> ${user.username}</div>
						</div>
					<div class="row" style="margin-top: 25px">
							<div class="col-md-5"style="text-align: right">姓名：</div>
							<div class="col-md-7" style="text-align:left;"> ${user.name}</div>
					</div>
						<div class="row" style="margin-top: 25px">
							<div class="col-md-5"style="text-align: right">性别：</div>
							<div class="col-md-7" style="text-align:left;"> ${user.sex}</div>

						</div>
						<div class="row" style="margin-top: 25px">
							<div class="col-md-5"style="text-align: right">电话：</div>
							<div class="col-md-7" style="text-align:left;" id="phone"> ${user.phone}</div>
							<div class="col-md-7" style="text-align:left;display: none;" id="up_phone">
								<input type="text" name="phone" id="input_phone" value="${user.phone}" class="form-control" style="width: 200px;height: 22px;">
								<span class="reg_sp8" id="reg_sp8"></span>
							</div>
						</div>

						<div class="row" style="margin-top: 25px;margin-bottom:35px;">
							<div class="col-md-5"style="text-align: right">邮箱：</div>
							<div class="col-md-7" style="text-align:left;" id="email"> ${user.email}</div>
							<div class="col-md-7" style="text-align:left;display: none;" id="up_email">
								<input type="email" id="input_email" name="email" value="${user.email}" class="form-control upd_email" style="width: 200px;height: 22px;">
								<span class="reg_sp9" id="reg_sp9"></span>
							</div>
						</div>

				</div>

				<%--显示修改密码信息--%>
				<div class="modal-body" id="upd_password" style="display: none;">

					<div class="row" style="margin-top: 35px">
						<div class="col-md-5"style="text-align: right">原始密码：</div>
						<div class="col-md-7" style="text-align:left;">
							<input type="text" name="old_password" id="old_password" placeholder="请输入6-16位密码" class="form-control" style="width: 200px;height: 22px;">
							<span class="reg_sp66" id="reg_sp66"></span>
						</div>
					</div>

					<div class="row" style="margin-top: 35px">
						<div class="col-md-5"style="text-align: right">新密码：</div>
						<div class="col-md-7" style="text-align:left;" >
							<input type="text" name="new_password" id="new_password" placeholder="请输入6-16位密码" class="form-control" style="width: 200px;height: 22px;">
							<span class="reg_sp6" id="reg_sp6"></span>
						</div>
					</div>

					<div class="row" style="margin-top: 35px;margin-bottom:35px;">
						<div class="col-md-5"style="text-align: right">确认密码：</div>
						<div class="col-md-7" style="text-align:left;" >
							<input type="text" name="new_password2" id="new_password2" placeholder="请输入6-16位密码" class="form-control" style="width: 200px;height: 22px;">
							<span class="reg_sp7" id="reg_sp7"></span>
						</div>
					</div>

				</div>


				<div class="modal-footer" style="text-align: center">
					<button type="button" class="btn btn-default" onclick="update_information();" id="up_information">修改信息</button>
					<button type="button" class="btn btn-default" onclick="update_password();"id="up_password">修改密码</button>
					<button type="button" class="btn btn-default" onclick="update_password_sumbit();" style="display: none;" id="up_password_sumbit">提交</button>
					<button type="button" class="btn btn-default" onclick="update_information_sumbit();" style="display: none;" id="up_information_sumbit">提交</button>
				</div>


			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

	<!-- 顶部菜单（来自bootstrap官方Demon）==================================== -->
		<nav class="navbar navbar-inverse navbar-fixed-top">
     <div class="row" style="background-color: #428BCA">
		 <div class="col-md-2 col-sm-3 top fa fa-home">
			社区商城后台管理
		 </div>
					 <div class="right">
						 <ul class="nav navbar-nav">
							 <li class="dropdown">
								 <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="height: 60px">
									 <img src="${pageContext.request.contextPath}/img/login_head.jpg" alt="不见了" s class="img-circle" width="38px" height="38px"/>
									 <span style="color: #FFFFFF;font-size: 15px">
                                <i>欢迎你：${user.name}</i>
                            </span>
								 </a>
								 <div class="dropdown-menu pull-right"
									  style="background: #FFFFFF;width: 250px;overflow: hidden">
									 <div style="margin-top: 16px;border-bottom: 1px solid #eeeeee">
										 <div style="text-align: center">
											 <img class="img-circle" src="${pageContext.request.contextPath}/img/login_head.jpg"
												  style="width: 38px;height: 38px;"/>
										 </div>
										 <div style="color: #323534;text-align: center;line-height: 36px;font-size: 15px">
											 <span>${user.name}</span>
										 </div>
									 </div>

									 <div class="row" style="margin-left: 15px;margin-right: 15px;margin-top: 10px">
										 <div class="col-md-4 text-center grid"  onclick="aa()">
											 <i class="fa fa-gear"  style="font-size: 25px;line-height: 45px;"></i>
											 <p style="padding: 0px;margin-top: 6px;margin-bottom: 10px;font-size: 12px" >
												 账号管理</p>
										 </div>
										 <div class="col-md-4 text-center grid" onclick="bb();">
											 <i class="fa fa-key" style="font-size: 25px;line-height: 45px;"></i>
											 <p style="padding: 0px;margin-top: 6px;margin-bottom: 10px;font-size: 12px">
												 密码修改</p>
										 </div>
										 <div class="col-md-4 text-center grid">
											 <i class="fa fa-heart-o" style="font-size: 25px;line-height: 45px;"></i>
											 <p style="padding: 0px;margin-top: 6px;margin-bottom: 10px;font-size: 12px">
												 帮助中心</p>
										 </div>
									 </div>

									 <div class="row" style="margin-top: 20px">
										 <div class="text-center" style="padding: 15px;margin: 0px;background: #f6f5f5;color: #323534;"onclick="ExitLogin();">
											 <i class="fa fa-sign-out">退出登录</i>
										 </div>
									 </div>
								 </div>
							 </li>
						 </ul>
					 </div>


	 </div>
		</nav>

	<!-- 左侧菜单选项========================================= -->
		<div class="container-fluid" >
			<div class="row-fluie">

				<div class="col-sm-3 col-md-2 sidebar">		
					<ul class="nav nav-sidebar">

						<!-- 一级菜单 -->
						<li class="active"><a href="#userMeun" class="nav-header menu-first collapsed" data-toggle="collapse">
							<i class="fa fa-user-plus"></i>&nbsp; 会员管理 <span class="sr-only">(current)</span></a>
						</li> 
						<!-- 二级菜单 -->
						<!-- 注意一级菜单中<a>标签内的href="#……"里面的内容要与二级菜单中<ul>标签内的id="……"里面的内容一致 -->
						<ul id="userMeun" class="nav nav-list collapse menu-second">
							<li><a href="javascript:void(0)" class="jump1" onclick="showAtRight('userList.jsp')"><i class="fa fa-users"></i> 查询会员信息</a></li>
						</ul>

						<li><a href="#user2Meun" class="nav-header menu-first collapsed" data-toggle="collapse">
							<i class="fa fa-user"></i>&nbsp; 团长管理 <span class="sr-only">(current)</span></a>
						</li>
						<!-- 二级菜单 -->
						<!-- 注意一级菜单中<a>标签内的href="#……"里面的内容要与二级菜单中<ul>标签内的id="……"里面的内容一致 -->
						<ul id="user2Meun" class="nav nav-list collapse menu-second">
							<li><a href="javascript:void(0)" class="jump2" onclick="showAtRight('${pageContext.request.contextPath}/Headman/FindHeadmanByPageServlet')"><i class="fa fa-users"></i> 查询团长信息</a></li>
						</ul>

						<li><a href="#recordMeun" class="nav-header menu-first collapsed" data-toggle="collapse">
							<i class="fa fa-file-text"></i>&nbsp; 订单管理 <span class="sr-only">(current)</span></a>
						</li>
						<ul id="recordMeun" class="nav nav-list collapse menu-second">
							<li><a href="###" onclick="showAtRight('order_processing.jsp')" ><i class="fa fa-search-plus"></i> 查询订单</a></li>
							<li><a href="###" onclick="showAtRight('deal.jsp')" ><i class="fa fa-user-secret"></i> 交易信息</a></li>
							<li><a href="###" onclick="showAtRight('order_processing.jsp')" ><i class="fa fa-remove"></i> 删除订单</a></li>
						</ul>

						<li><a href="#productMeun" class="nav-header menu-first collapsed" data-toggle="collapse">
							<i class="fa fa-shopping-cart"></i>&nbsp; 商品上架 <span class="sr-only">(current)</span></a>
						</li> 
						<ul id="productMeun" class="nav nav-list collapse menu-second">
							<li><a href="###" onclick="showAtRight('shopList.jsp')"><i class="fa fa-shopping-cart"></i> 商品列表 </a></li>
							<li><a href="###" onclick="aa1()"><i class="fa fa-upload"></i> 商品上架</a></li>
						</ul>
							
					</ul>

				</div>


			</div>

		</div>


<!-- 右侧内容展示==================================================   -->
 				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
					<h1 class="page-header"><i class="fa fa-cog fa-spin"></i>&nbsp;控制台<small>&nbsp;&nbsp;&nbsp;欢迎使用社区商城后台管理系统</small></h1>
						
						<!-- 载入左侧菜单指向的jsp（或html等）页面内容 -->
          				<div id="content">

							<div class="row">
								<div class="col-md-3 index_deals">

									<div class="index_div_deals index_div_deals0 col-md-6"><i class="fa fa-user"></i>
									</div>
									<div class="index_div_deals_infor col-md-6">
										<span>会员数</span>
										<span id="userNumber"></span>
									</div>
								</div>

								<div class="col-md-3 index_deals">

									<div class="index_div_deals index_div_deals1 col-md-6"><i class="fa fa-user"></i>
									</div>
									<div class="index_div_deals_infor col-md-6">
										<span>团长数</span>
										<span id="headManNumber"></span>
									</div>
								</div>
								<div class="col-md-3 index_deals">

									<div class="index_div_deals index_div_deals2 col-md-6"><i class="fa fa-shopping-cart" style=" margin-left: 0px;"></i>
									</div>
									<div class="index_div_deals_infor col-md-6">
										<span style="font-size: 19px">今日订单量</span>
										<span id="orderNumber"></span>
									</div>
								</div>
								<div class="col-md-3 index_deals">

									<div class="index_div_deals index_div_deals3 col-md-6"><i class="fa fa-jpy" style=" margin-left: 9px;"></i>
									</div>
									<div class="index_div_deals_infor col-md-6">
										<span style="font-size: 19px">今日收入额</span>
										<span id="income"></span>
									</div>
								</div>

							</div>

							<div class="row" style="margin-top: 20px;margin-bottom: 40px">
								<div class="col-md-4">
									<div id="user_chart" style="height: 300px;background-color: #fff;border: 1px solid #F5F5F5;">

									</div>
								</div>

								<div class="col-md-4">
									<div id="order_chart" style="height: 300px;background-color: #fff;border: 1px solid #F5F5F5;">

									</div>
								</div>

								<div class="col-md-4" style="height: 300px;background-color: #fff;border: 1px solid #F5F5F5;">
									<table border="1" class="table table-bordered table-hover table_deals" id="trr" style="margin-top: 15px">
										<h4 align="center" style="margin-top: 19px">商品销量排行</h4>
										<tr class="success">
											<th>排名</th>
											<th>名称</th>
											<th>销量</th>
											<th>所属类型</th>
										</tr>

									</table>
								</div>
							</div>

          				</div>

					<div class="row">
						<div class="foot-style">
							<p>吉林大学珠海学院软件1711班李鸿智 版权所有Copyright 2019-2020, All Rights Reserved 04172505</p>
						</div>
					</div>
				</div>



		<script type="text/javascript">
		
		/*
		 * 对选中的标签激活active状态，对先前处于active状态但之后未被选中的标签取消active
		 * （实现左侧菜单中的标签点击后变色的效果）
		 */
		$(document).ready(function () {
			$('ul.nav > li').click(function (e) {
				//e.preventDefault();	加上这句则导航的<a>标签会失效
				$('ul.nav > li').removeClass('active');
				$(this).addClass('active');
			});
		});
		
		/*
		 * 解决ajax返回的页面中含有javascript的办法：
		 * 把xmlHttp.responseText中的脚本都抽取出来，不管AJAX加载的HTML包含多少个脚本块，我们对找出来的脚本块都调用eval方法执行它即可
		 */
		function executeScript(html)
		{
		    
			var reg = /<script[^>]*>([^\x00]+)$/i;
		    //对整段HTML片段按<\/script>拆分
		    var htmlBlock = html.split("<\/script>");
		    for (var i in htmlBlock) 
		    {
		        var blocks;//匹配正则表达式的内容数组，blocks[1]就是真正的一段脚本内容，因为前面reg定义我们用了括号进行了捕获分组
		        if (blocks = htmlBlock[i].match(reg)) 
		        {
		            //清除可能存在的注释标记，对于注释结尾-->可以忽略处理，eval一样能正常工作
		            var code = blocks[1].replace(/<!--/, '');
		            try 
		            {
		                eval(code) //执行脚本
		            } 
		            catch (e) 
		            {
		            }
		        }
		    }
		}
		
		/*
		 * 利用div实现左边点击右边显示的效果（以id="content"的div进行内容展示）
		 * 注意：
		 *   ①：js获取网页的地址，是根据当前网页来相对获取的，不会识别根目录；
		 *   ②：如果右边加载的内容显示页里面有css，必须放在主页（即例中的index.jsp）才起作用
		 *   （如果单纯的两个页面之间include，子页面的css和js在子页面是可以执行的。 主页面也可以调用子页面的js。但这时要考虑页面中js和渲染的先后顺序 ）
		*/
		function showAtRight(url) {
			var xmlHttp;
			
			if (window.XMLHttpRequest) {
				// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlHttp=new XMLHttpRequest();	//创建 XMLHttpRequest对象
			}
			else {
				// code for IE6, IE5
				xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		
			xmlHttp.onreadystatechange=function() {		
				//onreadystatechange — 当readystate变化时调用后面的方法
				
				if (xmlHttp.readyState == 4) {
					//xmlHttp.readyState == 4	——	finished downloading response
					
					if (xmlHttp.status == 200) {
						//xmlHttp.status == 200		——	服务器反馈正常			
						
						document.getElementById("content").innerHTML=xmlHttp.responseText;	//重设页面中id="content"的div里的内容
						executeScript(xmlHttp.responseText);	//执行从服务器返回的页面内容里包含的JavaScript函数
					}
					//错误状态处理
					else if (xmlHttp.status == 404){
						alert("出错了☹   （错误代码：404 Not Found），……！"); 
						/* 对404的处理 */
						return;
					}
					else if (xmlHttp.status == 403) {  
						alert("出错了☹   （错误代码：403 Forbidden），……"); 
						/* 对403的处理  */ 
						return;
			        }
					else {
						alert("出错了☹   （错误代码：" + request.status + "），……"); 
						/* 对出现了其他错误代码所示错误的处理   */
						return;
					}   
				} 
		            
			  }
			
			//把请求发送到服务器上的指定文件（url指向的文件）进行处理
			xmlHttp.open("GET", url, true);		//true表示异步处理
			xmlHttp.send();
		}		
		</script>

	</body>




</html>