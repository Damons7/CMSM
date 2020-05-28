package Dao;

import JavaBean.user;

import java.util.List;

public interface UserDao {
    /**
     * 分页查询每页记录
     * @param start
     * @param rows

     * @return
     */
    public List<user> findByPage(int start, int rows,String condition);

    /**
     * 查询总记录数
     * @return

     */
    public int findTotalCount(String condition);

    /**
     * 移除记录
     * @return
     * @param id
     */
    public int deleteUser(int id);


//    /**
//     * 通过name查询id
//     * @return
//     * @param name
//     */
//    public int FindIdByName(String name);
}
