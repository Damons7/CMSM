package Dao.impl;

import Dao.FruitDao;
import JavaBean.Fruit;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class FruitDaoImpl implements FruitDao{

    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public int findTotalCount(String condition) {
        //1.定义模板初始化sql
        String  sql ="select count(*) from fruit where  conditions=1";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {
            sql = "select count(*) from fruit where conditions=1 and name like '%"+condition+"%' or id like '%"+condition+"%' ; ";
            System.out.println("sql1="+sql);
        }
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public List<Fruit> findFruitByPage(int start, int rows, String condition) {

        String sql = "select * from fruit where conditions=1 limit ? ,? ";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {
            sql = "select * from fruit where conditions=1 and name like '%"+condition+"%' or id like '%"+condition+"%' limit ? ,? ";
        }
        return template.query(sql, new BeanPropertyRowMapper<Fruit>(Fruit.class),start,rows);

    }

    @Override
    public int pull_offFruit(int id,String now_time) {
        //1.定义sql
        String sql = " update fruit set conditions =0,pull_off_time=? where id=?";
        //2.执行sql
        return  template.update(sql,now_time,id);
    }

    @Override
    public int AddFruit(Fruit fruit) {
        //1.定义sql
        String sql = " insert into fruit(name,price,discount_price,cost,numbers,amount,title,add_time,describes,imgs)values(?,?,?,?,?,?,?,?,?,?)";
             return  template.update(sql, fruit.getName(),fruit.getPrice(),fruit.getDiscount_price(),fruit.getCost(),fruit.getNumbers(),fruit.getAmount(),fruit.getTitle(),fruit.getAdd_time(),fruit.getDescribes(),fruit.getImgs());

    }

    @Override
    public Fruit DetailsFruit(int id) {
        //1.定义sql
        String sql = " select *from fruit where id=?";
        return  template.queryForObject(sql,new BeanPropertyRowMapper<Fruit>(Fruit.class),id);

    }

    @Override
    public int UpdateFruit(Fruit fru) {

        String sql = "update fruit set name =?,title=?,price=?,discount_price=?,cost=?,amount=?,describes=? where id=? ;";
        return  template.update(sql, fru.getName(),fru.getTitle(),fru.getPrice(),fru.getDiscount_price(),fru.getCost(),fru.getAmount(),fru.getDescribes(),fru.getId());

    }

    @Override
    public String FruitImgsPath(int id){
        String  sql ="select imgs from fruit where id=? ;";
        return template.queryForObject(sql, String.class, id);
    }

    @Override
    public Fruit FruitName(String name) {
        String  sql ="select *from fruit where name=? ;";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Fruit>(Fruit.class), name);
    }

    @Override
    public int FruitImgByName(String path,String name) {
        String sql = "update fruit set imgs=? where name=? ;";
        return  template.update(sql,path,name );

    }

}

