package Dao.impl;

import Dao.UserDao;
import JavaBean.user;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;


public class UserDaoImpl implements UserDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    @Override
    public int findTotalCount(String condition) {
        //1.定义模板初始化sql
        String  sql ="select count(*) from user where  1=1";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {

            sql = "select count(*) from user where  1=1 and phone like '%"+condition+"%' or email like '%"+condition+"' or name like '%"+condition+"%' ";
            System.out.println("sql1="+sql);
        }
            return template.queryForObject(sql, Integer.class);


    }

    @Override
    public List<user> findByPage(int start, int rows,String condition) {

        String sql = "select * from user  limit ? ,? ";
        if(condition!=null&&condition.length()!=0&&!condition.equals(null)) {

            sql = "select * from user where  1=1 and phone like '%"+condition+"%' or email like '%"+condition+"%' or name like '%"+condition+"%'  limit ? ,?";
            System.out.println("sql2="+sql);
        }
        return template.query(sql, new BeanPropertyRowMapper<user>(user.class),start,rows);


    }

    @Override
    public int deleteUser(int id) {
        //1.定义sql
        String sql = "delete from user where id = ?";
        //2.执行sql
        return template.update(sql, id);
    }

//        @Override
//    public int FindIdByName(String name) {
//        //1.定义sql
//        String sql = "select id from user where name = ?";
//        //2.执行sql
//        return template.queryForObject(sql, int.class,name);
//    }



}
