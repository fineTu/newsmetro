package com.newsmetro.util;

import java.io.*;

/**
 * Created by finetu on 6/29/15.
 */
public class BeanUtil {
    public static byte[] serializeBean(Serializable bean){
        ObjectOutputStream oos = null;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        try {
            oos = new ObjectOutputStream(baos);
            oos.writeObject(bean);
            byte[] bytes = baos.toByteArray();
            return bytes;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static <T> T UnSerializeBean(byte[] bytes){
        ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        ObjectInputStream ois = null;
        try {
            ois = new ObjectInputStream(bais);
            return (T)ois.readObject();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
