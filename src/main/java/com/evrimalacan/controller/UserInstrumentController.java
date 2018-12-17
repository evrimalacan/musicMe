package com.evrimalacan.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.evrimalacan.listener.EMF;
import com.evrimalacan.model.Brand;
import com.evrimalacan.model.Image;
import com.evrimalacan.model.Instrument;
import com.evrimalacan.model.Type;
import com.evrimalacan.model.User;

@WebServlet("/userInstrument")
@MultipartConfig(
	fileSizeThreshold = 6291456, // 6 MB
	maxFileSize = 10485760L, // 5 MB
	maxRequestSize = 20971520L // 20 MB
)
public class UserInstrumentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR =
    	"uploads" +
    	File.separator +
    	"instrument-images" +
    	File.separator;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = EMF.createEntityManager();

        em.getTransaction().begin();

        List<Instrument> ownedInstruments = em.createQuery(
            "SELECT DISTINCT i " +
            "from Instrument i " +
            "LEFT JOIN FETCH i.rents r " +
            "JOIN FETCH i.user u " +
            "LEFT JOIN FETCH i.images ii " +
            "JOIN FETCH i.type t " +
            "JOIN FETCH i.brand b " +
            "WHERE u.id = :id " +
            "AND (r.status IS NULL or r.status = 1)",
            Instrument.class
        )
        .setParameter("id", ((User) request.getSession().getAttribute("user")).getId())
        .getResultList();

        List<Brand> brands = em.createQuery(
            "SELECT b " +
            "from Brand b ",
            Brand.class
        ).getResultList();

        List<Type> types = em.createQuery(
            "SELECT t " +
            "from Type t ",
            Type.class
        ).getResultList();

        em.getTransaction().commit();
        em.close();

        request.setAttribute("brands", brands);
        request.setAttribute("types", types);
        request.setAttribute("ownedInstruments", ownedInstruments);

        request.setAttribute("imageDir", UPLOAD_DIR);

        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/instruments.jsp");

        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String type = request.getParameter("type");
    	String instrumentIdStr = request.getParameter("id");
    	Integer instrumentId = 0;

    	if (!instrumentIdStr.equals("")) {
    		instrumentId = Integer.parseInt(instrumentIdStr);
    	}

		if (type == null) {
    		updateInfo(request, response, instrumentId);
    	} else if (type.equals("image")) {
    		updateImages(request, response, instrumentId);
    	} else if (type.equals("thumbnail")) {
    		updateThumbnail(request, response, instrumentId);
    	}
    }

    private void updateImages(HttpServletRequest request, HttpServletResponse response, Integer instrumentId) throws IOException, ServletException {
    	String applicationPath = request.getServletContext().getRealPath("");
		String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
    	String[] deleteImageIds = request.getParameterValues("deleted_ids");

    	EntityManager em = EMF.createEntityManager();
		em.getTransaction().begin();

		if (deleteImageIds != null) {
			Image imageToDelete;

			for (String id : deleteImageIds) {
				imageToDelete = em.createQuery(
		            "SELECT im " +
		            "FROM Image im " +
		            "WHERE instrument_id = :iid " +
		            "AND im.id = :id",
		            Image.class
		        )
				.setParameter("id", Integer.parseInt(id))
		        .setParameter("iid", instrumentId)
		        .getSingleResult();

	    		File image_file = new File(uploadFilePath + imageToDelete.getPath());

				if (image_file.exists()) {
					System.out.println(imageToDelete.getPath());
					image_file.delete();
				}

	    		em.remove(imageToDelete);
	    	}
		}

		File uploadFolder = new File(uploadFilePath);
		if (!uploadFolder.exists()) {
			uploadFolder.mkdirs();
		}

		Instrument instrument = getInstrument(
			instrumentId,
			((User) request.getSession().getAttribute("user")).getId(),
			em
    	);

		Image image;

		for (Part part : request.getParts()) {
			if (part != null && part.getSize() > 0) {
				String contentType = part.getContentType();

				// this is not a file
				if (contentType == null) {
					continue;
				}

				// allows only JPEG files to be uploaded
				if (!contentType.equalsIgnoreCase("image/jpeg")) {
					continue;
				}

				String fileName = part.getSubmittedFileName() + "_" + System.currentTimeMillis();

				part.write(uploadFilePath + fileName);

				System.out.println("File successfully uploaded to "
						+ uploadFolder.getAbsolutePath()
						+ File.separator
						+ fileName
						+ "<br>\r\n");

				image = new Image(fileName);

				image.setInstrument(instrument);
				em.persist(image);
			}
		}

		em.getTransaction().commit();
		em.close();
		
		redirect(response, "/userInstrument", instrumentId);
    }

    private void updateInfo(HttpServletRequest request, HttpServletResponse response, Integer instrumentId) throws IOException {
    	Integer brandId = Integer.parseInt(request.getParameter("brand_id"));
    	Integer typeId = Integer.parseInt(request.getParameter("type_id"));

    	EntityManager em = EMF.createEntityManager();

    	Instrument instrument;

    	if (instrumentId != 0) {
    		instrument = getInstrument(
				instrumentId,
				((User) request.getSession().getAttribute("user")).getId(),
				em
	    	);
    	} else {
    		instrument = new Instrument();
    	}

    	em.getTransaction().begin();

    	Brand brand = em.find(Brand.class, brandId);
    	Type type = em.find(Type.class, typeId);

    	instrument.setName(request.getParameter("name"));
    	instrument.setDescription(request.getParameter("description"));
    	instrument.setDailyPrice(Double.parseDouble(request.getParameter("dailyPrice")));
    	instrument.setMonthlyPrice(Double.parseDouble(request.getParameter("monthlyPrice")));
    	instrument.setBrand(brand);
    	instrument.setType(type);

    	if (instrumentId == 0) {
    		instrument.setUser(((User) request.getSession().getAttribute("user")));
    		
    		em.persist(instrument);
    		em.flush();
    	}

    	em.getTransaction().commit();
    	em.close();
    	
    	if (instrumentId == 0) {
    		redirect(response, "/userInstrument", instrument.getId());
    	}
    }

    private void updateThumbnail(HttpServletRequest request, HttpServletResponse response, Integer instrumentId) {
    	Integer imageId = Integer.parseInt(request.getParameter("image_id"));

    	EntityManager em = EMF.createEntityManager();

    	em.getTransaction().begin();

    	em.createQuery(
            "UPDATE Image " +
            "SET is_thumbnail = 0" +
            "WHERE is_thumbnail = 1" +
            "AND instrument_id = :iid"
        )
    	.setParameter("iid", instrumentId)
    	.executeUpdate();

    	Image image = em.find(Image.class, imageId);

    	image.setThumbnail(true);

    	em.getTransaction().commit();
    	em.close();
    }

    private Instrument getInstrument(Integer instrumentId, Integer userId, EntityManager em) {
    	Instrument instrument = em.createQuery(
            "SELECT i " +
            "FROM Instrument i " +
            "JOIN i.user u " +
            "WHERE u.id = :uid " +
            "AND i.id = :iid",
            Instrument.class
        )
        .setParameter("uid", userId)
        .setParameter("iid", instrumentId)
        .getSingleResult();

    	return instrument;
    }
    
    private void redirect(HttpServletResponse response, String url, Integer... id) throws IOException {
    	if (id != null) {
    		url = url + "#" + id[0];
    	}
    	
    	response.sendRedirect(url);
    }
}
