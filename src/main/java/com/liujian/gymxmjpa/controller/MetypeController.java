package com.liujian.gymxmjpa.controller;

import com.liujian.gymxmjpa.dao.MemberttypeDao;
import com.liujian.gymxmjpa.service.MembertypeDaoImpl;
import com.liujian.gymxmjpa.entity.Membertype;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 会员卡类型信息Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/4
 */
@Controller
@RequestMapping("/metype")
public class MetypeController {

    @Autowired
    private MembertypeDaoImpl membertypeDaoImpl;
    @Autowired
    private MemberttypeDao memberttypeDao;

    /**
     * @Description: 会员卡类型-删除
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long typeId,String typeName, int pageSize, int pageNumber){
     memberttypeDao.deleteById(typeId);
     Map<String,Object>  map1=new HashMap<String,Object>();
     map1.put("typeName",typeName);
     map1.put("qi",(pageNumber-1)*pageSize);
     map1.put("shi",pageSize);
     return membertypeDaoImpl.query(map1);
    }

    /**
     * @Description: 会员卡类型-添加会员卡类型
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Membertype membertype){

        memberttypeDao.save(membertype);
    }

    /**
     * @Description: 会员卡类型-根据id查询
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Membertype> one(long typeId){
        return memberttypeDao.findById(typeId);
    }

    /**
     * @Description: 会员卡类型-修改会员卡类型信息
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(Membertype membertype){
        memberttypeDao.save(membertype);
    }


}
