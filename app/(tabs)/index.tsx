import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  Image,
  TouchableOpacity,
  TextInput,
  FlatList,
  Dimensions,
  Alert,
  Linking,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Search, MapPin, Heart, Phone, Filter } from 'lucide-react-native';

const { width } = Dimensions.get('window');

interface Property {
  id: string;
  title: string;
  price: string;
  location: string;
  city: string;
  type: string;
  status: string;
  description: string;
  image: string;
  area?: string;
  bedrooms?: number;
  bathrooms?: number;
}

interface Category {
  id: string;
  name: string;
  properties: Property[];
}

export default function HomeScreen() {
  const [categories, setCategories] = useState<Category[]>([]);
  const [recommendedProperties, setRecommendedProperties] = useState<Property[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchCategoryProperties();
    fetchRecommendedProperties();
  }, []);

  const fetchCategoryProperties = async () => {
    try {
      const response = await fetch('https://aiinrealestate.in/api/category_property');
      const data = await response.json();
      if (data.success) {
        setCategories(data.categories || []);
      }
    } catch (error) {
      console.error('Error fetching categories:', error);
      // Fallback with mock data
      setCategories(mockCategories);
    } finally {
      setLoading(false);
    }
  };

  const fetchRecommendedProperties = async () => {
    try {
      const response = await fetch('https://aiinrealestate.in/api/property');
      const data = await response.json();
      if (data.success) {
        setRecommendedProperties(data.properties?.slice(0, 10) || []);
      }
    } catch (error) {
      console.error('Error fetching properties:', error);
      setRecommendedProperties(mockProperties);
    }
  };

  const handleWhatsAppContact = (property: Property) => {
    const message = `📌 Property Details:%0A%0A🏷 Title: ${property.title}%0A💰 Price: ${property.price}%0A📍 Location: ${property.location}, ${property.city}%0A🏡 Type: ${property.type}%0A📌 Status: ${property.status}%0A📝 Description: ${property.description}`;
    const whatsappUrl = `https://api.whatsapp.com/send/?phone=&text=${message}&type=phone_number&app_absent=0`;
    Linking.openURL(whatsappUrl);
  };

  const renderPropertyCard = ({ item }: { item: Property }) => (
    <TouchableOpacity
      style={styles.propertyCard}
      onPress={() => handleWhatsAppContact(item)}
      activeOpacity={0.9}
    >
      <LinearGradient
        colors={['#667eea', '#764ba2']}
        style={styles.cardGradient}
      >
        <Image source={{ uri: item.image }} style={styles.propertyImage} />
        <View style={styles.propertyInfo}>
          <Text style={styles.propertyTitle} numberOfLines={2}>
            {item.title}
          </Text>
          <View style={styles.locationRow}>
            <MapPin size={14} color="#a0a9ff" />
            <Text style={styles.locationText}>
              {item.location}, {item.city}
            </Text>
          </View>
          <View style={styles.priceRow}>
            <Text style={styles.priceText}>₹{item.price}</Text>
            <TouchableOpacity style={styles.heartButton}>
              <Heart size={18} color="#ff6b9d" />
            </TouchableOpacity>
          </View>
          <View style={styles.typeRow}>
            <Text style={styles.typeText}>{item.type}</Text>
            <Text style={styles.statusText}>{item.status}</Text>
          </View>
        </View>
      </LinearGradient>
    </TouchableOpacity>
  );

  const renderCategorySection = ({ item }: { item: Category }) => (
    <View style={styles.categorySection}>
      <Text style={styles.categoryTitle}>{item.name}</Text>
      <FlatList
        data={item.properties}
        renderItem={renderPropertyCard}
        keyExtractor={(prop) => prop.id}
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.horizontalList}
      />
    </View>
  );

  return (
    <View style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Categories and Properties */}
        {loading ? (
          <View style={styles.loadingContainer}>
            <Text style={styles.loadingText}>Loading properties...</Text>
          </View>
        ) : (
          <>
            <FlatList
              data={categories}
              renderItem={renderCategorySection}
              keyExtractor={(category) => category.id}
              scrollEnabled={false}
            />

            {/* Recommended Properties */}
            <View style={styles.categorySection}>
              <Text style={styles.categoryTitle}>Recommended for You</Text>
              <FlatList
                data={recommendedProperties}
                renderItem={renderPropertyCard}
                keyExtractor={(prop) => prop.id}
                horizontal
                showsHorizontalScrollIndicator={false}
                contentContainerStyle={styles.horizontalList}
              />
            </View>
          </>
        )}
      </ScrollView>
    </View>
  );
}

// Mock data fallback
const mockProperties: Property[] = [
  {
    id: '1',
    title: '3 BHK Luxury Apartment',
    price: '75,00,000',
    location: 'Bopal',
    city: 'Ahmedabad',
    type: 'Apartment',
    status: 'For Sale',
    description: 'Spacious 3BHK apartment with modern amenities',
    image: 'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
  },
  {
    id: '2',
    title: '2 BHK Modern Villa',
    price: '1,20,00,000',
    location: 'Satellite',
    city: 'Ahmedabad',
    type: 'Villa',
    status: 'For Sale',
    description: 'Beautiful villa with garden and parking',
    image: 'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg',
  },
];

const mockCategories: Category[] = [
  {
    id: '1',
    name: 'Premium Apartments',
    properties: mockProperties,
  },
  {
    id: '2',
    name: 'Luxury Villas',
    properties: mockProperties,
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  categorySection: {
    marginBottom: 30,
  },
  categoryTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#ffffff',
    marginHorizontal: 20,
    marginBottom: 15,
  },
  horizontalList: {
    paddingLeft: 20,
  },
  propertyCard: {
    width: width * 0.8,
    marginRight: 15,
    borderRadius: 20,
    overflow: 'hidden',
  },
  cardGradient: {
    padding: 15,
  },
  propertyImage: {
    width: '100%',
    height: 180,
    borderRadius: 15,
    marginBottom: 15,
  },
  propertyInfo: {
    gap: 8,
  },
  propertyTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#ffffff',
  },
  locationRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 5,
  },
  locationText: {
    fontSize: 14,
    color: '#a0a9ff',
  },
  priceRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  priceText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#00ff88',
  },
  heartButton: {
    width: 35,
    height: 35,
    borderRadius: 17.5,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  typeRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  typeText: {
    fontSize: 14,
    color: '#74b9ff',
    backgroundColor: 'rgba(116, 185, 255, 0.2)',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 10,
  },
  statusText: {
    fontSize: 14,
    color: '#00ff88',
    backgroundColor: 'rgba(0, 255, 136, 0.2)',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 10,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 50,
  },
  loadingText: {
    color: '#a0a9ff',
    fontSize: 16,
  },
});