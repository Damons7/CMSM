<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/5/4
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>交易信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/deal.css">
</head>
<script>
    $(function () {
        //初始化图表

        var myDealCharts = echarts.init($("#deal_chart").get(0));
        var myOrderCharts = echarts.init($("#order_chart").get(0));
        var myGoodsCharts = echarts.init($("#goods_chart").get(0));
        var myOrderPieCharts = echarts.init($("#OrderPie_Chart").get(0));

        var Dealoption = {
            title: {
                text: "销量分布图",
                subtext: '2020-02-28'
            },
            legend: {
                data: ["柱状图","折线图"]
            },
            tooltip: {
                trigger:'axis'
            },
            xAxis: {
                data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
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
                data: ["已收货","待发货","待收货","退货中","已退货"]
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
        var Goodsoption = {
                title: {
                    text: "商品销量比例图",
                    subtext: '2020年度'
                },
                legend: {
                    right: '25%', bottom: '2%',
                    data: ["水果", "零食", "蔬菜"]
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                series: [{
                    type: 'pie',
                    name: '商品'
                }]
            };
        var OrderPieoption = {
            title: {
                text: "各季度订单销量比例图",
                subtext: '2020年度'
            },
            legend: {
                 bottom: '2%',
                data:  ["一季度","二季度","三季度","四季度"]
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            series: [{
                type: 'pie',
                name: '销量'
            }]
        };
        myDealCharts.setOption(Dealoption);
        $.get("Deal/goodsSalesByMonthServlet", {}, function (deal2) {

            myDealCharts.setOption({
                series: [{
                    data: [deal2["jan"],deal2["feb"],deal2["mar"],deal2["apr"],deal2["may"],deal2["june"],deal2["july"],
                        deal2["aug"], deal2["septe"], deal2["oct"],deal2["nov"],deal2["dece"]
                    ]
                },
                    {
                        data: [deal2["jan"],deal2["feb"],deal2["mar"],deal2["apr"],deal2["may"],deal2["june"],deal2["july"],
                            deal2["aug"], deal2["septe"], deal2["oct"],deal2["nov"],deal2["dece"]
                        ]
                    }

                ]
            })
        });
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
        myGoodsCharts.setOption(Goodsoption);
        $.get("Deal/goodsScaleServlet", {}, function (goods) {
            myGoodsCharts.setOption({
                series: [{
                    radius: '65%',
                    data: [{ value:goods[0],name: "水果"},
                        { value:goods[1],name: "零食"},
                        { value:goods[2],name: "蔬菜"}],
                    itemStyle: {
                        normal: {
                            shadowBlur: 200,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            })
        });
        myOrderPieCharts.setOption(OrderPieoption);
        $.get("Deal/goodsSalesByQuarterServlet", {}, function (deal3) {
            myOrderPieCharts.setOption({
                series: [{
                    radius: '60%',
                    data:[{value:deal3["q1th"], name:"一季度"},
                        {value:deal3["q2nd"], name:"二季度"},
                        {value:deal3["q3rd"], name:"三季度"},
                        {value:deal3["q4th"], name:"四季度"}],
                    roseType: 'angle',
                    itemStyle: {
                        normal: {
                            shadowBlur: 200,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
                ]
            })
        });


        //获取交易金额、订单量、交易成功、交易失败、退款金额
        $.get("Deal/orderSalesServlet", {}, function (deal4) {
            $("#transactionAmount").html(deal4[0]);
            $("#orderNumber").html(deal4[1]);
            $("#transactionSuccess").html(deal4[2]);
            $("#transactionFail").html(deal4[3]);
            $("#refundAmount").html(deal4[4]);
        });

        $.get("Deal/goodsRankServlet", {}, function (rankByGoods) {
            for (var i=0;i<rankByGoods.length;i++) {
                var lidd='<tr><td>' + (i + 1) + '</td>' +
                    '<td>' + rankByGoods[i].goodsname + '</td>' +
                    '<td>' + rankByGoods[i].salesVolume + '</td>' +
                    '<td>' + rankByGoods[i].types + '</td></tr>';
                $("#trr").append(lidd);
            }
        });

    })
</script>
<body>
<div class="row">
    <div class="col-md-2 deals">

        <div class="div_deals div_deals0 col-md-6"><i class="fa fa-jpy"></i>
        </div>
        <div class="div_deals_infor col-md-6">
            <span>交易金额</span>
            <span id="transactionAmount"></span>
        </div>
        </div>

    <div class="col-md-2 deals">

        <div class="div_deals div_deals1 col-md-6"><i class="fa fa-shopping-cart"style="font-size: 40px"></i>
        </div>
        <div class="div_deals_infor col-md-6">
            <span>订单数量</span>
            <span id="orderNumber"></span>
        </div>
    </div>
    <div class="col-md-2 deals">

        <div class="div_deals div_deals2 col-md-6"><i class="fa fa-shopping-cart"style="font-size: 40px"></i>
        </div>
        <div class="div_deals_infor col-md-6">
            <span>交易成功</span>
            <span id="transactionSuccess"></span>
        </div>
    </div>
    <div class="col-md-2 deals">

        <div class="div_deals div_deals3 col-md-6"><i class="fa fa-shopping-cart" style="font-size: 40px"></i>
        </div>
        <div class="div_deals_infor col-md-6">
            <span>交易失败</span>
            <span id="transactionFail"></span>
        </div>
    </div>
    <div class="col-md-2 deals">

        <div class="div_deals div_deals4 col-md-6"><i class="fa fa-jpy"></i>
        </div>
        <div class="div_deals_infor col-md-6">
            <span>退款金额</span>
            <span id="refundAmount"></span>
        </div>
    </div>
</div>

<div class="row">
    <div id="deal_chart" style="height: 300px;background-color: #fff;border: 1px solid #F5F5F5;margin-top: 15px">

    </div>
</div>

<div class="row">
    <div id="order_chart" style="height: 380px;background-color: #fff;border: 1px solid #F5F5F5;margin-top: 15px">

    </div>
</div>

<div class="row">
    <div class="col-md-4">
    <div id="goods_chart" style="height: 380px;background-color: #fff;border: 1px solid #F5F5F5;margin-top: 15px">

    </div>
    </div>

    <div class="col-md-4">
        <div id="OrderPie_Chart" style="height: 380px;background-color: #fff;border: 1px solid #F5F5F5;margin-top: 15px">

        </div>
    </div>

    <div class="col-md-4" style="height: 400px;background-color: #fff;border: 1px solid #F5F5F5;margin-top: 15px">
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
</body>
</html>
