package com.evrimalacan.hibernate.util;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class HibernateUtil {
	/* 
	 * I DECIDED TO USE ENTITYMANAGER INSTEAD OF HIBERNATE SESSION
	
	private static final SessionFactory sessionFactory;
	 
    static {
    	StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
    	
        try {
            sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
 
    public static Session openSession() {
        return sessionFactory.openSession();
    }*/
	
	private static final EntityManagerFactory emf;
	 
    static {
    	emf = Persistence.createEntityManagerFactory("MusicMe");
    }
 
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }
    
    public static void close() {
    	getEntityManagerFactory().close();
    }
}
