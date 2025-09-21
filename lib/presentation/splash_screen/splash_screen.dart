import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _isInitialized = false;
  bool _hasNetworkError = false;
  String _statusMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _logoAnimationController.forward();
    _fadeAnimationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Check network connectivity
      setState(() {
        _statusMessage = 'Checking connectivity...';
      });

      final connectivityResult = await Connectivity().checkConnectivity();
      final hasConnection = connectivityResult != ConnectivityResult.none;

      if (!hasConnection) {
        setState(() {
          _hasNetworkError = true;
          _statusMessage = 'No internet connection';
        });
        _showRetryOption();
        return;
      }

      // Simulate API initialization
      setState(() {
        _statusMessage = 'Loading property data...';
      });
      await Future.delayed(const Duration(milliseconds: 800));

      setState(() {
        _statusMessage = 'Preparing categories...';
      });
      await Future.delayed(const Duration(milliseconds: 600));

      setState(() {
        _statusMessage = 'Almost ready...';
      });
      await Future.delayed(const Duration(milliseconds: 400));

      setState(() {
        _isInitialized = true;
        _statusMessage = 'Ready!';
      });

      // Navigate to properties screen after successful initialization
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.properties);
      }
    } catch (e) {
      setState(() {
        _hasNetworkError = true;
        _statusMessage = 'Initialization failed';
      });
      _showRetryOption();
    }
  }

  void _showRetryOption() {
    Timer(const Duration(seconds: 5), () {
      if (mounted && _hasNetworkError) {
        _showRetryDialog();
      }
    });
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Connection Error',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Unable to connect to our servers. Please check your internet connection and try again.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _retryInitialization();
              },
              child: Text(
                'Retry',
                style: TextStyle(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _proceedOffline();
              },
              child: Text(
                'Continue Offline',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _retryInitialization() {
    setState(() {
      _hasNetworkError = false;
      _statusMessage = 'Retrying...';
    });
    _initializeApp();
  }

  void _proceedOffline() {
    setState(() {
      _statusMessage = 'Loading offline data...';
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.properties);
      }
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppTheme.backgroundGradientDark,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoScaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildLogo(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoadingIndicator(),
                    SizedBox(height: 3.h),
                    _buildStatusText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            width: 12.w,
            height: 12.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 1.h),
          Text(
            'AI In Real',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
          Text(
            'Estate',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    if (_hasNetworkError) {
      return CustomIconWidget(
        iconName: 'wifi_off',
        color: Colors.white.withValues(alpha: 0.8),
        size: 6.w,
      );
    }

    if (_isInitialized) {
      return CustomIconWidget(
        iconName: 'check_circle',
        color: Colors.white,
        size: 6.w,
      );
    }

    return SizedBox(
      width: 6.w,
      height: 6.w,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        _statusMessage,
        key: ValueKey(_statusMessage),
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
