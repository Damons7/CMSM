package Servlet;

import JavaBean.DetailOrder;
import JavaBean.Order;
import JavaBean.PageBean;
import JavaBean.userAddress;
import Service.OrderService;
import Service.impl.OrderServiceImpl;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Order/*")
public class OrderServlet extends BaseServlet {
    private OrderService service = new OrderServiceImpl();
    /**
     * 查询用户功能
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
     public void FindOrderByPageServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //1.获取参数
        String currentPage = request.getParameter("currentPage");//当前页码
        String rows = request.getParameter("rows");//每页显示条数

        if(currentPage == null || "".equals(currentPage)){

            currentPage = "1";
        }
        if(rows == null || "".equals(rows)){
            rows = "10";
        }

        //获取条件查询参数
        String condition="";
        try{
            String condition1 = request.getParameter("condition");
            if(condition1==null||condition1.equals("null")||condition1.length()<=0){
                condition="";
            }else
                condition = new String(condition1.getBytes("ISO-8859-1"), "UTF-8");
        }
        catch (Exception e) {
            e.printStackTrace();
        }

         String conditions = request.getParameter("ids");

        //2.调用service查询
        PageBean<Order> pb = service.findOrderByPage(currentPage,rows,condition,conditions);
        System.out.println(pb);
        writeValue(pb,response);
    }

    /**
     * 单个发货
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void deliver_OrderServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //1.获取所有id
        String orderid = request.getParameter("orderid");
        System.out.println("orderid="+orderid);
        //2.调用service删除
        int a =  service.deliver_Order(orderid);
        //3.跳转查询所有Servlet
        writeValue(a,response);

    }

    /**
     * 批量发货
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void Bulk_deliver_OrderServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //1.获取所有id
        String idd = request.getParameter("uid");
        //2.调用service删除
        System.out.println("数组"+idd);
        ObjectMapper mapper = new ObjectMapper();
        String []ids=mapper.readValue(idd,String[].class);
        int a1 =  service.Bulk_deliver_Order(ids);
        writeValue(a1,response);
    }

    /**
     * 单个退货
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void return_OrderServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //1.获取所有id
        String orderid = request.getParameter("orderid");
        System.out.println("orderid="+orderid);
        //2.调用service删除
        int a =  service.return_Order(orderid);
        //3.跳转查询所有Servlet
        writeValue(a,response);

    }

    /**
     * 批量退货
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void Bulk_return_OrderServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        //1.获取所有id
        String idd = request.getParameter("uid");
        //2.调用service删除
        System.out.println("数组"+idd);
        ObjectMapper mapper = new ObjectMapper();
        String []ids=mapper.readValue(idd,String[].class);
        int a1 =  service.Bulk_return_Order(ids);
        writeValue(a1,response);
    }

    /**
     * 订单详情
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void DetailOrderServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据
        String orderid = request.getParameter("orderid");
        request.setAttribute("orderid",orderid);
        System.out.println("orderid:"+orderid);
        //查询用户收货地址
        userAddress useraddress=new userAddress();
        useraddress=service.DetailsUserAddress(orderid);
        request.setAttribute("useraddress",useraddress);

        //查询订单详情
        List<DetailOrder> orderlist=service.DetailsOrderService(orderid);
        double allprice=0.00;
        for (int i = 0; i < orderlist.size(); i++){
            DetailOrder obj =  orderlist.get(i);
            allprice+=obj.getGoods_price()*obj.getGoods_number();
        }
        request.setAttribute("allprice",allprice);
        request.setAttribute("orderlist",orderlist);
        request.getRequestDispatcher("/order_details.jsp").forward(request,response);


    }

    /**
     * 订单详情
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void UpdateOrderServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据
        String orderid = request.getParameter("orderid");
        String name1 = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("address");
        //防止乱码
        String name = new String(name1.getBytes("ISO-8859-1"), "UTF-8");
        String address = new String(address1.getBytes("ISO-8859-1"), "UTF-8");

        //c存入对象
        userAddress  addre=new userAddress();
        addre.setAddress(address);
        addre.setPhone(phone);
        addre.setName(name);
        //调用service
        int a=service.updateOrder(addre,orderid);

        writeValue(a,response);


    }

    /**
     * 修改订单备注
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void UpdateOrderMessageServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        //2.获取数据
        String orderid = request.getParameter("orderid");
        String message1 = request.getParameter("message");

        //防止乱码
        String message = new String(message1.getBytes("ISO-8859-1"), "UTF-8");

        //调用service
        int a=service.updateOrderMessage(message,orderid);

        writeValue(a,response);


    }

}
