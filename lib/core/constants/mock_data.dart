class MockData {
  static const bool USE_REAL_API = false; // Toggle this to switch APIs

  static const Map<String, dynamic> PROPERTIES_RESPONSE = {
    "success": true,
    "message": "Properties fetched successfully!",
    "properties": [
      {
        "id": 1,
        "title": "Luxury Villa in Alkapuri",
        "description":
            "Beautiful 4BHK villa with modern amenities, swimming pool, and landscaped garden",
        "price": "2.5 Cr",
        "location": "Alkapuri",
        "city": "Vadodara",
        "state": "Gujarat",
        "country": "India",
        "pin_code": "390007",
        "property_type": "Villa",
        "property_details": [
          {
            "id": 1,
            "bedrooms": "4",
            "bathrooms": "3",
            "superbuiltArea": "2500",
            "price": "2.5 Cr",
            "plotArea": "3000",
            "carpetArea": "2200",
            "builtArea": "2500"
          }
        ],
        "bedrooms": "4",
        "bathrooms": "3",
        "area_sqft": "2500",
        "year_built": "2023",
        "status": "For Sale",
        "features": "Swimming Pool, Garden, Parking",
        "created_at": "2025-01-15T10:30:00.000Z",
        "updated_at": "2025-01-15T10:30:00.000Z",
        "is_featured": "yes",
        "contact_info": "+91 9876543210",
        "sequence": 1,
        "posted_by": "Owner",
        "notes": null,
        "festive_offer": "yes",
        "available_units": "1",
        "offer_units": "1",
        "images": [
          "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&h=600&fit=crop",
          "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&h=600&fit=crop",
          "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop"
        ],
        "videos": ["https://www.youtube.com/watch?v=sample1"],
        "facilities": ["Swimming Pool", "Garden", "Security", "Parking"]
      },
      {
        "id": 2,
        "title": "Modern Apartment in Gotri",
        "description":
            "Spacious 3BHK apartment with city view and premium amenities",
        "price": "85 Lakhs",
        "location": "Gotri",
        "city": "Vadodara",
        "state": "Gujarat",
        "country": "India",
        "pin_code": "390023",
        "property_type": "Apartment",
        "property_details": [
          {
            "id": 2,
            "bedrooms": "3",
            "bathrooms": "2",
            "superbuiltArea": "1800",
            "price": "85 Lakhs",
            "plotArea": "",
            "carpetArea": "1500",
            "builtArea": "1800"
          }
        ],
        "bedrooms": "3",
        "bathrooms": "2",
        "area_sqft": "1800",
        "year_built": "2024",
        "status": "Ready To Move",
        "features": "Gym, Lift, Parking",
        "created_at": "2025-01-15T11:00:00.000Z",
        "updated_at": "2025-01-15T11:00:00.000Z",
        "is_featured": "no",
        "contact_info": "+91 9876543211",
        "sequence": 2,
        "posted_by": "Builder",
        "notes": null,
        "festive_offer": "no",
        "available_units": "5",
        "offer_units": "0",
        "images": [
          "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop",
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop"
        ],
        "videos": [],
        "facilities": ["Gym", "Lift", "Security", "Clubhouse"]
      },
      {
        "id": 3,
        "title": "Cozy Studio Apartment in Manjalpur",
        "description":
            "1BHK studio apartment perfect for singles or couples with modern interiors",
        "price": "45 Lakhs",
        "location": "Manjalpur",
        "city": "Vadodara",
        "state": "Gujarat",
        "country": "India",
        "pin_code": "390011",
        "property_type": "Studio Apartment",
        "property_details": [
          {
            "id": 3,
            "bedrooms": "1",
            "bathrooms": "1",
            "superbuiltArea": "700",
            "price": "45 Lakhs",
            "plotArea": "",
            "carpetArea": "650",
            "builtArea": "700"
          }
        ],
        "bedrooms": "1",
        "bathrooms": "1",
        "area_sqft": "700",
        "year_built": "2022",
        "status": "For Sale",
        "features": "24/7 Security, Parking",
        "created_at": "2025-01-16T10:00:00.000Z",
        "updated_at": "2025-01-16T10:00:00.000Z",
        "is_featured": "no",
        "contact_info": "+91 9876543213",
        "sequence": 3,
        "posted_by": "Owner",
        "notes": null,
        "festive_offer": "no",
        "available_units": "2",
        "offer_units": "0",
        "images": [
          "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop"
        ],
        "videos": [],
        "facilities": ["Security", "Parking"]
      },
      {
        "id": 4,
        "title": "Commercial Office Space in Alkapuri",
        "description":
            "Fully furnished office space in prime location with modern facilities",
        "price": "3 Cr",
        "location": "Alkapuri",
        "city": "Vadodara",
        "state": "Gujarat",
        "country": "India",
        "pin_code": "390007",
        "property_type": "Commercial",
        "property_details": [
          {
            "id": 4,
            "bedrooms": "",
            "bathrooms": "2",
            "superbuiltArea": "3500",
            "price": "3 Cr",
            "plotArea": "",
            "carpetArea": "3000",
            "builtArea": "3500"
          }
        ],
        "bedrooms": "",
        "bathrooms": "2",
        "area_sqft": "3500",
        "year_built": "2023",
        "status": "For Rent",
        "features": "Lift, Parking, Conference Rooms",
        "created_at": "2025-01-17T09:00:00.000Z",
        "updated_at": "2025-01-17T09:00:00.000Z",
        "is_featured": "yes",
        "contact_info": "+91 9876543214",
        "sequence": 4,
        "posted_by": "Builder",
        "notes": null,
        "festive_offer": "yes",
        "available_units": "1",
        "offer_units": "1",
        "images": [
          "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&h=600&fit=crop"
        ],
        "videos": [],
        "facilities": ["Lift", "Parking", "Conference Room"]
      }
    ]
  };

  static const Map<String, dynamic> CATEGORY_PROPERTIES_RESPONSE = {
    "success": true,
    "message": "Categories with properties fetched successfully!",
    "data": [
      {
        "category_id": 1,
        "category_name": "New Launch",
        "properties": [
          {
            "id": 5,
            "title": "Skyline Residency - New Launch",
            "description":
                "Premium 3BHK apartments with modern amenities in prime location",
            "price": "1.2 Cr",
            "location": "Fatehgunj",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390002",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 5,
                "bedrooms": "3",
                "bathrooms": "2",
                "superbuiltArea": "1650",
                "price": "1.2 Cr",
                "plotArea": "",
                "carpetArea": "1400",
                "builtArea": "1650"
              }
            ],
            "bedrooms": "3",
            "bathrooms": "2",
            "area_sqft": "1650",
            "year_built": "2025",
            "status": "New Launch",
            "features": "Gym, Swimming Pool, Clubhouse, Garden",
            "created_at": "2025-01-15T12:00:00.000Z",
            "updated_at": "2025-01-15T12:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543212",
            "sequence": 1,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "yes",
            "available_units": "25",
            "offer_units": "5",
            "category_id": 1,
            "images": [
              "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Gym",
              "Swimming Pool",
              "Clubhouse",
              "Garden",
              "Security"
            ]
          },
          {
            "id": 10,
            "title": "Crystal Heights - Premium Launch",
            "description": "Luxury 4BHK apartments with panoramic city views",
            "price": "1.8 Cr",
            "location": "Sayajigunj",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390005",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 10,
                "bedrooms": "4",
                "bathrooms": "3",
                "superbuiltArea": "2200",
                "price": "1.8 Cr",
                "plotArea": "",
                "carpetArea": "1900",
                "builtArea": "2200"
              }
            ],
            "bedrooms": "4",
            "bathrooms": "3",
            "area_sqft": "2200",
            "year_built": "2025",
            "status": "New Launch",
            "features": "Rooftop Garden, Spa, Concierge",
            "created_at": "2025-01-16T10:00:00.000Z",
            "updated_at": "2025-01-16T10:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543220",
            "sequence": 2,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "no",
            "available_units": "15",
            "offer_units": "0",
            "category_id": 1,
            "images": [
              "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Rooftop Garden",
              "Spa",
              "Concierge",
              "Valet Parking"
            ]
          },
          {
            "id": 11,
            "title": "Metro View Towers",
            "description": "Smart 2BHK homes with metro connectivity",
            "price": "95 Lakhs",
            "location": "Akota",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390020",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 11,
                "bedrooms": "2",
                "bathrooms": "2",
                "superbuiltArea": "1350",
                "price": "95 Lakhs",
                "plotArea": "",
                "carpetArea": "1150",
                "builtArea": "1350"
              }
            ],
            "bedrooms": "2",
            "bathrooms": "2",
            "area_sqft": "1350",
            "year_built": "2025",
            "status": "New Launch",
            "features": "Smart Home, Metro Access, Mall",
            "created_at": "2025-01-17T09:00:00.000Z",
            "updated_at": "2025-01-17T09:00:00.000Z",
            "is_featured": "no",
            "contact_info": "+91 9876543221",
            "sequence": 3,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "yes",
            "available_units": "40",
            "offer_units": "8",
            "category_id": 1,
            "images": [
              "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Smart Home",
              "Metro Access",
              "Shopping Mall",
              "Food Court"
            ]
          }
        ]
      },
      {
        "category_id": 2,
        "category_name": "Ready To Move",
        "properties": [
          {
            "id": 6,
            "title": "Green Valley Apartments",
            "description": "Ready to move 2BHK apartments with all amenities",
            "price": "75 Lakhs",
            "location": "Subhanpura",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390023",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 6,
                "bedrooms": "2",
                "bathrooms": "2",
                "superbuiltArea": "1200",
                "price": "75 Lakhs",
                "plotArea": "",
                "carpetArea": "1000",
                "builtArea": "1200"
              }
            ],
            "bedrooms": "2",
            "bathrooms": "2",
            "area_sqft": "1200",
            "year_built": "2023",
            "status": "Ready To Move",
            "features": "Parking, Security, Lift",
            "created_at": "2025-01-16T08:00:00.000Z",
            "updated_at": "2025-01-16T08:00:00.000Z",
            "is_featured": "no",
            "contact_info": "+91 9876543215",
            "sequence": 2,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "no",
            "available_units": "8",
            "offer_units": "0",
            "category_id": 2,
            "images": [
              "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop"
            ],
            "facilities": ["Parking", "Security", "Lift"]
          },
          {
            "id": 12,
            "title": "Sunshine Residency",
            "description": "Spacious 3BHK ready to move homes with garden view",
            "price": "1.1 Cr",
            "location": "Vasna",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390015",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 12,
                "bedrooms": "3",
                "bathrooms": "2",
                "superbuiltArea": "1550",
                "price": "1.1 Cr",
                "plotArea": "",
                "carpetArea": "1350",
                "builtArea": "1550"
              }
            ],
            "bedrooms": "3",
            "bathrooms": "2",
            "area_sqft": "1550",
            "year_built": "2024",
            "status": "Ready To Move",
            "features": "Garden View, Clubhouse, Pool",
            "created_at": "2025-01-18T07:00:00.000Z",
            "updated_at": "2025-01-18T07:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543222",
            "sequence": 1,
            "posted_by": "Owner",
            "notes": null,
            "festive_offer": "yes",
            "available_units": "3",
            "offer_units": "1",
            "category_id": 2,
            "images": [
              "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Garden View",
              "Clubhouse",
              "Swimming Pool",
              "Kids Play Area"
            ]
          },
          {
            "id": 13,
            "title": "City Center Plaza",
            "description": "Premium 1BHK apartments in heart of city",
            "price": "55 Lakhs",
            "location": "Race Course",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390007",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 13,
                "bedrooms": "1",
                "bathrooms": "1",
                "superbuiltArea": "850",
                "price": "55 Lakhs",
                "plotArea": "",
                "carpetArea": "750",
                "builtArea": "850"
              }
            ],
            "bedrooms": "1",
            "bathrooms": "1",
            "area_sqft": "850",
            "year_built": "2024",
            "status": "Ready To Move",
            "features": "Prime Location, Shopping Mall",
            "created_at": "2025-01-19T06:00:00.000Z",
            "updated_at": "2025-01-19T06:00:00.000Z",
            "is_featured": "no",
            "contact_info": "+91 9876543223",
            "sequence": 3,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "no",
            "available_units": "12",
            "offer_units": "0",
            "category_id": 2,
            "images": [
              "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Prime Location",
              "Shopping Mall",
              "Restaurant",
              "Gym"
            ]
          }
        ]
      },
      {
        "category_id": 3,
        "category_name": "Under Construction",
        "properties": [
          {
            "id": 7,
            "title": "Royal Heights - Phase 2",
            "description":
                "Luxury 4BHK penthouses under construction with premium amenities",
            "price": "2.8 Cr",
            "location": "Alkapuri",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390007",
            "property_type": "Penthouse",
            "property_details": [
              {
                "id": 7,
                "bedrooms": "4",
                "bathrooms": "4",
                "superbuiltArea": "3200",
                "price": "2.8 Cr",
                "plotArea": "",
                "carpetArea": "2800",
                "builtArea": "3200"
              }
            ],
            "bedrooms": "4",
            "bathrooms": "4",
            "area_sqft": "3200",
            "year_built": "2026",
            "status": "Under Construction",
            "features": "Private Terrace, Jacuzzi, Home Theater",
            "created_at": "2025-01-17T09:00:00.000Z",
            "updated_at": "2025-01-17T09:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543216",
            "sequence": 1,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "yes",
            "available_units": "3",
            "offer_units": "1",
            "category_id": 3,
            "images": [
              "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Private Terrace",
              "Jacuzzi",
              "Home Theater",
              "Concierge"
            ]
          },
          {
            "id": 14,
            "title": "Emerald Towers",
            "description": "Modern 3BHK apartments with smart home features",
            "price": "1.4 Cr",
            "location": "Gotri",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390021",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 14,
                "bedrooms": "3",
                "bathrooms": "2",
                "superbuiltArea": "1750",
                "price": "1.4 Cr",
                "plotArea": "",
                "carpetArea": "1500",
                "builtArea": "1750"
              }
            ],
            "bedrooms": "3",
            "bathrooms": "2",
            "area_sqft": "1750",
            "year_built": "2026",
            "status": "Under Construction",
            "features": "Smart Home, Solar Panels, EV Charging",
            "created_at": "2025-01-20T08:00:00.000Z",
            "updated_at": "2025-01-20T08:00:00.000Z",
            "is_featured": "no",
            "contact_info": "+91 9876543224",
            "sequence": 2,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "no",
            "available_units": "20",
            "offer_units": "0",
            "category_id": 3,
            "images": [
              "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Smart Home",
              "Solar Panels",
              "EV Charging",
              "Rainwater Harvesting"
            ]
          }
        ]
      },
      {
        "category_id": 4,
        "category_name": "Recommended Properties",
        "properties": [
          {
            "id": 8,
            "title": "Garden View Villas",
            "description":
                "Spacious 3BHK villas with private gardens and modern amenities",
            "price": "1.8 Cr",
            "location": "Waghodia",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "391760",
            "property_type": "Villa",
            "property_details": [
              {
                "id": 8,
                "bedrooms": "3",
                "bathrooms": "3",
                "superbuiltArea": "2200",
                "price": "1.8 Cr",
                "plotArea": "2800",
                "carpetArea": "1900",
                "builtArea": "2200"
              }
            ],
            "bedrooms": "3",
            "bathrooms": "3",
            "area_sqft": "2200",
            "year_built": "2024",
            "status": "For Sale",
            "features": "Private Garden, Car Parking, Security",
            "created_at": "2025-01-18T10:00:00.000Z",
            "updated_at": "2025-01-18T10:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543217",
            "sequence": 1,
            "posted_by": "Owner",
            "notes": null,
            "festive_offer": "no",
            "available_units": "6",
            "offer_units": "0",
            "category_id": 4,
            "images": [
              "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Private Garden",
              "Car Parking",
              "Security",
              "Clubhouse"
            ]
          },
          {
            "id": 9,
            "title": "City Center Apartments",
            "description":
                "Modern 2BHK apartments in the heart of the city with excellent connectivity",
            "price": "95 Lakhs",
            "location": "Race Course",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390007",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 9,
                "bedrooms": "2",
                "bathrooms": "2",
                "superbuiltArea": "1350",
                "price": "95 Lakhs",
                "plotArea": "",
                "carpetArea": "1150",
                "builtArea": "1350"
              }
            ],
            "bedrooms": "2",
            "bathrooms": "2",
            "area_sqft": "1350",
            "year_built": "2024",
            "status": "Ready To Move",
            "features": "Prime Location, Metro Connectivity, Shopping Mall",
            "created_at": "2025-01-19T11:00:00.000Z",
            "updated_at": "2025-01-19T11:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543218",
            "sequence": 2,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "yes",
            "available_units": "12",
            "offer_units": "2",
            "category_id": 4,
            "images": [
              "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "Metro Connectivity",
              "Shopping Mall",
              "Gym",
              "Security"
            ]
          },
          {
            "id": 15,
            "title": "Riverside Villas",
            "description":
                "Exclusive 5BHK villas with river view and private pool",
            "price": "3.5 Cr",
            "location": "Harni",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "390022",
            "property_type": "Villa",
            "property_details": [
              {
                "id": 15,
                "bedrooms": "5",
                "bathrooms": "4",
                "superbuiltArea": "4000",
                "price": "3.5 Cr",
                "plotArea": "5000",
                "carpetArea": "3500",
                "builtArea": "4000"
              }
            ],
            "bedrooms": "5",
            "bathrooms": "4",
            "area_sqft": "4000",
            "year_built": "2024",
            "status": "For Sale",
            "features": "River View, Private Pool, Garden",
            "created_at": "2025-01-21T12:00:00.000Z",
            "updated_at": "2025-01-21T12:00:00.000Z",
            "is_featured": "yes",
            "contact_info": "+91 9876543225",
            "sequence": 3,
            "posted_by": "Owner",
            "notes": null,
            "festive_offer": "yes",
            "available_units": "2",
            "offer_units": "1",
            "category_id": 4,
            "images": [
              "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&h=600&fit=crop",
              "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "River View",
              "Private Pool",
              "Garden",
              "Home Theater",
              "Wine Cellar"
            ]
          },
          {
            "id": 16,
            "title": "Tech Park Residences",
            "description": "Contemporary 3BHK apartments near IT hub",
            "price": "1.25 Cr",
            "location": "Bhayli",
            "city": "Vadodara",
            "state": "Gujarat",
            "country": "India",
            "pin_code": "391410",
            "property_type": "Apartment",
            "property_details": [
              {
                "id": 16,
                "bedrooms": "3",
                "bathrooms": "2",
                "superbuiltArea": "1600",
                "price": "1.25 Cr",
                "plotArea": "",
                "carpetArea": "1400",
                "builtArea": "1600"
              }
            ],
            "bedrooms": "3",
            "bathrooms": "2",
            "area_sqft": "1600",
            "year_built": "2024",
            "status": "For Sale",
            "features": "IT Hub Proximity, Co-working Space",
            "created_at": "2025-01-22T10:00:00.000Z",
            "updated_at": "2025-01-22T10:00:00.000Z",
            "is_featured": "no",
            "contact_info": "+91 9876543226",
            "sequence": 4,
            "posted_by": "Builder",
            "notes": null,
            "festive_offer": "no",
            "available_units": "18",
            "offer_units": "0",
            "category_id": 4,
            "images": [
              "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop"
            ],
            "facilities": [
              "IT Hub Proximity",
              "Co-working Space",
              "Cafeteria",
              "Shuttle Service"
            ]
          }
        ]
      }
    ]
  };

  static const Map<String, dynamic> WEBSTORIES_RESPONSE = {
    "success": true,
    "message": "Webstories fetched successfully!",
    "webstories": [
      {
        "id": 1,
        "title": "Best Investment Properties in 2025",
        "url": null,
        "keywords": "investment, property, 2025",
        "status": "active",
        "views": "1.2K",
        "date": "2025-01-15T04:00:00.000Z",
        "details": [
          {
            "img":
                "https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=600&fit=crop",
            "description":
                "Top investment opportunities in real estate for maximum returns"
          }
        ]
      },
      {
        "id": 2,
        "title": "Home Buying Guide for First Time Buyers",
        "url": null,
        "keywords": "home buying, first time, guide",
        "status": "active",
        "views": "890",
        "date": "2025-01-14T04:00:00.000Z",
        "details": [
          {
            "img":
                "https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=400&h=600&fit=crop",
            "description": "Complete guide for first-time home buyers"
          }
        ]
      },
      {
        "id": 3,
        "title": "Top Luxury Villas to Watch in 2025",
        "url": null,
        "keywords": "luxury, villa, real estate",
        "status": "active",
        "views": "2.3K",
        "date": "2025-01-13T04:00:00.000Z",
        "details": [
          {
            "img":
                "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400&h=600&fit=crop",
            "description": "Explore the most luxurious villas available"
          }
        ]
      },
      {
        "id": 4,
        "title": "Affordable Housing Options in Vadodara",
        "url": null,
        "keywords": "affordable, housing, Vadodara",
        "status": "active",
        "views": "1.5K",
        "date": "2025-01-12T04:00:00.000Z",
        "details": [
          {
            "img":
                "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&h=600&fit=crop",
            "description": "Budget-friendly options for first-time buyers"
          }
        ]
      },
      {
        "id": 5,
        "title": "Smart Home Technology Trends",
        "url": null,
        "keywords": "smart home, technology, trends",
        "status": "active",
        "views": "980",
        "date": "2025-01-11T04:00:00.000Z",
        "details": [
          {
            "img":
                "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=600&fit=crop",
            "description": "Latest smart home features that add value"
          }
        ]
      },
      {
        "id": 6,
        "title": "Commercial Real Estate Opportunities",
        "url": null,
        "keywords": "commercial, real estate, investment",
        "status": "active",
        "views": "750",
        "date": "2025-01-10T04:00:00.000Z",
        "details": [
          {
            "img":
                "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=400&h=600&fit=crop",
            "description": "Explore commercial property investment options"
          }
        ]
      }
    ]
  };
}
