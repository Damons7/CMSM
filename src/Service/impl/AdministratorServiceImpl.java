package Service.impl;

import Dao.AdministratorDao;
import Dao.impl.AdministratorDaoImpl;
import JavaBean.PageBean;
import JavaBean.administrator;
import Service.AdministratorService;
import util.MailUtils;
import util.UuidUtil;
import Functions.encryption;
import java.util.List;
import java.util.Map;

public class AdministratorServiceImpl implements AdministratorService {
    private AdministratorDao dao = new AdministratorDaoImpl();

    @Override
    public List<administrator> findAll() {
        //调用Dao完成查询
        return dao.findAll();
    }

    @Override
    public administrator login(administrator admin) {
        //加密密码
        encryption encry=new encryption();
       String password=encry.encryptions(admin.getPassword());
        return dao.findUserByUsernameAndPassword(admin.getUsername(),password);
    }

    @Override
    public administrator register(String  register) {
        return dao.findUserByRegistername(register);
    }

    @Override
    public administrator findUserByUsername(String  username) {
        return dao.findUserByUsername(username);
    }

    @Override
    public int update_password(administrator  admin,String new_password,String old_password) {
        encryption encry=new encryption();
        if(admin.getPassword().equals(encry.encryptions(old_password))){
            admin.setPassword(encry.encryptions(new_password));
            return dao.update_Password(admin);
        }
        else return 0;
    }

    @Override
    public int registerUser(administrator  register) {
        //加密密码
        encryption encry=new encryption();
        register.setPassword(encry.encryptions(register.getPassword()));
        //设置激活码
        register.setCode(UuidUtil.getUuid());
        //设置激活状态
        register.setStatus("N");
        int a=dao.RegisterUser(register);
        String content="<a href='http://localhost:8080/ActiveRegisterServlet.do?code="+register.getCode()+"'>点击激活【社区商城团购后台管理】</a>";

        MailUtils.sendMail(register.getEmail(),content,"激活邮件");

        return a;
    }

    @Override
    public boolean active(String code) {
        //1.根据激活码查询用户对象
        AdministratorDao dao=new AdministratorDaoImpl();
        administrator admin =dao.findByCode(code);
        System.out.println("此方法别调用");
        if(admin != null){
            //2.调用dao的修改激活状态的方法
           dao.updateStatus(admin);
            return true;
        }else{
            return false;
        }

    }

    @Override
    public void addUser(administrator admin) {
        dao.add(admin);
    }

    @Override
    public int deleteUser(String id) {
        return dao.delete(Integer.parseInt(id));
    }

    @Override
    public administrator findUserById(String id) {
        return dao.findById(Integer.parseInt(id));
    }

    @Override
    public int update_information(administrator admin) {
        return dao.update_information(admin);
    }

    @Override
    public int delSelectedUser(String[] ids) {
        int a=0;
        if(ids != null && ids.length > 0){
            //1.遍历数组
            for (String id : ids) {

                //2.调用dao删除
              a= dao.delete(Integer.parseInt(id));
            }
        }
            return a;
    }

    @Override
    public PageBean<administrator> findUserByPage(String _currentPage, String _rows, Map<String, String[]> condition) {

        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }
        //1.创建空的PageBean对象
        PageBean<administrator> pb = new PageBean<administrator>();
        //2.设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        //3.调用dao查询总记录数
        int totalCount = dao.findTotalCount(condition);
        pb.setTotalCount(totalCount);
        //4.调用dao查询List集合
        //计算开始的记录索引
        int start = (currentPage - 1) * rows;
        List<administrator> list = dao.findByPage(start,rows,condition);
        pb.setList(list);

        //5.计算总页码
        int totalPage = (totalCount % rows)  == 0 ? totalCount/rows : (totalCount/rows) + 1;
        pb.setTotalPage(totalPage);


        return pb;
    }
}
