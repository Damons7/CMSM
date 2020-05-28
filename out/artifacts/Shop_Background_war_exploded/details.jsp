<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/4/5
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/test5.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/details.css">
    <title>商品详情</title>
</head>
<% String id=request.getParameter("id");String type=request.getParameter("type");%>


<style>
    .ddd2{
        display: inline-block;
        position: relative;
    }
    .del_old{ width:20px; height: 20px; line-height: 20px; text-align: center; border-radius: 50%; color: #fff;
        background-color: #ff6982; cursor: pointer; font-style: normal;      position: absolute;
        top: 0px;
        right: 0px;}
</style>
<script>
    var up_imgs=new Array(5);
    var i=0;
    del_imgfunction = function (x) {

        if(confirm("确定删删除图片？"))
        if(x==1)
            $(".del_oldimage_div1").hide("fast", "swing", function () {
                up_imgs[i]= $('#up_img').attr('src');
                i++;
            });
        else if(x==2)
            $(".del_oldimage_div2").hide("fast", "swing", function () {
                up_imgs[i]= $('#up_img1').attr('src');
                i++;
            });
        else if(x==3)
            $(".del_oldimage_div3").hide("fast", "swing", function () {
                up_imgs[i]= $('#up_img2').attr('src');
                i++;
            });
        else if(x==4)
            $(".del_oldimage_div4").hide("fast", "swing", function () {
                up_imgs[i]= $('#up_img3').attr('src');
                i++;
            });
        else if(x==5)
            $(".del_oldimage_div5").hide("fast", "swing", function () {
                up_imgs[i]= $('#up_img4').attr('src');
                i++;
            });
    }

    detailsFruit=function (a) {
    $.get("Fruit/DetailsFruitServlet", {id: a}, function (fru) {
        //名称
        $("#up_name").val(fru.name);
        //标题title
        list = '<h2>' + fru.title + '</h2>';
        $(".title").html(list);
        $("#up_title").html(fru.title);

        //详细信息details
        list2 = '<p>' + fru.describes + '</p>';
        $(".detail").html(list2);
        $("#up_describes").html(fru.describes);

        $("#frist_img").attr('src',fru.imgss[0]);
        $("#2nd").attr('src',fru.imgss[1]);
        $("#3rd").attr('src',fru.imgss[2]);
        $("#4th").attr('src',fru.imgss[3]);
        $("#5th").attr('src',fru.imgss[4]);

        $(".small_img1").attr('src',fru.imgss[0]);
        $(".small_img2").attr('src',fru.imgss[1]);
        $(".small_img3").attr('src',fru.imgss[2]);
        $(".small_img4").attr('src',fru.imgss[3]);
        $(".small_img5").attr('src',fru.imgss[4]);

//        $(".small_img").html(list3);

        $("#up_img").attr('src',fru.imgss[0]);
        $("#up_img1").attr('src',fru.imgss[1]);
        $("#up_img2").attr('src',fru.imgss[2]);
        $("#up_img3").attr('src',fru.imgss[3]);
        $("#up_img4").attr('src',fru.imgss[4]);
          var s1=0;
        for(var s=0;s<fru.imgss.length;s++){
            if(fru.imgss[s].indexOf("not_exist")!=-1) {
                s1=s+1;
                $(".del_oldimage_div" + s1+ "").css("display", "none");
            }
            else
                continue;
        }

        if( fru.price== fru.discount_price)
        {
            $("#discount_price").html('价格:￥'+fru.discount_price);
            $("#up_discount_price").val(fru.discount_price);
            $("#up_price").val(fru.price);
            $("#price").css("display","none");
        }
        else {
            //原价
            $("#price").html('价格:￥' + fru.price);
            $("#up_price").val(fru.price);
            //促销价
            $("#discount_price").html('价格:￥' + fru.discount_price);
            $("#up_discount_price").val(fru.discount_price);
        }
        //成本
        $("#up_cost").val(fru.cost);
        //数量
        $("#up_amount").val(fru.amount);
    })
}

    detailsVegetables=function (a) {
        $.get("Vegetables/DetailsVegetablesServlet", {id: a}, function (veg) {

            //名称
            $("#up_name").val(veg.name);
            //标题title
            list = '<h2>' + veg.title + '</h2>';
            $(".title").html(list);
            $("#up_title").html(veg.title);

            //详细信息details
            list2 = '<p>' + veg.describes + '</p>';
            $(".detail").html(list2);
            $("#up_describes").html(veg.describes);

            $("#frist_img").attr('src',veg.imgss[0]);
            $("#2nd").attr('src',veg.imgss[1]);
            $("#3rd").attr('src',veg.imgss[2]);
            $("#4th").attr('src',veg.imgss[3]);
            $("#5th").attr('src',veg.imgss[4]);

            $(".small_img1").attr('src',veg.imgss[0]);
            $(".small_img2").attr('src',veg.imgss[1]);
            $(".small_img3").attr('src',veg.imgss[2]);
            $(".small_img4").attr('src',veg.imgss[3]);
            $(".small_img5").attr('src',veg.imgss[4]);

            $("#up_img").attr('src',veg.imgss[0]);
            $("#up_img1").attr('src',veg.imgss[1]);
            $("#up_img2").attr('src',veg.imgss[2]);
            $("#up_img3").attr('src',veg.imgss[3]);
            $("#up_img4").attr('src',veg.imgss[4]);
            var s1=0;
            for(var s=0;s<veg.imgss.length;s++){
                if(veg.imgss[s].indexOf("not_exist")!=-1) {
                    s1=s+1;
                    $(".del_oldimage_div" + s1+ "").css("display", "none");
                }
                else
                    continue;
            }

            if( veg.price== veg.discount_price)
            {
                $("#discount_price").html('价格:￥'+veg.discount_price);
                $("#up_discount_price").val(veg.discount_price);
                $("#up_price").val(veg.price);
                $("#price").css("display","none");
            }
            else {
                //原价
                $("#price").html('价格:￥' + veg.price);
                $("#up_price").val(veg.price);
                //促销价
                $("#discount_price").html('价格:￥' + veg.discount_price);
                $("#up_discount_price").veg(fru.discount_price);
            }
            //成本
            $("#up_cost").val(veg.cost);
            //数量
            $("#up_amount").val(veg.amount);
        })
    }

    detailsSnacks=function (a) {
        $.get("Snacks/DetailsSnacksServlet", {id: a}, function (sna) {
            //名称
            $("#up_name").val(sna.name);
            //标题title
            list = '<h2>' + sna.title + '</h2>';
            $(".title").html(list);
            $("#up_title").html(sna.title);

            //详细信息details
            list2 = '<p>' + sna.describes + '</p>';
            $(".detail").html(list2);
            $("#up_describes").html(sna.describes);

            $("#frist_img").attr('src',sna.imgss[0]);
            $("#2nd").attr('src',sna.imgss[1]);
            $("#3rd").attr('src',sna.imgss[2]);
            $("#4th").attr('src',sna.imgss[3]);
            $("#5th").attr('src',sna.imgss[4]);

            $(".small_img1").attr('src',sna.imgss[0]);
            $(".small_img2").attr('src',sna.imgss[1]);
            $(".small_img3").attr('src',sna.imgss[2]);
            $(".small_img4").attr('src',sna.imgss[3]);
            $(".small_img5").attr('src',sna.imgss[4]);

//        $(".small_img").html(list3);

            $("#up_img").attr('src',sna.imgss[0]);
            $("#up_img1").attr('src',sna.imgss[1]);
            $("#up_img2").attr('src',sna.imgss[2]);
            $("#up_img3").attr('src',sna.imgss[3]);
            $("#up_img4").attr('src',sna.imgss[4]);
            var s1=0;
            for(var s=0;s<sna.imgss.length;s++){
                if(sna.imgss[s].indexOf("not_exist")!=-1) {
                    s1=s+1;
                    $(".del_oldimage_div" + s1+ "").css("display", "none");
                }
                else
                    continue;
            }

            if( sna.price== sna.discount_price)
            {
                $("#discount_price").html('价格:￥'+sna.discount_price);
                $("#up_discount_price").val(sna.discount_price);
                $("#up_price").val(sna.price);
                $("#price").css("display","none");
            }
            else {
                //原价
                $("#price").html('价格:￥' + sna.price);
                $("#up_price").val(sna.price);
                //促销价
                $("#discount_price").html('价格:￥' + sna.discount_price);
                $("#up_discount_price").val(sna.discount_price);
            }
            //成本
            $("#up_cost").val(sna.cost);
            //数量
            $("#up_amount").val(sna.amount);
        })
    }

    $(function () {
        var a =<%=id%>;
        var type=<%=type%>;

        //水果类详情
        if(type==1) {
            detailsFruit(a);
        }
        //蔬菜类详情
        else if(type==2){
            detailsVegetables(a);
        }
        //零食类详情
        else if(type==3){
            detailsSnacks(a);
        }

    })

    //检查商品信息
    var aa = "0";
    var bb = "0";
    var cc = "0";
    var dd= "0";
    var ee= "0";
    var ff = "0";
    var gg = "0";

    $(function () {
        $("#up_name").blur(function ()  {
            var name = $("#up_name").val();
            var message = "";
            // 完成正则匹配
            if (name.length<=0) {
                aa = "1";
                $("#reg_spaa").text("输入名称").css('color', '#f53808');
                $("#up_name").css("border","1px solid red");
            }
            else if (name.length > 0) {
                aa= "0";
                $("#up_name").css("border", "");
                $("#reg_spaa").text(message ).css('color', '#0000ff');
            }

        });

        $("#up_title").blur(function () {

            var title = $("#up_title").val();
            var message = "";
            // 完成正则匹配
            if (title.trim().length<= 0) {
                bb = "2";
                $("#reg_spbb").text("未输入").css('color', '#f53808');
                $("#up_title").css("border","1px solid red");

            }
            else if (title.trim().length > 0) {
                bb = "0";
                $("#reg_spbb").text(message).css('color', '#0000ff');
                $("#up_title").css("border", "");
            }

        });

        $("#up_amount").blur(function () {

            var amount = $("#up_amount").val();
            var message = "";
            var flag = false;
            var reg_amount = /^[1-9]\d*$/;
            // 完成正则匹配
            if (amount.length<= 0) {
                cc= "3";
                message = "请输入商品数量！";
                $("#up_amount").css("border","1px solid red");

            }
            else   if (!reg_amount.test(amount)) {
                cc="3";// 修改全局变量
                message = "格式有误！";
                $("#up_amount").css("border", "1px solid red");
            }
            else if (amount.length > 0) {
                cc = "0";
                flag = true;
                $("#up_amount").css("border", "");
            }
            if (flag) {
                $("#reg_spcc").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spcc").text(message).css('color', '#f53808');
            }

        });

        $("#up_cost").blur(function () {

            var cost = $("#up_cost").val();
            var message = "";
            var flag = false;
            var reg_cost =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
            // 完成正则匹配
            if (cost.length<= 0) {
                dd= "4";
                message = "未输入！";
                $("#up_cost").css("border","1px solid red");

            }
            else   if (!reg_cost.test(cost)) {
                dd= "4";// 修改全局变量
                message = "格式有误！";
                $("#up_cost").css("border", "1px solid red");
            }
            else if (cost.length > 0) {
                dd = "0";
                flag = true;
                $("#up_cost").css("border", "");
            }
            if (flag) {
                $("#reg_spdd").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spdd").text(message).css('color', '#f53808');
            }

        });

        $("#up_price").blur(function () {

            var price = $("#up_price").val();
            var message = "";
            var flag = false;
            var reg_price =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
            // 完成正则匹配
            if (price.length<= 0) {
                ee = "5";
                message = "未输入！";
                $("#up_price").css("border","1px solid red");

            }
            else   if (!reg_price.test(price)) {
                ee= "5";// 修改全局变量
                message = "格式有误！";
                $("#up_price").css("border", "1px solid red");
            }
            else if (price.length > 0) {
                ee = "0";
                flag = true;
                $("#up_price").css("border", "");
            }
            if (flag) {
                $("#reg_spee").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spee").text(message).css('color', '#f53808');
            }

        });

        $("#up_discount_price").blur(function () {

            var discount_price = $("#up_discount_price").val();
            var message = "";
            var flag = false;
            var reg_discount_price =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
            // 完成正则匹配
            if (discount_price.length<= 0) {
                ff = "6";
                message = "未输入！";
                $("#up_discount_price").css("border","1px solid red");

            }
            else   if (!reg_discount_price.test(discount_price)) {
                ff= "6";// 修改全局变量
                message = "格式有误！";
                $("#up_discount_price").css("border", "1px solid red");
            }
            else if (discount_price.length > 0) {
                ff = "0";
                flag = true;
                $("#up_discount_price").css("border", "");
            }
            if (flag) {
                $("#reg_spff").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spff").text(message).css('color', '#f53808');
            }

        });

        $("#up_describes").blur(function () {

            var describes = $("#up_describes").val();
            var message="";
            // 完成正则匹配
            if (describes.trim().length<= 0) {
                gg = "7";
                $("#reg_spgg").text("未输入").css('color', '#f53808');
                $("#up_describes").css("border","1px solid red");
            }
            else if (describes.trim().length > 0) {
                gg = "0";
                $("#reg_spgg").text(message).css('color', '#0000ff');
                $("#up_describes").css("border", "");
            }
        });

    });

    function check_commodity2() {
        if (aa == 1||bb==2||cc==3||dd==4||ee==5||ff==6||gg==7) {
            alert("商品格式有误!请检查后重新输入!")
            return false;
        }
        else
            return true;
    }

    update_information=function () {
        if (check_commodity2()) {
            var a =<%=id%>;
            var type =<%=type%>;
            if (type == 1) {
                $.get("Fruit/UpdateFruitServlet",
                    {
                        id: a,
                        name: $("#up_name").val(),
                        title: $("#up_title").val(),
                        amount: $("#up_amount").val(),
                        price: $("#up_price").val(),
                        discount_price: $("#up_discount_price").val(),
                        cost: $("#up_cost").val(),
                        describes: $("#up_describes").val(),
                        imgs: $("#add-pic-btn").val(),
                        del_imgs: JSON.stringify(up_imgs)
                    },
                    function () {
                        if (a != 0) {
                            var newUrl = 'Fruit/FruitImgServlet?type=updateimg&name=' + $("#up_name").val();
                            $("#myform").attr('action', newUrl);    //通过jquery为action属性赋值
                            $("#sumit_img").trigger("click");
                            alert("更新成功！");
                            detailsFruit(a);
                        }
                        else
                            alert("更新失败，联系开发员！");
                    })
            }
            else if (type == 2) {
                $.get("Vegetables/UpdateVegetablesServlet",
                    {
                        id: a,
                        name: $("#up_name").val(),
                        title: $("#up_title").val(),
                        amount: $("#up_amount").val(),
                        price: $("#up_price").val(),
                        discount_price: $("#up_discount_price").val(),
                        cost: $("#up_cost").val(),
                        describes: $("#up_describes").val(),
                        imgs: $("#add-pic-btn").val(),
                        del_imgs: JSON.stringify(up_imgs)
                    },
                    function () {
                        if (a != 0) {
                            var newUrl = 'Vegetables/VegetablesImgServlet?type=updateimg&name=' + $("#up_name").val();
                            $("#myform").attr('action', newUrl);    //通过jquery为action属性赋值
                            $("#sumit_img").trigger("click");
                            alert("更新成功！");
                            detailsVegetables(a);
                        }
                        else
                            alert("更新失败，联系开发员！");
                    })
            }
            else if (type == 3) {
                $.get("Snacks/UpdateSnacksServlet",
                    {
                        id: a,
                        name: $("#up_name").val(),
                        title: $("#up_title").val(),
                        amount: $("#up_amount").val(),
                        price: $("#up_price").val(),
                        discount_price: $("#up_discount_price").val(),
                        cost: $("#up_cost").val(),
                        describes: $("#up_describes").val(),
                        imgs: $("#add-pic-btn").val(),
                        del_imgs: JSON.stringify(up_imgs)
                    },
                    function () {
                        if (a != 0) {
                            var newUrl = 'Snacks/SnacksImgServlet?type=updateimg&name=' + $("#up_name").val();
                            $("#myform").attr('action', newUrl);    //通过jquery为action属性赋值
                            $("#sumit_img").trigger("click");
                            alert("更新成功！");
                            detailsSnacks(a);
                        }
                        else
                            alert("更新失败，联系开发员！");
                    })
            }

            $(".close_modal").trigger("click");

        }
    }

    var num2=0;
    document.getElementById("add-pic-btn").addEventListener("change", function () {
            var obj = this,
                length = obj.files.length,
                arrTitle = []; //存标题名
            _html = '';
        num2+=length;
        if(num2>5){
            alert("最多只能上传5张图片");
            num2-=length;
            return;
        }

            for (var i = 0; i < length; i++) {
                var reader = new FileReader();
                if (!reader) {
                    console.log('对不起，您的浏览器不支持！请更换浏览器试一下');
                    return
                }
                //存储上传的多张图片名字
                arrTitle.push(obj.files[i].name)

                reader.error = function (e) {
                    console.log("读取异常")
                }

                //iffi语法
                ;(function (i) {
                    //读取成功
                    reader.onload = function (e) {
                        //console.log(e)
                        var _src = e.target.result;

                        //节点
                        var divItem = document.createElement('div');
                        divItem.setAttribute('class', 'item');
                        var divPic = document.createElement('div');
                        divPic.setAttribute('class', 'pic-box');
                        var img = document.createElement('img');
                        img.setAttribute('class', 'img');
                        img.setAttribute('src', _src);
                        var divTk = document.createElement('div');
                        divTk.setAttribute('class', 'tk')
                        var spanDel = document.createElement('span');
                        spanDel.setAttribute('class', 'del');
                        spanDel.setAttribute('title', arrTitle[i]);
                        spanDel.innerText = 'x';

                        divTk.innerHTML = arrTitle[i];

                        divItem.appendChild(divPic);
                        divPic.appendChild(img);
                        divItem.appendChild(divTk);
                        divItem.appendChild(spanDel);

                        //增加节点结构
                        var groupTu = document.getElementById('groupTu');
                        groupTu.insertBefore(divItem, groupTu.firstChild);

                        //增加删除节点
                        spanDel.onclick = function () {
                            removeItem(this);
                            return false;
                        };

                    };
                })(i)

                reader.onloadstart = function () {

                }
                reader.onprogress = function (e) {
                    if (e.lengthComputable) {
                        console.log("正在读取文件")
                    }
                };
                reader.readAsDataURL(obj.files[i]);
            }

        })
    //删除图片
    function removeItem(delNode){
        var itemNode = delNode.parentNode,
            title = delNode.getAttribute('title');
        var flag = confirm("确认要删除名为："+title+"的图片？");
        if(flag) {
            itemNode.parentNode.removeChild(itemNode);
            num2--;
            console.log('删除成功~')
        }
        return false;
    }
