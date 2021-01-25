package com.liujian.gymxmjpa.real;

import com.liujian.gymxmjpa.dao.AdminuserDao;
import com.liujian.gymxmjpa.entity.Adminuser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private AdminuserDao adminuserDao;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("已授权");
        Subject subject = SecurityUtils.getSubject();
        Adminuser user = (Adminuser) principalCollection.getPrimaryPrincipal() ;
        //
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo() ;
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        UsernamePasswordToken token = (UsernamePasswordToken)authenticationToken ;
        Adminuser adminuser = adminuserDao.findByAdminNameAndAdminPassword(token.getUsername(),String.copyValueOf(token.getPassword()));

        if(null == adminuser){
            return null ;
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(adminuser.getAdminName(),adminuser.getAdminPassword(),"") ;
        System.out.println("完成认证！");
        return info;
    }
}
