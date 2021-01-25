package com.liujian.gymxmjpa.controller;

import com.liujian.gymxmjpa.dao.*;
import com.liujian.gymxmjpa.service.PrivateCoachInfoDaoImpl;
import com.liujian.gymxmjpa.entity.PrivateCoachInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @Description: 会员私教详情Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/9
 */
@Controller
@RequestMapping("/privateinfo")
public class PrivateCoachInfoController {

    @Autowired
    private CoachDao coachDao;
    @Autowired
    private SubjectDao subjectDao;
    @Autowired
    private MenberDao menberDao;

    @Autowired
    private PrivateCoachInfoDao privateCoachInfoDao;
    @Autowired
    private PrivateCoachInfoDaoImpl privateCoachInfoDaoImpl;

    /**
     * @Description: 会员私教课程-进入会员私教课程界面
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/jin3")
    public String jin3(){

        return "WEB-INF/jsp/privatecoach";
    }

    /**
     * @Description: 会员私教详情-查询所有会员私教信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/ddaa")
    @ResponseBody
    public List<PrivateCoachInfo> query(){
       List<PrivateCoachInfo> list=privateCoachInfoDao.findAll();
//       for (PrivateCoachInfo li:list){
//           System.out.println(li.getMember().getMemberName());
//       }
     return   privateCoachInfoDao.findAll();
    }

    /**
     * @Description: 会员私教详情-查询教练,课程,会员信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @ModelAttribute("a")
    public Model cha(Model model){
        model.addAttribute("coach",coachDao.findAll());
        model.addAttribute("subject",subjectDao.findAll());
        model.addAttribute("menber",menberDao.findAll());
        return  model;
    }

    /**
     * @Description: 会员私教详情-根据教练id,课程id,会员id分页查询
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query2(Model model,Integer coachid, Integer subjectid, Integer memberid, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("coachid",coachid);
        map1.put("subjectid",subjectid);
        map1.put("memberid",memberid);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return privateCoachInfoDaoImpl.query(map1);
    }

    /**
     * @Description: 会员私教详情-根据id查询所有会员私教信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/query2")
    @ResponseBody
    public List<PrivateCoachInfo> query3(long pid){
        List<PrivateCoachInfo> list  = new ArrayList<PrivateCoachInfo>();
        list.add(privateCoachInfoDao.findById(pid).get());
        return list;
    }

    /**
     * @Description: 会员私教详情-根据id查询会员私教信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<PrivateCoachInfo> one(long id){
        return privateCoachInfoDao.findById(id);
    }

    /**
     * @Description: 会员私教详情-删除会员私教信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long id,Integer coachid,Integer subjectid, Integer memberid, int pageSize, int pageNumber){
        privateCoachInfoDao.deleteById(id);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("coachid",coachid);
        map1.put("subjectid",subjectid);
        map1.put("memberid",memberid);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return privateCoachInfoDaoImpl.query(map1);
    }

    /**
     * @Description: 会员私教详情-修改会员私教信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(PrivateCoachInfo privateCoachInfo){
        privateCoachInfoDaoImpl.update(privateCoachInfo);
    }

    /**
     * @Description: 会员私教详情-根据会员id查询所有会员私教信息的数量
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/count")
    @ResponseBody
    public Long count (Integer memid){
        privateCoachInfoDaoImpl.count(memid);
        return  privateCoachInfoDaoImpl.count(memid);
    }
    /**
     * @Description: 会员私教详情-根据会员id在会员私教信息表中查询信息
     * @Author: LiuJian
     * @Date: 2020/4/9
     */
    @RequestMapping("/byid")
    @ResponseBody
    public List<PrivateCoachInfo> queryid(Long memberid){
        return privateCoachInfoDaoImpl.ByMemberid(memberid);
    }
}
