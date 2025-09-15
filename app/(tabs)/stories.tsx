import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Image,
  FlatList,
  Dimensions,
  Modal,
  StatusBar,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Search, X, ChevronLeft, ChevronRight, Mic } from 'lucide-react-native';

const { width, height } = Dimensions.get('window');

interface WebStory {
  id: string;
  title: string;
  image: string;
  date: string;
  category: string;
  content: string;
  images: string[];
}

const CATEGORIES = ['Buy', 'Sell', 'Rent', 'Lease'];

export default function StoriesScreen() {
  const [stories, setStories] = useState<WebStory[]>([]);
  const [selectedStory, setSelectedStory] = useState<WebStory | null>(null);
  const [currentSlide, setCurrentSlide] = useState(0);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('Buy');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchWebStories();
  }, []);

  const fetchWebStories = async () => {
    try {
      const response = await fetch('https://aiinrealestate.in/api/webstories');
      const data = await response.json();
      if (data.success) {
        setStories(data.stories || []);
      }
    } catch (error) {
      console.error('Error fetching web stories:', error);
      setStories(mockStories);
    } finally {
      setLoading(false);
    }
  };

  const openStoryViewer = (story: WebStory) => {
    setSelectedStory(story);
    setCurrentSlide(0);
  };

  const closeStoryViewer = () => {
    setSelectedStory(null);
    setCurrentSlide(0);
  };

  const nextSlide = () => {
    if (selectedStory && currentSlide < selectedStory.images.length - 1) {
      setCurrentSlide(currentSlide + 1);
    }
  };

  const prevSlide = () => {
    if (currentSlide > 0) {
      setCurrentSlide(currentSlide - 1);
    }
  };

  const renderStoryCard = ({ item }: { item: WebStory }) => (
    <TouchableOpacity
      style={styles.storyCard}
      onPress={() => openStoryViewer(item)}
      activeOpacity={0.9}
    >
      <LinearGradient
        colors={['#667eea', '#764ba2']}
        style={styles.cardGradient}
      >
        <Image source={{ uri: item.image }} style={styles.storyImage} />
        <View style={styles.storyOverlay}>
          <View style={styles.categoryBadge}>
            <Text style={styles.categoryText}>{item.category}</Text>
          </View>
          <Text style={styles.storyTitle} numberOfLines={2}>
            {item.title}
          </Text>
          <Text style={styles.storyDate}>{item.date}</Text>
        </View>
      </LinearGradient>
    </TouchableOpacity>
  );

  const renderCategoryButton = (category: string) => (
    <TouchableOpacity
      key={category}
      style={[
        styles.categoryButton,
        selectedCategory === category && styles.selectedCategoryButton,
      ]}
      onPress={() => setSelectedCategory(category)}
    >
      <Text
        style={[
          styles.categoryButtonText,
          selectedCategory === category && styles.selectedCategoryButtonText,
        ]}
      >
        {category}
      </Text>
    </TouchableOpacity>
  );

  const filteredStories = stories.filter(story =>
    story.title.toLowerCase().includes(searchQuery.toLowerCase()) &&
    (selectedCategory === 'Buy' || story.category === selectedCategory)
  );

  return (
    <View style={styles.container}>
      <StatusBar barStyle="light-content" />
      
      {/* Stories Grid */}
      {loading ? (
        <View style={styles.loadingContainer}>
          <Text style={styles.loadingText}>Loading stories...</Text>
        </View>
      ) : (
        <FlatList
          data={filteredStories}
          renderItem={renderStoryCard}
          keyExtractor={(item) => item.id}
          numColumns={2}
          columnWrapperStyle={styles.row}
          contentContainerStyle={styles.storiesGrid}
          showsVerticalScrollIndicator={false}
        />
      )}

      {/* Story Viewer Modal */}
      <Modal
        visible={!!selectedStory}
        transparent={true}
        animationType="slide"
        onRequestClose={closeStoryViewer}
      >
        {selectedStory && (
          <View style={styles.storyViewer}>
            <StatusBar backgroundColor="#000000" barStyle="light-content" />
            
            {/* Progress Bar */}
            <View style={styles.progressContainer}>
              {selectedStory.images.map((_, index) => (
                <View
                  key={index}
                  style={[
                    styles.progressBar,
                    { backgroundColor: index <= currentSlide ? '#ffffff' : 'rgba(255,255,255,0.3)' }
                  ]}
                />
              ))}
            </View>

            {/* Close Button */}
            <TouchableOpacity style={styles.closeButton} onPress={closeStoryViewer}>
              <X size={24} color="#ffffff" />
            </TouchableOpacity>

            {/* Story Content */}
            <View style={styles.storyContent}>
              <Image
                source={{ uri: selectedStory.images[currentSlide] }}
                style={styles.fullscreenImage}
                resizeMode="cover"
              />
              
              <LinearGradient
                colors={['transparent', 'rgba(0,0,0,0.8)']}
                style={styles.storyTextOverlay}
              >
                <Text style={styles.storyViewerTitle}>{selectedStory.title}</Text>
                <Text style={styles.storyDescription}>{selectedStory.content}</Text>
              </LinearGradient>
            </View>

            {/* Navigation */}
            <TouchableOpacity
              style={[styles.navButton, styles.prevButton]}
              onPress={prevSlide}
              disabled={currentSlide === 0}
            >
              <ChevronLeft size={24} color={currentSlide === 0 ? '#666' : '#ffffff'} />
            </TouchableOpacity>

            <TouchableOpacity
              style={[styles.navButton, styles.nextButton]}
              onPress={nextSlide}
              disabled={currentSlide === selectedStory.images.length - 1}
            >
              <ChevronRight
                size={24}
                color={currentSlide === selectedStory.images.length - 1 ? '#666' : '#ffffff'}
              />
            </TouchableOpacity>
          </View>
        )}
      </Modal>
    </View>
  );
}

