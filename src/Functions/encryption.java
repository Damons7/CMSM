package Functions;

public class encryption {
//加密密码,解密密码
    public String encryptions(String pwd)
    {
        char[] ch = pwd.toCharArray();
        int leng=pwd.length();
        char [] char1 = new char[leng / 2];;
        char [] char2;
         String string2;
        if(pwd.length()%2==0) {
            char2 = new char[leng / 2];
            for (int a = leng / 2,b=0; a < leng; a++,b++) {
                char2[leng/2-1-b]=ch[a];
            }
            string2 = new String(char2);
        }
        else {
            char2 = new char[leng / 2+1];
            for (int a = leng / 2,b=0; a < leng; a++,b++) {
                char2[leng/2-b]=ch[a];
            }
         string2 = new String(char2);
        }
            for (int a = 0; a < leng / 2; a++) {
                char1[ leng / 2-1-a]=ch[a];
            }
            String string1 = new String(char1);


            pwd=string1+string2;
                return  pwd;
        }

    }

