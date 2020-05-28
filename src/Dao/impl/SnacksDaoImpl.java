package Dao.impl;

import Dao.SnacksDao;
import JavaBean.Snacks;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class SnacksDaoImpl implements SnacksDao{
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public int findTotalCount(String condition) {
        //1.定义模板初始化sql
        String  sql ="select count(*) from snacks where  conditions=1";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {
            sql = "select count(*) from snacks where  conditions=1 and name like '%"+condition+"%' or id like '%"+condition+"%' ; ";
            System.out.println("sql1="+sql);
        }
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public List<Snacks> findSnacksByPage(int start, int rows, String condition) {

        String sql = "select * from Snacks where conditions=1 limit ? ,? ";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {

            sql = "select * from snacks where  conditions=1 and name like '%"+condition+"%' or id like '%"+condition+"%' limit ? ,? ";
            System.out.println("sql2="+sql);
        }
        return template.query(sql, new BeanPropertyRowMapper<Snacks>(Snacks.class),start,rows);


    }

    @Override
    public int pull_offSnacks(int id,String now_time) {
        //1.定义sql
        String sql = " update snacks set conditions =0,pull_off_time=? where id=?";
        //2.执行sql
        return  template.update(sql,now_time,id);
    }

    @Override
    public int AddSnacks(Snacks snack) {
        //1.定义sql
        String sql = " insert into snacks(name,price,discount_price,cost,numbers,amount,title,add_time,describes,imgs)values(?,?,?,?,?,?,?,?,?,?)";
        return  template.update(sql, snack.getName(),snack.getPrice(),snack.getDiscount_price(),snack.getCost(),snack.getNumbers(),snack.getAmount(),snack.getTitle(),snack.getAdd_time(),snack.getDescribes(),snack.getImgs());

    }

    @Override
    public Snacks DetailsSnacks(int id) {
        //1.定义sql
        String sql = " select *from snacks where id=?";
        return  template.queryForObject(sql,new BeanPropertyRowMapper<Snacks>(Snacks.class),id);

    }

    @Override
    public int UpdateSnacks(Snacks sna) {


        String sql = "update snacks set name =?,title=?,price=?,discount_price=?,cost=?,amount=?,describes=? where id=? ;";
        return  template.update(sql, sna.getName(),sna.getTitle(),sna.getPrice(),sna.getDiscount_price(),sna.getCost(),sna.getAmount(),sna.getDescribes(),sna.getId());

    }

    @Override
    public Snacks SnacksName(String name) {
        String  sql ="select *from snacks where name= ? ;";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Snacks>(Snacks.class), name);
    }

    @Override
    public int SnacksImgByName(String path,String name) {
        System.out.println("name"+name+"   path:"+path);
        String sql = "update snacks set imgs= ?  where name= ?  ;";
        return  template.update(sql,path,name );

    }
}
