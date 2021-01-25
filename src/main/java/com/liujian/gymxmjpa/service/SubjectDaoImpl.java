package com.liujian.gymxmjpa.service;

import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 课程管理service实现层
 * @Author: LiuJian
 * @Date: 2020/4/8
 */
@Service
public class SubjectDaoImpl {

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 课程管理service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from Subject where 1=1";
        if(map1.get("subname")!=null && !map1.get("subname").equals("")){
            jpal=jpal+" and subname like '%"+map1.get("subname")+"%'";
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(s) from Subject s where 1=1";

        if(map1.get("subname")!=null && !map1.get("subname").equals("")){
            jpa=jpa+" and subname like '%"+map1.get("subname")+"%'";
        }

        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 课程管理service实现层-计算总数量
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    public Long count(String  subname){
        String jpa="select count(s) from Subject s where subname ='"+subname+"'";
        Query query=entityManager.createQuery(jpa);
        System.out.println(query);
        Long c=(Long)query.getSingleResult();
        return c;
    }
}
