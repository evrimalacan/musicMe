package com.evrimalacan.model;

import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "instruments")
public class Instrument {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
	@GenericGenerator(name = "native", strategy = "native")
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	
	@ManyToOne
	private User user;
	
	@Column(nullable = false)
	private String name;
	
	private String description;

	@ManyToOne
    private Type type;

	@ManyToOne
    private Brand brand;
	
	@Column(name = "daily_price", nullable = false, scale = 2)
	private double dailyPrice;
	
	@Column(name = "monthly_price", nullable = false, scale = 2)
	private double monthlyPrice;
	
	@OneToMany(mappedBy = "instrument")
    private Set<Image> images;

	@OneToMany(mappedBy = "instrument")
    private Set<Rent> rents;
	
	public Instrument() {
	}
	
	public Instrument(String name, String description, Type type, Brand brand) {
		this.name = name;
		this.description = description;
		this.type = type;
		this.brand = brand;
	}
	
	public Set<Image> getImages() {
		return images;
	}

	public void setImages(Set<Image> images) {
		this.images = images;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Brand getBrand() {
		return brand;
	}
	public void setBrand(Brand brand) {
		this.brand = brand;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}

	public double getDailyPrice() {
		return dailyPrice;
	}

	public void setDailyPrice(double dailyPrice) {
		this.dailyPrice = dailyPrice;
	}

	public double getMonthlyPrice() {
		return monthlyPrice;
	}

	public void setMonthlyPrice(double monthlyPrice) {
		this.monthlyPrice = monthlyPrice;
	}
	
	public Set<Rent> getRents() {
		return rents;
	}

	public void setRents(Set<Rent> rents) {
		this.rents = rents;
	}
}
