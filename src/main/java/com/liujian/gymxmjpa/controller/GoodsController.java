package com.liujian.gymxmjpa.controller;
import com.liujian.gymxmjpa.dao.GoodInfoDao;
import com.liujian.gymxmjpa.dao.GoodsDao;
import com.liujian.gymxmjpa.service.GoodsDaoImpl;
import com.liujian.gymxmjpa.entity.GoodInfo;
import com.liujian.gymxmjpa.entity.Goods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 商品管理Controller控制层
 * @Author: LiuJian
 * @Date: 2020/4/14
 */
@Controller
@RequestMapping("/goods")
public class GoodsController {
   @Autowired
   private GoodsDao goodsDao;
   @Autowired
   private GoodInfoDao goodInfoDao;
   @Autowired
   private GoodsDaoImpl goodsDaoImpl;

    /**
     * @Description: 商品管理-进入商品列表界面
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/sp")
    public String sp(){

        return "WEB-INF/jsp/Goods";
    }

    /**
     * @Description: 商品管理-根据商品名称分页查询
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String goodsname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("goodsname",goodsname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return goodsDaoImpl.query(map1);
    }

    /**
     * @Description: 商品管理-查询所有商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/query2")
    @ResponseBody
    public List<Goods> query2(){
        List list  = goodsDao.findAll();
        return list;
    }

    /**
     * @Description: 商品管理-根据商品id删除商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long goodsId,String goodsname, int pageSize, int pageNumber){

        //先根据商品id在商品信息表里查询是否有其信息
        List<GoodInfo> goodInfoList = goodInfoDao.queryByGoodsIdNative(goodsId);
        if(goodInfoList !=null && goodInfoList.size() > 0){
            //如果有,先循环删除
            for(GoodInfo goodInfo : goodInfoList){
                if(goodsId == goodInfo.getGoods().getGoodsId()){
                    goodInfoDao.delete(goodInfo);
                }
            }
        }
        goodsDao.deleteById(goodsId);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("goodsname",goodsname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return goodsDaoImpl.query(map1);

    }

    /**
     * @Description: 商品管理-添加商品
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Goods goods){
        goodsDao.save(goods);
    }

    /**
     * @Description: 商品管理-根据商品id查询单个商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Goods> one(long goodsId){
        return goodsDao.findById(goodsId);
    }

    /**
     * @Description: 商品管理-根据商品名称计算总数量
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/count")
    @ResponseBody
    public Long count (String goodsName){
        goodsDaoImpl.count(goodsName);
        return  goodsDaoImpl.count(goodsName);
    }

    /**
     * @Description: 商品管理-修改商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(Goods goods){
        goodsDaoImpl.update(goods);
    }

    /**
     * @Description: 商品管理-修改商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/update")
    @ResponseBody
    public  void update(Goods goods){
        goodsDao.save(goods);
    }

    /**
     * @Description: 商品管理-查询所有商品信息
     * @Author: LiuJian
     * @Date: 2020/4/14
     */
    @RequestMapping("/topcoach")
    @ResponseBody
    public Map<String,Object> topcoach(){
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("goods",goodsDao.findAll());
        return map ;
    }
}
