import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Image,
  FlatList,
  Dimensions,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Calendar, User, ArrowRight, Clock } from 'lucide-react-native';

const { width } = Dimensions.get('window');

interface BlogPost {
  id: string;
  title: string;
  excerpt: string;
  image: string;
  author: string;
  date: string;
  readTime: string;
  category: string;
}

const blogPosts: BlogPost[] = [
  {
    id: '1',
    title: 'Top 10 Tips for First-Time Home Buyers',
    excerpt: 'Buying your first home can be overwhelming. Here are essential tips to make the process smoother and ensure you make the right decision.',
    image: 'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
    author: 'Rajesh Kumar',
    date: 'March 15, 2025',
    readTime: '5 min read',
    category: 'Buying Guide',
  },
  {
    id: '2',
    title: 'Real Estate Investment Strategies in 2025',
    excerpt: 'Discover the most effective real estate investment strategies for 2025 and learn how to maximize your returns in the current market.',
    image: 'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg',
    author: 'Priya Sharma',
    date: 'March 12, 2025',
    readTime: '7 min read',
    category: 'Investment',
  },
  {
    id: '3',
    title: 'Understanding Home Loan EMI Calculations',
    excerpt: 'A comprehensive guide to understanding how EMI calculations work and tips to reduce your home loan interest burden.',
    image: 'https://images.pexels.com/photos/280222/pexels-photo-280222.jpeg',
    author: 'Amit Patel',
    date: 'March 10, 2025',
    readTime: '4 min read',
    category: 'Finance',
  },
  {
    id: '4',
    title: 'The Future of Smart Homes in India',
    excerpt: 'Explore how smart home technology is revolutionizing the Indian real estate market and what to expect in the coming years.',
    image: 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg',
    author: 'Sneha Gupta',
    date: 'March 8, 2025',
    readTime: '6 min read',
    category: 'Technology',
  },
  {
    id: '5',
    title: 'Legal Checklist for Property Purchase',
    excerpt: 'Essential legal documents and verifications you must complete before purchasing any property in India.',
    image: 'https://images.pexels.com/photos/1370704/pexels-photo-1370704.jpeg',
    author: 'Vikram Singh',
    date: 'March 5, 2025',
    readTime: '8 min read',
    category: 'Legal',
  },
  {
    id: '6',
    title: 'Rental Property Management Tips',
    excerpt: 'Learn how to effectively manage your rental properties and maximize your rental income with these proven strategies.',
    image: 'https://images.pexels.com/photos/2581922/pexels-photo-2581922.jpeg',
    author: 'Anita Desai',
    date: 'March 3, 2025',
    readTime: '5 min read',
    category: 'Property Management',
  },
];

