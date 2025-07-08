package com.tumblermall.products.vo;

public class ProductDetailVO {
    private Long id;
    private Long productId;
    private String colorGroup;
    private String color;
    private String sizeGroup;
    private String size;
    private String additionalPrice;
    private Boolean isDeleted;
    private String madeInCountry;
    private String country;
    private String materialId;
    private String material;
    private String weight;
    private String dimensions;
    private Integer heatRetentionTime;
    private Integer coldRetentionTime;
    private Integer iceRetentionTime;
    private Boolean isSealed;
    private String components;
    private Boolean asAvailable;
    private Integer asPeriod;
    private Integer careNoteId;
    private String productStrengths;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getColorGroup() {
        return colorGroup;
    }

    public void setColorGroup(String colorGroup) {
        this.colorGroup = colorGroup;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSizeGroup() {
        return sizeGroup;
    }

    public void setSizeGroup(String sizeGroup) {
        this.sizeGroup = sizeGroup;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getAdditionalPrice() {
        return additionalPrice;
    }

    public void setAdditionalPrice(String additionalPrice) {
        this.additionalPrice = additionalPrice;
    }

    public Boolean getDeleted() {
        return isDeleted;
    }

    public void setDeleted(Boolean deleted) {
        isDeleted = deleted;
    }

    public String getMadeInCountry() {
        return madeInCountry;
    }

    public void setMadeInCountry(String madeInCountry) {
        this.madeInCountry = madeInCountry;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getMaterialId() {
        return materialId;
    }

    public void setMaterialId(String materialId) {
        this.materialId = materialId;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public Integer getHeatRetentionTime() {
        return heatRetentionTime;
    }

    public void setHeatRetentionTime(Integer heatRetentionTime) {
        this.heatRetentionTime = heatRetentionTime;
    }

    public Integer getColdRetentionTime() {
        return coldRetentionTime;
    }

    public void setColdRetentionTime(Integer coldRetentionTime) {
        this.coldRetentionTime = coldRetentionTime;
    }

    public Integer getIceRetentionTime() {
        return iceRetentionTime;
    }

    public void setIceRetentionTime(Integer iceRetentionTime) {
        this.iceRetentionTime = iceRetentionTime;
    }

    public Boolean getSealed() {
        return isSealed;
    }

    public void setSealed(Boolean sealed) {
        isSealed = sealed;
    }

    public String getComponents() {
        return components;
    }

    public void setComponents(String components) {
        this.components = components;
    }

    public Boolean getAsAvailable() {
        return asAvailable;
    }

    public void setAsAvailable(Boolean asAvailable) {
        this.asAvailable = asAvailable;
    }

    public Integer getAsPeriod() {
        return asPeriod;
    }

    public void setAsPeriod(Integer asPeriod) {
        this.asPeriod = asPeriod;
    }

    public Integer getCareNoteId() {
        return careNoteId;
    }

    public void setCareNoteId(Integer careNoteId) {
        this.careNoteId = careNoteId;
    }

    public String getProductStrengths() {
        return productStrengths;
    }

    public void setProductStrengths(String productStrengths) {
        this.productStrengths = productStrengths;
    }
}