package com.evrimalacan.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(
	name = "rents",
	uniqueConstraints =
		@UniqueConstraint(columnNames={"user_id", "instrument_id", "day", "month", "year"})
)
public class Rent {
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    @Column(name = "id", updatable = false, nullable = false)
    private int id;
	
	@ManyToOne
    private User user;
	
	@ManyToOne
    private Instrument instrument;
	
	@Column(nullable = true)
	private int day;
	
	private int month;
	
	private int year;
	
	private int status;
	
	private String detail;
	
	public Rent() {
	}
	
	public Rent(User user, Instrument instrument, int day, int month, int year, int status, String detail) {
		super();
		this.user = user;
		this.instrument = instrument;
		this.day = day;
		this.month = month;
		this.year = year;
		this.status = status;
		this.detail = detail;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Instrument getInstrument() {
		return instrument;
	}

	public void setInstrument(Instrument instrument) {
		this.instrument = instrument;
	}

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
}
