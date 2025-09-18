import React from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Linking,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { MessageCircle, Phone, ChevronDown, Menu } from 'lucide-react-native';
import AppLogo from './AppLogo';

export default function Header() {
  const handleWhatsApp = () => {
    Linking.openURL('https://api.whatsapp.com/send/?phone=&text=Hello%20AI%20in%20Real%20Estate&type=phone_number&app_absent=0');
  };

  const handleCall = () => {
    Linking.openURL('tel:+919876543210');
  };

  const handleLogin = () => {
    console.log('Login pressed');
  };

  return (
    <LinearGradient
      colors={['#0f0f23', '#1a1a2e', '#16213e']}
      style={styles.header}
    >
      <View style={styles.headerContent}>
        <View style={styles.leftSection}>
          <TouchableOpacity style={styles.menuButton}>
            <Menu size={20} color="#ffffff" />
          </TouchableOpacity>
          <AppLogo size="medium" />
        </View>

        <View style={styles.rightActions}>
          <TouchableOpacity style={styles.actionButton} onPress={handleWhatsApp}>
            <MessageCircle size={18} color="#25D366" />
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.actionButton} onPress={handleCall}>
            <Phone size={18} color="#ff6b35" />
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.languageButton}>
            <Text style={styles.languageText}>Gujarati</Text>
            <ChevronDown size={16} color="#ffffff" />
          </TouchableOpacity>
        </View>
      </View>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  header: {
    paddingTop: 50,
    paddingBottom: 15,
    paddingHorizontal: 20,
  },
  headerContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  leftSection: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 15,
  },
  menuButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  rightActions: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  actionButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.15)',
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  languageButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 14,
    paddingVertical: 10,
    borderRadius: 20,
    borderWidth: 1.5,
    borderColor: 'rgba(255, 255, 255, 0.3)',
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    gap: 6,
  },
  languageText: {
    color: '#ffffff',
    fontSize: 13,
    fontWeight: '600',
  },
});