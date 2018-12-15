package com.evrimalacan.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.org.apache.xerces.internal.util.URI;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        session.invalidate();
        
        String referer = request.getHeader("referer");
		
		if (referer.contains(request.getServerName())) {
			response.sendRedirect(new URI(referer).getPath());
		} else {
			response.sendRedirect("/");
		}
    }
}
