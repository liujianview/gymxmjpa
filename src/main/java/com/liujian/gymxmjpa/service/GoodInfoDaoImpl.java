package com.liujian.gymxmjpa.service;

import com.liujian.gymxmjpa.dao.MenberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 商品售卖信息管理service实现层
 * @Author: LiuJian
 * @Date: 2020/4/14
 */
@Service
public class GoodInfoDaoImpl {

    @Autowired
    private MenberDao menberDao;
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 商品售卖信息管理service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from GoodInfo where 1=1";
        if(map1.get("goodsid")!=null && !map1.get("goodsid").equals("")){
            jpal =jpal+" and goodsid = '"+map1.get("goodsid")+"'";
        }
        if(map1.get("memberid")!=null && !map1.get("memberid").equals("")){
            jpal =jpal+" and memberid = '"+map1.get("memberid")+"'";
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(x) from GoodInfo x where 1=1";

        if(map1.get("goodsid")!=null && !map1.get("goodsid").equals("")){
            jpa =jpa+" and goodsid = '"+map1.get("goodsid")+"'";
        }
        if(map1.get("memberid")!=null && !map1.get("memberid").equals("")){
            jpa =jpa+" and memberid = '"+map1.get("memberid")+"'";
        }
        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

}
