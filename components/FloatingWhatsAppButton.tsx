import React from 'react';
import { TouchableOpacity, Text, StyleSheet, Linking } from 'react-native';
import { MessageCircle, X } from 'lucide-react-native';

interface FloatingWhatsAppButtonProps {
  visible?: boolean;
  onClose?: () => void;
}

export default function FloatingWhatsAppButton({ visible = true, onClose }: FloatingWhatsAppButtonProps) {
  const handleWhatsApp = () => {
    const message = 'Hello! I want to post my property through WhatsApp.';
    const whatsappUrl = `https://api.whatsapp.com/send/?phone=&text=${encodeURIComponent(message)}&type=phone_number&app_absent=0`;
    Linking.openURL(whatsappUrl);
  };

  if (!visible) return null;

  return (
    <TouchableOpacity style={styles.floatingButton} onPress={handleWhatsApp} activeOpacity={0.9}>
      <MessageCircle size={16} color="#ffffff" />
      <Text style={styles.buttonText}>Post Property through WhatsApp</Text>
      {onClose && (
        <TouchableOpacity style={styles.closeButton} onPress={onClose}>
          <X size={14} color="#ffffff" />
        </TouchableOpacity>
      )}
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  floatingButton: {
    position: 'absolute',
    top: 120,
    right: 20,
    backgroundColor: '#25D366',
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 25,
    gap: 8,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
    zIndex: 1000,
  },
  buttonText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  closeButton: {
    marginLeft: 5,
  },
});