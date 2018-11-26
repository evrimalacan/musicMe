package com.evrimalacan.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
       "/user",
       "/userInstrument",
    }
)
public class AllowUser implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

//        String loginURI = req.getContextPath() + "/login";
//        boolean loginRequest = req.getRequestURI().equals(loginURI);

        boolean user = req.getSession().getAttribute("user") != null;

        if (user) {
            chain.doFilter(request, response);
        } else {
        	req.getSession().setAttribute("error", "You need to Login first");
        	req.getSession().setAttribute("redirect", req.getRequestURI());
            res.sendRedirect("/login");
        }
    }

    public void init(FilterConfig fConfig) throws ServletException {
    }
}
