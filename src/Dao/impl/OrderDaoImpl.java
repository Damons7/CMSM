package Dao.impl;

import Dao.OrderDao;
import JavaBean.DetailOrder;
import JavaBean.Order;
import JavaBean.userAddress;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class OrderDaoImpl implements OrderDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public int findTotalCount(String condition, String conditions) {
        String sql = "select count(*) from orders where  1=1";
        if (conditions.equals("0")) { //conditions为0.表示全部订单
            if (condition != null && condition.length() != 0 && !condition.equals(null)) {
                sql = "select count(*) from orders where 1=1 and orderid like '%" + condition + "%' or phone like '%" + condition + "' or name like '%" + condition + "%' ";
                System.out.println("sql1=" + sql);
            }
            return template.queryForObject(sql, Integer.class);
        }else if (conditions.equals("1")) { //conditions为1.表示已收货
            conditions="已收货";
        }else if (conditions.equals("2")) { //conditions为2.表示待发货
            conditions="待发货";
        }else if (conditions.equals("3")) { //conditions为3.表示待收货
            conditions="待收货";
        }else if (conditions.equals("4")) { //conditions为4.表示退货中
            conditions="退货中";
        }else if (conditions.equals("5")) { //conditions为5.表示已退货
            conditions="已退货";
        }
        sql = "select count(*) from orders where  conditions=? ";
        if (condition != null && condition.length() != 0 && !condition.equals(null)) {
            sql = "select count(*) from orders where conditions=? and (orderid like '%" + condition + "%' or phone like '%" + condition + "' or name like '%" + condition + "%') ";
        }
        return template.queryForObject(sql, Integer.class,conditions);

    }

    @Override
    public List<Order> findByPage(int start, int rows, String condition, String conditions) {
        String sql = "select * from orders  limit ? ,? ";
        if (conditions.equals("0")) {//conditions为0.表示全部订单
            if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {
                sql = "select * from orders where 1=1 and phone like '%"+condition+"%' or orderid like '%"+condition+"%' or name like '%"+condition+"%'  limit ? ,?";
            }
            return template.query(sql, new BeanPropertyRowMapper<Order>(Order.class),start,rows);
        }else if (conditions.equals("1")) { //conditions为1.表示已收货
            conditions="已收货";
        }else if (conditions.equals("2")) { //conditions为2.表示待发货
            conditions="待发货";
        }else if (conditions.equals("3")) { //conditions为3.表示待收货
            conditions="待收货";
        }else if (conditions.equals("4")) { //conditions为4.表示退货中
            conditions="退货中";
        }else if (conditions.equals("5")) { //conditions为5.表示已退货
            conditions="已退货";
        }
            sql = "select * from orders where conditions=?  limit ? ,? ";
            if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {
                sql = "select * from orders where  conditions=?  and (phone like '%"+condition+"%' or orderid like '%"+condition+"%' or name like '%"+condition+"%')  limit ? ,?";
            }
            return template.query(sql, new BeanPropertyRowMapper<Order>(Order.class),conditions,start,rows);

    }

    @Override
    public int deliver_Order(String orderid,String now_time) {
        //1.定义sql
        String sql = " update orders set conditions =?,deliver_time=? where orderid=?";
        //2.执行sql
        return  template.update(sql,"待收货",now_time,orderid);
    }

    @Override
    public int return_Order(String orderid,String now_time) {
        //1.定义sql
        String sql = " update orders set conditions =?,returned_time=? where orderid=?";
        //2.执行sql
        return  template.update(sql,"退货中",now_time,orderid);
    }

    @Override
    public List<DetailOrder> DetailOrderDao(String orderid){
        //1.定义sql
        String sql = "select *from detail_orders where orderid =? ";
       //2.执行sql
        return template.query(sql,new BeanPropertyRowMapper<DetailOrder>(DetailOrder.class),orderid);
    }

    @Override
    public userAddress FindAddressByOrderid(String orderid){
        //1.定义sql
        String sql = "select *from orders where orderid = ?";
        //2.执行sql
        return template.queryForObject(sql, new BeanPropertyRowMapper<userAddress>(userAddress.class),orderid);
    }

    @Override
    public int updateOrderDao(userAddress addre,String orderid){
        //1.定义sql
        String sql = " update orders set name =?,phone=?,address=?  where orderid=?";
        //2.执行sql
        return  template.update(sql,addre.getName(),addre.getPhone(),addre.getAddress(),orderid);
    }

    @Override
    public int updateOrderMessageDao(String message,String orderid){
        //1.定义sql
        String sql = " update orders set message =? where orderid=?";
        //2.执行sql
        return  template.update(sql,message,orderid);
    }

}
