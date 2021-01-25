package com.liujian.gymxmjpa.controller;

import com.liujian.gymxmjpa.dao.LoosDao;
import com.liujian.gymxmjpa.service.LoosDaoImpl;
import com.liujian.gymxmjpa.entity.Loos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @Description: 遗失物品管理Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/14
 */
@Controller
@RequestMapping("/loos")
public class LoosController {
   @Autowired
    private LoosDaoImpl loosDaoImpl;
   @Autowired
   private LoosDao loosDao;

    /**
     * @Description: 遗失物品管理-进入遗失物品信息界面
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/jin9")
    public String jin7(){

        return "WEB-INF/jsp/loos";
    }

    /**
     * @Description: 遗失物品管理-根据遗失物品名称分页查询
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String loosName, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("loosName",loosName);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return loosDaoImpl.query(map1);
    }

    /**
     * @Description: 遗失物品管理-添加遗失物品
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Loos loos){
        loosDao.save(loos);
    }

    /**
     * @Description: 遗失物品管理-根据遗失物品id查询信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/query3")
    @ResponseBody
    public List<Loos> query3(long loosId){
        List<Loos> list  = new ArrayList<Loos>();
        list.add(loosDao.findById(loosId).get());
        return list;
    }

    /**
     * @Description: 遗失物品管理-取回遗失物品修改其信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/quhui")
    @ResponseBody
    public  void upd(Loos loos){
        loosDaoImpl.update(loos);
    }

    /**
     * @Description: 遗失物品管理-根据遗失物品id查询单个物品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Loos> one(Long loosId){
        Optional<Loos> loos =loosDao.findById(loosId);
        return loos;
    }

}
