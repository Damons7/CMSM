package Service.impl;

import Dao.SnacksDao;
import Dao.impl.SnacksDaoImpl;
import Functions.in_img;
import JavaBean.PageBean;
import JavaBean.Snacks;
import Service.SnacksService;
import org.apache.commons.fileupload.FileItem;
import util.UuidUtil;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class SnacksServiceImpl implements SnacksService {
    private SnacksDao dao = new SnacksDaoImpl();

    @Override
    public PageBean<Snacks> findSnacksByPage(String _currentPage, String _rows, String condition) {

        int currentPage = Integer.parseInt(_currentPage);
        int rows = Integer.parseInt(_rows);

        if(currentPage <=0) {
            currentPage = 1;
        }
        //1.创建空的PageBean对象
        PageBean<Snacks> pb = new PageBean<Snacks>();
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
        List<Snacks> list = dao.findSnacksByPage(start,rows,condition);
        for (Snacks snas:list){
            try {
                String imgss[] = inimg.get_imgss(snas.getImgs());
                snas.setImgss(imgss);
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
    public int pull_offSelectedSnacks(String[] ids) {
        int a=0;
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd");
        if(ids != null && ids.length > 0){
            //1.遍历数组
            for (String id : ids) {
                //2.调用dao删除
                a= dao.pull_offSnacks(Integer.parseInt(id),now_time.format(new Date()));
            }
        }
        return a;
    }

    @Override
    public int pull_offSnacks(String id) {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd");
        return  dao.pull_offSnacks(Integer.parseInt(id),now_time.format(new Date()));}

    @Override
    public int AddSnacks(Snacks  snack) {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd");
        snack.setAdd_time(now_time.format(new Date()));
        try {
            String Title = new String(snack.getTitle().getBytes("ISO-8859-1"), "UTF-8");
            String Describes = new String(snack.getDescribes().getBytes("ISO-8859-1"), "UTF-8");
            String name = new String(snack.getName().getBytes("ISO-8859-1"), "UTF-8");
            snack.setTitle(Title);
            snack.setDescribes(Describes);
            snack.setName(name);

        }   catch (Exception e) {
            e.printStackTrace();
        }

        return dao.AddSnacks(snack);
    }

    @Override
    public Snacks DetailsSnacks(String  id) {
        int id1 = Integer.parseInt(id);
        Snacks sna=new Snacks();
        sna=dao. DetailsSnacks(id1);
        in_img inimg=new in_img();
        try {
            String imgss[] = inimg.get_imgss(sna.getImgs());
            sna.setImgss(imgss);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return sna;
    }

    @Override
    public int UpdateSnacks(Snacks sna,String []del_imgs) {
        try {
            String Title = new String(sna.getTitle().getBytes("ISO-8859-1"), "UTF-8");
            String Describes = new String(sna.getDescribes().getBytes("ISO-8859-1"), "UTF-8");
            String name = new String(sna.getName().getBytes("ISO-8859-1"), "UTF-8");
            sna.setTitle(Title);
            sna.setDescribes(Describes);
            sna.setName(name);
            in_img imgs = new in_img();

            for (int i=0;i<del_imgs.length;i++) {
                if(del_imgs[i]==null||del_imgs[i].length()==0)
                    continue;
                imgs.delFile("F:\\Shop_Background\\web"+del_imgs[i],i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dao.UpdateSnacks(sna);
    }

    @Override
    public int SnacksImg(List<FileItem> items, String snacksname){
        String uploadFiilePath = "";
        in_img imgs = new in_img();
        if (!items.get(0).getName().equals("")) {
            String name = items.get(0).getName();
            //指定上传位置
            uploadFiilePath = "F:\\Shop_Background\\web\\imgs\\snacks\\" + name.substring(0, name.length() - 4);
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
                int b = dao.SnacksImgByName(uploadFiilePath, snacksname);
                if (b == 0) {
                    return 0;
                }
                int leng = saveDir.listFiles().length;
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
            uploadFiilePath = "F:\\Shop_Background\\web\\imgs\\snacks\\" + UuidUtil.getUuid();
            File saveDir2 = new File(uploadFiilePath);
            //如果目录不存在，就创建目录
            if (!saveDir2.exists()) {
                saveDir2.mkdir();
            }
            if (saveDir2.listFiles().length+items.size() >= 5) {
                return 0;
            }
            int b = dao.SnacksImgByName(uploadFiilePath, snacksname);
            if (b == 0) {
                System.out.println("进入4");
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
    public int SnacksUpdateImg(List<FileItem> items,String snacksname){
        Snacks Sna=null;
        int leng=0;//长度
        int num=0;
        String []not_exists=new String[5];
        Sna= dao.SnacksName(snacksname);
        String uploadFiilePath=Sna.getImgs();
        in_img imgs = new in_img();
        File saveDir = new File(uploadFiilePath);
        if (!items.get(0).getName().equals("")) {
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
                    System.out.println("not_exists"+x+not_exists[x]);
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
