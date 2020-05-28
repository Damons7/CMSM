package Dao.impl;

import Dao.AdministratorDao;
import JavaBean.administrator;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class AdministratorDaoImpl implements AdministratorDao {

    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<administrator> findAll() {
        //使用JDBC操作数据库...
        //1.定义sql
        String sql = "select * from administrator";
        List<administrator> admins = template.query(sql, new BeanPropertyRowMapper<administrator>(administrator.class));

        return admins;
    }

    @Override
    public administrator findUserByUsernameAndPassword(String username, String password) {
        try {
            String sql = "select * from administrator where username = ? and password = ?";
            administrator admin = template.queryForObject(sql, new BeanPropertyRowMapper<administrator>(administrator.class), username, password);
            return admin;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public administrator findUserByRegistername(String registername) {
        try {
            String sql = "select * from administrator where username = ?  ";
            administrator admin = template.queryForObject(sql, new BeanPropertyRowMapper<administrator>(administrator.class), registername);
            return admin;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public administrator findUserByUsername(String username) {
        try {
            String sql = "select * from administrator where username = ?  ";
            administrator admin = template.queryForObject(sql, new BeanPropertyRowMapper<administrator>(administrator.class), username);
            return admin;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public int update_Password(administrator admin) {
        String sql = " update administrator set password =?  where username=?";
         return  template.update(sql,admin.getPassword(),admin.getUsername());
    }

    @Override
    public int RegisterUser(administrator register) {
        try {
            String sql = "insert into administrator(USERNAME,PASSWORD,NAME,EMAIL,PHONE,SEX,CODE,STATUS)values(?,?,?,?,?,?,?,?);";
            int a=template.update(sql, register.getUsername(),register.getPassword(),register.getUsername(),register.getEmail(),
                    register.getPhone(),register.getSex(),register.getCode(),register.getStatus());
            return a;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }

    @Override
    public administrator findByCode(String code) {
        administrator admin = null;
        try {
            String sql = "select * from administrator where code = ? ;";
            admin = template.queryForObject(sql,new BeanPropertyRowMapper<administrator>(administrator.class),code);
        } catch (DataAccessException e) {
            e.printStackTrace();
        }

        return admin;
    }

    /**
     * 修改指定用户激活状态
     * @param admin
     */
    @Override
    public void updateStatus(administrator admin) {
        String sql = " update administrator set status = 'Y' where id=?";
        template.update(sql,admin.getId());
    }

    @Override
    public void add(administrator admin) {
        //1.定义sql
        String sql = "insert into administrator values(null,?,?,?,null,null)";
        //2.执行sql
        template.update(sql, admin.getName(), admin.getPhone(), admin.getEmail());
    }

    @Override
    public int delete(int id) {
        //1.定义sql
        String sql = "delete from administrator where id = ?";
        //2.执行sql
       return template.update(sql, id);


    }

    @Override
    public administrator findById(int id) {
        String sql = "select * from administrator where id = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<administrator>(administrator.class), id);
    }

    @Override
    public int update_information(administrator admin) {
        String sql = "update administrator set phone = ?, email = ? where username = ?";
        return template.update(sql, admin.getPhone(), admin.getEmail(), admin.getUsername());
    }

    @Override
    public int findTotalCount(Map<String, String[]> condition) {
        //1.定义模板初始化sql
        String sql = "select count(*) from administrator where 1 = 1 ";
        StringBuilder sb = new StringBuilder(sql);
        //2.遍历map
        Set<String> keySet = condition.keySet();
        //定义参数的集合
        List<Object> params = new ArrayList<Object>();
        for (String key : keySet) {

            //排除分页条件参数
            if("currentPage".equals(key) || "rows".equals(key)){
                continue;
            }

            //获取value
            String value = condition.get(key)[0];
            //判断value是否有值
            if(value != null && !"".equals(value)){
                //有值
                sb.append(" and "+key+" like ? ");
                params.add("%"+value+"%");//？条件的值
            }
        }
        System.out.println(sb.toString());
        System.out.println(params);

        return template.queryForObject(sb.toString(),Integer.class,params.toArray());
    }

    @Override
    public List<administrator> findByPage(int start, int rows, Map<String, String[]> condition) {
        String sql = "select * from administrator where 1 = 1 ";

        StringBuilder sb = new StringBuilder(sql);
        //2.遍历map
        Set<String> keySet = condition.keySet();
        //定义参数的集合
        List<Object> params = new ArrayList<Object>();
        for (String key : keySet) {

            //排除分页条件参数
            if("currentPage".equals(key) || "rows".equals(key)){
                continue;
            }

            //获取value
            String value = condition.get(key)[0];
            //判断value是否有值
            if(value != null && !"".equals(value)){
                //有值
                sb.append(" and "+key+" like ? ");
                params.add("%"+value+"%");//？条件的值
            }
        }

        //添加分页查询
        sb.append(" limit ?,? ");
        //添加分页查询参数值
        params.add(start);
        params.add(rows);
        sql = sb.toString();
        System.out.println(sql);
        System.out.println(params);

        return template.query(sql,new BeanPropertyRowMapper<administrator>(administrator.class),params.toArray());
    }
}
