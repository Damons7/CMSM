package Service;

import JavaBean.PageBean;
import JavaBean.administrator;

import java.util.List;
import java.util.Map;

/**
 * 用户管理的业务接口
 */
public interface AdministratorService {

    /**
     * 查询所有用户信息
     * @return
     */
    public List<administrator> findAll();

    /**
     * 登录方法
     * @param admin
     * @return
     */
    administrator login(administrator admin);

    /**
     * 注册时查询用户名是否存在
     * @param register
     */
    administrator register(String register);

    /**
     * 注册方法
     * @param register
     */
    int registerUser(administrator register);

    /**
     * 判断激活码
     * @param code
     */
    boolean active(String code);

    /**
     * 保存User
     * @param admin
     */
    void addUser(administrator admin);

    /**
     * 通过username查找管理员
     * @param username
     */
    public administrator findUserByUsername(String  username);

    /**
     * 修改管理员密码
     * @param admin
     */
    public int update_password(administrator  admin,String new_password,String old_password);

    /**
     * 根据id删除administrator
     * @param id
     */
    int deleteUser(String id);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    administrator findUserById(String id);

    /**
     * 修改管理员信息
     * @param admin
     */
    int update_information(administrator admin);

    /**
     * 批量删除用户
     * @param ids
     */
    int delSelectedUser(String[] ids);

    /**
     * 分页条件查询
     * @param currentPage
     * @param rows
     * @param condition
     * @return
     */
    PageBean<administrator> findUserByPage(String currentPage, String rows, Map<String, String[]> condition);
}
