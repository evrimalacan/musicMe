package com.evrimalacan.controller;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.evrimalacan.listener.EMF;
import com.evrimalacan.model.Instrument;

@WebServlet("")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String query = "SELECT i from Instrument i ";
    	String term = request.getParameter("term");
    	
    	EntityManager em = EMF.createEntityManager();
    	TypedQuery<Instrument> instrumentQuery = null;
    	
    	System.out.println(request.getServletContext().getRealPath("/"));
    	
    	if (term != null) {
			instrumentQuery = em.createQuery(
	            query +
	            "WHERE i.name like :term",
	            Instrument.class
	        ).setParameter("term", "%" + term + "%");
		} else {
			instrumentQuery = em.createQuery(
	            query,
	            Instrument.class
	        );
		}

    	em.getTransaction().begin();

		List<Instrument> instruments = instrumentQuery.getResultList();

        em.getTransaction().commit();
        em.close();

//        for	(Instrument ins : instruments) {
//        	System.out.println(ins.getName());
//        	System.out.println(ins.getBrand().getName());
//        	System.out.println(ins.getType().getName());
//        }

        request.setAttribute("instruments", instruments);
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/home.jsp");

        rd.forward(request, response);
    }
}
