package com.evrimalacan.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.evrimalacan.listener.EMF;
import com.evrimalacan.model.Instrument;
import com.evrimalacan.model.Rent;
import com.evrimalacan.model.User;

@WebServlet("/userRent")
public class UserRentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR =
    	"uploads" +
    	File.separator +
    	"instrument-images" +
    	File.separator;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = EMF.createEntityManager();

        em.getTransaction().begin();

        List<Rent> rents = em.createQuery(
            "SELECT DISTINCT r " +
            "from Rent r " +
            "JOIN FETCH r.instrument i " +
            "LEFT JOIN FETCH i.images ii " +
            "JOIN FETCH r.user u " +
            "WHERE u.id = :id",
            Rent.class
        )
        .setParameter("id", ((User) request.getSession().getAttribute("user")).getId())
        .getResultList();

        List<Rent> rentals = em.createQuery(
            "SELECT DISTINCT r " +
            "from Rent r " +
            "JOIN FETCH r.instrument i " +
            "JOIN i.user u " +
            "LEFT JOIN FETCH i.images ii " +
            "WHERE u.id = :uid " +
            "AND r.status = 0",
            Rent.class
        )
        .setParameter("uid", ((User) request.getSession().getAttribute("user")).getId())
        .getResultList();

        em.getTransaction().commit();
        em.close();
        
        request.setAttribute("rents", rents);
        request.setAttribute("rentals", rentals);

        request.setAttribute("imageDir", UPLOAD_DIR);

        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/rent.jsp");

        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	EntityManager em = EMF.createEntityManager();

        em.getTransaction().begin();
        
        Integer rentId = Integer.parseInt(request.getParameter("id"));
        Integer status = Integer.parseInt(request.getParameter("status"));
        
    	Rent rent = em.createQuery(
            "SELECT r " +
            "FROM Rent r " +
            "JOIN r.instrument i " +
            "JOIN i.user u " +
            "WHERE u.id = :uid " +
            "AND r.id = :id",
            Rent.class
        )
    	.setParameter("id", rentId)
    	.setParameter("uid", ((User) request.getSession().getAttribute("user")).getId())
    	.getSingleResult();
    	
    	rent.setStatus(status);
    	
    	em.getTransaction().commit();
        em.close();
        
        response.sendRedirect("/userRent");
    }
}