// Mock data
const mockStories: WebStory[] = [
  {
    id: '1',
    title: 'Modern House For Sale',
    image: 'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
    date: '13th March 2025',
    category: 'Sale',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce quis rhoncus libero.',
    images: [
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg',
      'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg',
    ],
  },
  {
    id: '2',
    title: '50 Lacs Apartments In Bopal',
    image: 'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg',
    date: '16th March 2025',
    category: 'Sale',
    content: 'Beautiful apartments with modern amenities and great location.',
    images: [
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg',
      'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg',
    ],
  },
  {
    id: '3',
    title: '3 bhk apartments on rent',
    image: 'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg',
    date: '18th March 2025',
    category: 'Rent',
    content: 'Spacious 3BHK apartments available for rent in prime locations.',
    images: [
      'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg',
    ],
  },
  {
    id: '4',
    title: 'Selling or Buying A Home?',
    image: 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg',
    date: '18th March 2025',
    category: 'Buy',
    content: 'Expert guidance for selling or buying your dream home.',
    images: [
      'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg',
    ],
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  storiesGrid: {
    paddingHorizontal: 15,
  },
  row: {
    justifyContent: 'space-between',
    marginBottom: 15,
  },
  storyCard: {
    width: (width - 45) / 2,
    height: 250,
    borderRadius: 15,
    overflow: 'hidden',
  },
  cardGradient: {
    flex: 1,
    position: 'relative',
  },
  storyImage: {
    width: '100%',
    height: '100%',
    position: 'absolute',
  },
  storyOverlay: {
    flex: 1,
    justifyContent: 'space-between',
    padding: 15,
    backgroundColor: 'rgba(0, 0, 0, 0.3)',
  },
  categoryBadge: {
    alignSelf: 'flex-start',
    backgroundColor: '#ff6b35',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 10,
  },
  categoryText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  storyTitle: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 5,
  },
  storyDate: {
    color: '#a0a9ff',
    fontSize: 12,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    color: '#a0a9ff',
    fontSize: 16,
  },
  storyViewer: {
    flex: 1,
    backgroundColor: '#000000',
  },
  progressContainer: {
    flexDirection: 'row',
    paddingHorizontal: 15,
    paddingTop: 40,
    gap: 5,
  },
  progressBar: {
    flex: 1,
    height: 3,
    borderRadius: 1.5,
  },
  closeButton: {
    position: 'absolute',
    top: 45,
    right: 20,
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 1,
  },
  storyContent: {
    flex: 1,
    marginTop: 20,
  },
  fullscreenImage: {
    width: '100%',
    height: '100%',
  },
  storyTextOverlay: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    padding: 20,
  },
  storyViewerTitle: {
    color: '#ffffff',
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  storyDescription: {
    color: '#ffffff',
    fontSize: 16,
    lineHeight: 24,
  },
  navButton: {
    position: 'absolute',
    top: '50%',
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  prevButton: {
    left: 20,
  },
  nextButton: {
    right: 20,
  },
});