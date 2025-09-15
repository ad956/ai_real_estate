import React from 'react';
import {
  Modal,
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Image,
  FlatList,
  Dimensions,
  Linking,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { X, MapPin, Heart, Phone, Share, Bed, Bath, Square, Car } from 'lucide-react-native';

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
  gallery?: string[];
  features?: {
    bedrooms?: number;
    bathrooms?: number;
    area?: string;
    parking?: number;
  };
}

interface PropertyDetailModalProps {
  visible: boolean;
  property: Property | null;
  onClose: () => void;
}

export default function PropertyDetailModal({ visible, property, onClose }: PropertyDetailModalProps) {
  if (!property) return null;

  const handleWhatsAppContact = () => {
    const message = `📌 Property Details:%0A%0A🏷 Title: ${property.title}%0A💰 Price: ${property.price}%0A📍 Location: ${property.location}, ${property.city}%0A🏡 Type: ${property.type}%0A📌 Status: ${property.status}%0A📝 Description: ${property.description}`;
    const whatsappUrl = `https://api.whatsapp.com/send/?phone=&text=${message}&type=phone_number&app_absent=0`;
    Linking.openURL(whatsappUrl);
  };

  const renderGalleryImage = ({ item }: { item: string }) => (
    <Image source={{ uri: item }} style={styles.galleryImage} />
  );

  const gallery = property.gallery || [property.image, property.image, property.image];

  return (
    <Modal
      visible={visible}
      animationType="slide"
      presentationStyle="pageSheet"
      onRequestClose={onClose}
    >
      <LinearGradient colors={['#0f0f23', '#1a1a2e', '#16213e']} style={styles.container}>
        <ScrollView showsVerticalScrollIndicator={false}>
          {/* Header */}
          <View style={styles.header}>
            <TouchableOpacity style={styles.closeButton} onPress={onClose}>
              <X size={24} color="#ffffff" />
            </TouchableOpacity>
            <TouchableOpacity style={styles.actionButton}>
              <Heart size={20} color="#ff6b9d" />
            </TouchableOpacity>
            <TouchableOpacity style={styles.actionButton}>
              <Share size={20} color="#74b9ff" />
            </TouchableOpacity>
          </View>

          {/* Image Gallery */}
          <View style={styles.galleryContainer}>
            <FlatList
              data={gallery}
              renderItem={renderGalleryImage}
              keyExtractor={(item, index) => `gallery-${index}`}
              horizontal
              showsHorizontalScrollIndicator={false}
              pagingEnabled
            />
            <View style={styles.galleryIndicator}>
              <Text style={styles.indicatorText}>1 / {gallery.length}</Text>
            </View>
          </View>

          {/* Property Info */}
          <View style={styles.contentContainer}>
            {/* Title and Location */}
            <View style={styles.titleSection}>
              <Text style={styles.propertyTitle}>{property.title}</Text>
              <View style={styles.locationRow}>
                <MapPin size={16} color="#a0a9ff" />
                <Text style={styles.locationText}>
                  {property.location}, {property.city}
                </Text>
              </View>
            </View>

            {/* Price and Type */}
            <View style={styles.priceSection}>
              <Text style={styles.priceText}>₹{property.price}</Text>
              <View style={styles.typeStatusRow}>
                <View style={styles.typeBadge}>
                  <Text style={styles.typeText}>{property.type}</Text>
                </View>
                <View style={styles.statusBadge}>
                  <Text style={styles.statusText}>{property.status}</Text>
                </View>
              </View>
            </View>

            {/* Property Features */}
            {property.features && (
              <View style={styles.featuresSection}>
                <Text style={styles.sectionTitle}>Property Features</Text>
                <View style={styles.featuresGrid}>
                  {property.features.bedrooms && (
                    <View style={styles.featureItem}>
                      <View style={styles.featureIcon}>
                        <Bed size={20} color="#6c5ce7" />
                      </View>
                      <Text style={styles.featureLabel}>Bedrooms</Text>
                      <Text style={styles.featureValue}>{property.features.bedrooms}</Text>
                    </View>
                  )}
                  
                  {property.features.bathrooms && (
                    <View style={styles.featureItem}>
                      <View style={styles.featureIcon}>
                        <Bath size={20} color="#6c5ce7" />
                      </View>
                      <Text style={styles.featureLabel}>Bathrooms</Text>
                      <Text style={styles.featureValue}>{property.features.bathrooms}</Text>
                    </View>
                  )}
                  
                  {property.features.area && (
                    <View style={styles.featureItem}>
                      <View style={styles.featureIcon}>
                        <Square size={20} color="#6c5ce7" />
                      </View>
                      <Text style={styles.featureLabel}>Area</Text>
                      <Text style={styles.featureValue}>{property.features.area}</Text>
                    </View>
                  )}
                  
                  {property.features.parking && (
                    <View style={styles.featureItem}>
                      <View style={styles.featureIcon}>
                        <Car size={20} color="#6c5ce7" />
                      </View>
                      <Text style={styles.featureLabel}>Parking</Text>
                      <Text style={styles.featureValue}>{property.features.parking}</Text>
                    </View>
                  )}
                </View>
              </View>
            )}

            {/* Description */}
            <View style={styles.descriptionSection}>
              <Text style={styles.sectionTitle}>Description</Text>
              <Text style={styles.descriptionText}>{property.description}</Text>
            </View>
          </View>
        </ScrollView>

        {/* Bottom Action Bar */}
        <View style={styles.bottomBar}>
          <TouchableOpacity
            style={styles.whatsappButton}
            onPress={handleWhatsAppContact}
            activeOpacity={0.9}
          >
            <LinearGradient
              colors={['#25D366', '#128C7E']}
              style={styles.whatsappGradient}
            >
              <Phone size={20} color="#ffffff" />
              <Text style={styles.whatsappText}>Contact on WhatsApp</Text>
            </LinearGradient>
          </TouchableOpacity>
        </View>
      </LinearGradient>
    </Modal>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingTop: 50,
    paddingBottom: 20,
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    zIndex: 1,
  },
  closeButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(0, 0, 0, 0.6)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  actionButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(0, 0, 0, 0.6)',
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 10,
  },
  galleryContainer: {
    height: 300,
    position: 'relative',
  },
  galleryImage: {
    width: width,
    height: 300,
  },
  galleryIndicator: {
    position: 'absolute',
    bottom: 15,
    right: 15,
    backgroundColor: 'rgba(0, 0, 0, 0.6)',
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 15,
  },
  indicatorText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  contentContainer: {
    paddingHorizontal: 20,
    paddingTop: 20,
  },
  titleSection: {
    marginBottom: 20,
  },
  propertyTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#ffffff',
    marginBottom: 8,
    lineHeight: 30,
  },
  locationRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  locationText: {
    fontSize: 16,
    color: '#a0a9ff',
  },
  priceSection: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 30,
  },
  priceText: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#00ff88',
  },
  typeStatusRow: {
    gap: 10,
  },
  typeBadge: {
    backgroundColor: 'rgba(116, 185, 255, 0.2)',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
  },
  typeText: {
    color: '#74b9ff',
    fontSize: 14,
    fontWeight: '600',
  },
  statusBadge: {
    backgroundColor: 'rgba(0, 255, 136, 0.2)',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
  },
  statusText: {
    color: '#00ff88',
    fontSize: 14,
    fontWeight: '600',
  },
  featuresSection: {
    marginBottom: 30,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#ffffff',
    marginBottom: 15,
  },
  featuresGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 15,
  },
  featureItem: {
    width: (width - 60) / 2,
    backgroundColor: 'rgba(108, 92, 231, 0.1)',
    padding: 15,
    borderRadius: 12,
    alignItems: 'center',
  },
  featureIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(108, 92, 231, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  featureLabel: {
    fontSize: 12,
    color: '#a0a9ff',
    marginBottom: 4,
  },
  featureValue: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#ffffff',
  },
  descriptionSection: {
    marginBottom: 100,
  },
  descriptionText: {
    fontSize: 16,
    color: '#a0a9ff',
    lineHeight: 24,
  },
  bottomBar: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    padding: 20,
    backgroundColor: 'rgba(15, 15, 35, 0.95)',
  },
  whatsappButton: {
    borderRadius: 25,
    overflow: 'hidden',
  },
  whatsappGradient: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 15,
    gap: 10,
  },
  whatsappText: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});