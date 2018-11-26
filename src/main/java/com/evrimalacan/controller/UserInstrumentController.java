package com.evrimalacan.controller;

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
import com.evrimalacan.model.Brand;
import com.evrimalacan.model.Instrument;
import com.evrimalacan.model.User;

@WebServlet("/userInstrument")
public class UserInstrumentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = EMF.createEntityManager();

        em.getTransaction().begin();

        List<Instrument> ownedInstruments = em.createQuery(
            "SELECT i " +
            "from Instrument i " +
            "JOIN i.user u " +
            "WHERE u.id = :id",
            Instrument.class
        )
        .setParameter("id", ((User) request.getSession().getAttribute("user")).getId())
        .getResultList();
        
        List<Brand> brands = em.createQuery(
            "SELECT b " +
            "from Brand b ",
            Brand.class
        ).getResultList();

        em.getTransaction().commit();
        em.close();
        
        System.out.println(ownedInstruments);
        
        request.setAttribute("brands", brands);
        request.setAttribute("ownedInstruments", ownedInstruments);
        
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/instruments.jsp");

        rd.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Integer instrument_id = Integer.parseInt(request.getParameter("id"));
    	Integer brand_id = Integer.parseInt(request.getParameter("brand"));
    	
    	EntityManager em = EMF.createEntityManager();
    	
    	Instrument instrument = em.find(Instrument.class, instrument_id);
    	Brand brand= em.find(Brand.class, brand_id);
    	
    	em.getTransaction().begin();
    	
    	instrument.setName(request.getParameter("name"));
    	instrument.setDescription(request.getParameter("description"));
    	instrument.setDailyPrice(Double.parseDouble(request.getParameter("dailyPrice")));
    	instrument.setMonthlyPrice(Double.parseDouble(request.getParameter("monthlyPrice")));
    	instrument.setBrand(brand);
    		
    	em.getTransaction().commit();
    	
    	System.out.println("oldu bitti :))");
    }
}
