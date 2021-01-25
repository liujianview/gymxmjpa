package com.liujian.gymxmjpa.dao;


import com.liujian.gymxmjpa.entity.Subject;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 课程信息Dao层接口
 * @Author: LiuJian
 * @Date: 2020/4/3
 */
public interface SubjectDao extends JpaRepository<Subject,Long> {
}
