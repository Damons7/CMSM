package Service.impl;

import Dao.UserDao;
import Dao.impl.UserDaoImpl;
import JavaBean.PageBean;
import JavaBean.user;
import Service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService{
    private UserDao dao = new UserDaoImpl();

    @Override
    public PageBean<user> findUserByPage(String _currentPage, String _rows,String condition) {

        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }
        //1.创建空的PageBean对象
        PageBean<user> pb = new PageBean<user>();
        //2.设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        //3.调用dao查询总记录数
        int totalCount = dao.findTotalCount(condition);
        pb.setTotalCount(totalCount);
        //4.调用dao查询List集合
        //计算开始的记录索引
        int start = (currentPage - 1) * rows;
        List<user> list = dao.findByPage(start,rows,condition);
        pb.setList(list);

        //5.计算总页码
        int totalPage = (totalCount % rows)  == 0 ? totalCount/rows : (totalCount/rows) + 1;
        pb.setTotalPage(totalPage);


        return pb;
    }

    @Override
    public int delSelectedUser(String[] ids) {
        int a=0;
        if(ids != null && ids.length > 0){
            //1.遍历数组
            for (String id : ids) {
                //2.调用dao删除
                a= dao.deleteUser(Integer.parseInt(id));
            }
        }
        return a;
    }

    @Override
    public int deleteUser(String id) { return  dao.deleteUser(Integer.parseInt(id));
    }

}
