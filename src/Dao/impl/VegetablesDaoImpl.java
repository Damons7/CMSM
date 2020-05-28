package Dao.impl;

import Dao.VegetablesDao;
import JavaBean.Vegetables;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class VegetablesDaoImpl implements VegetablesDao{
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public int findTotalCount(String condition) {
        //1.定义模板初始化sql
        String  sql ="select count(*) from vegetables where conditions=1";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {
            sql = "select count(*) from vegetables where  conditions=1 and name like '%"+condition+"%' or id like '%"+condition+"%' ; ";
            System.out.println("sql1="+sql);
        }
        return template.queryForObject(sql, Integer.class);
    }

    @Override
    public List<Vegetables> findVegetablesByPage(int start, int rows, String condition) {

        String sql = "select * from vegetables where conditions=1 limit ? ,? ";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {

            sql = "select * from vegetables where conditions=1 and name like '%"+condition+"%' or id like '%"+condition+"%' limit ? ,? ";
            System.out.println("sql2="+sql);
        }
        return template.query(sql, new BeanPropertyRowMapper<Vegetables>(Vegetables.class),start,rows);


    }

    @Override
    public int pull_offVegetables(int id,String now_time) {
        //1.定义sql
        String sql = " update vegetables set conditions =0,pull_off_time=? where id=?";
        //2.执行sql
        return  template.update(sql,now_time,id);
    }

    @Override
    public int AddVegetables(Vegetables veg) {
        //1.定义sql
        String sql = " insert into vegetables(name,price,discount_price,cost,numbers,amount,title,add_time,describes,imgs)values(?,?,?,?,?,?,?,?,?,?)";
        return  template.update(sql, veg.getName(),veg.getPrice(),veg.getDiscount_price(),veg.getCost(),veg.getNumbers(),veg.getAmount(),veg.getTitle(),veg.getAdd_time(),veg.getDescribes(),veg.getImgs());

    }

    @Override
    public Vegetables DetailsVegetables(int id) {
        //1.定义sql
        String sql = " select *from vegetables where id=?";
        return  template.queryForObject(sql,new BeanPropertyRowMapper<Vegetables>(Vegetables.class),id);

    }

    @Override
    public int UpdateVegetables(Vegetables veg) {
        String sql = "update vegetables set name =?,title=?,price=?,discount_price=?,cost=?,amount=?,describes=? where id=? ;";
        return  template.update(sql, veg.getName(),veg.getTitle(),veg.getPrice(),veg.getDiscount_price(),veg.getCost(),veg.getAmount(),veg.getDescribes(),veg.getId());
    }

    @Override
    public int VegetablesImgByName(String path,String name) {
        String sql = "update vegetables set imgs=? where name=? ;";
        return  template.update(sql,path,name );

    }

    @Override
    public Vegetables VegetablesName(String name) {
        String  sql ="select *from vegetables where name=? ;";
        return template.queryForObject(sql, new BeanPropertyRowMapper<Vegetables>(Vegetables.class), name);
    }

}
