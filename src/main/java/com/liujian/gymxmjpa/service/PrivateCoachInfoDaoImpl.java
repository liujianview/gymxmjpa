package com.liujian.gymxmjpa.service;

import com.liujian.gymxmjpa.dao.CoachDao;
import com.liujian.gymxmjpa.dao.PrivateCoachInfoDao;
import com.liujian.gymxmjpa.entity.PrivateCoachInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 会员私教信息service实现层
 * @Author: LiuJian
 * @Date: 2020/4/9
 */
@Service
public class PrivateCoachInfoDaoImpl {

    @Autowired
    private PrivateCoachInfoDao privateCoachInfoDao;
    @Autowired
    private CoachDao coachDao;
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 会员私教信息service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from PrivateCoachInfo where 1=1";
       if(map1.get("subjectid")!=null && !map1.get("subjectid").equals("")){
            jpal =jpal+" and subjectid = '"+map1.get("subjectid")+"'";
       }
        if(map1.get("coachid")!=null && !map1.get("coachid").equals("")){
            jpal =jpal+" and coachid = '"+map1.get("coachid")+"'";
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
        String jpa="select count(p) from PrivateCoachInfo p where 1=1";
        if(map1.get("subjectid")!=null && !map1.get("subjectid").equals("")){
            jpa =jpa+" and subjectid = '"+map1.get("subjectid")+"'";
        }
        if(map1.get("coachid")!=null && !map1.get("coachid").equals("")){
            jpa =jpa+" and coachid = '"+map1.get("coachid")+"'";
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

    /**
     * @Description: 会员私教信息service实现层-计算总数量
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    public Long count(Integer memid){
        String jpa="select count(p) from PrivateCoachInfo p where memberId="+memid;
        Query query=entityManager.createQuery(jpa);
        System.out.println(query);
        Long c=(Long)query.getSingleResult();

        return c;
    }

    /**
     * @Description: 会员私教信息service实现层-修改会员私教信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    public int update(PrivateCoachInfo privateCoachInfo){
        PrivateCoachInfo privateCoachInfo1=privateCoachInfoDao.findById(privateCoachInfo.getPid()).get();
        privateCoachInfo1.setCoach(privateCoachInfo.getCoach());
        privateCoachInfoDao.save(privateCoachInfo1);
        return 1;
    }

    /**
     * @Description: 会员私教信息service实现层-根据会员id查询
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    public List<PrivateCoachInfo> ByMemberid(Long memberid){
        List<PrivateCoachInfo> list = privateCoachInfoDao.queryByIdNative(memberid);
        return list;
    }
}
