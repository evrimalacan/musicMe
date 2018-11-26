package com.evrimalacan.model;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "brands")
public class Brand {																																																												
	@OneToMany(mappedBy = "brand")
    private List<Instrument> instruments = new ArrayList<>();

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
	@GenericGenerator(name = "native", strategy = "native")
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	
	@Column(nullable = false)
	private String name;
	
	private String about;

	public Brand() {
	}

	public Brand(String name, String about) {
		this.name = name;
		this.about = about;
	}

	public List<Instrument> getInstruments() {
		return instruments;
	}
	public void setInstruments(List<Instrument> instruments) {
		this.instruments = instruments;
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
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}

	@Override
	public String toString() {
		return "Brand [instruments=" + instruments + ", id=" + id + ", name=" + name + ", about=" + about + "]";
	}

}
