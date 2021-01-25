package com.liujian.gymxmjpa.controller;

import com.liujian.gymxmjpa.dao.PrivateCoachInfoDao;
import com.liujian.gymxmjpa.dao.SubjectDao;
import com.liujian.gymxmjpa.service.SubjectDaoImpl;
import com.liujian.gymxmjpa.entity.PrivateCoachInfo;
import com.liujian.gymxmjpa.entity.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


/**
 * @Description: 课程管理Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/8
 */
@Controller
@RequestMapping("/subject")
public class SubjectController {
   @Autowired
   private SubjectDaoImpl subjectDaoImpl;
   @Autowired
   private SubjectDao subjectDao;
   @Autowired
   private PrivateCoachInfoDao privateCoachInfoDao;

    /**
     * @Description: 课程管理-进入课程信息界面
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/jin7")
    public String jin7(){

        return "WEB-INF/jsp/subject";
    }

    /**
     * @Description: 课程管理-根据课程名称分页查询
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String subname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("subname",subname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return subjectDaoImpl.query(map1);
    }

    /**
     * @Description: 课程管理-根据课程id删除课程
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long subId,String subname, int pageSize, int pageNumber){

        //先根据教练id在私教信息表里查询是否有其信息
        List<PrivateCoachInfo> privateCoachInfoList = privateCoachInfoDao.queryBySubjectIdNative(subId);
        if(privateCoachInfoList !=null && privateCoachInfoList.size() > 0){
            //如果有,先循环删除
            for(PrivateCoachInfo privateCoachInfo : privateCoachInfoList){
                if(subId == privateCoachInfo.getSubject().getSubId()){
                    privateCoachInfoDao.delete(privateCoachInfo);
                }
            }
        }
        subjectDao.deleteById(subId);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("subname",subname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return subjectDaoImpl.query(map1);
    }

    /**
     * @Description: 课程管理-添加课程
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Subject subject){
        subjectDao.save(subject);
    }

    /**
     * @Description: 课程管理-根据课程id查询课程信息
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Subject> one(long subId){
        return subjectDao.findById(subId);
    }

    /**
     * @Description: 课程管理-修改课程信息
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(Subject subject){
        subjectDao.save(subject);
    }

    /**
     * @Description: 课程管理-根据课程名称计算总课程数据
     * @Author: LiuJian
     * @Date: 2020/4/8
     */
    @RequestMapping("/count")
    @ResponseBody
    public Long count (String subname){
        subjectDaoImpl.count(subname);
        return  subjectDaoImpl.count(subname);
    }

}
