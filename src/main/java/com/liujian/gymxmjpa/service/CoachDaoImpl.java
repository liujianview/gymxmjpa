package com.liujian.gymxmjpa.service;

import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 教练管理service实现层
 * @Author: LiuJian
 * @Date: 2020/4/9
 */
@Service
public class CoachDaoImpl {

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 教练管理service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from Coach where 1=1";
        if(map1.get("coachname")!=null && !map1.get("coachname").equals("")){
            jpal=jpal+" and coachName like '%"+map1.get("coachname")+"%'";
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(c) from Coach c where 1=1";

        if(map1.get("coachname")!=null && !map1.get("coachname").equals("")){
            jpa=jpa+" and coachName like '%"+map1.get("coachname")+"%'";
        }

        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 教练管理service实现层-查询总数据
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    public Long count(String  coachName){
        String jpa="select count(c) from Coach c where coachName ='"+coachName+"'";
        Query query=entityManager.createQuery(jpa);
        System.out.println(query);
        Long c=(Long)query.getSingleResult();
        return c;
    }
}
