import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Animated,
  TouchableOpacity,
  Dimensions,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { CheckCircle, AlertCircle, Info, X } from 'lucide-react-native';

const { width } = Dimensions.get('window');

interface ToastNotificationProps {
  visible: boolean;
  message: string;
  type?: 'success' | 'error' | 'info';
  duration?: number;
  onHide?: () => void;
}

export default function ToastNotification({
  visible,
  message,
  type = 'success',
  duration = 3000,
  onHide,
}: ToastNotificationProps) {
  const [slideAnim] = useState(new Animated.Value(-100));

  useEffect(() => {
    if (visible) {
      // Slide in
      Animated.spring(slideAnim, {
        toValue: 0,
        useNativeDriver: true,
        tension: 100,
        friction: 8,
      }).start();

      // Auto hide
      const timer = setTimeout(() => {
        hideToast();
      }, duration);

      return () => clearTimeout(timer);
    }
  }, [visible]);

  const hideToast = () => {
    Animated.timing(slideAnim, {
      toValue: -100,
      duration: 300,
      useNativeDriver: true,
    }).start(() => {
      onHide?.();
    });
  };

  const getIcon = () => {
    switch (type) {
      case 'success':
        return <CheckCircle size={20} color="#ffffff" />;
      case 'error':
        return <AlertCircle size={20} color="#ffffff" />;
      default:
        return <Info size={20} color="#ffffff" />;
    }
  };

  const getColors = () => {
    switch (type) {
      case 'success':
        return ['#00ff88', '#00cc6a'];
      case 'error':
        return ['#ff6b9d', '#e55a87'];
      default:
        return ['#74b9ff', '#0984e3'];
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
      <LinearGradient colors={getColors()} style={styles.toast}>
        <View style={styles.content}>
          <View style={styles.iconContainer}>
            {getIcon()}
          </View>
          
          <Text style={styles.message} numberOfLines={2}>
            {message}
          </Text>
          
          <TouchableOpacity style={styles.closeButton} onPress={hideToast}>
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
    zIndex: 1001,
    paddingTop: 50,
    paddingHorizontal: 20,
  },
  toast: {
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
    padding: 16,
    gap: 12,
  },
  iconContainer: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  message: {
    flex: 1,
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '600',
    lineHeight: 18,
  },
  closeButton: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
});