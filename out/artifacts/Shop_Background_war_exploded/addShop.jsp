<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Stict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang = "zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
    var num=0;
    document.getElementById("add-pic-btn").addEventListener("change", function () {
        var obj = this,
            length = obj.files.length,
            arrTitle = []; //存标题名
        _html = '';
        num+=length;
        if(num>5){
            alert("最多只能上传5张图片");
            num-=length;
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
            num--;
            console.log('删除成功~')
        }
        return false;
    }

    //检查商品信息
    var a = "1";
    var b = "2";
    var c = "3";
    var d = "4";
    var e= "5";
    var f = "6";
    var g = "7";

    $(function () {
        $("#name").blur(function () {
            var name = $("#name").val();
            var message = "";
            var flag = false;
            // 完成正则匹配
            if (name.length<=0) {
                a = "1";
                $("#reg_spa").text("输入名称").css('color', '#f53808');
                $("#name").css("border","1px solid red");
            }
            else if (name.length > 0) {
                a= "0";
                flag = true;
                $("#name").css("border", "");
            }
            if(flag) {
                $("#reg_spa").text(message).css('color', '#0000ff');
                // 判断商品名称是否存在
                $.get("Fruit/FruitNameServlet", {name: $("#name").val()}, function (data) {
                    if (data == "true") {
                        a = "1";
                        $("#reg_spa").text("该商品已上架").css('color', '#f53808');
                        $("#name").css("border", "1px solid red");
                    } else {
                        $("#name").css("border", "");
                        $("#reg_spa").text("✔").css('color', '#0000ff');
                    }
                });
            }

        });

        $("#title").blur(function () {

            var title = $("#title").val();
            var message = "";
            // 完成正则匹配
            if (title.trim().length<= 0) {
                b = "2";
                $("#reg_spb").text("未输入").css('color', '#f53808');
                $("#title").css("border","1px solid red");

            }
            else if (title.trim().length > 0) {
                b = "0";
                $("#reg_spb").text(message).css('color', '#0000ff');
                $("#title").css("border", "");
            }

        });

        $("#amount").blur(function () {

            var amount = $("#amount").val();
            var message = "";
            var flag = false;
            var reg_amount = /^[1-9]\d*$/;
            // 完成正则匹配
            if (amount.length<= 0) {
                c= "3";
                message = "请输入商品数量！";
                $("#amount").css("border","1px solid red");

            }
            else   if (!reg_amount.test(amount)) {
                c="3";// 修改全局变量
                message = "格式有误！";
                $("#amount").css("border", "1px solid red");
            }
            else if (amount.length > 0) {
                c = "0";
                flag = true;
                $("#amount").css("border", "");
            }
            if (flag) {
                $("#reg_spc").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spc").text(message).css('color', '#f53808');
            }

        });

        $("#cost").blur(function () {

            var cost = $("#cost").val();
            var message = "";
            var flag = false;
            var reg_cost =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
            // 完成正则匹配
            if (cost.length<= 0) {
                d= "4";
                message = "未输入！";
                $("#cost").css("border","1px solid red");

            }
            else   if (!reg_cost.test(cost)) {
                d= "4";// 修改全局变量
                message = "格式有误！";
                $("#cost").css("border", "1px solid red");
            }
            else if (cost.length > 0) {
                d = "0";
                flag = true;
                $("#cost").css("border", "");
            }
            if (flag) {
                $("#reg_spd").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spd").text(message).css('color', '#f53808');
            }

        });

        $("#price").blur(function () {

            var price = $("#price").val();
            var message = "";
            var flag = false;
            var reg_price =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
            // 完成正则匹配
            if (price.length<=0) {
                e = "5";
                message = "未输入！";
                $("#price").css("border","1px solid red");

            }
            else   if (!reg_price.test(price)) {
                e= "5";// 修改全局变量
                message = "格式有误！";
                $("#price").css("border", "1px solid red");
            }
            else if (price.length > 0) {
                e = "0";
                flag = true;
                $("#price").css("border", "");
            }
            if (flag) {
                $("#reg_spe").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spe").text(message).css('color', '#f53808');
            }

        });

        $("#discount_price").blur(function () {

            var discount_price = $("#discount_price").val();
            var message = "";
            var flag = false;
            var reg_discount_price =/^\d{0,8}\.{0,1}(\d{1,2})?$/;
            // 完成正则匹配
            if (discount_price.length<= 0) {
                f = "6";
                message = "未输入！";
                $("#discount_price").css("border","1px solid red");

            }
            else   if (!reg_discount_price.test(discount_price)) {
                f= "6";// 修改全局变量
                message = "格式有误！";
                $("#discount_price").css("border", "1px solid red");
            }
            else if (discount_price.length > 0) {
                f = "0";
                flag = true;
                $("#discount_price").css("border", "");
            }
            if (flag) {
                $("#reg_spf").text(message).css('color', '#0000ff');

            } else {
                $("#reg_spf").text(message).css('color', '#f53808');
            }

        });

        $("#describes").blur(function () {

            var describes = $("#describes").val();
            var message="";
            // 完成正则匹配
            if (describes.trim().length<= 0) {
                g = "7";
                $("#reg_spg").text("未输入").css('color', '#f53808');
                $("#describes").css("border","1px solid red");
            }
            else if (describes.trim().length > 0) {
                g = "0";
                $("#reg_spg").text(message).css('color', '#0000ff');
                $("#describes").css("border", "");
            }
        });

    });
    function check_commodity() {
        if (a == 1||b==2||c==3||d==4||e==5||f==6||g==7) {
            alert("商品格式有误!请检查后重新输入!")
            return false;
        }
        else
           return true;
    }


</script>
</head>

<button id="open_modal3" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal3" style="display: none"></button>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel" style="text-align:center;">
                    上架商品
                </h4>
            </div>
            <%--显示信息--%>
            <div class="modal-body" id="information">

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">商品类型：</div>
                    <div class="col-md-3" style="text-align:left;">
                        <select class="form-control" id="select_shop">
                            <option name="type" value="1" class="tpye">水果类</option>
                            <option name="type" value="2" class="tpye">蔬菜类</option>
                            <option name="type" value="3" class="tpye">零食类</option>
                        </select>
                    </div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">名称：</div>
                    <div class="col-md-3" style="text-align:left;">
                        <input type="text" name="name" id="name" placeholder="输入商品名称"  class="form-control" style="width: 130px;height: 22px;">
                    </div>
                    <div class="col-md-4"> <span id="reg_spa"></span></div>

                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">标题：</div>
                    <div class="col-md-8" style="text-align:left;">
                         <textarea rows="10" cols="30" class="form-control" id="title" name="title" style="width: 280px;height: 44px;"placeholder="30字以内">
                        </textarea>
                        <span id="reg_spb"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">数量：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="amount" id="amount"  class="form-control" style="width: 100px;height: 22px;">
                        <span id="reg_spc"></span>
                    </div>

                    <div class="col-md-2"style="text-align: right">成本：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="cost" id="cost"  class="form-control" style="width: 80px;height: 22px;">
                        <span id="reg_spd"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 25px">

                    <div class="col-md-4"style="text-align: right">原价：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="price" id="price"  class="form-control" style="width: 100px;height: 22px;">
                        <span id="reg_spe"></span>
                    </div>
                    <div class="col-md-2"style="text-align: right">促销价：</div>
                    <div class="col-md-2" style="text-align:left;">
                        <input type="text" name="discount_price" id="discount_price"  class="form-control" style="width: 80px;height: 22px;">
                        <span id="reg_spf"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 25px">
                    <div class="col-md-4"style="text-align: right">详细介绍：</div>
                    <div class="col-md-8" style="text-align:left;">
                       <textarea rows="10" cols="30" class="form-control" id="describes" name="describes" style="width: 280px;height: 66px;"placeholder="100字以内">
                        </textarea>
                        <span id="reg_spg"></span>
                    </div>

                </div>
                <form action="Fruit/FruitImgServlet" id="myform" method="post" enctype="multipart/form-data" target="nm_iframe">

                <div class="row" style="margin-top: 25px;margin-bottom:35px;">
                    <div class="col-md-4"style="text-align: right">详情图片：</div>

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
                <button type ="submit" class="btn btn-default"  id="up_information" onclick="Add_commodity();">提交上架</button>
            </div>


            <iframe id="id_iframe" name="nm_iframe" style="display:none;"></iframe>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</html>