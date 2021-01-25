package com.liujian.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 商品统计信息实体类
 * @Author: LiuJian
 * @Date: 2020/4/3
 */
@Entity
@Table(name = "goodinfo")
@Getter
@Setter
public class GoodInfo implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long id;
  @ManyToOne
  @JoinColumn(name = "goodsid")
  private Goods goods;

  @ManyToOne
  @JoinColumn(name = "memberid")
  private Member member;
  private int count;
  private double price;
  private String remark;

}
