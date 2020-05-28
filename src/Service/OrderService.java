package Service;

import JavaBean.DetailOrder;
import JavaBean.Order;
import JavaBean.PageBean;
import JavaBean.userAddress;

import java.util.List;

public interface OrderService {
    /**
     * 分页条件查询
     * @param currentPage
     * @param rows

     * @return
     */
    PageBean<Order> findOrderByPage(String currentPage, String rows, String condition, String conditions);

    /**
     * 批量发货
     * @param ids
     */
    public int Bulk_deliver_Order(String[] ids);

    /**
     * 单个发货
     * @param id
     */
    public int deliver_Order(String id);

    /**
     * 批量退货
     * @param ids
     */
    public int Bulk_return_Order(String[] ids);

    /**
     * 单个退货
     * @param id
     */
    public int return_Order(String id);

    /**
     * 订单地址信息
     * @param orderid
     */
    public userAddress DetailsUserAddress(String orderid);

    /**
     * 订单详情
     * @param orderid
     */
    public List<DetailOrder> DetailsOrderService(String orderid);

    /**
     * 修改订单信息
     * @param addre,orderid
     */
    public int updateOrder(userAddress addre,String orderid );

    /**
     * 修改订单备注信息
     * @param message,orderid
     */
    public int updateOrderMessage(String message,String orderid );
}


