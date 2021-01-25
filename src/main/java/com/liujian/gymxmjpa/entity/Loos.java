package com.liujian.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 丢失物品信息实体类
 * @Author: LiuJian
 * @Date: 2020/4/3
 */
@Entity
@Table(name = "loos")
@Getter
@Setter
public class Loos {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long loosId;
  private String loosName;
  private String loosImages;
  private String loosAddress;
  private java.sql.Date loosjdate;
  private Integer loosStatus;
  private String scavenger;
  private String scavengerPhone;
  private String receiveName;
  private String receivePhone;
  private java.sql.Date loosldate;
  private String admin;
}
