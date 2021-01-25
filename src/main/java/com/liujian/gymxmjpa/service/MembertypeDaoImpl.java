package com.liujian.gymxmjpa.service;

import com.liujian.gymxmjpa.dao.MemberttypeDao;
import com.liujian.gymxmjpa.entity.Membertype;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 会员卡类型service实现层
 * @Author: LiuJian
 * @Date: 2020/4/4
 */
@Service
public class MembertypeDaoImpl {

    @Autowired
    private MemberttypeDao memberttypeDao;

    /**
     * @Description: 会员卡类型service实现层-查询所有会员卡类型
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    public List<Membertype> cha(){
        List<Membertype> list=memberttypeDao.findAll();
        return list;
    }

    /**
     * @Description: 会员卡类型service实现层-根据id查询会员卡类型信息
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    public Membertype cha2(int id){
        Long lo=new Long(id);
        Membertype list=memberttypeDao.findById(lo).get();
        return list;
    }
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 会员卡类型service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from Membertype where 1=1";
        if(map1.get("typeName")!=null && !map1.get("typeName").equals("")){
            jpal=jpal+" and TypeName like '%"+map1.get("typeName")+"%'";
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(t) from Membertype t where 1=1";

        if(map1.get("typeName")!=null && !map1.get("typeName").equals("")){
            jpa=jpa+" and TypeName like '%"+map1.get("typeName")+"%'";
        }

        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }
}
