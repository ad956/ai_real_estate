# AI In Real Estate 🏠

A modern Flutter application for real estate property browsing with AI-powered features, EMI calculator, web stories, and comprehensive property management.

## ✨ Features

- 🏠 **Property Browsing** - Browse properties by categories (New Launch, Ready to Move, Under Construction)
- 📱 **Direct Contact** - WhatsApp and phone integration for instant property inquiries
- 🧮 **EMI Calculator** - Calculate loan EMIs with interactive sliders and visual breakdowns
- 📖 **Web Stories** - Engaging property stories and market insights
- 📝 **Real Estate Blog** - Latest news, tips, and market analysis
- 🌙 **Dark Theme** - Beautiful gradient-based dark theme design
- 📍 **Location-based** - Properties in Vadodara with detailed location info

## 📋 Prerequisites

- Flutter SDK (^3.29.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android SDK / Xcode (for iOS development)

## 🛠️ Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd ai_in_real_estate
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## 📁 Project Structure

```
ai_in_real_estate/
├── lib/
│   ├── core/
│   │   ├── constants/     # Mock data and constants
│   │   └── utils/         # Logger and connectivity services
│   ├── models/            # Data models (Property, WebStory)
│   ├── presentation/      # UI screens and widgets
│   │   ├── properties_screen/    # Property listing
│   │   ├── property_details_screen/ # Property details
│   │   ├── emi_calculator_screen/  # EMI calculator
│   │   ├── web_stories_screen/     # Web stories
│   │   ├── blog_screen/            # Blog articles
│   │   └── splash_screen/          # App splash
│   ├── services/          # API services
│   ├── theme/             # App theming
│   ├── widgets/           # Reusable components
│   └── routes/            # Navigation routes
├── assets/                # Images and static assets
└── pubspec.yaml          # Dependencies
```

## 🎨 Key Features

### Property Management
- Category-based property browsing
- Detailed property information with image galleries
- Direct WhatsApp (+919586363303) and phone contact
- Property filtering and search

### EMI Calculator
- Interactive loan amount, interest rate, and tenure sliders
- Visual pie chart breakdown of principal vs interest
- Detailed repayment schedule table
- Responsive calculations with real-time updates

### Modern UI/UX
- Dark gradient theme with purple/blue color scheme
- Responsive design using Sizer package
- Smooth animations and haptic feedback
- Custom shimmer loading states

## 🔧 Configuration

### API Integration
Toggle between mock data and real API in `lib/core/constants/mock_data.dart`:
```dart
static const bool USE_REAL_API = false; // Set to true for live API
```

## 📦 Dependencies

- `sizer` - Responsive design
- `google_fonts` - Typography
- `cached_network_image` - Image caching
- `url_launcher` - External app integration
- `connectivity_plus` - Network status
- `dio` - HTTP client
- `fl_chart` - Charts and graphs

## 🚀 Deployment

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```
