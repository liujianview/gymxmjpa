package com.liujian.gymxmjpa.config;

import com.liujian.gymxmjpa.real.MyRealm;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {

    /**
     * 密码校验规则HashedCredentialsMatcher
     * 这个类是为了对密码进行编码的 ,
     * 防止密码在数据库里明码保存 , 当然在登陆认证的时候 ,
     * 这个类也负责对form里输入的密码进行编码
     * 处理认证匹配处理器：如果自定义需要实现继承HashedCredentialsMatcher
     */
    //    @Bean("hashedCredentialsMatcher")
    //    public HashedCredentialsMatcher getHashedCredentialsMatcher() {
    //        HashedCredentialsMatcher credentialsMatcher = new HashedCredentialsMatcher();
    //        //指定加密方式为MD5
    //        credentialsMatcher.setHashAlgorithmName("MD5");
    //        //加密次数
    //        credentialsMatcher.setHashIterations(1024);
    //        credentialsMatcher.setStoredCredentialsHexEncoded(true);
    //        return credentialsMatcher;
    //    }


    @Bean
    public MyRealm getMyRealm(){
        MyRealm myRealm = new MyRealm() ;
        //        myRealm.setCredentialsMatcher(getHashedCredentialsMatcher());
        return myRealm ;
    }

    @Bean
    public SimpleCookie rememberMeCookie() {
        //System.out.println("ShiroConfiguration.rememberMeCookie()");
        //这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
        SimpleCookie simpleCookie = new SimpleCookie("ckbox");
        //<!-- 记住我cookie生效时间30天 ,单位秒;-->
        simpleCookie.setMaxAge(259200);
        return simpleCookie;
    }

    @Bean
    public EhCacheManager getEhCacheManager(){
        EhCacheManager ehCacheManager = new EhCacheManager() ;
        ehCacheManager.setCacheManagerConfigFile("classpath:ehcache-shiro.xml");
        return ehCacheManager ;
    }

    @Bean
    public CookieRememberMeManager rememberMeManager() {
        //System.out.println("ShiroConfiguration.rememberMeManager()");
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(rememberMeCookie());
        //rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度(128 256 512 位)
        //  cookieRememberMeManager.setCipherKey(Base64.decode("2AvVhdsgUs0FSA3SDFAdag=="));
        return cookieRememberMeManager;
    }




    @Bean
    public DefaultWebSecurityManager getDefaultWebSecurityManager(){
        DefaultWebSecurityManager defaultWebSecurityManager = new DefaultWebSecurityManager() ;
        defaultWebSecurityManager.setRealm(getMyRealm());
        //注册记住我
        defaultWebSecurityManager.setRememberMeManager(rememberMeManager());
        //注册缓存
        defaultWebSecurityManager.setCacheManager(getEhCacheManager());
        return defaultWebSecurityManager ;
    }


    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(){
        System.out.println("开启了Shiro注解支持");
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(getDefaultWebSecurityManager());
        return authorizationAttributeSourceAdvisor;
    }

    @Bean
    @ConditionalOnMissingBean
    public DefaultAdvisorAutoProxyCreator defaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator defaultAAP = new DefaultAdvisorAutoProxyCreator();
        defaultAAP.setProxyTargetClass(true);
        return defaultAAP;
    }

    @Bean
    public ShiroFilterFactoryBean getShiroFilterFactoryBean(){
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean() ;

        //设置网页安全管理器
        shiroFilterFactoryBean.setSecurityManager(getDefaultWebSecurityManager());

        Map<String,String> map = new LinkedHashMap<String,String>() ;
        //定义可以直接访问的资源
        map.put("/login.jsp","anon") ;
        map.put("/vcode.jsp","anon");
        map.put("/dl/yz","anon") ;
        map.put("/static/**","anon") ;
        //取消认证
        map.put("/logout","logout") ;


        //
        //  map.put("/add.jsp","perms[user:*]") ;


        map.put("/**","user") ;


        shiroFilterFactoryBean.setFilterChainDefinitionMap(map);
        shiroFilterFactoryBean.setLoginUrl("/login.jsp");
        shiroFilterFactoryBean.setUnauthorizedUrl("/unauth.jsp");

        return shiroFilterFactoryBean ;
    }

}
