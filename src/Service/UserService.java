package Service;

import JavaBean.PageBean;
import JavaBean.user;

public interface UserService {
    /**
     * 分页条件查询
     * @param currentPage
     * @param rows

     * @return
     */
    PageBean<user> findUserByPage(String currentPage, String rows,String condition);

    /**
     * 批量移除用户
     * @param ids
     */
    public int delSelectedUser(String[] ids);

    /**
     * 单个移除用户
     * @param id
     */
    public int deleteUser(String id);

}
