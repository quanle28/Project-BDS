package com.javaweb.config;

import com.javaweb.security.CustomSuccessHandler;
import com.javaweb.service.impl.CustomUserDetailService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    // lấy role và user
    @Bean
    public UserDetailsService userDetailsService() {
        return new CustomUserDetailService();
    }

    // mã hóa password
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // set user và password
    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) {
        auth.authenticationProvider(authenticationProvider());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
                http.csrf().disable()
                        .authorizeRequests()

                        .antMatchers("/admin/building-edit", "/admin/building/{ids}").hasRole("MANAGER")
                        .antMatchers("/admin/**").hasAnyRole("MANAGER","STAFF")
                        .antMatchers("/login", "/resource/**", "/trang-chu", "/api/**","web/contact/").permitAll()
                        .and()
                        .formLogin().loginPage("/login").usernameParameter("j_username").passwordParameter("j_password").permitAll()
                        .loginProcessingUrl("/j_spring_security_check")
                        .successHandler(myAuthenticationSuccessHandler())
                        .failureUrl("/login?incorrectAccount").and()
                        .logout().logoutUrl("/logout").deleteCookies("JSESSIONID")
                        .and().exceptionHandling().accessDeniedPage("/access-denied").and()
                        .sessionManagement().maximumSessions(1).expiredUrl("/login?sessionTimeout");
    }

    @Bean
    public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
        return new CustomSuccessHandler();
    }
}
