package Dao;

import JavaBean.DetailOrder;
import JavaBean.Order;
import JavaBean.userAddress;

import java.util.List;

public interface OrderDao {
    /**
     * 分页查询每页记录
     * @param start
     * @param start,rows,condition,conditions

     * @return List<Order>
     */
    public List<Order> findByPage(int start, int rows, String condition,String conditions);

    /**
     * 查询总记录数
     * @param condition,conditions
     * @return int
     */
    public int findTotalCount(String condition,String conditions);

    /**
     * 发货 (conditons状态改变)
     * @return
     * @param orderid,now_time
     */
    public int deliver_Order(String orderid,String now_time);

    /**
     * 退货 (conditons状态改变)
     * @return
     * @param orderid,now_time
     */
    public int return_Order(String orderid,String now_time);

    /**
     * 通过orderid查询用户收货地址
     * @return
     * @param orderid
     */
    public userAddress FindAddressByOrderid(String orderid);

    /**
     * 查询订单详情
     * @return
     * @param orderid
     */
    public List<DetailOrder> DetailOrderDao(String orderid);

    /**
     * 修改订单详情
     * @return
     * @param addre,orderid
     */
    public int updateOrderDao(userAddress addre,String orderid);

    /**
     * 修改订单备注详情
     * @return
     * @param message,orderid
     */
    public int updateOrderMessageDao(String message,String orderid);
}



