package Dao;

import JavaBean.administrator;

import java.util.List;
import java.util.Map;

/**
 * 用户操作的DAO
 */
public interface AdministratorDao {


    public List<administrator> findAll();

    administrator findUserByUsernameAndPassword(String username, String password);

    //通过用户名查询是否存在
    administrator findUserByRegistername(String registername);

    //注册方法
    int RegisterUser(administrator register);

    //邮箱查询激活码
    administrator findByCode(String code);

    //更新激活状态
    void updateStatus(administrator admin);

    void add(administrator admin);

    int delete(int id);

    administrator findById(int i);

    //修改管理员信息
    int update_information(administrator admin);

    //通过username查找管理员信息
    public administrator findUserByUsername(String username);

   //修改管理员密码
    public int update_Password(administrator admin);

    /**
     * 查询总记录数
     * @return int
     * @param condition
     */
    int findTotalCount(Map<String, String[]> condition);

    /**
     * 分页查询每页记录
     * @param start
     * @param rows
     * @param condition
     * @return
     */
    List<administrator> findByPage(int start, int rows, Map<String, String[]> condition);
}
