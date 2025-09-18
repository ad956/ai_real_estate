import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, ScrollView } from 'react-native';
import { Home, PlusSquare, BookOpen, Heart, Users, Calculator, FileText, Bot, TrendingUp, Bell } from 'lucide-react-native';

const navigationItems = [
  { id: 'properties', title: 'Properties', icon: Home, route: 'index' },
  { id: 'post', title: 'Post Property', icon: PlusSquare, route: 'post' },
  { id: 'stories', title: 'Web Stories', icon: BookOpen, route: 'stories' },
  { id: 'iwant', title: 'I want', icon: Heart, route: 'iwant' },
  { id: 'developers', title: 'Developers', icon: Users, route: 'developers' },
  { id: 'calculator', title: 'EMI Calculator', icon: Calculator, route: 'calculator' },
  { id: 'blog', title: 'Blog', icon: FileText, route: 'blog' },
  { id: 'ai', title: 'Ask AI', icon: Bot, route: 'ai' },
  { id: 'finance', title: 'AI In Finance Planning', icon: TrendingUp, route: 'finance' },
  { id: 'updates', title: 'Updates', icon: Bell, route: 'updates' },
];

interface NavigationTabsProps {
  activeRoute?: string;
  onNavigate?: (route: string) => void;
}

export default function NavigationTabs({ activeRoute = 'index', onNavigate }: NavigationTabsProps) {
  return (
    <View style={styles.container}>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.scrollContent}
      >
        {navigationItems.map((item) => {
          const IconComponent = item.icon;
          const isActive = activeRoute === item.route;
          
          return (
            <TouchableOpacity
              key={item.id}
              style={[styles.navItem, isActive && styles.activeNavItem]}
              onPress={() => onNavigate?.(item.route)}
            >
              <IconComponent 
                size={16} 
                color={isActive ? '#6c5ce7' : '#a0a9ff'} 
              />
              <Text style={[styles.navText, isActive && styles.activeNavText]}>
                {item.title}
              </Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255, 255, 255, 0.1)',
    paddingVertical: 15,
  },
  scrollContent: {
    paddingHorizontal: 20,
    gap: 25,
  },
  navItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    paddingVertical: 8,
    paddingHorizontal: 12,
    borderRadius: 15,
  },
  activeNavItem: {
    backgroundColor: 'rgba(108, 92, 231, 0.2)',
  },
  navText: {
    color: '#a0a9ff',
    fontSize: 14,
    fontWeight: '500',
  },
  activeNavText: {
    color: '#6c5ce7',
    fontWeight: '600',
  },
});