package com.liujian.gymxmjpa.controller;


import com.liujian.gymxmjpa.service.MembertypeDaoImpl;
import com.liujian.gymxmjpa.entity.Membertype;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description: 会员卡类型Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/4
 */
@Controller
@RequestMapping("/ktype")
public class MembertypeController {

    @Autowired
    private MembertypeDaoImpl membertypeDaoImpl;

    /**
     * @Description: 会员卡类型-进入jsp页面
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/jin5")
    public String jin5(){

        return "WEB-INF/jsp/Membertype";
    }

    /**
     * @Description: 会员卡类型-查询所有数据
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/query")
    @ResponseBody
    public List<Membertype> query(){

        return membertypeDaoImpl.cha();
    }

    /**
     * @Description: 会员卡类型-分页查询
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/queryq")
    @ResponseBody
    public Map<String,Object> query(String typeName, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("typeName",typeName);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return membertypeDaoImpl.query(map1);
    }

    /**
     * @Description: 会员卡类型-根据id查询
     * @Author: LiuJian
     * @Date: 2020/4/4
     */
    @RequestMapping("/query2")
    @ResponseBody
    public Membertype query2(int xztype){

        return membertypeDaoImpl.cha2(xztype);
    }
}
