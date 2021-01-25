package com.liujian.gymxmjpa.service;

import com.liujian.gymxmjpa.dao.EquipmentDao;
import com.liujian.gymxmjpa.entity.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 器材管理service实现层
 * @Author: LiuJian
 * @Date: 2020/4/12
 */
@Service
public class EquipmentDaoImpl {
    @Autowired
    private EquipmentDao equipmentDao;
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 器材管理service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from Equipment where 1=1";
        if(map1.get("hyname")!=null && !map1.get("hyname").equals("")){
            jpal=jpal+" and eqName like '%"+map1.get("hyname")+"%'";
        }

        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(m) from Equipment m where 1=1";

        if(map1.get("hyname")!=null && !map1.get("hyname").equals("")){
            jpa=jpa+" and eqName like '%"+map1.get("hyname")+"%'";
        }

        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 器材管理service实现层-新增
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    //增加
    public int insert(Equipment equipment){
        equipmentDao.save(equipment);
        return  1;
    }

    /**
     * @Description: 器材管理service实现层-删除
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    //删除
    public int del(int eqId){
        Long memid=new Long(eqId);
        equipmentDao.deleteById(memid);
        return 1;
    }

}
