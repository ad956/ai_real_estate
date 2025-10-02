# Google Play Store Upload Checklist

## Pre-Upload Requirements ✅

### 1. App Configuration
- [x] Updated application ID to `com.aiinrealestate.app`
- [x] Set version to 1.0.0+1
- [x] Added proper permissions in AndroidManifest.xml
- [x] Created keystore configuration

### 2. Build Files
- [x] Created key.properties file
- [x] Updated build.gradle.kts for release signing
- [x] Created build script (build_release.bat)

### 3. Required Documents
- [x] Privacy Policy created
- [x] App description ready (from README.md)

## Manual Steps Required

### 1. Create Keystore (Run this command in terminal):
```bash
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
**Use these details:**
- Store Password: android123
- Key Password: android123
- First/Last Name: AI Real Estate
- Organization: AI Real Estate
- City: Vadodara
- State: Gujarat
- Country: IN

### 2. Build App Bundle:
```bash
# Run the build script
build_release.bat
```

### 3. Google Play Console Setup:
1. Go to https://play.google.com/console
2. Create new app
3. Upload the .aab file from `build/app/outputs/bundle/release/`
4. Fill store listing:
   - **App Name:** AI In Real Estate
   - **Short Description:** Smart property discovery with AI-powered features
   - **Full Description:** Use content from README.md
   - **Category:** House & Home
   - **Content Rating:** Everyone
   - **Privacy Policy:** Upload privacy_policy.md content to a website

### 4. Store Assets Needed:
- **App Icon:** 512x512 PNG (use assets/images/app_logo.png)
- **Feature Graphic:** 1024x500 PNG
- **Screenshots:** At least 2 phone screenshots
- **Privacy Policy URL:** Required (host privacy_policy.md online)

### 5. Release Process:
1. Internal Testing → Closed Testing → Production
2. Review Google Play policies
3. Submit for review (takes 1-3 days)

## Important Notes:
- Keep keystore file secure (backup it!)
- Never share keystore passwords
- Update version number for each release
- Test thoroughly before uploading