package Service.impl;

import Dao.VegetablesDao;
import Dao.impl.VegetablesDaoImpl;
import Functions.in_img;
import JavaBean.PageBean;
import JavaBean.Vegetables;
import Service.VegetablesService;
import org.apache.commons.fileupload.FileItem;
import util.UuidUtil;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class VegetablesServiceImpl implements VegetablesService {
    private VegetablesDao dao = new VegetablesDaoImpl();

    @Override
    public PageBean<Vegetables> findVegetablesByPage(String _currentPage, String _rows, String condition) {

        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }
        //1.创建空的PageBean对象
        PageBean<Vegetables> pb = new PageBean<Vegetables>();
        //2.设置参数
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        //3.调用dao查询总记录数
        int totalCount = dao.findTotalCount(condition);
        pb.setTotalCount(totalCount);
        //4.调用dao查询List集合
        //计算开始的记录索引
        int start = (currentPage - 1) * rows;
        in_img inimg=new in_img();

        List<Vegetables> list = dao.findVegetablesByPage(start,rows,condition);
        for (Vegetables veg:list){


            try {
                String imgss[] = inimg.get_imgss(veg.getImgs());
                veg.setImgss(imgss);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        pb.setList(list);

        //5.计算总页码
        int totalPage = (totalCount % rows)  == 0 ? totalCount/rows : (totalCount/rows) + 1;
        pb.setTotalPage(totalPage);


        return pb;
    }

    @Override
    public int pull_offSelectedVegetables(String[] ids) {
        int a=0;
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd");
        if(ids != null && ids.length > 0){
            //1.遍历数组
            for (String id : ids) {
                //2.调用dao删除
                a= dao.pull_offVegetables(Integer.parseInt(id),now_time.format(new Date()));
            }
        }
        return a;
    }

    @Override
    public int pull_offVegetables(String id) {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd");
        return  dao.pull_offVegetables(Integer.parseInt(id),now_time.format(new Date()));}


    @Override
    public int AddVegetables(Vegetables  veg) {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd");
        veg.setAdd_time(now_time.format(new Date()));
        try {
            String Title = new String(veg.getTitle().getBytes("ISO-8859-1"), "UTF-8");
            String Describes = new String(veg.getDescribes().getBytes("ISO-8859-1"), "UTF-8");
            String name = new String(veg.getName().getBytes("ISO-8859-1"), "UTF-8");
            veg.setTitle(Title);
            veg.setDescribes(Describes);
            veg.setName(name);

        }   catch (Exception e) {
            e.printStackTrace();
        }

        return dao.AddVegetables(veg);
    }

    @Override
    public Vegetables DetailsVegetables(String  id) {
        int id1 = Integer.parseInt(id);
        Vegetables veg=new Vegetables();
        veg=dao. DetailsVegetables(id1);
        in_img inimg=new in_img();
        try {
            String imgss[] = inimg.get_imgss(veg.getImgs());
            veg.setImgss(imgss);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return veg;
    }

    @Override
    public int UpdateVegetables(Vegetables veg,String []del_imgs) {
        try {
            String Title = new String(veg.getTitle().getBytes("ISO-8859-1"), "UTF-8");
            String Describes = new String(veg.getDescribes().getBytes("ISO-8859-1"), "UTF-8");
            String name = new String(veg.getName().getBytes("ISO-8859-1"), "UTF-8");
            veg.setTitle(Title);
            veg.setDescribes(Describes);
            veg.setName(name);
            in_img imgs = new in_img();

            for (int i=0;i<del_imgs.length;i++) {
                if(del_imgs[i]==null||del_imgs[i].length()==0)
                    continue;
                imgs.delFile("F:\\Shop_Background\\web"+del_imgs[i],i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return dao.UpdateVegetables(veg);
    }

    @Override
    public int VegetablesImg(List<FileItem> items, String vegetablesname){
        String uploadFiilePath = "";
        in_img imgs = new in_img();
        if (!items.get(0).getName().equals("")) {
            String name = items.get(0).getName();
            //指定上传位置
            uploadFiilePath = "F:\\Shop_Background\\web\\imgs\\vegetables\\" + name.substring(0, name.length() - 4);
            File saveDir = new File(uploadFiilePath);
            //如果目录不存在，就创建目录
            if (!saveDir.exists()) {
                saveDir.mkdir();
            }
            if (saveDir.listFiles().length+items.size() >= 5) {
                return 0;
            } else {
                Iterator<FileItem> iter = items.iterator();
                while (iter.hasNext() && saveDir.listFiles().length < 5) {
                    FileItem item = (FileItem) iter.next();
                    // 获得文件名(全路径)
                    String fileName = item.getName();
                    if (fileName != null && !fileName.equals("")) {
                        File fullFile = new File(fileName);
                        File saveFile = new File(uploadFiilePath, fullFile.getName()); //将文件保存到指定的路径
                        try {
                            item.write(saveFile); //把获取数据保存到电脑文件
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                }
                int b = dao.VegetablesImgByName(uploadFiilePath, vegetablesname);
                if (b == 0) {
                    return 0;
                }
                int leng = saveDir.listFiles().length;
                System.out.println(leng);
                if (leng >= 5) {
                    return 1;
                } else {
                    for (int i = 0; i < 5 - leng; i++) {
                        try {
                            imgs.updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg", uploadFiilePath + "\\not_exist_" + UuidUtil.getUuid() + ".jpg");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                    }
                }
            }
        }
        else{
            uploadFiilePath = "F:\\Shop_Background\\web\\imgs\\vegetables\\" + UuidUtil.getUuid();
            File saveDir2 = new File(uploadFiilePath);
            //如果目录不存在，就创建目录
            if (!saveDir2.exists()) {
                saveDir2.mkdir();
            }
            if (saveDir2.listFiles().length+items.size() >= 5) {
                return 0;
            }
            int b = dao.VegetablesImgByName(uploadFiilePath, vegetablesname);
            if (b == 0) {
                return 0;
            }
            else{
                for (int i = 0; i < 5 ; i++) {
                    try {
                        imgs.updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg", uploadFiilePath + "\\not_exist_" + UuidUtil.getUuid() + ".jpg");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                }
            }

        }
        return 1;

    }

    @Override
    public int VegetablesUpdateImg(List<FileItem> items,String vegetablesname){
        Vegetables veg=null;
        int leng=0;//长度
        int num=0;
        String []not_exists=new String[5];
        veg= dao.VegetablesName(vegetablesname);
        String uploadFiilePath=veg.getImgs();
        in_img imgs = new in_img();
        File saveDir = new File(uploadFiilePath);
        if (!items.get(0).getName().equals("")) {
            String name = items.get(0).getName();
            //指定上传位置

            if (!saveDir.exists()) {
                return 0;
            }
            leng=saveDir.listFiles().length;
            int x=0;
            for (int i = 0; i < leng; i++) {
                if (saveDir.listFiles()[i].getName().indexOf("not_exist") == 0)
                {
                    num++;
                    not_exists[x]=saveDir.listFiles()[i].toString();
                    x++;
                    continue;
                }
            }
            if (5-num+items.size()>5) {
                return 0;
            }

            for (int j = 0; j <items.size(); j++) {
                imgs.delFile2(not_exists[j]);
            }

            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                // 获得文件名(全路径)
                String fileName = item.getName();
                if (fileName != null && !fileName.equals("")) {
                    File fullFile = new File(fileName);
                    File saveFile = new File(uploadFiilePath, fullFile.getName()); //将文件保存到指定的路径
                    try {
                        item.write(saveFile); //把获取数据保存到电脑文件
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
            }

            leng = saveDir.listFiles().length;
            System.out.println(leng);
            if (leng >= 5) {
                return 1;
            }
        }

        else{
            leng = saveDir.listFiles().length;
            for (int i = 0; i < 5-leng; i++) {
                try {

                    imgs.updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg", uploadFiilePath + "\\not_exist_" + UuidUtil.getUuid() + ".jpg");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return 1;

    }
}
