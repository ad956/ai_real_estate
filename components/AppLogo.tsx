import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

interface AppLogoProps {
  size?: 'small' | 'medium' | 'large';
}

export default function AppLogo({ size = 'medium' }: AppLogoProps) {
  const textSize = size === 'small' ? 20 : size === 'large' ? 36 : 28;
  const subTextSize = size === 'small' ? 10 : size === 'large' ? 16 : 14;

  return (
    <View style={styles.logoContainer}>
      <View style={styles.logoText}>
        <View style={styles.mainTextContainer}>
          <Text style={[styles.logoMainText, { fontSize: textSize }]}>Ai</Text>
          <Text style={[styles.logoSubText, { fontSize: subTextSize }]}>in</Text>
          <Text style={[styles.logoStar, { fontSize: subTextSize }]}>★</Text>
        </View>
        <Text style={[styles.logoBottomText, { fontSize: subTextSize }]}>Real Estate.in</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  logoContainer: {
    alignItems: 'flex-start',
  },
  logoText: {
    alignItems: 'flex-start',
  },
  mainTextContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: 2,
  },
  logoMainText: {
    fontWeight: 'bold',
    color: '#6c5ce7',
    textShadowColor: 'rgba(108, 92, 231, 0.3)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  logoSubText: {
    color: '#ff6b35',
    fontWeight: '600',
    marginTop: 2,
  },
  logoStar: {
    color: '#ff6b35',
    fontWeight: 'bold',
    marginTop: -2,
  },
  logoBottomText: {
    color: '#ffffff',
    marginTop: -4,
    fontWeight: '500',
  },
});