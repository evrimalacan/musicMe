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

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		EntityManager em = EMF.createEntityManager();

		try {
			User user = em.createQuery(
				"SELECT u " +
				"FROM User u " +
				"WHERE u.email = :email and " +
				"u.password = :pw",
				User.class
			)
			.setParameter("email", email)
			.setParameter("pw", password)
			.getSingleResult();

			em.close();

			request.getSession().setAttribute("user", user);

			String redirect = request.getParameter("redirect");
			String referer = request.getParameter("referer");

			if (redirect != null) {
				response.sendRedirect(redirect);
			} else if (referer != null && referer.contains(request.getServerName())) {
				response.sendRedirect(new URI(referer).getPath());
			} else {
				response.sendRedirect("/");
			}
		} catch (NoResultException e) {
			request.setAttribute("error", "Email or password is incorrect");
			showLoginForm(request, response);
		}

		em.close();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		showLoginForm(request, response);
	}

	private void showLoginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/login.jsp");

		rd.forward(request, response);
	}
}
