import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Animated,
  Dimensions,
  Linking,
} from 'react-native';
import { MessageCircle, X, Phone, Bell } from 'lucide-react-native';
import { LinearGradient } from 'expo-linear-gradient';

const { width } = Dimensions.get('window');

interface NotificationBannerProps {
  type?: 'whatsapp' | 'call' | 'info';
  message: string;
  actionText?: string;
  onAction?: () => void;
  onClose?: () => void;
  autoHide?: boolean;
  duration?: number;
}

export default function NotificationBanner({
  type = 'whatsapp',
  message,
  actionText,
  onAction,
  onClose,
  autoHide = true,
  duration = 5000,
}: NotificationBannerProps) {
  const [visible, setVisible] = useState(true);
  const slideAnim = new Animated.Value(-100);

  useEffect(() => {
    // Slide in animation
    Animated.spring(slideAnim, {
      toValue: 0,
      useNativeDriver: true,
      tension: 100,
      friction: 8,
    }).start();

    // Auto hide
    if (autoHide) {
      const timer = setTimeout(() => {
        handleClose();
      }, duration);
      return () => clearTimeout(timer);
    }
  }, []);

  const handleClose = () => {
    Animated.timing(slideAnim, {
      toValue: -100,
      duration: 300,
      useNativeDriver: true,
    }).start(() => {
      setVisible(false);
      onClose?.();
    });
  };

  const handleAction = () => {
    if (type === 'whatsapp') {
      const whatsappUrl = 'https://api.whatsapp.com/send/?phone=&text=Hello%20AI%20in%20Real%20Estate&type=phone_number&app_absent=0';
      Linking.openURL(whatsappUrl);
    } else if (type === 'call') {
      Linking.openURL('tel:+919876543210');
    }
    onAction?.();
  };

  const getIcon = () => {
    switch (type) {
      case 'whatsapp':
        return <MessageCircle size={20} color="#ffffff" />;
      case 'call':
        return <Phone size={20} color="#ffffff" />;
      default:
        return <Bell size={20} color="#ffffff" />;
    }
  };

  const getColors = () => {
    switch (type) {
      case 'whatsapp':
        return ['#25D366', '#128C7E'];
      case 'call':
        return ['#ff6b35', '#e55a2b'];
      default:
        return ['#6c5ce7', '#5a4fcf'];
    }
  };

  if (!visible) return null;

  return (
    <Animated.View
      style={[
        styles.container,
        {
          transform: [{ translateY: slideAnim }],
        },
      ]}
    >
      <LinearGradient colors={getColors()} style={styles.banner}>
        <View style={styles.content}>
          <View style={styles.iconContainer}>
            {getIcon()}
          </View>
          
          <View style={styles.textContainer}>
            <Text style={styles.message} numberOfLines={2}>
              {message}
            </Text>
          </View>
          
          {actionText && (
            <TouchableOpacity style={styles.actionButton} onPress={handleAction}>
              <Text style={styles.actionText}>{actionText}</Text>
            </TouchableOpacity>
          )}
          
          <TouchableOpacity style={styles.closeButton} onPress={handleClose}>
            <X size={18} color="#ffffff" />
          </TouchableOpacity>
        </View>
      </LinearGradient>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    zIndex: 1000,
    paddingTop: 50,
    paddingHorizontal: 15,
  },
  banner: {
    borderRadius: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 10,
  },
  content: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 15,
    gap: 12,
  },
  iconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  textContainer: {
    flex: 1,
  },
  message: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '600',
    lineHeight: 18,
  },
  actionButton: {
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: 'rgba(255, 255, 255, 0.3)',
  },
  actionText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },
  closeButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
});