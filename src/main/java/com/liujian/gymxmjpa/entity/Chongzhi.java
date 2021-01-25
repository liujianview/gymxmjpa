package com.liujian.gymxmjpa.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 充值信息实体类
 * @Author: LiuJian
 * @Date: 2020/4/3
 */
@Getter
@Setter
@Table(name = "chongzhi")
@Entity
public class Chongzhi {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long id;

  @OneToOne
  @JoinColumn(name = "Memberid")
  private Member member;

  @OneToOne
  @JoinColumn(name = "Typeid")
  private Membertype membertype;
  private long money;
  private long ssmoney;
  private long zlmoney;
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
  private java.sql.Timestamp date;
  private long czjine;
  private String beizhu;
  private long czStatic;


}
