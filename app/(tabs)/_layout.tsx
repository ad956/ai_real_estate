import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Dimensions,
} from 'react-native';
import { Tabs } from 'expo-router';
import { LinearGradient } from 'expo-linear-gradient';
import { Search, Mic, ChevronDown, Download, MessageCircle, Home, PlusSquare, BookOpen, Heart, Users, Calculator, FileText, Bot, TrendingUp, Bell, Phone } from 'lucide-react-native';
import { useRouter, usePathname } from 'expo-router';
import Header from '../../components/Header';
import FloatingActionMenu from '../../components/FloatingActionMenu';

const { width } = Dimensions.get('window');

const topNavItems = [
  { id: 'properties', title: 'Properties', icon: Home, route: '/' },
  { id: 'post', title: 'Post Property', icon: PlusSquare, route: '/post-property' },
  { id: 'stories', title: 'Web Stories', icon: BookOpen, route: '/stories' },
  { id: 'iwant', title: 'I want', icon: Heart, route: '/under-construction' },
  { id: 'developers', title: 'Developers', icon: Users, route: '/under-construction' },
  { id: 'calculator', title: 'EMI Calculator', icon: Calculator, route: '/calculator' },
  { id: 'blog', title: 'Blog', icon: FileText, route: '/blog' },
  { id: 'ai', title: 'Ask AI', icon: Bot, route: '/ai-assistant' },
  { id: 'finance', title: 'AI In Finance Planning', icon: TrendingUp, route: '/under-construction' },
  { id: 'updates', title: 'Updates', icon: Bell, route: '/under-construction' },
];

const propertyTypes = ['Buy', 'Rent', 'Plot', 'Commercial'];

