import React, { useEffect, useRef } from 'react';
import { View, Text, StyleSheet, Animated, Easing } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';

interface LoadingSpinnerProps {
  message?: string;
  size?: 'small' | 'large';
}

export default function LoadingSpinner({ message = 'Loading...', size = 'large' }: LoadingSpinnerProps) {
  const spinValue = useRef(new Animated.Value(0)).current;
  const scaleValue = useRef(new Animated.Value(0.8)).current;
  const opacityValue = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.parallel([
      Animated.timing(scaleValue, {
        toValue: 1,
        duration: 300,
        easing: Easing.out(Easing.back(1.2)),
        useNativeDriver: true,
      }),
      Animated.timing(opacityValue, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }),
    ]).start();

    const spinAnimation = Animated.loop(
      Animated.timing(spinValue, {
        toValue: 1,
        duration: 2000,
        easing: Easing.linear,
        useNativeDriver: true,
      })
    );
    spinAnimation.start();

    return () => spinAnimation.stop();
  }, []);

  const spin = spinValue.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg'],
  });

  const spinnerSize = size === 'large' ? 60 : 40;
  const centerSize = size === 'large' ? 40 : 26;

  return (
    <Animated.View 
      style={[
        styles.container,
        {
          opacity: opacityValue,
          transform: [{ scale: scaleValue }],
        },
      ]}
    >
      <LinearGradient
        colors={['rgba(108, 92, 231, 0.15)', 'rgba(116, 185, 255, 0.15)']}
        style={styles.loadingCard}
      >
        <View style={[styles.spinnerContainer, { width: spinnerSize, height: spinnerSize }]}>
          <Animated.View
            style={[
              styles.spinner,
              {
                width: spinnerSize,
                height: spinnerSize,
                borderRadius: spinnerSize / 2,
                transform: [{ rotate: spin }],
              },
            ]}
          >
            <LinearGradient
              colors={['#6c5ce7', '#74b9ff']}
              style={[styles.spinnerGradient, { borderRadius: spinnerSize / 2 }]}
            />
          </Animated.View>
          <View style={[styles.spinnerCenter, { width: centerSize, height: centerSize, borderRadius: centerSize / 2 }]} />
        </View>
        <Text style={styles.message}>{message}</Text>
      </LinearGradient>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  loadingCard: {
    padding: 30,
    borderRadius: 25,
    alignItems: 'center',
    gap: 20,
    minWidth: 200,
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.3,
    shadowRadius: 16,
    elevation: 12,
  },
  spinnerContainer: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  spinner: {
    position: 'absolute',
  },
  spinnerGradient: {
    width: '100%',
    height: '100%',
    borderWidth: 4,
    borderColor: 'transparent',
    borderTopColor: '#6c5ce7',
    borderRightColor: '#74b9ff',
  },
  spinnerCenter: {
    backgroundColor: 'rgba(108, 92, 231, 0.2)',
  },
  message: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '700',
    textAlign: 'center',
    letterSpacing: 0.5,
  },
});