</script>
<body>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModa2" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel" style="text-align:center;">
                    修改商品详情
                </h4>
            </div>
            <%--显示信息--%>
            <div class="modal-body" id="information">

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">名称：</div>
                    <div class="col-md-3" style="text-align:left;">
                        <input type="text" name="name" id="up_name"  class="form-control" style="width: 100px;height: 22px;">
                    </div>
                    <div class="col-md-4"> <span id="reg_spaa"></span></div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">标题：</div>
                    <div class="col-md-8" style="text-align:left;">
                         <textarea rows="10" cols="30" class="form-control" style="width: 280px;height: 44px;" id="up_title" placeholder="30字以内">
                        </textarea>
                        <span id="reg_spbb"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">数量：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="amount" id="up_amount"  class="form-control" style="width: 100px;height: 22px;">
                        <span id="reg_spcc"></span>
                    </div>

                    <div class="col-md-2"style="text-align: right">成本：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="cost" id="up_cost"  class="form-control" style="width: 80px;height: 22px;">
                        <span id="reg_spdd"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">原价：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="price" id="up_price"  class="form-control" style="width: 100px;height: 22px;">
                        <span id="reg_spee"></span>
                    </div>
                    <div class="col-md-2"style="text-align: right">促销价：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="discount_price" id="up_discount_price"   class="form-control" style="width: 80px;height: 22px;">
                        <span id="reg_spff"></span>
                    </div>
                </div>
                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">详细介绍：</div>
                    <div class="col-md-8" style="text-align:left;">
                       <textarea rows="10" cols="30" class="form-control" id="up_describes" name="describes" style="width: 280px;height: 66px;" placeholder="100字以内">

                        </textarea>
                        <span id="reg_spgg"></span>
                    </div>

                </div>


                <div class="row" style="margin-top: 25px;margin-bottom:35px;">
                    <div class="col-md-4"style="text-align: right">详情图片：</div>
                    <div class="col-md-8">
                        <div class="row">
                            <div class="col-md-5 del_oldimage_div1" style="padding: 5px">
                                <span>图一:</span>
                                 <img style="width: 150px;height: 130px;" id="up_img" onclick="javascript:window.open(this.src);">
                                <span class="del_old" onclick="del_imgfunction(1);">x</span>
                            </div>
                            <div class="col-md-5 del_oldimage_div2" style="padding: 5px">
                                <span>图二:</span>
                                 <img style="width: 150px;height: 130px;" id="up_img1" onclick="javascript:window.open(this.src);">
                                <span class="del_old" onclick="del_imgfunction(2);">x</span>
                            </div>
                            <div class="col-md-5 del_oldimage_div3" style="padding: 5px">
                                <span>图三:</span>
                                 <img style="width: 150px;height: 130px;" id="up_img2" onclick="javascript:window.open(this.src);">
                                <span class="del_old" onclick="del_imgfunction(3);">x</span>
                            </div>
                            <div class="col-md-5 del_oldimage_div4" style="padding: 5px">
                                <span>图四:</span>
                                 <img id="up_img3"style="width: 150px;height: 130px;" onclick="javascript:window.open(this.src);">
                                <span class="del_old"onclick="del_imgfunction(4);">x</span>
                            </div>
                            <div class="col-md-5 del_oldimage_div5" style="padding: 5px">
                                <span>图五:</span>
                                 <img id="up_img4"style="width: 150px;height: 130px;"onclick="javascript:window.open(this.src);">
                                <span class="del_old" onclick="del_imgfunction(5);">x</span>
                            </div>
                        </div>
                    </div>
                </div>
                <form action="Fruit/FruitImgServlet" id="myform" method="post" enctype="multipart/form-data" target="nm_iframe">

                    <div class="row" style="margin-top: 25px;margin-bottom:35px;">
                        <div class="col-md-4"style="text-align: right">更新图片：</div>

                        <div class="col-md-8">
                            <div class="upload-pic">
                                <label class="up-lab" for="add-pic-btn" >点击上传</label>
                                <input type="file" name="file_img"  accept="image/*" multiple class="up-file" id="add-pic-btn" >
                            </div>
                            <div class="group-coms-pic" id="groupTu" style="position: relative; left: 10px;">

                            </div>
                        </div>

                </div>
                    <button type="submit" style="display:none;" id="sumit_img">提交图片</button>
                </form>
            </div>
            <div class="modal-footer" style="text-align: center">
                <button type="button" class="btn btn-default close_modal" data-dismiss="modal" style="display: none">关闭</button>
                <button type ="submit" class="btn btn-default"  id="up_information" onclick="update_information();">提交上架</button>
            </div>

            <iframe name="nm_iframe" style="display:none;"></iframe>

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="row" style="height: 380px" >
   <div class="col-md-5" style="height: 100%">
       <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="3000" style="border-radius:12px;">
           <!-- Wrapper for slides -->
           <div class="carousel-inner" role="listbox" style="margin-top: 20px; border-radius:12px;">

               <div class="item active">
                   <img  alt="图片加载失败" style="display: block;height: 350px;width:100%; border-radius:12px;" id="frist_img">;
               </div>

               <div class="item">
                   <img  alt="图片加载失败" style="display: block;height: 350px;width:100%; border-radius:12px;" id="2nd">;
               </div>

               <div class="item">
                   <img  alt="图片加载失败" style="display: block;height: 350px;width:100%; border-radius:12px;" id="3rd">;
               </div>

               <div class="item">
                   <img  alt="图片加载失败" style="display: block;height: 350px;width:100%; border-radius:12px;"id="4th">;
               </div>

               <div class="item">
                   <img  alt="图片加载失败" style="display: block;height: 350px;width:100%; border-radius:12px;" id="5th">;
               </div>
           </div>
           <!-- Indicators -->
           <ol class="carousel-indicators ">
               <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
               <li data-target="#carousel-example-generic" data-slide-to="1"></li>
               <li data-target="#carousel-example-generic" data-slide-to="2"></li>
               <li data-target="#carousel-example-generic" data-slide-to="3"></li>
               <li data-target="#carousel-example-generic" data-slide-to="4"></li>
           </ol>
           <!-- Controls -->
       <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev" style="margin-right: 0px;">
           <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
           <span class="sr-only">Previous</span>
       </a>
       <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next" style="margin-right: 0px;">
           <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
           <span class="sr-only">Next</span>
       </a>

       </div>
   </div>

    <div class="col-md-7">
        <div class="title"></div>
            <div>推荐等级
                <i class="fa fa-star" aria-hidden="true" style="color: #FAE21C"></i>
                <i class="fa fa-star" aria-hidden="true"style="color: #FAE21C"></i>
                <i class="fa fa-star" aria-hidden="true"style="color: #FAE21C"></i>
                <i class="fa fa-star-o" aria-hidden="true"></i>
                <i class="fa fa-star-o" aria-hidden="true"></i>

            </div>
            <div class="price">
                <span id="price"></span>  <span id="discount_price"></span>
            </div>
        <div class="detail">

        </div>
            <div class="btns">
                <a class="btn btn-primary  btn-lg" href="#">月销量</a>
                 <button class="btn btn-primary btn-lg" id="open_modal" data-toggle="modal" data-target="#myModa2">修改详情</button>
            </div>
    </div>

</div>
<div class="row" style="margin-top: 2px">
    <div class="col-md-5">
        <div class="small_img">
            <img  alt="图片加载失败。。"  data-target="#carousel-example-generic" data-slide-to="0" class="small_img1">
            <img  alt="图片加载失败。。"  data-target="#carousel-example-generic" data-slide-to="1" class="small_img2">
            <img  alt="图片加载失败。。"  data-target="#carousel-example-generic" data-slide-to="2" class="small_img3">
            <img  alt="图片加载失败。。"  data-target="#carousel-example-generic" data-slide-to="3" class="small_img4">
            <img  alt="图片加载失败。。"  data-target="#carousel-example-generic" data-slide-to="4" class="small_img5">
        </div>
    </div>
</div>
</body>
</html>
