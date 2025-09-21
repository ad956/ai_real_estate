class Property {
  final int id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String city;
  final String state;
  final String country;
  final String pinCode;
  final String propertyType;
  final String bedrooms;
  final String bathrooms;
  final String areaSqft;
  final String yearBuilt;
  final String status;
  final String features;
  final String postedBy;
  final String festiveOffer;
  final String availableUnits;
  final String offerUnits;
  final List<String> images;
  final List<String> videos;
  final List<String> facilities;
  final PropertyDetails? propertyDetails;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.yearBuilt,
    required this.status,
    required this.features,
    required this.postedBy,
    required this.festiveOffer,
    required this.availableUnits,
    required this.offerUnits,
    required this.images,
    required this.videos,
    required this.facilities,
    this.propertyDetails,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      location: json['location'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      pinCode: json['pin_code'] ?? '',
      propertyType: json['property_type'] ?? '',
      bedrooms: json['bedrooms'] ?? '',
      bathrooms: json['bathrooms'] ?? '',
      areaSqft: json['area_sqft'] ?? '',
      yearBuilt: json['year_built'] ?? '',
      status: json['status'] ?? '',
      features: json['features'] ?? '',
      postedBy: json['posted_by'] ?? '',
      festiveOffer: json['festive_offer'] ?? '',
      availableUnits: json['available_units'] ?? '',
      offerUnits: json['offer_units'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      facilities: List<String>.from(json['facilities'] ?? []),
      propertyDetails: json['property_details'] != null && 
          (json['property_details'] as List).isNotEmpty
          ? PropertyDetails.fromJson(json['property_details'][0])
          : null,
    );
  }

  String get fullLocation => '$location, $city';
  
  String get formattedPrice {
    if (price.isEmpty) return 'Price on request';
    if (price.startsWith('₹')) return price;
    return '₹$price';
  }

  String get primaryImage {
    if (images.isNotEmpty) {
      final imagePath = images.first;
      if (imagePath.startsWith('http')) return imagePath;
      return 'https://aiinrealestate.in$imagePath';
    }
    return 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=300&fit=crop';
  }
}

class PropertyDetails {
  final String bedrooms;
  final String bathrooms;
  final String plotArea;
  final String carpetArea;
  final String builtArea;
  final String superbuiltArea;

  PropertyDetails({
    required this.bedrooms,
    required this.bathrooms,
    required this.plotArea,
    required this.carpetArea,
    required this.builtArea,
    required this.superbuiltArea,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
    return PropertyDetails(
      bedrooms: json['bedrooms'] ?? '',
      bathrooms: json['bathrooms'] ?? '',
      plotArea: json['plotArea'] ?? '',
      carpetArea: json['carpetArea'] ?? '',
      builtArea: json['builtArea'] ?? '',
      superbuiltArea: json['superbuiltArea'] ?? '',
    );
  }
}

class CategoryProperty {
  final int categoryId;
  final String categoryName;
  final List<Property> properties;

  CategoryProperty({
    required this.categoryId,
    required this.categoryName,
    required this.properties,
  });

  factory CategoryProperty.fromJson(Map<String, dynamic> json) {
    return CategoryProperty(
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? '',
      properties: (json['properties'] as List? ?? [])
          .map((p) => Property.fromJson(p))
          .toList(),
    );
  }
}

class WebStory {
  final int id;
  final String title;
  final String? url;
  final String? keywords;
  final String status;
  final String views;
  final String date;
  final List<WebStoryDetail> details;

  WebStory({
    required this.id,
    required this.title,
    this.url,
    this.keywords,
    required this.status,
    required this.views,
    required this.date,
    required this.details,
  });

  factory WebStory.fromJson(Map<String, dynamic> json) {
    return WebStory(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'],
      keywords: json['keywords'],
      status: json['status'] ?? '',
      views: json['views'] ?? '0',
      date: json['date'] ?? '',
      details: (json['details'] as List? ?? [])
          .map((d) => WebStoryDetail.fromJson(d))
          .toList(),
    );
  }
}

class WebStoryDetail {
  final String img;
  final String description;

  WebStoryDetail({
    required this.img,
    required this.description,
  });

  factory WebStoryDetail.fromJson(Map<String, dynamic> json) {
    return WebStoryDetail(
      img: json['img'] ?? '',
      description: json['description'] ?? '',
    );
  }

  String get fullImageUrl {
    if (img.startsWith('http')) return img;
    return 'https://aiinrealestate.in$img';
  }
}