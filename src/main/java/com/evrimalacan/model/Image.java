package com.evrimalacan.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "images")
public class Image {
    @ManyToOne
    private Instrument instrument;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    @Column(name = "id", updatable = false, nullable = false)
    private int id;

    @Column(nullable = false)
    private String path;
    
    @Column(name = "is_thumbnail", nullable = false)
    @ColumnDefault("0")
    private boolean isThumbnail;

    public Image() {
    }

    public Image(String path) {
        this.path = path;
    }

	public Instrument getInstrument() {
		return instrument;
	}

	public void setInstrument(Instrument instrument) {
		this.instrument = instrument;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public boolean isThumbnail() {
		return isThumbnail;
	}

	public void setThumbnail(boolean isThumbnail) {
		this.isThumbnail = isThumbnail;
	}
}
