package com.evrimalacan.controller;

import java.io.File;
import java.io.IOException;

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

@WebServlet("/instrument/*")
public class GetInstrumentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String UPLOAD_DIR =
			File.separator +
	    	"uploads" +
	    	File.separator +
	    	"instrument-images" +
	    	File.separator;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();

//		String[] split_uri = uri.split("/instrument/");
//		Integer id = Integer.parseInt(split_uri[1]);

//		String id = uri.substring(uri.lastIndexOf("/"), uri.length());

		String string_id = uri.replace("/instrument/", "");
		Integer id = Integer.parseInt(string_id);

		EntityManager em = EMF.createEntityManager();

		em.getTransaction().begin();

		Instrument instrument = em.createQuery(
            "SELECT DISTINCT i " +
            "from Instrument i " +
            "LEFT JOIN FETCH i.images ii " +
            "JOIN FETCH i.type t " +
            "JOIN FETCH i.brand b " +
            "WHERE i.id = :id",
            Instrument.class
        )
        .setParameter("id", id)
        .getSingleResult();
		
		if (request.getSession().getAttribute("user") != null) {
			Boolean isRenting = !em.createQuery(
	            "SELECT r " +
	            "from Rent r " +
	            "JOIN r.instrument i " +
	            "JOIN r.user u " +
	            "WHERE i.id = :iid " +
	            "AND u.id = :uid",
	            Rent.class
	        )
	        .setParameter("iid", id)
	        .setParameter("uid", ((User) request.getSession().getAttribute("user")).getId())
	        .getResultList()
	        .isEmpty();
			
			request.setAttribute("isRenting", isRenting);
		}
		
		em.getTransaction().commit();
        em.close();

		request.setAttribute("instrument", instrument);
		
		request.setAttribute("imageDir", UPLOAD_DIR);

		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/instrument.jsp");

        rd.forward(request, response);
	}
}
