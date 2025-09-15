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
import { Search, Mic, ChevronDown, Download, MessageCircle, Chrome as Home, SquarePlus as PlusSquare, BookOpen, Heart, Users, Calculator, FileText, Bot, TrendingUp, Bell } from 'lucide-react-native';

const { width } = Dimensions.get('window');

const topNavItems = [
  { id: 'properties', title: 'Properties', icon: Home },
  { id: 'post', title: 'Post Property', icon: PlusSquare },
  { id: 'stories', title: 'Web Stories', icon: BookOpen },
  { id: 'iwant', title: 'I want', icon: Heart },
  { id: 'developers', title: 'Developers', icon: Users },
  { id: 'calculator', title: 'EMI Calculator', icon: Calculator },
  { id: 'blog', title: 'Blog', icon: FileText },
  { id: 'ai', title: 'Ask AI', icon: Bot },
  { id: 'finance', title: 'AI In Finance Planning', icon: TrendingUp },
  { id: 'updates', title: 'Updates', icon: Bell },
];

const propertyTypes = ['Buy', 'Rent', 'Plot', 'Commercial'];

export default function TabLayout() {
  const [selectedPropertyType, setSelectedPropertyType] = useState('Buy');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedArea, setSelectedArea] = useState('Vadodara');
  const [selectedType, setSelectedType] = useState('Select Property Type');
  const [minPrice, setMinPrice] = useState('Min Price');
  const [maxPrice, setMaxPrice] = useState('Max Price');

  const TopNavigation = () => (
    <View style={styles.topNavContainer}>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.topNavContent}
      >
        {topNavItems.map((item) => {
          const IconComponent = item.icon;
          return (
            <TouchableOpacity key={item.id} style={styles.topNavItem}>
              <IconComponent size={16} color="#a0a9ff" />
              <Text style={styles.topNavText}>{item.title}</Text>
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
        
        <TouchableOpacity style={styles.callButton}>
          <Text style={styles.callText}>📞</Text>
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
        
        <View style={styles.filtersRow}>
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
        </View>
        
        <TouchableOpacity style={styles.searchButton}>
          <Search size={20} color="#ffffff" />
        </TouchableOpacity>
      </View>
    </View>
  );

  return (
    <LinearGradient colors={['#0f0f23', '#1a1a2e', '#16213e']} style={styles.container}>
      <TopNavigation />
      <PropertyTypeButtons />
      <SearchSection />
      
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
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  topNavContainer: {
    paddingTop: 50,
    paddingBottom: 15,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255, 255, 255, 0.1)',
  },
  topNavContent: {
    paddingHorizontal: 20,
    gap: 25,
  },
  topNavItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    paddingVertical: 8,
  },
  topNavText: {
    color: '#a0a9ff',
    fontSize: 14,
    fontWeight: '500',
  },
  propertyTypeContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 15,
  },
  propertyTypeButtons: {
    flexDirection: 'row',
    gap: 10,
  },
  propertyTypeButton: {
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 20,
    backgroundColor: 'rgba(108, 92, 231, 0.3)',
  },
  selectedPropertyTypeButton: {
    backgroundColor: '#6c5ce7',
  },
  propertyTypeText: {
    color: '#a0a9ff',
    fontSize: 14,
    fontWeight: '600',
  },
  selectedPropertyTypeText: {
    color: '#ffffff',
  },
  actionButtons: {
    flexDirection: 'row',
    gap: 10,
  },
  downloadButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: '#6c5ce7',
    paddingHorizontal: 15,
    paddingVertical: 8,
    borderRadius: 15,
  },
  downloadText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  callButton: {
    backgroundColor: '#ff6b35',
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 15,
    justifyContent: 'center',
    alignItems: 'center',
  },
  callText: {
    fontSize: 16,
  },
  whatsappButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: '#25D366',
    paddingHorizontal: 15,
    paddingVertical: 8,
    borderRadius: 15,
  },
  whatsappText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  searchSection: {
    paddingHorizontal: 20,
    paddingVertical: 15,
    marginBottom: 10,
  },
  searchContainer: {
    backgroundColor: 'rgba(255, 255, 255, 0.95)',
    borderRadius: 25,
    padding: 15,
    position: 'relative',
  },
  searchInputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 15,
  },
  searchInput: {
    flex: 1,
    marginLeft: 15,
    color: '#333333',
    fontSize: 16,
  },
  micButton: {
    width: 30,
    height: 30,
    borderRadius: 15,
    backgroundColor: 'rgba(108, 92, 231, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  filtersRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    flexWrap: 'wrap',
  },
  filterButton: {
    backgroundColor: '#ff6b35',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
  },
  filterButtonText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  filterDropdown: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    backgroundColor: 'rgba(160, 169, 255, 0.1)',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: 'rgba(160, 169, 255, 0.3)',
  },
  filterDropdownText: {
    color: '#666666',
    fontSize: 12,
  },
  searchButton: {
    position: 'absolute',
    right: 15,
    top: '50%',
    transform: [{ translateY: -20 }],
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#6c5ce7',
    justifyContent: 'center',
    alignItems: 'center',
  },
});