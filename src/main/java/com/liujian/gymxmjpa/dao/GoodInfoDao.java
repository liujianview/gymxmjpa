package com.liujian.gymxmjpa.dao;


import com.liujian.gymxmjpa.entity.GoodInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * @Description: 商品统计信息Dao层接口
 * @Author: LiuJian
 * @Date: 2020/4/3
 */
public interface GoodInfoDao extends JpaRepository<GoodInfo,Long> {

    @Query(value = "select * FROM  goodinfo where memberid =:memberid",nativeQuery = true)
    public List<GoodInfo> queryByIdNative(@Param("memberid") long memberid);

    @Query(value = "select * FROM  goodinfo where goodsid =:goodsid",nativeQuery = true)
    public List<GoodInfo> queryByGoodsIdNative(@Param("goodsid") long goodsid) ;
}
