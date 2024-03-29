package domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import domain.Enums.OpeningCategory;
import settings.StringToOpeningCategoryConverter;
import settings.StringToPlayerGenderConverter;

@Entity
@Table(name = "opening")
public class Opening {
	public Opening() {
	}

	public Opening(String name, String category, int year, String player) {
		this.name = name;
		this.category = OpeningCategory.getCategoryByInput(category);
		this.year = year;
		this.player = player;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_opening", unique = true, nullable = false)
	private Long id;

	@Column(name = "opening_name", nullable = false)
	private String name;

	@Column(name = "opening_category", nullable = false)
	@Convert(converter = StringToOpeningCategoryConverter.class)
	private OpeningCategory category;

	@Column(name = "opening_year", nullable = true)
	private int year;

	@Column(name = "opening_famous_player", nullable = true)
	private String player;

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "opening")
	private List<OpeningUsage> openingUsage = new ArrayList<>();

	@Transient
	private int openingUsagePoints;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategory() {
		return category.getCategory();
	}

	public void setCategory(String category) {
		this.category = OpeningCategory.getCategoryByInput(category);
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getPlayer() {
		return player;
	}

	public void setPlayer(String player) {
		this.player = player;
	}

	public List<OpeningUsage> getOpeningUsage() {
		return openingUsage;
	}

	public void setOpeningUsage(List<OpeningUsage> openingUsage) {
		this.openingUsage = openingUsage;
	}

	public void setOpeningUsagePoints(int openingUsagePoints) {
		this.openingUsagePoints = openingUsagePoints;
	}

	public int getOpeningUsagePoints() {
		return openingUsagePoints;
	}

	@Override
	public String toString() {
		return "Opening [id=" + id + ", name=" + name + ", category="
				+ category.getCategory() + ", year=" + year + ", player="
				+ player + ", openingUsage.size()=" + openingUsage.size() + "]";
	}
}
