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
import com.evrimalacan.model.Instrument;

@WebServlet("/instrument/*")
public class GetInstrumentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();

//		String[] split_uri = uri.split("/instrument/");
//		Integer id = Integer.parseInt(split_uri[1]);

//		String id = uri.substring(uri.lastIndexOf("/"), uri.length());

		String string_id = uri.replace("/instrument/", "");
		Integer id = Integer.parseInt(string_id);

		EntityManager em = EMF.createEntityManager();

		em.getTransaction().begin();

		Instrument instrument = em.find(Instrument.class, id);

		em.getTransaction().commit();
        em.close();

		request.setAttribute("instrument", instrument);

		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/instrument.jsp");

        rd.forward(request, response);
	}
}
