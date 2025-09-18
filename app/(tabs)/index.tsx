import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  FlatList,
  Dimensions,
} from 'react-native';
import LoadingSpinner from '../../components/LoadingSpinner';
import ModernPropertyCard from '../../components/ModernPropertyCard';
import NotificationBanner from '../../components/NotificationBanner';
import { logApiRequest, logApiResponse, logApiError } from '../../utils/apiLogger';

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
  fallbackImage: string;
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
  const [loading, setLoading] = useState(true);
  const [showNotification, setShowNotification] = useState(true);

  useEffect(() => {
    fetchCategoryProperties();
  }, []);

  const fetchCategoryProperties = async () => {
    const endpoint = 'https://aiinrealestate.in/api/category_property';
    try {
      logApiRequest(endpoint);
      const response = await fetch(endpoint);
      const data = await response.json();
      logApiResponse(endpoint, data);
      
      if (data.success && data.data) {
        const transformedCategories = data.data.map((category: any) => ({
          id: category.category_id.toString(),
          name: category.category_name,
          properties: category.properties.map((prop: any) => ({
            id: prop.id.toString(),
            title: prop.title,
            price: prop.price || 'Price on request',
            location: prop.location,
            city: prop.city,
            type: prop.property_type,
            status: prop.status,
            description: prop.features || prop.description || '',
            image: prop.images?.[0] ? `https://aiinrealestate.in/api${prop.images[0]}` : `https://picsum.photos/400/300?random=${prop.id}`,
            fallbackImage: `https://picsum.photos/400/300?random=${prop.id}`,
            area: prop.property_details?.[0]?.plotArea || 'N/A',
            bedrooms: prop.bedrooms || 0,
            bathrooms: prop.bathrooms || 0,
          }))
        }));
        
        // Add additional categories based on property status
        const allProperties = transformedCategories.flatMap(cat => cat.properties);
        const additionalCategories = [
          {
            id: 'recommended',
            name: 'Recommended Properties',
            properties: allProperties.slice(0, 8).map((prop, index) => ({ ...prop, id: `rec_${prop.id}_${index}` }))
          },
          {
            id: 'new-launch',
            name: 'New Launch',
            properties: allProperties.filter(p => p.status.includes('Construction')).slice(0, 6).map((prop, index) => ({ ...prop, id: `new_${prop.id}_${index}` }))
          },
          {
            id: 'ready-to-move',
            name: 'Ready To Move',
            properties: allProperties.filter(p => p.status === 'Ready To Move').slice(0, 6).map((prop, index) => ({ ...prop, id: `ready_${prop.id}_${index}` }))
          },
          {
            id: 'under-construction',
            name: 'Under Construction',
            properties: allProperties.filter(p => p.status === 'Under Construction').slice(0, 6).map((prop, index) => ({ ...prop, id: `under_${prop.id}_${index}` }))
          }
        ].filter(cat => cat.properties.length > 0);
        
        const finalCategories = [...transformedCategories, ...additionalCategories];
        console.log('✅ Transformed categories:', finalCategories.length);
        setCategories(finalCategories);
      } else {
        console.warn('⚠️ Invalid category data structure');
        setCategories(mockCategories);
      }
    } catch (error) {
      logApiError(endpoint, error);
      setCategories(mockCategories);
    } finally {
      setLoading(false);
    }
  };

  const fetchRecommendedProperties = async () => {
    const endpoint = 'https://aiinrealestate.in/api/property';
    try {
      logApiRequest(endpoint);
      const response = await fetch(endpoint);
      const data = await response.json();
      logApiResponse(endpoint, data);
      
      if (data.success && data.properties) {
        const transformedProperties = data.properties.slice(0, 10).map((prop: any) => ({
          id: prop.id.toString(),
          title: prop.title,
          price: prop.price || 'Price on request',
          location: prop.location,
          city: prop.city,
          type: prop.property_type,
          status: prop.status,
          description: prop.features || prop.description || '',
          image: prop.images?.[0] ? `https://aiinrealestate.in${prop.images[0]}` : 'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
          area: prop.property_details?.[0]?.plotArea || 'N/A',
          bedrooms: prop.bedrooms || 0,
          bathrooms: prop.bathrooms || 0,
        }));
        console.log('✅ Transformed recommended properties:', transformedProperties.length);
        setRecommendedProperties(transformedProperties);
      } else {
        console.warn('⚠️ Invalid properties data structure');
        setRecommendedProperties(mockProperties);
      }
    } catch (error) {
      logApiError(endpoint, error);
      setRecommendedProperties(mockProperties);
    }
  };

  const handleWhatsAppContact = (property: Property) => {
    const message = `📌 Property Details:%0A%0A🏷 Title: ${property.title}%0A💰 Price: ${property.price}%0A📍 Location: ${property.location}, ${property.city}%0A🏡 Type: ${property.type}%0A📌 Status: ${property.status}%0A📝 Description: ${property.description}`;
    const whatsappUrl = `https://api.whatsapp.com/send/?phone=&text=${message}&type=phone_number&app_absent=0`;
    Linking.openURL(whatsappUrl);
  };



  const renderPropertyCard = ({ item }: { item: Property }) => (
    <ModernPropertyCard 
      property={item} 
      onPress={() => handleWhatsAppContact(item)}
      style={styles.propertyCard}
    />
  );

  const renderCategorySection = ({ item }: { item: Category }) => (
    <View style={styles.categorySection}>
      <View style={styles.titleSection}>
        <Text style={styles.categoryTitle}>{item.name}</Text>
      </View>
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
      {/* Notification Banner */}
      {showNotification && (
        <NotificationBanner
          type="whatsapp"
          message="🏠 Get instant property updates on WhatsApp! Connect with verified agents."
          actionText="Connect"
          onClose={() => setShowNotification(false)}
          duration={8000}
        />
      )}
      
      <ScrollView showsVerticalScrollIndicator={false} style={styles.scrollView}>
        {/* Categories and Properties */}
        {loading ? (
          <LoadingSpinner message="Loading properties..." />
        ) : (
          <FlatList
            data={categories}
            renderItem={renderCategorySection}
            keyExtractor={(category) => category.id}
            scrollEnabled={false}
          />
        )}
      </ScrollView>
    </View>
  );
}

