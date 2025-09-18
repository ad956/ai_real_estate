import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Animated,
  Linking,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Plus, MessageCircle, Phone, PlusSquare, X, Bot } from 'lucide-react-native';

export default function FloatingActionMenu() {
  const [isOpen, setIsOpen] = useState(false);
  const [animation] = useState(new Animated.Value(0));

  const toggleMenu = () => {
    const toValue = isOpen ? 0 : 1;
    
    Animated.spring(animation, {
      toValue,
      useNativeDriver: true,
      tension: 100,
      friction: 8,
    }).start();
    
    setIsOpen(!isOpen);
  };

  const handleWhatsApp = () => {
    const message = 'Hello! I want to inquire about properties.';
    const whatsappUrl = `https://api.whatsapp.com/send/?phone=&text=${encodeURIComponent(message)}&type=phone_number&app_absent=0`;
    Linking.openURL(whatsappUrl);
    toggleMenu();
  };

  const handleCall = () => {
    Linking.openURL('tel:+919876543210');
    toggleMenu();
  };

  const handlePostProperty = () => {
    console.log('Post property');
    toggleMenu();
  };

  const handleAskAI = () => {
    console.log('Ask AI');
    toggleMenu();
  };

  const menuItems = [
    {
      icon: MessageCircle,
      label: 'WhatsApp',
      color: '#25D366',
      onPress: handleWhatsApp,
    },
    {
      icon: Phone,
      label: 'Call',
      color: '#ff6b35',
      onPress: handleCall,
    },
    {
      icon: PlusSquare,
      label: 'Post Property',
      color: '#6c5ce7',
      onPress: handlePostProperty,
    },
    {
      icon: Bot,
      label: 'Ask AI',
      color: '#74b9ff',
      onPress: handleAskAI,
    },
  ];

  return (
    <View style={styles.container}>
      {/* Menu Items */}
      {menuItems.map((item, index) => {
        const IconComponent = item.icon;
        const translateY = animation.interpolate({
          inputRange: [0, 1],
          outputRange: [0, -(60 * (index + 1))],
        });
        
        const scale = animation.interpolate({
          inputRange: [0, 1],
          outputRange: [0, 1],
        });

        return (
          <Animated.View
            key={item.label}
            style={[
              styles.menuItem,
              {
                transform: [{ translateY }, { scale }],
              },
            ]}
          >
            <TouchableOpacity
              style={[styles.menuButton, { backgroundColor: item.color }]}
              onPress={item.onPress}
              activeOpacity={0.9}
            >
              <IconComponent size={20} color="#ffffff" />
            </TouchableOpacity>
            <Text style={styles.menuLabel}>{item.label}</Text>
          </Animated.View>
        );
      })}

      {/* Main FAB */}
      <TouchableOpacity
        style={styles.fab}
        onPress={toggleMenu}
        activeOpacity={0.9}
      >
        <LinearGradient
          colors={['#6c5ce7', '#5a4fcf']}
          style={styles.fabGradient}
        >
          <Animated.View
            style={{
              transform: [
                {
                  rotate: animation.interpolate({
                    inputRange: [0, 1],
                    outputRange: ['0deg', '45deg'],
                  }),
                },
              ],
            }}
          >
            {isOpen ? (
              <X size={24} color="#ffffff" />
            ) : (
              <Plus size={24} color="#ffffff" />
            )}
          </Animated.View>
        </LinearGradient>
      </TouchableOpacity>

      {/* Backdrop */}
      {isOpen && (
        <Animated.View
          style={[
            styles.backdrop,
            {
              opacity: animation.interpolate({
                inputRange: [0, 1],
                outputRange: [0, 0.3],
              }),
            },
          ]}
        >
          <TouchableOpacity
            style={StyleSheet.absoluteFillObject}
            onPress={toggleMenu}
            activeOpacity={1}
          />
        </Animated.View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    bottom: 30,
    right: 20,
    zIndex: 1000,
  },
  fab: {
    width: 56,
    height: 56,
    borderRadius: 28,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 12,
  },
  fabGradient: {
    width: '100%',
    height: '100%',
    borderRadius: 28,
    justifyContent: 'center',
    alignItems: 'center',
  },
  menuItem: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  menuButton: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 8,
  },
  menuLabel: {
    backgroundColor: 'rgba(0, 0, 0, 0.8)',
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 8,
    overflow: 'hidden',
  },
  backdrop: {
    position: 'absolute',
    top: -1000,
    left: -1000,
    right: -100,
    bottom: -100,
    backgroundColor: '#000000',
    zIndex: -1,
  },
});