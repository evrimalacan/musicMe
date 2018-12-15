package com.evrimalacan.controller;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.evrimalacan.listener.EMF;
import com.evrimalacan.model.Instrument;
import com.evrimalacan.model.Rent;
import com.evrimalacan.model.User;

@WebServlet("/rent")
public class RentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String rentType = request.getParameter("type");
    	Integer instrumentId = Integer.parseInt(request.getParameter("instrument_id"));
    	Integer userId = ((User) request.getSession().getAttribute("user")).getId();
    	String[] date = request.getParameter("date").split("/");
    	
    	EntityManager em = EMF.createEntityManager();
    	em.getTransaction().begin();
    	
    	User user = em.find(User.class, userId);
    	Instrument instrument = em.find(Instrument.class, instrumentId);
    	
    	Rent rent = new Rent();
    	
    	rent.setUser(user);
    	rent.setInstrument(instrument);
    	
    	switch (date.length) {
			case 2:
				rent.setMonth(Integer.parseInt(date[0]));
				rent.setYear(Integer.parseInt(date[1]));
				break;
			case 3:
				rent.setDay(Integer.parseInt(date[0]));
				rent.setMonth(Integer.parseInt(date[1]));
				rent.setYear(Integer.parseInt(date[2]));
				break;
			default:
				return;
		}
    	
    	em.persist(rent);
    	
    	em.getTransaction().commit();
    	em.close();
    	
    	
    	
//    	Rent rentRequest = new Rent(user, instrument);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    }
}