// Mock data fallback
const mockProperties: Property[] = [
  {
    id: '1',
    title: 'NA Approved Land',
    price: '3 Cr to 3.5 Cr',
    location: 'Por',
    city: 'Vadodara',
    type: 'Land',
    status: 'For Sale',
    description: 'B1,440 SqFt NA Approved Land',
    image: 'https://picsum.photos/400/300?random=1',
    fallbackImage: 'https://picsum.photos/400/300?random=1',
    area: 'N/ABHK',
  },
  {
    id: '2',
    title: '4BHK Apartments',
    price: '60 lakhs to 90 lakhs',
    location: 'Gotri',
    city: 'Vadodara',
    type: 'Apartment',
    status: 'Under Construction',
    description: 'Yash Complex Gotri Main Road',
    image: 'https://picsum.photos/400/300?random=2',
    fallbackImage: 'https://picsum.photos/400/300?random=2',
    area: 'N/ABHK',
  },
  {
    id: '3',
    title: '3 BHK Apartment in Sunpharma',
    price: '25 L to 30 L',
    location: 'Sunpharma Road',
    city: 'Vadodara',
    type: 'Apartment',
    status: 'Ready To Move',
    description: 'Ready to move 3BHK apartment',
    image: 'https://picsum.photos/400/300?random=3',
    fallbackImage: 'https://picsum.photos/400/300?random=3',
    area: 'N/ABHK',
  },
  {
    id: '4',
    title: '2 BHK Flats in Atladara',
    price: '30 L to 35 L',
    location: 'Atladara',
    city: 'Vadodara',
    type: 'Flat',
    status: 'Ready To Move',
    description: 'Ready to move 2BHK flats',
    image: 'https://picsum.photos/400/300?random=4',
    fallbackImage: 'https://picsum.photos/400/300?random=4',
    area: 'N/ABHK',
  },
  {
    id: '5',
    title: '4 BHK Luxurious Flats in New Alkapuri',
    price: '1 Cr to 1.10 Cr',
    location: 'New Alkapuri',
    city: 'Vadodara',
    type: 'Flat',
    status: 'Under Construction',
    description: 'Own your Zero Comfort Home',
    image: 'https://picsum.photos/400/300?random=5',
    fallbackImage: 'https://picsum.photos/400/300?random=5',
    area: 'N/ABHK',
  },
];

const mockCategories: Category[] = [
  {
    id: '1',
    name: 'Featured Properties',
    properties: mockProperties,
  },
  {
    id: '2',
    name: 'New Launches',
    properties: mockProperties.slice(0, 3),
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  scrollView: {
    flex: 1,
    paddingTop: 10,
  },
  categorySection: {
    marginBottom: 35,
  },
  categoryTitle: {
    fontSize: 24,
    fontWeight: '800',
    color: '#ffffff',
    marginHorizontal: 20,
    marginBottom: 20,
    lineHeight: 30,
    letterSpacing: -0.5,
  },
  horizontalList: {
    paddingLeft: 20,
    paddingRight: 10,
  },
  propertyCard: {
    marginRight: 15,
  },
});