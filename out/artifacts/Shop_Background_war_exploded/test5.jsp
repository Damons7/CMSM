
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/test5.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/details.css">
    <title></title>

<script>

    Add=function () {
        var newUrl = '/TestServlet.do';
        $("#myform").attr('action',newUrl);    //通过jquery为action属性赋值
        $("#sumit_img").trigger("click");

    }

$(function () {

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

})
</script>
</head>
<body>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  >
    <div class="modal-dialog">
        <div class="modal-content">

            <%--显示信息--%>
            <div class="modal-body" id="information">

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
                <button type ="submit" class="btn btn-default"  id="up_information" onclick="Add();">提交上架</button>
            </div>


            <iframe name="nm_iframe" style="display:none;"></iframe>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




</body>
</html>