export default function BlogScreen() {
  const renderFeaturedPost = () => {
    const featuredPost = blogPosts[0];
    return (
      <TouchableOpacity style={styles.featuredCard} activeOpacity={0.9}>
        <LinearGradient
          colors={['#667eea', '#764ba2']}
          style={styles.featuredGradient}
        >
          <Image source={{ uri: featuredPost.image }} style={styles.featuredImage} />
          <LinearGradient
            colors={['transparent', 'rgba(0,0,0,0.8)']}
            style={styles.featuredOverlay}
          >
            <View style={styles.featuredContent}>
              <View style={styles.categoryBadge}>
                <Text style={styles.categoryText}>{featuredPost.category}</Text>
              </View>
              <Text style={styles.featuredTitle}>{featuredPost.title}</Text>
              <Text style={styles.featuredExcerpt} numberOfLines={3}>
                {featuredPost.excerpt}
              </Text>
              <View style={styles.featuredMeta}>
                <View style={styles.metaItem}>
                  <User size={14} color="#a0a9ff" />
                  <Text style={styles.metaText}>{featuredPost.author}</Text>
                </View>
                <View style={styles.metaItem}>
                  <Calendar size={14} color="#a0a9ff" />
                  <Text style={styles.metaText}>{featuredPost.date}</Text>
                </View>
                <View style={styles.metaItem}>
                  <Clock size={14} color="#a0a9ff" />
                  <Text style={styles.metaText}>{featuredPost.readTime}</Text>
                </View>
              </View>
            </View>
          </LinearGradient>
        </LinearGradient>
      </TouchableOpacity>
    );
  };

  const renderBlogPost = ({ item }: { item: BlogPost }) => (
    <TouchableOpacity style={styles.blogCard} activeOpacity={0.9}>
      <LinearGradient
        colors={['rgba(108, 92, 231, 0.1)', 'rgba(116, 185, 255, 0.1)']}
        style={styles.cardGradient}
      >
        <Image source={{ uri: item.image }} style={styles.blogImage} />
        <View style={styles.blogContent}>
          <View style={styles.blogHeader}>
            <View style={[styles.categoryBadge, styles.smallCategoryBadge]}>
              <Text style={[styles.categoryText, styles.smallCategoryText]}>
                {item.category}
              </Text>
            </View>
            <ArrowRight size={18} color="#6c5ce7" />
          </View>
          
          <Text style={styles.blogTitle} numberOfLines={2}>
            {item.title}
          </Text>
          
          <Text style={styles.blogExcerpt} numberOfLines={3}>
            {item.excerpt}
          </Text>
          
          <View style={styles.blogMeta}>
            <View style={styles.metaRow}>
              <View style={styles.metaItem}>
                <User size={12} color="#a0a9ff" />
                <Text style={styles.smallMetaText}>{item.author}</Text>
              </View>
              <View style={styles.metaItem}>
                <Clock size={12} color="#a0a9ff" />
                <Text style={styles.smallMetaText}>{item.readTime}</Text>
              </View>
            </View>
            <Text style={styles.dateText}>{item.date}</Text>
          </View>
        </View>
      </LinearGradient>
    </TouchableOpacity>
  );

  const otherPosts = blogPosts.slice(1);

  return (
    <View style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Header */}
        <View style={styles.headerSection}>
          <Text style={styles.headerTitle}>Blog</Text>
        </View>

        {/* Featured Post */}
        <View style={styles.featuredSection}>
          <Text style={styles.sectionTitle}>Featured Article</Text>
          {renderFeaturedPost()}
        </View>

        {/* Recent Posts */}
        <View style={styles.recentSection}>
          <Text style={styles.sectionTitle}>Recent Posts</Text>
          <FlatList
            data={otherPosts}
            renderItem={renderBlogPost}
            keyExtractor={(item) => item.id}
            scrollEnabled={false}
          />
        </View>
      </ScrollView>
    </View>
  );
}

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
    fontSize: 32,
    fontWeight: '800',
    color: '#ffffff',
    marginBottom: 15,
    textAlign: 'center',
    textShadowColor: 'rgba(108, 92, 231, 0.3)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  featuredSection: {
    paddingHorizontal: 20,
    marginBottom: 30,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '800',
    color: '#ffffff',
    marginBottom: 20,
    letterSpacing: -0.5,
  },
  featuredCard: {
    height: 340,
    borderRadius: 25,
    overflow: 'hidden',
    elevation: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.25,
    shadowRadius: 16,
  },
  featuredGradient: {
    flex: 1,
  },
  featuredImage: {
    width: '100%',
    height: '100%',
    position: 'absolute',
  },
  featuredOverlay: {
    flex: 1,
    justifyContent: 'flex-end',
  },
  featuredContent: {
    padding: 20,
  },
  categoryBadge: {
    alignSelf: 'flex-start',
    backgroundColor: '#ff6b35',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginBottom: 15,
    shadowColor: '#ff6b35',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.4,
    shadowRadius: 4,
    elevation: 4,
  },
  smallCategoryBadge: {
    paddingHorizontal: 10,
    paddingVertical: 5,
    borderRadius: 12,
    marginBottom: 0,
    shadowColor: '#ff6b35',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 3,
  },
  categoryText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '700',
  },
  smallCategoryText: {
    fontSize: 11,
    fontWeight: '700',
  },
  featuredTitle: {
    fontSize: 26,
    fontWeight: '800',
    color: '#ffffff',
    marginBottom: 12,
    lineHeight: 32,
    textShadowColor: 'rgba(0, 0, 0, 0.8)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  featuredExcerpt: {
    fontSize: 16,
    color: '#ffffff',
    lineHeight: 22,
    marginBottom: 15,
    opacity: 0.9,
  },
  featuredMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  metaItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  metaText: {
    fontSize: 12,
    color: '#a0a9ff',
  },
  smallMetaText: {
    fontSize: 11,
    color: '#a0a9ff',
  },
  recentSection: {
    paddingHorizontal: 20,
    marginBottom: 30,
  },
  blogCard: {
    marginBottom: 20,
    borderRadius: 20,
    overflow: 'hidden',
    elevation: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
  },
  cardGradient: {
    flexDirection: 'row',
    padding: 18,
  },
  blogImage: {
    width: 110,
    height: 110,
    borderRadius: 16,
    backgroundColor: '#f0f0f0',
  },
  blogContent: {
    flex: 1,
    marginLeft: 15,
    justifyContent: 'space-between',
  },
  blogHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  blogTitle: {
    fontSize: 17,
    fontWeight: '800',
    color: '#ffffff',
    marginBottom: 10,
    lineHeight: 22,
  },
  blogExcerpt: {
    fontSize: 13,
    color: '#a0a9ff',
    lineHeight: 18,
    marginBottom: 10,
  },
  blogMeta: {
    gap: 6,
  },
  metaRow: {
    flexDirection: 'row',
    gap: 15,
  },
  dateText: {
    fontSize: 11,
    color: '#74b9ff',
    fontWeight: '500',
  },
});