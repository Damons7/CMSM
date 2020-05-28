package Servlet;

import JavaBean.Deal;
import JavaBean.goodsRank;
import Service.DealService;
import Service.impl.DealServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet( "/Deal/*")

public class DealServlet extends BaseServlet {
    private DealService service = new DealServiceImpl();

    /**
     * 查询商品比例功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void goodsScaleServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        int[] goods = service.goodsScale();

        writeValue(goods,response);
    }

    /**
     * 查询订单状态绘制图表
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void orderConditionsServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        Deal deal = service.orderConditionsService();

        int orderConditions[]={0,0,0,0,0};
        orderConditions[0]=deal.getAlreadyNumber();
        orderConditions[1]=deal.getDeliverNumber();
        orderConditions[2]=deal.getTakeOverNumber();
        orderConditions[3]=deal.getReturningNumber();
        orderConditions[4]=deal.getReturnedNumber();
        writeValue(orderConditions,response);


    }

    /**
     * 查询商品销量，按月绘图
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void goodsSalesByMonthServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        Deal deal2 = service.orderMonthService();
        writeValue(deal2,response);

    }

    /**
     * 查询商品销量，按季度绘图
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void goodsSalesByQuarterServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        Deal deal3 = service.orderQuarterService();
        writeValue(deal3,response);
    }

    /**
     * 查询交易金额、退款金额、交易失败、交易成功、订单数量
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void orderSalesServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        int []deal4 = service.orderSalesService();
        writeValue(deal4,response);
    }

    /**
     * 查询会员人数、男女比例
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void userDataServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        int []userData = service.userDataService();
        writeValue(userData,response);
    }

    /**
     * 查询团长人数
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void headManDataServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        int headManData = service.headManDataService();
        writeValue(headManData,response);
    }

    /**
     * 查询具体日期订单量（如今日订单量）
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void dateOrderNumberServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        //2.获取时间
        String date = request.getParameter("date");
        int []nowNumber = service.dateOrderNumberService(date);
        writeValue(nowNumber,response);
    }

    /**
     * 查询商品销量排行
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void goodsRankServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        List<goodsRank> rankByGoods=service.goodsRankService();

        writeValue(rankByGoods,response);
    }
}
