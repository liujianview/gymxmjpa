package com.liujian.gymxmjpa.service;

import com.liujian.gymxmjpa.dao.GoodsDao;
import com.liujian.gymxmjpa.entity.Goods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 商品管理service实现层
 * @Author: LiuJian
 * @Date: 2020/4/14
 */
@Service
public class GoodsDaoImpl {

    @Autowired
    private GoodsDao goodsDao;
    @PersistenceContext
    private EntityManager entityManager;


    /**
     * @Description: 商品管理service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from Goods where 1=1";
        if(map1.get("goodsname")!=null && !map1.get("goodsname").equals("")){
            jpal=jpal+" and goodsName like '%"+map1.get("goodsname")+"%'";
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(g) from Goods g where 1=1";

        if(map1.get("goodsname")!=null && !map1.get("goodsname").equals("")){
            jpa=jpa+" and goodsName like '%"+map1.get("goodsname")+"%'";
        }

        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 商品管理service实现层-计算总数量
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    public Long count(String  goodsName){
        String jpa="select count(g) from Goods g where goodsName ='"+goodsName+"'";
        Query query=entityManager.createQuery(jpa);
        System.out.println(query);
        Long c=(Long)query.getSingleResult();
        return c;
    }

    /**
     * @Description: 商品管理service实现层-修改商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    public int update(Goods goods){
        Goods goods1=goodsDao.findById(goods.getGoodsId()).get();
        goods1.setInventory(goods.getInventory());
        goodsDao.save(goods1);
        return 1;
    }
}
