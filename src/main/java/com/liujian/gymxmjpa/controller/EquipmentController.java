package com.liujian.gymxmjpa.controller;


import com.liujian.gymxmjpa.service.EquipmentDaoImpl;
import com.liujian.gymxmjpa.entity.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 器材管理Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/12
 */
@Controller
@RequestMapping("/qc")
public class EquipmentController {
    @Autowired
    private EquipmentDaoImpl equipmentDao;

    /**
     * @Description: 器材管理-进入器材信息界面
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    @RequestMapping("/yemian")
    public String yemian(){

        return "WEB-INF/jsp/CEquipment";
    }

    /**
     * @Description: 器材管理-根据器材名称分页查询
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String hyname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("hyname",hyname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return equipmentDao.query(map1);
    }

    /**
     * @Description: 器材管理-添加器材
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    @RequestMapping("/insert")
    @ResponseBody
    public Map<String,Object> insert(Equipment equipment){
        equipmentDao.insert(equipment);
        return query("",5,1);
    }

    /**
     * @Description: 器材管理-根据器材id删除
     * @Author: LiuJian
     * @Date: 2020/4/12
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> del(int eqId){
        equipmentDao.del(eqId);
        return query("",5,1);
    }
}
