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
  TextInput,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Search, X, ChevronLeft, ChevronRight, Mic } from 'lucide-react-native';
import LoadingSpinner from '../../components/LoadingSpinner';
import { logApiRequest, logApiResponse, logApiError } from '../../utils/apiLogger';

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
    const endpoint = 'https://aiinrealestate.in/api/webstories';
    try {
      logApiRequest(endpoint);
      const response = await fetch(endpoint);
      const data = await response.json();
      logApiResponse(endpoint, data);
      
      if (data.success && data.webstories) {
        const transformedStories = data.webstories.map((story: any) => ({
          id: story.id.toString(),
          title: story.title,
          image: story.details?.[0]?.img ? `https://aiinrealestate.in/api${story.details[0].img}` : `https://picsum.photos/400/300?random=${story.id}`,
          date: new Date(story.date).toLocaleDateString('en-GB', {
            day: 'numeric',
            month: 'long',
            year: 'numeric'
          }),
          category: 'Buy',
          content: story.details?.[0]?.description || 'No description available',
          images: story.details?.map((detail: any, index: number) => 
            detail.img ? `https://aiinrealestate.in/api${detail.img}` : `https://picsum.photos/400/300?random=${story.id}${index}`
          ) || [`https://picsum.photos/400/300?random=${story.id}`],
        }));
        console.log('✅ Transformed web stories:', transformedStories.length);
        setStories(transformedStories);
      } else {
        console.warn('⚠️ Invalid web stories data structure');
        setStories(mockStories);
      }
    } catch (error) {
      logApiError(endpoint, error);
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
      <View style={styles.cardContainer}>
        <Image source={{ uri: item.image }} style={styles.storyImage} />
        <View style={styles.storyOverlay}>
          <View style={styles.categoryBadge}>
            <Text style={styles.categoryText}>{item.category}</Text>
          </View>
          <View style={styles.storyContent}>
            <Text style={styles.storyTitle} numberOfLines={2}>
              {item.title}
            </Text>
            <Text style={styles.storyDate}>{item.date}</Text>
          </View>
        </View>
      </View>
    </TouchableOpacity>
  );

  const filteredStories = stories.filter(story =>
    story.title.toLowerCase().includes(searchQuery.toLowerCase()) &&
    (selectedCategory === 'Buy' || story.category === selectedCategory)
  );

  return (
    <View style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false}>
        <StatusBar barStyle="light-content" />
        
        <View style={styles.headerSection}>
          <Text style={styles.headerTitle}>Web-Stories</Text>
          
          <View style={styles.categoryButtons}>
            {CATEGORIES.map((category) => (
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
            ))}
          </View>
          
          <View style={styles.searchContainer}>
            <Search size={20} color="#a0a9ff" />
            <TextInput
              style={styles.searchInput}
              placeholder="Search web stories..."
              placeholderTextColor="#a0a9ff"
              value={searchQuery}
              onChangeText={setSearchQuery}
            />
            <TouchableOpacity style={styles.micButton}>
              <Mic size={18} color="#6c5ce7" />
            </TouchableOpacity>
          </View>
        </View>
        
        {loading ? (
          <LoadingSpinner message="Loading stories..." />
        ) : (
          <FlatList
            data={filteredStories}
            renderItem={renderStoryCard}
            keyExtractor={(item) => item.id}
            numColumns={2}
            columnWrapperStyle={styles.row}
            contentContainerStyle={styles.storiesGrid}
            showsVerticalScrollIndicator={false}
            scrollEnabled={false}
          />
        )}
      </ScrollView>
      
      <Modal
        visible={!!selectedStory}
        transparent={true}
        animationType="slide"
        onRequestClose={closeStoryViewer}
      >
        {selectedStory && (
          <View style={styles.storyViewer}>
            <StatusBar backgroundColor="#000000" barStyle="light-content" />
            
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

            <TouchableOpacity style={styles.closeButton} onPress={closeStoryViewer}>
              <X size={24} color="#ffffff" />
            </TouchableOpacity>

            <View style={styles.storyContentModal}>
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

const mockStories: WebStory[] = [
  {
    id: '1',
    title: 'Modern House For Sale',
    image: 'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
    date: '13th March 2025',
    category: 'Sale',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    images: [
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg',
    ],
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  headerSection: {
    paddingHorizontal: 20,
    paddingVertical: 20,
  },
  headerTitle: {
    fontSize: 36,
    fontWeight: 'bold',
    color: '#ffffff',
    textAlign: 'center',
    marginBottom: 25,
    textShadowColor: 'rgba(108, 92, 231, 0.3)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  categoryButtons: {
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 15,
    marginBottom: 20,
  },
  categoryButton: {
    paddingHorizontal: 28,
    paddingVertical: 14,
    borderRadius: 25,
    backgroundColor: '#6c5ce7',
    elevation: 6,
    shadowColor: '#6c5ce7',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.4,
    shadowRadius: 8,
  },
  selectedCategoryButton: {
    backgroundColor: '#ff6b35',
    shadowColor: '#ff6b35',
    transform: [{ scale: 1.05 }],
  },
  categoryButtonText: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '700',
  },
  selectedCategoryButtonText: {
    color: '#ffffff',
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.98)',
    borderRadius: 25,
    paddingHorizontal: 20,
    paddingVertical: 15,
    gap: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 12,
    elevation: 8,
  },
  searchInput: {
    flex: 1,
    color: '#333333',
    fontSize: 16,
  },
  micButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(108, 92, 231, 0.15)',
    justifyContent: 'center',
    alignItems: 'center',
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
    height: 300,
    borderRadius: 25,
    overflow: 'hidden',
    elevation: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.25,
    shadowRadius: 16,
    backgroundColor: '#ffffff',
  },
  cardContainer: {
    flex: 1,
    position: 'relative',
  },
  storyImage: {
    width: '100%',
    height: '100%',
    position: 'absolute',
    backgroundColor: '#f0f0f0',
  },
  storyOverlay: {
    flex: 1,
    justifyContent: 'space-between',
    padding: 18,
    backgroundColor: 'rgba(0, 0, 0, 0.4)',
  },
  categoryBadge: {
    alignSelf: 'flex-start',
    backgroundColor: '#ff6b35',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 15,
    shadowColor: '#ff6b35',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.4,
    shadowRadius: 4,
    elevation: 4,
  },
  categoryText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },
  storyContent: {
    gap: 8,
  },
  storyTitle: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '800',
    lineHeight: 20,
    textShadowColor: 'rgba(0, 0, 0, 0.8)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  storyDate: {
    color: '#a0a9ff',
    fontSize: 12,
    fontWeight: '500',
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
  storyContentModal: {
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