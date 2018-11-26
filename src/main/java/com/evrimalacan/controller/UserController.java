package com.evrimalacan.controller;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.evrimalacan.listener.EMF;
import com.evrimalacan.model.User;

@WebServlet("/user")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	User user = (User) request.getSession().getAttribute("user");
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	
    	EntityManager em = EMF.createEntityManager();
    	em.getTransaction().begin();
    	
    	user.setName(name);
    	user.setEmail(email);
    		
    	em.getTransaction().commit();
    	
    	request.getSession().setAttribute("message", "Your account information has been updated successfully");
    	request.getSession().setAttribute("messageType", "success");
    	
    	response.sendRedirect("/user");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        showUserForm(request, response);
    }

    private void showUserForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String message = (String) request.getSession().getAttribute("message");
    	String messageType = (String) request.getSession().getAttribute("messageType");
    	
    	request.setAttribute("message", message);
    	request.setAttribute("messageType", messageType);
    	
    	request.getSession().removeAttribute("message");
    	request.getSession().removeAttribute("messageType");
    	
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/user.jsp");

        rd.forward(request, response);
    }
}
