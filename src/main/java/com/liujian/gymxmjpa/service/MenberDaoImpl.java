package com.liujian.gymxmjpa.service;

import com.liujian.gymxmjpa.dao.GoodInfoDao;
import com.liujian.gymxmjpa.dao.MenberDao;
import com.liujian.gymxmjpa.dao.PrivateCoachInfoDao;
import com.liujian.gymxmjpa.dao.chongzhiDao;
import com.liujian.gymxmjpa.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Description: 会员管理service实现层
 * @Author: LiuJian
 * @Date: 2020/4/6
 */
@Service
public class MenberDaoImpl {


    @Autowired
    private MenberDao menberDao;

    @Autowired
    private PrivateCoachInfoDao privateCoachInfoDao;

    @Autowired
    private GoodInfoDao goodInfoDao;

    @Autowired
    private chongzhiDao chongZhiDao;

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 会员管理service实现层-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //根据会员到期的日期修改到期后状态
        List<Member> memberslist=menberDao.findAll();
        //得到现在的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        try {
            Date now = sdf.parse(date);
            for (Member list:memberslist){
                //得到会员到期时间
                String date1= list.getMemberxufei().toString();
                if(date1 == null){
                    date1 = date;
                }
                Date daoqi = sdf.parse(date1);
                Member m= menberDao.findById(list.getMemberId()).get();
                if(daoqi.before(now)){
                    //设置会员状态为不正常
                    m.setMemberStatic(2L);
                }else {
                    //设置会员状态为正常
                    m.setMemberStatic(1L);
                }
                menberDao.save(m);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        //分页
        String jpal="from Member where 1=1";
        if(map1.get("hyname")!=null && !map1.get("hyname").equals("")){
            jpal=jpal+" and memberName like '%"+map1.get("hyname")+"%'";
        }
        int ktype=(int)map1.get("ktype");
        if(ktype!=0){
            jpal=jpal+"and membertypes="+ktype;
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(m) from Member m where 1=1";

        if(map1.get("hyname")!=null && !map1.get("hyname").equals("")){
            jpa=jpa+" and memberName like '%"+map1.get("hyname")+"%'";
        }
        if(ktype!=0){
            jpa=jpa+" and membertypes="+ktype;
        }
        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 会员管理service实现层-会员到期分页查询
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    //会员到期查询
    public Map<String,Object> query2(Map<String,Object> map1){
        //分页
        String jpal="from Member where 1=1";
        if(map1.get("hyname")!=null && !map1.get("hyname").equals("")){
            jpal=jpal+" and memberName like '%"+map1.get("hyname")+"%'";
        }
        int ktype=(int)map1.get("ktype");
        if(ktype!=0){
            jpal=jpal+" and membertypes="+ktype;
        }
        jpal+=" and memberStatic = 2";
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(m) from Member m where 1=1";

        if(map1.get("hyname")!=null && !map1.get("hyname").equals("")){
            jpa=jpa+" and memberName like '%"+map1.get("hyname")+"%'";
        }
        if(ktype!=0){
            jpa=jpa+" and membertypes="+ktype;
        }
        jpa+=" and memberStatic = 2";
        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 会员管理service实现层-根据会员id删除
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    public int del(int id){
        Long memid=new Long(id);
        //先根据会员id在私教信息表里查询是否有其信息
        List<PrivateCoachInfo> privateCoachInfoList = privateCoachInfoDao.queryByIdNative(memid);
        if(privateCoachInfoList !=null && privateCoachInfoList.size() > 0){
            //如果有,先循环删除
            for(PrivateCoachInfo privateCoachInfo : privateCoachInfoList){
                if(memid.equals(privateCoachInfo.getMember().getMemberId())){
                    privateCoachInfoDao.delete(privateCoachInfo);
                }
            }
        }
        //再根据会员id在商品信息表中查是否有其信息
        List<GoodInfo> goodInfoList = goodInfoDao.queryByIdNative(memid);
        if(goodInfoList != null && goodInfoList.size()>0){
            for(GoodInfo goodInfo : goodInfoList){
                if(memid.equals(goodInfo.getMember().getMemberId())){
                    goodInfoDao.delete(goodInfo);
                }
            }
        }
        //根据会员id在充值信息表中查询是否有其信息
        List<Chongzhi> chongzhiList = chongZhiDao.queryByIdNative(memid);
        if(chongzhiList != null && chongzhiList.size()>0){
            for(Chongzhi chongzhi : chongzhiList){
                if(memid.equals(chongzhi.getMember().getMemberId())){
                    chongZhiDao.delete(chongzhi);
                }
            }
        }
        //最后删除此会员
        menberDao.deleteById(memid);
        return 1;
    }


    /**
     * @Description: 会员管理service实现层-添加会员
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    public int insert(Member member){
        member.setMemberStatic(1L);
        menberDao.save(member);
        return  1;
    }

    /**
     * @Description: 会员管理service实现层-修改会员信息
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    public int update(Member member){
        menberDao.save(member);
        return 1;
    }

    /**
     * @Description: 会员管理service实现层-根据id查询会员信息
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    public Member cha(int id){
        Long lo=new Long(id);
        Member list=menberDao.findById(lo).get();
        return list;
    }

    /**
     * @Description: 会员管理service实现层-修改会员信息
     * @Author: LiuJian
     * @Date: 2020/4/6
     */
    public int upd(Member member){
        Member member1=menberDao.findById(member.getMemberId()).get();
        member1.setMemberbalance(member.getMemberbalance());
        menberDao.save(member1);
        return 1;
    }
}
