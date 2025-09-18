# AI in Real Estate - Mobile App

A React Native Expo app that replicates the design and functionality of [aiinrealestate.in](https://aiinrealestate.in/).

## Features

- **Property Listings**: Browse properties with detailed information
- **Web Stories**: Interactive property stories with image galleries
- **EMI Calculator**: Calculate loan EMI with interactive sliders and charts
- **Blog**: Real estate articles and tips
- **WhatsApp Integration**: Contact property owners directly
- **Responsive Design**: Matches the exact theme of aiinrealestate.in

## Design Elements

- **Color Scheme**: Purple gradient background (#0f0f23, #1a1a2e, #16213e)
- **Primary Colors**: Purple (#6c5ce7), Orange (#ff6b35), Blue (#74b9ff)
- **Typography**: Clean, modern fonts with proper hierarchy
- **Components**: Property cards, navigation tabs, floating buttons

## Screens

1. **Home**: Property listings with categories and search
2. **Web Stories**: Interactive story viewer with navigation
3. **EMI Calculator**: Loan calculator with pie charts and breakdown
4. **Blog**: Featured articles and recent posts

## Setup Instructions

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm run dev
   ```

3. Run on device/simulator:
   - iOS: Press `i` in terminal
   - Android: Press `a` in terminal
   - Web: Press `w` in terminal

## App Configuration

- **App Name**: AI in Real Estate
- **Bundle ID**: com.aiinrealestate.app
- **Logo**: Uses app_logo.png from assets/images/
- **Theme**: Dark theme with purple gradients

## Components

- `Header`: Top navigation with logo and action buttons
- `AppLogo`: Reusable logo component
- `FloatingWhatsAppButton`: WhatsApp contact button
- `LoadingSpinner`: Loading states
- `NavigationTabs`: Top navigation tabs

## API Integration

The app is configured to fetch data from:
- Properties: `https://aiinrealestate.in/api/property`
- Categories: `https://aiinrealestate.in/api/category_property`
- Web Stories: `https://aiinrealestate.in/api/webstories`

## Build

To build for production:
```bash
npm run build:web
```

## Technologies Used

- React Native
- Expo Router
- TypeScript
- Expo Linear Gradient
- Lucide React Native (Icons)
- React Native SVG