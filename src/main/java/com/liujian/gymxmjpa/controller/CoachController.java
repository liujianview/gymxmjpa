package com.liujian.gymxmjpa.controller;
import com.liujian.gymxmjpa.dao.CoachDao;
import com.liujian.gymxmjpa.dao.PrivateCoachInfoDao;
import com.liujian.gymxmjpa.service.CoachDaoImpl;
import com.liujian.gymxmjpa.entity.Coach;
import com.liujian.gymxmjpa.entity.PrivateCoachInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 教练管理Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/9
 */
@Controller
@RequestMapping("/coach")
public class CoachController {
   @Autowired
   private CoachDao coachDao;
   @Autowired
   private PrivateCoachInfoDao privateCoachInfoDao;
   @Autowired
   private CoachDaoImpl coachDaoImpl;

    /**
     * @Description: 教练管理-进入教练列表界面
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/jin3")
    public String jin3(){

        return "WEB-INF/jsp/coach";
    }

    /**
     * @Description: 教练管理-根据教练姓名分页查询
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String coachname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("coachname",coachname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return coachDaoImpl.query(map1);
    }

    /**
     * @Description: 教练管理-根据教练id删除教练信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long id,String coachname, int pageSize, int pageNumber){

        //先根据教练id在私教信息表里查询是否有其信息
        List<PrivateCoachInfo> privateCoachInfoList = privateCoachInfoDao.queryByCoachIdNative(id);
        if(privateCoachInfoList !=null && privateCoachInfoList.size() > 0){
            //如果有,先循环删除
            for(PrivateCoachInfo privateCoachInfo : privateCoachInfoList){
                if(id == privateCoachInfo.getCoach().getCoachId()){
                    privateCoachInfoDao.delete(privateCoachInfo);
                }
            }
        }
        coachDao.deleteById(id);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("coachname",coachname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return coachDaoImpl.query(map1);
    }

    /**
     * @Description: 教练管理-根据教练姓名计算总数据数量
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/count")
    @ResponseBody
    public Long count (String coachName){
        coachDaoImpl.count(coachName);
        return  coachDaoImpl.count(coachName);
    }

    /**
     * @Description: 教练管理-添加新教练
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Coach coach){
        coachDao.save(coach);
    }

    /**
     * @Description: 教练管理-根据教练id查询
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Coach> one(long id){
        return coachDao.findById(id);
    }

    /**
     * @Description: 教练管理-修改教练信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(Coach coach){
        coachDao.save(coach);
    }


}
