import React, { useEffect, useRef } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Animated,
  Dimensions,
  TouchableOpacity,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Construction, ArrowLeft, Wrench, Hammer } from 'lucide-react-native';
import { useRouter } from 'expo-router';

const { width, height } = Dimensions.get('window');

interface UnderConstructionProps {
  title?: string;
  message?: string;
}

export default function UnderConstruction({ 
  title = "Under Construction", 
  message = "This page is being built with care. Check back soon!" 
}: UnderConstructionProps) {
  const router = useRouter();
  const bounceAnim = useRef(new Animated.Value(0)).current;
  const rotateAnim = useRef(new Animated.Value(0)).current;
  const fadeAnim = useRef(new Animated.Value(0)).current;
  const scaleAnim = useRef(new Animated.Value(0.8)).current;

  useEffect(() => {
    // Bounce animation for main icon
    const bounceAnimation = Animated.loop(
      Animated.sequence([
        Animated.timing(bounceAnim, {
          toValue: -20,
          duration: 1000,
          useNativeDriver: true,
        }),
        Animated.timing(bounceAnim, {
          toValue: 0,
          duration: 1000,
          useNativeDriver: true,
        }),
      ])
    );

    // Rotation animation for tools
    const rotateAnimation = Animated.loop(
      Animated.timing(rotateAnim, {
        toValue: 1,
        duration: 3000,
        useNativeDriver: true,
      })
    );

    // Fade in animation
    const fadeAnimation = Animated.timing(fadeAnim, {
      toValue: 1,
      duration: 1500,
      useNativeDriver: true,
    });

    // Scale animation
    const scaleAnimation = Animated.spring(scaleAnim, {
      toValue: 1,
      tension: 50,
      friction: 7,
      useNativeDriver: true,
    });

    bounceAnimation.start();
    rotateAnimation.start();
    fadeAnimation.start();
    scaleAnimation.start();

    return () => {
      bounceAnimation.stop();
      rotateAnimation.stop();
    };
  }, []);

  const rotateInterpolate = rotateAnim.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg'],
  });

  return (
    <LinearGradient colors={['#0f0f23', '#1a1a2e', '#16213e']} style={styles.container}>
      <TouchableOpacity style={styles.backButton} onPress={() => router.back()}>
        <ArrowLeft size={24} color="#ffffff" />
      </TouchableOpacity>

      <Animated.View 
        style={[
          styles.content,
          {
            opacity: fadeAnim,
            transform: [{ scale: scaleAnim }],
          },
        ]}
      >
        {/* Animated Construction Icon */}
        <Animated.View
          style={[
            styles.iconContainer,
            {
              transform: [{ translateY: bounceAnim }],
            },
          ]}
        >
          <View style={styles.mainIcon}>
            <Construction size={80} color="#6c5ce7" />
          </View>
          
          {/* Rotating Tools */}
          <Animated.View
            style={[
              styles.toolIcon,
              styles.tool1,
              {
                transform: [{ rotate: rotateInterpolate }],
              },
            ]}
          >
            <Wrench size={24} color="#ff6b35" />
          </Animated.View>
          
          <Animated.View
            style={[
              styles.toolIcon,
              styles.tool2,
              {
                transform: [{ rotate: rotateInterpolate }],
              },
            ]}
          >
            <Hammer size={24} color="#74b9ff" />
          </Animated.View>
        </Animated.View>

        {/* Title */}
        <Text style={styles.title}>{title}</Text>
        
        {/* Message */}
        <Text style={styles.message}>{message}</Text>
        
        {/* Progress Dots */}
        <View style={styles.progressContainer}>
          <View style={styles.progressDots}>
            {[0, 1, 2].map((index) => (
              <Animated.View
                key={index}
                style={[
                  styles.dot,
                  {
                    opacity: fadeAnim,
                    transform: [
                      {
                        scale: bounceAnim.interpolate({
                          inputRange: [-20, 0],
                          outputRange: [1.2, 1],
                          extrapolate: 'clamp',
                        }),
                      },
                    ],
                  },
                ]}
              />
            ))}
          </View>
          <Text style={styles.progressText}>Building something amazing...</Text>
        </View>

        {/* Back Button */}
        <TouchableOpacity style={styles.homeButton} onPress={() => router.push('/')}>
          <Text style={styles.homeButtonText}>Go to Home</Text>
        </TouchableOpacity>
      </Animated.View>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 20,
  },
  backButton: {
    position: 'absolute',
    top: 50,
    left: 20,
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 1,
  },
  content: {
    alignItems: 'center',
    width: '100%',
  },
  iconContainer: {
    position: 'relative',
    marginBottom: 40,
    width: 120,
    height: 120,
    justifyContent: 'center',
    alignItems: 'center',
  },
  mainIcon: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: 'rgba(108, 92, 231, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#6c5ce7',
  },
  toolIcon: {
    position: 'absolute',
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  tool1: {
    top: -10,
    right: -10,
  },
  tool2: {
    bottom: -10,
    left: -10,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#ffffff',
    textAlign: 'center',
    marginBottom: 16,
  },
  message: {
    fontSize: 16,
    color: '#a0a9ff',
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 40,
    paddingHorizontal: 20,
  },
  progressContainer: {
    alignItems: 'center',
    marginBottom: 40,
  },
  progressDots: {
    flexDirection: 'row',
    gap: 8,
    marginBottom: 12,
  },
  dot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#6c5ce7',
  },
  progressText: {
    fontSize: 14,
    color: '#74b9ff',
    fontStyle: 'italic',
  },
  homeButton: {
    backgroundColor: '#6c5ce7',
    paddingHorizontal: 32,
    paddingVertical: 16,
    borderRadius: 25,
    elevation: 5,
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
  },
  homeButtonText: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '600',
  },
});