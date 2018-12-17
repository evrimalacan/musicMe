package com.evrimalacan.controller;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.evrimalacan.listener.EMF;
import com.evrimalacan.model.User;
import com.sun.org.apache.xerces.internal.util.URI;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passwordConfirmation = request.getParameter("password_confirmation");

        if (!password.equals(passwordConfirmation)) {
            request.setAttribute("error", "Passwords does not match");
            showRegisterForm(request, response);

            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters");
            showRegisterForm(request, response);

            return;
        }

        EntityManager em = EMF.createEntityManager();
        em.getTransaction().begin();
        
        try {
	        User user = em.createQuery(
	            "SELECT u " +
	            "FROM User u " +
	            "WHERE u.email = :email",
	            User.class
	        )
	        .setParameter("email", email)
	        .getSingleResult();
	        
            request.setAttribute("error", "This email is in use");
            showRegisterForm(request, response);

            return;
        } catch (NoResultException e) {
		}

        
        User newUser = new User(name, email, password);

        em.persist(newUser);

        em.getTransaction().commit();
        em.close();
        
        RequestDispatcher rd = request.getRequestDispatcher("/login");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        showRegisterForm(request, response);
    }

    private void showRegisterForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/register.jsp");

        rd.forward(request, response);
    }
}