export default function TabLayout() {
  const router = useRouter();
  const pathname = usePathname();
  const [selectedPropertyType, setSelectedPropertyType] = useState('Buy');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedArea, setSelectedArea] = useState('Vadodara');
  const [selectedType, setSelectedType] = useState('Select Property Type');
  const [minPrice, setMinPrice] = useState('Min Price');
  const [maxPrice, setMaxPrice] = useState('Max Price');
  
  const showPropertyFilters = pathname === '/';

  const TopNavigation = () => (
    <View style={styles.topNavContainer}>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.topNavContent}
      >
        {topNavItems.map((item) => {
          const IconComponent = item.icon;
          const isActive = pathname === item.route;
          return (
            <TouchableOpacity 
              key={item.id} 
              style={[styles.topNavItem, isActive && styles.activeTopNavItem]}
              onPress={() => router.push(item.route)}
            >
              <IconComponent size={16} color={isActive ? '#6c5ce7' : '#a0a9ff'} />
              <Text style={[styles.topNavText, isActive && styles.activeTopNavText]}>{item.title}</Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>
    </View>
  );

  const PropertyTypeButtons = () => (
    <View style={styles.propertyTypeContainer}>
      <View style={styles.propertyTypeButtons}>
        {propertyTypes.map((type) => (
          <TouchableOpacity
            key={type}
            style={[
              styles.propertyTypeButton,
              selectedPropertyType === type && styles.selectedPropertyTypeButton,
            ]}
            onPress={() => setSelectedPropertyType(type)}
          >
            <Text
              style={[
                styles.propertyTypeText,
                selectedPropertyType === type && styles.selectedPropertyTypeText,
              ]}
            >
              {type}
            </Text>
          </TouchableOpacity>
        ))}
      </View>
      
      <View style={styles.actionButtons}>
        <TouchableOpacity style={styles.downloadButton}>
          <Download size={16} color="#ffffff" />
          <Text style={styles.downloadText}>Download</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.projectButton}>
          <Text style={styles.projectText}>Project</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.whatsappButton}>
          <MessageCircle size={16} color="#ffffff" />
          <Text style={styles.whatsappText}>WhatsApp</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const SearchSection = () => (
    <View style={styles.searchSection}>
      <View style={styles.searchContainer}>
        <View style={styles.searchInputContainer}>
          <Search size={20} color="#a0a9ff" />
          <TextInput
            style={styles.searchInput}
            placeholder="Search localities or landmarks..."
            placeholderTextColor="#a0a9ff"
            value={searchQuery}
            onChangeText={setSearchQuery}
          />
          <TouchableOpacity style={styles.micButton}>
            <Mic size={18} color="#6c5ce7" />
          </TouchableOpacity>
        </View>
        
        <ScrollView 
          horizontal 
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.filtersRow}
        >
          <TouchableOpacity style={styles.filterButton}>
            <Text style={styles.filterButtonText}>{selectedArea}</Text>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.filterDropdown}>
            <Text style={styles.filterDropdownText}>Select Area</Text>
            <ChevronDown size={16} color="#a0a9ff" />
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.filterDropdown}>
            <Text style={styles.filterDropdownText}>{selectedType}</Text>
            <ChevronDown size={16} color="#a0a9ff" />
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.filterDropdown}>
            <Text style={styles.filterDropdownText}>{minPrice}</Text>
            <ChevronDown size={16} color="#a0a9ff" />
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.filterDropdown}>
            <Text style={styles.filterDropdownText}>{maxPrice}</Text>
            <ChevronDown size={16} color="#a0a9ff" />
          </TouchableOpacity>
        </ScrollView>
        
        <TouchableOpacity style={styles.searchButton}>
          <Search size={20} color="#ffffff" />
        </TouchableOpacity>
      </View>
    </View>
  );

  return (
    <LinearGradient colors={['#0f0f23', '#1a1a2e', '#16213e']} style={styles.container}>
      <Header />
      <TopNavigation />
      {showPropertyFilters && (
        <>
          <PropertyTypeButtons />
          <SearchSection />
        </>
      )}
      
      <Tabs
        screenOptions={{
          headerShown: false,
          tabBarStyle: {
            display: 'none',
          },
        }}>
        <Tabs.Screen name="index" />
        <Tabs.Screen name="stories" />
        <Tabs.Screen name="calculator" />
        <Tabs.Screen name="blog" />
      </Tabs>
      
      <FloatingActionMenu />
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  topNavContainer: {
    paddingBottom: 18,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255, 255, 255, 0.15)',
  },
  topNavContent: {
    paddingHorizontal: 20,
    gap: 20,
  },
  topNavItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
    paddingVertical: 10,
    paddingHorizontal: 16,
    borderRadius: 20,
    minWidth: 100,
  },
  activeTopNavItem: {
    backgroundColor: 'rgba(108, 92, 231, 0.25)',
    borderWidth: 1,
    borderColor: 'rgba(108, 92, 231, 0.4)',
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 3,
  },
  topNavText: {
    color: '#a0a9ff',
    fontSize: 13,
    fontWeight: '600',
  },
  activeTopNavText: {
    color: '#ffffff',
    fontWeight: '700',
  },
  propertyTypeContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 18,
  },
  propertyTypeButtons: {
    flexDirection: 'row',
    gap: 12,
  },
  propertyTypeButton: {
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 25,
    backgroundColor: 'rgba(108, 92, 231, 0.2)',
    borderWidth: 1.5,
    borderColor: 'rgba(108, 92, 231, 0.3)',
  },
  selectedPropertyTypeButton: {
    backgroundColor: '#6c5ce7',
    borderColor: '#6c5ce7',
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 6,
  },
  propertyTypeText: {
    color: '#a0a9ff',
    fontSize: 14,
    fontWeight: '700',
  },
  selectedPropertyTypeText: {
    color: '#ffffff',
  },
  actionButtons: {
    flexDirection: 'row',
    gap: 8,
  },
  downloadButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: '#6c5ce7',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 18,
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 4,
  },
  downloadText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },
  projectButton: {
    backgroundColor: '#ff6b35',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 18,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#ff6b35',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 4,
  },
  projectText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },
  whatsappButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: '#25D366',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 18,
    shadowColor: '#25D366',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 4,
  },
  whatsappText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },

  searchSection: {
    paddingHorizontal: 20,
    paddingVertical: 15,
    marginBottom: 10,
  },
  searchContainer: {
    backgroundColor: 'rgba(255, 255, 255, 0.98)',
    borderRadius: 20,
    padding: 18,
    position: 'relative',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 12,
    elevation: 8,
  },
  searchInputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 15,
    paddingBottom: 15,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(160, 169, 255, 0.2)',
  },
  searchInput: {
    flex: 1,
    marginLeft: 15,
    color: '#333333',
    fontSize: 16,
    fontWeight: '500',
  },
  micButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(108, 92, 231, 0.15)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  filtersRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
    paddingRight: 60,
  },
  filterButton: {
    backgroundColor: '#ff6b35',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 16,
    shadowColor: '#ff6b35',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 4,
  },
  filterButtonText: {
    color: '#ffffff',
    fontSize: 13,
    fontWeight: '700',
  },
  filterDropdown: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: 'rgba(160, 169, 255, 0.1)',
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 16,
    borderWidth: 1.5,
    borderColor: 'rgba(160, 169, 255, 0.3)',
  },
  filterDropdownText: {
    color: '#666666',
    fontSize: 13,
    fontWeight: '500',
  },
  searchButton: {
    position: 'absolute',
    right: 18,
    bottom: 18,
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: '#6c5ce7',
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.4,
    shadowRadius: 8,
    elevation: 8,
  },
});