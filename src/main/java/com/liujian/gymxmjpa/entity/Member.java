package com.liujian.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @Description: 会员信息实体类
 * @Author: LiuJian
 * @Date: 2020/4/3
 */
@Entity
@Table(name = "member")
@Getter
@Setter
public class Member implements Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long memberId;
  private String memberName;
  private String memberPhone;
  private long memberSex;
  private long memberAge;
  private String birthday;
  //@Transient
  //private long memberType;
  private java.sql.Date nenberDate;
  @ManyToOne
  @JoinColumn(name = "MemberTypes")
  private Membertype membertypes;

  private long memberStatic;

  private float memberbalance;

  private java.sql.Date Memberxufei;
}
