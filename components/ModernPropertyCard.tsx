import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Image,
  Dimensions,
  Linking,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { MapPin, Heart, Share2, MessageCircle, Phone, Eye, Bed, Bath, Square } from 'lucide-react-native';

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

interface ModernPropertyCardProps {
  property: Property;
  onPress?: () => void;
  style?: any;
}

export default function ModernPropertyCard({ property, onPress, style }: ModernPropertyCardProps) {
  const [imageSource, setImageSource] = useState(property.image);
  const [liked, setLiked] = useState(false);

  const handleWhatsApp = () => {
    const message = `🏠 Property: ${property.title}%0A💰 Price: ${property.price}%0A📍 Location: ${property.location}, ${property.city}`;
    const whatsappUrl = `https://api.whatsapp.com/send/?phone=&text=${message}&type=phone_number&app_absent=0`;
    Linking.openURL(whatsappUrl);
  };

  const handleCall = () => {
    Linking.openURL('tel:+919876543210');
  };

  const handleShare = () => {
    // Share functionality
    console.log('Share property:', property.id);
  };

  const getStatusColor = () => {
    switch (property.status) {
      case 'For Sale':
        return '#00ff88';
      case 'Under Construction':
        return '#ff6b35';
      case 'Ready To Move':
        return '#74b9ff';
      default:
        return '#6c5ce7';
    }
  };

  return (
    <TouchableOpacity
      style={[styles.card, style]}
      onPress={onPress}
      activeOpacity={0.95}
    >
      <View style={styles.imageContainer}>
        <Image
          source={{ uri: imageSource }}
          style={styles.image}
          onError={() => {
            if (imageSource !== property.fallbackImage) {
              setImageSource(property.fallbackImage);
            }
          }}
        />
        
        {/* Image Overlay */}
        <LinearGradient
          colors={['transparent', 'rgba(0,0,0,0.8)']}
          style={styles.imageOverlay}
        />
        
        {/* Top Badges */}
        <View style={styles.topBadges}>
          <View style={[styles.statusBadge, { backgroundColor: getStatusColor() }]}>
            <Text style={styles.statusText}>{property.status}</Text>
          </View>
          
          <TouchableOpacity
            style={[styles.heartButton, liked && styles.heartButtonLiked]}
            onPress={() => setLiked(!liked)}
          >
            <Heart size={16} color={liked ? '#ff6b9d' : '#ffffff'} fill={liked ? '#ff6b9d' : 'transparent'} />
          </TouchableOpacity>
        </View>
        
        {/* Property Details Overlay */}
        <View style={styles.overlayContent}>
          <Text style={styles.title} numberOfLines={2}>
            {property.title}
          </Text>
          
          <View style={styles.locationRow}>
            <MapPin size={14} color="#a0a9ff" />
            <Text style={styles.location} numberOfLines={1}>
              {property.location}, {property.city}
            </Text>
          </View>
          
          <Text style={styles.price}>₹{property.price}</Text>
          
          {/* Property Features */}
          <View style={styles.features}>
            {property.area && property.area !== 'N/A' && (
              <View style={styles.feature}>
                <Square size={12} color="#a0a9ff" />
                <Text style={styles.featureText}>{property.area} SqFt</Text>
              </View>
            )}
            {property.bedrooms > 0 && (
              <View style={styles.feature}>
                <Bed size={12} color="#a0a9ff" />
                <Text style={styles.featureText}>{property.bedrooms} BHK</Text>
              </View>
            )}
            {property.bathrooms > 0 && (
              <View style={styles.feature}>
                <Bath size={12} color="#a0a9ff" />
                <Text style={styles.featureText}>{property.bathrooms} Bath</Text>
              </View>
            )}
          </View>
        </View>
      </View>
      
      {/* Action Buttons */}
      <View style={styles.actionButtons}>
        <TouchableOpacity style={styles.actionButton} onPress={handleShare}>
          <Share2 size={16} color="#6c5ce7" />
        </TouchableOpacity>
        
        <TouchableOpacity style={[styles.actionButton, styles.callButton]} onPress={handleCall}>
          <Phone size={16} color="#ffffff" />
        </TouchableOpacity>
        
        <TouchableOpacity style={[styles.actionButton, styles.whatsappButton]} onPress={handleWhatsApp}>
          <MessageCircle size={16} color="#ffffff" />
        </TouchableOpacity>
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  card: {
    width: width * 0.85,
    backgroundColor: '#ffffff',
    borderRadius: 20,
    marginHorizontal: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.15,
    shadowRadius: 16,
    elevation: 12,
    overflow: 'hidden',
  },
  imageContainer: {
    height: 240,
    position: 'relative',
  },
  image: {
    width: '100%',
    height: '100%',
    backgroundColor: '#f0f0f0',
  },
  imageOverlay: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    height: '60%',
  },
  topBadges: {
    position: 'absolute',
    top: 15,
    left: 15,
    right: 15,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
  },
  statusBadge: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 5,
  },
  statusText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },
  heartButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(0, 0, 0, 0.3)',
    justifyContent: 'center',
    alignItems: 'center',
    backdropFilter: 'blur(10px)',
  },
  heartButtonLiked: {
    backgroundColor: 'rgba(255, 107, 157, 0.2)',
  },
  overlayContent: {
    position: 'absolute',
    bottom: 15,
    left: 15,
    right: 15,
  },
  title: {
    fontSize: 18,
    fontWeight: '700',
    color: '#ffffff',
    marginBottom: 6,
    lineHeight: 22,
  },
  locationRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    marginBottom: 8,
  },
  location: {
    fontSize: 13,
    color: '#a0a9ff',
    flex: 1,
  },
  price: {
    fontSize: 20,
    fontWeight: '800',
    color: '#00ff88',
    marginBottom: 10,
  },
  features: {
    flexDirection: 'row',
    gap: 15,
  },
  feature: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  featureText: {
    fontSize: 12,
    color: '#a0a9ff',
    fontWeight: '500',
  },
  actionButtons: {
    flexDirection: 'row',
    padding: 15,
    gap: 10,
    backgroundColor: '#ffffff',
  },
  actionButton: {
    flex: 1,
    height: 44,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(108, 92, 231, 0.1)',
    borderWidth: 1,
    borderColor: 'rgba(108, 92, 231, 0.2)',
  },
  callButton: {
    backgroundColor: '#ff6b35',
    borderColor: '#ff6b35',
  },
  whatsappButton: {
    backgroundColor: '#25D366',
    borderColor: '#25D366',
  },
});