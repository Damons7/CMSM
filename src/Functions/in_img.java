package Functions;

import util.UuidUtil;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class in_img {
    public  String copyFile(String srcPath, String destPath) throws IOException {
        String a="\\\\";
        String s[]=srcPath.split(a);
        //名字.后缀 (eg:apple.jpg)
        String srcPath2=s[s.length-1];
        //名字
        String name=srcPath2.substring(0,srcPath2.length() - 4);
        //后缀
        String suffix=srcPath2.substring(srcPath2.length() - 4,srcPath2.length());

        //判断文件夹是否存在，不存在，则创建
        File file=new File(destPath+name);
        if  (!file .exists()  && !file .isDirectory())
        {
            System.out.println("//文件夹不存在，准备创建。。。");
            file .mkdir();
        } else
        {
            System.out.println("//目录存在");
        }

        destPath = destPath + name + "\\" + name + suffix;
        updateFile(srcPath,destPath);
        for (int i=0;i<4;i++) {
            String updateFileNewname=file.getParent()+"\\"+name+"\\not_exist_"+UuidUtil.getUuid()+".jpg";
            updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg",updateFileNewname);
        }
        return file.getParent();
    }

    public  String copyFile(String srcPath[], String destPath) throws IOException {
        String a="\\\\";
        String names="";
        String suffixs="";
        String destPath1=destPath;;
        int file_lenth=0;
            for (int j=0;j<srcPath.length;j++) {

                String s[] = srcPath[j].trim().split(a);
                //名字.后缀 (eg:apple.jpg)
                String srcPath2 = s[s.length - 1];
                //名字
                String name = srcPath2.substring(0, srcPath2.length() - 4);
                //后缀
                String suffix = srcPath2.substring(srcPath2.length() - 4, srcPath2.length());

                if(j==0){
                    names = name;
                    suffixs = suffix;
                    System.out.println("名字："+names+"后缀："+suffix);
                }

                //判断文件夹是否存在，不存在，则创建
                File file = new File(destPath1 + names);
                if (!file.exists() && !file.isDirectory()) {
                    System.out.println("//文件夹不存在，准备创建。。。");
                    file.mkdir();
                } else {
                    System.out.println("//目录存在");
                }
                file_lenth= file.listFiles().length;
                for (int i = 0; i < file_lenth; i++) {
                    if (get_imgss2(file.getPath())[i].indexOf("not_exist") != 1)
                    {
                        delFile2(get_imgss2(file.getPath())[i]);
                        break;
                    }
                }
                file_lenth= file.listFiles().length;
                destPath = destPath + names + "\\" + name + suffix;
                System.out.println("srcPath[j]:"+srcPath[j].trim());
                System.out.println("destpath:"+destPath);
                updateFile(srcPath[j].trim(),destPath);
                destPath=destPath1;
            }

        for (int i=0;i<5-file_lenth;i++) {

            destPath = destPath1 + names + "\\not_exist_"+ UuidUtil.getUuid()+ ".jpg";
            updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg",destPath);
        }
        System.out.println("最后返回："+destPath1+names);
        return destPath1+names;

    }

    //获取路径
    public String[] get_imgss(String path)throws IOException
    {
        File file = new File(path);
        File [] files = file.listFiles();
        String[] imgss=new String[files.length];
        for (int i = 0; i < files.length; i++)
        {
            File file1 = files[i];
            imgss[i]= file1.getPath().substring(22);
        }
        return  imgss;
    }

    //删除图片并用（暂无图片）替换
    public  void delFile(String path,int index){
        File file=new File(path);
        System.out.println("路径:"+path);
        if(file.exists() && file.isFile()) {
            file.delete();
            System.out.println("文件" + file.getName() + "已经删除");
            String updateFilepath = "F:\\Shop_Background\\web\\img\\not_exist.jpg";
            String updateFileNewname = "F:\\Shop_Background\\web\\imgs\\fruit\\book0\\not_exist_" +UuidUtil.getUuid()+".jpg";
            try {
                updateFile(updateFilepath, updateFileNewname);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        else{
            System.out.println("未删除成功");
        }
    }

    //删除（暂无图片）的图片
    public  void delFile2(String path){
        File file=new File(path);
        System.out.println("路径:"+path);
        if(file.exists() && file.isFile()) {
            file.delete();
            System.out.println("文件" + file.getName() + "已经删除");
        }
        else{
            System.out.println("未删除成功");
        }
    }

    //获取图片完整路径
    public String[] get_imgss2(String path)throws IOException
    {
        File file = new File(path);
        File [] files = file.listFiles();
        String[] imgss=new String[files.length];
        for (int i = 0; i < files.length; i++)
        {
            File file1 = files[i];
            imgss[i]= file1.getPath();
        }
        return  imgss;
    }

    //更新图片
    public  void updateFile(String updateFilepath, String updateFileNewname)throws IOException{
        // 打开输入流
        FileInputStream fis = new FileInputStream(updateFilepath);
        // 打开输出流
        FileOutputStream fos = new FileOutputStream(updateFileNewname);

        // 读取和写入信息
        int len = 0;
        // 创建一个字节数组，当做缓冲区
        byte[] b = new byte[1024];
        while ((len = fis.read(b)) != -1) {
            fos.write(b);
        }

        // 关闭流  先开后关  后开先关
        fos.close(); // 后开先关
        fis.close(); // 先开后关

    }

    //更新图片(同时如果有（暂无图片），则删除）
    public  void updateFile2(String updateFilepath, String updateFileNewpath)throws IOException{
        String s[]=updateFilepath.split("\\\\");
        File file=new File(updateFileNewpath);
        for (int i = 0; i < file.listFiles().length; i++) {
            if (get_imgss2(file.getPath())[i].indexOf("not_exist") != -1)
            {
                delFile2(get_imgss2(file.getPath())[i]);
                break;
            }
        }
        // 打开输入流
        FileInputStream fis = new FileInputStream(updateFilepath);
        // 打开输出流
        FileOutputStream fos = new FileOutputStream(updateFileNewpath+"\\"+s[s.length-1]);

        // 读取和写入信息
        int len = 0;
        // 创建一个字节数组，当做缓冲区
        byte[] b = new byte[1024];
        while ((len = fis.read(b)) != -1) {
            fos.write(b);
        }

        // 关闭流  先开后关  后开先关
        fos.close(); // 后开先关
        fis.close(); // 先开后关
    }

    //新上传图片
    public  String addnewFile(String path_out, String path_in)throws IOException{

        if (!path_out.equals("")&&path_out!=null&&path_out.length()!=0) {

            String s[] = path_out.split("\\\\");
            //判断文件夹是否存在，不存在，则创建
            File file = new File(path_in);
            if (!file.exists() && !file.isDirectory()) {
                System.out.println("//文件夹不存在，准备创建。。。");
                file.mkdir();
            } else {
                System.out.println("//目录存在");
            }

            updateFile(path_out, path_in + "\\" + s[s.length - 1]);
            int _length = file.listFiles().length;
            for (int i = 0; i < 5 - _length; i++) {
                updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg", path_in + "\\not_exist_" + UuidUtil.getUuid() + ".jpg");
            }
        }
        else
        {
            String Rom_name=UuidUtil.getUuid();
            File file = new File(path_in+Rom_name);
            if (!file.exists() && !file.isDirectory()) {
                System.out.println("//文件夹不存在，准备创建。。。");
                file.mkdir();
            } else {
                System.out.println("//目录存在");
            }
            for (int i = 0; i < 5 ; i++) {
                updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg", path_in + Rom_name+"\\not_exist_" + UuidUtil.getUuid() + ".jpg");
            }
            path_in=path_in+Rom_name;
        }
        return path_in;
    }

    //新上传图片
    public  String addnewFile(String path_out[], String path_in)throws IOException {

        for (int i = 0; i < path_out.length; i++) {
            String s[] = path_out[i].split(",");
          String s1[]=s[0].trim().split("\\\\");
        //判断文件夹是否存在，不存在，则创建
        File file = new File(path_in);
        if (!file.exists() && !file.isDirectory()) {
            System.out.println("//文件夹不存在，准备创建。。。");
            file.mkdir();
        } else {
            System.out.println("//目录存在");
        }

        updateFile(s[0].trim(), path_in + "\\" + s1[s1.length - 1]);

    }

        for(int i=0;i<5-path_out.length;i++)
        {
            updateFile("F:\\Shop_Background\\web\\img\\not_exist.jpg",path_in+"\\not_exist_"+UuidUtil.getUuid()+".jpg");
        }
        return path_in;
    }

    //获取文件夹内首张图的全路径
    public String get_firstImgPath(String path)throws IOException
    {
        File file = new File(path);
        return  file.listFiles()[0].getPath().substring(22);
    }
}