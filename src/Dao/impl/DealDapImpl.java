package Dao.impl;

import Dao.DealDao;
import JavaBean.Deal;
import JavaBean.Order;
import JavaBean.goodsRank;
import JavaBean.userDetail;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class DealDapImpl implements DealDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public int fruitAmount(){
        //1.定义模板初始化sql
        String  sql ="select count(*) from fruit";
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public int snacksAmount(){
        //1.定义模板初始化sql
        String  sql ="select count(*) from snacks";
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public int vegetablesAmount(){
        //1.定义模板初始化sql
        String  sql ="select count(*) from vegetables";
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public Deal orderAmount(){
        //1.定义模板初始化sql
        String  sql ="select  sum(case conditions when '已收货' then 1 else 0 end) as alreadyNumber, " +
                "        sum(case conditions when '待发货' then 1 else 0 end) as deliverNumber, " +
                "        sum(case conditions when '待收货' then 1 else 0 end) as takeOverNumber, " +
                "        sum(case conditions when '退货中' then 1 else 0 end) as returningNumber, " +
                "        sum(case conditions when '已退货' then 1 else 0 end) as returnedNumber " +
                " from orders ; ";
        return template.queryForObject(sql,new BeanPropertyRowMapper<Deal>(Deal.class));
    }

    @Override
    public Deal orderMonth(){
        //1.定义模板初始化sql
        String  sql ="select  sum(case  when add_time like '2019-01%' then 1 else 0 end) as jan, " +
                "        sum(case  when add_time like '2019-02%' then 1 else 0 end) as feb, " +
                "        sum(case  when add_time like '2019-03%' then 1 else 0 end) as mar, " +
                "        sum(case  when add_time like '2019-04%' then 1 else 0 end) as apr, " +
                "        sum(case  when add_time like '2019-05%' then 1 else 0 end) as may, " +
                "        sum(case  when add_time like '2019-06%' then 1 else 0 end) as june, " +
                "        sum(case  when add_time like '2019-07%' then 1 else 0 end) as july, " +
                "        sum(case  when add_time like '2019-08%' then 1 else 0 end) as aug, " +
                "        sum(case  when add_time like '2019-09%' then 1 else 0 end) as sept, " +
                "        sum(case  when add_time like '2019-10%' then 1 else 0 end) as oct, " +
                "        sum(case  when add_time like '2019-11%' then 1 else 0 end) as nov, " +
                "        sum(case  when add_time like '2019-12%' then 1 else 0 end) as dece " +
                " from orders;";
        return template.queryForObject(sql,new BeanPropertyRowMapper<Deal>(Deal.class));
    }

    @Override
    public Deal orderQuarter(){
        //1.定义模板初始化sql
        String  sql ="select  sum(case  when add_time like '2019-01%' or add_time like'2019-02%' or add_time like '2019-03%' then 1 else 0 end) as q1th, " +
                "        sum(case  when add_time like '2019-04%' or add_time like'2019-05%' or add_time like '2019-06%' then 1 else 0 end) as q2nd, " +
                "        sum(case  when add_time like '2019-07%' or add_time like'2019-08%' or add_time like '2019-09%' then 1 else 0 end) as q3rd, " +
                "        sum(case  when add_time like '2019-12%' or add_time like'2019-11%' or add_time like '2019-10%' then 1 else 0 end) as q4th " +
                " from orders; ";
        return template.queryForObject(sql,new BeanPropertyRowMapper<Deal>(Deal.class));
    }


    @Override
    public int transactionAmount() {
        String sql="select sum(price) from orders where conditions='已收货';";
        return template.queryForObject(sql,Integer.class);
    }

    @Override
    public int refundAmount() {
        String sql="select sum(price) from orders where conditions='已退货';";
        return template.queryForObject(sql,Integer.class);
    }

    @Override
    public Deal orderNumbers() {
        String sql="select sum(case conditions when '已收货' then 1 else 0 end) as transactionSuccess," +
                "sum(case conditions when '已退货' then 1 else 0 end) as transactionFail," +
                "count(*) as orderNumber from orders;";
        return template.queryForObject(sql,new BeanPropertyRowMapper<Deal>(Deal.class));
    }

    @Override
    public userDetail userNumbers() {
        String sql="select count(*) as counts ,sum(case sex when '男' then 1 else 0 end) as manNumber," +
                "sum(case sex when '女' then 1 else 0 end) as womanNumber from user;";
        return template.queryForObject(sql,new BeanPropertyRowMapper<userDetail>(userDetail.class));
    }

    @Override
    public int headManNumber() {
        String sql="select count(*) from headman;";
        return template.queryForObject(sql,Integer.class);
    }

    public List<Order> dateOrderDao(){
        String sql="select add_time from orders;";
        return template.query(sql, new BeanPropertyRowMapper<Order>(Order.class));
    }

    @Override
    public Deal dateOrderNumberDao(String date) {
        String sql="select count(*) as orderNumber,sum(price) as transactionAmount from orders where add_time=? ;";
        try{
            return  template.queryForObject(sql,new BeanPropertyRowMapper<Deal>(Deal.class),date);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public  List<goodsRank> goodsRankDao() {
        String sql="select types,name as goodsname,(numbers-amount)as salesVolume from fruit  union all " +
                "select types,name as goodsname,(numbers-amount)as salesVolume from vegetables union all " +
                "select types,name as goodsname,(numbers-amount)as salesVolume from snacks order by salesVolume desc " +
                "limit 7 ;";
        return template.query(sql, new BeanPropertyRowMapper<goodsRank>(goodsRank.class));
    }


}
