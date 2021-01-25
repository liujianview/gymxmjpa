package com.liujian.gymxmjpa.controller;

import com.liujian.gymxmjpa.dao.GoodInfoDao;
import com.liujian.gymxmjpa.dao.GoodsDao;
import com.liujian.gymxmjpa.dao.MenberDao;
import com.liujian.gymxmjpa.service.GoodInfoDaoImpl;
import com.liujian.gymxmjpa.service.GoodsDaoImpl;
import com.liujian.gymxmjpa.service.MenberDaoImpl;
import com.liujian.gymxmjpa.entity.GoodInfo;
import com.liujian.gymxmjpa.entity.Goods;
import com.liujian.gymxmjpa.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 商品售卖信息管理Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/14
 */
@Controller
@RequestMapping("/goodinfo")
public class GoodInfoController {
   @Autowired
    private GoodInfoDao goodInfoDao;
   @Autowired
   private GoodsDao goodsDao;
   @Autowired
   private GoodInfoDaoImpl goodInfoDaoImpl;
    @Autowired
    private MenberDao menberDao;
    @Autowired
    private GoodsDaoImpl goodsDaoImpl;
    @Autowired
    private MenberDaoImpl menberDaoImpl;

    /**
     * @Description: 商品售卖信息管理-进入商品售卖信息界面
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/spinfo")
    public String spinfo(){

        return "WEB-INF/jsp/GoodInfo";
    }

    /**
     * @Description: 商品售卖信息管理-根据商品id,会员id查询商品售卖信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(Integer goodsid,Integer memberid, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("goodsid",goodsid);
        map1.put("memberid",memberid);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return goodInfoDaoImpl.query(map1);
    }

    /**
     * @Description: 商品售卖信息管理-根据商品id,会员id删除信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long id,Integer goodsid,Integer memberid,int pageSize, int pageNumber){
         goodInfoDao.deleteById(id);
         Map<String,Object>  map1=new HashMap<String,Object>();
         map1.put("goodsid",goodsid);
         map1.put("memberid",memberid);
         map1.put("qi",(pageNumber-1)*pageSize);
         map1.put("shi",pageSize);
         return goodInfoDaoImpl.query(map1);
    }

    /**
     * @Description: 商品售卖信息管理-根据商品id,会员id批量删除信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/dellist")
    @ResponseBody
    public Map<String,Object> delete(int array[],Integer goodsid,Integer memberid,int pageSize, int pageNumber){
        System.out.println(array[0]);
        for(int i = 0;i<array.length;i++){
            goodInfoDao.deleteById((long) array[i]);
        }
        return query(goodsid,memberid,pageSize,pageNumber);
    }

    /**
     * @Description: 商品售卖信息管理-添加商品售卖信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(GoodInfo goodInfo){
        goodInfoDao.save(goodInfo);
    }

    /**
     * @Description: 商品售卖信息管理-根据商品id查询商品售卖信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<GoodInfo> one(long goodsId){
        return goodInfoDao.findById(goodsId);
    }

    /**
     * @Description: 商品售卖信息管理-根据商品id查询商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/chagoods")
    @ResponseBody
    public Optional<Goods> oneg(long goodsId){
        return goodsDao.findById(goodsId);
    }

    /**
     * @Description: 商品售卖信息管理-根据会员id查询会员信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/chamember")
    @ResponseBody
    public Optional<Member> onem(long memberId){
        return menberDao.findById(memberId);
    }

    /**
     * @Description: 商品售卖信息管理-修改商品售卖信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(GoodInfo goodInfo){
        goodInfoDao.save(goodInfo);
    }

    /**
     * @Description: 商品售卖信息管理-修改会员信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/updmember")
    @ResponseBody
    public  void upd(Member member){
        menberDaoImpl.upd(member);
    }

    /**
     * @Description: 商品售卖信息管理-修改商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/updgoods")
    @ResponseBody
    public  void upd(Goods goods){
        goodsDaoImpl.update(goods);
    }

}
