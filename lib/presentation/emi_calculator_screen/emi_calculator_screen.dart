import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/emi_breakdown_table_widget.dart';
import './widgets/emi_pie_chart_widget.dart';
import './widgets/emi_result_card_widget.dart';
import './widgets/interest_rate_slider_widget.dart';
import './widgets/loan_amount_slider_widget.dart';
import './widgets/tenure_slider_widget.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  double _loanAmount = 2500000; // Default ₹25 Lakh
  double _interestRate = 8.5; // Default 8.5%
  double _tenureYears = 20; // Default 20 years

  double _monthlyEmi = 0;
  double _totalAmount = 0;
  double _totalInterest = 0;

  @override
  void initState() {
    super.initState();
    _calculateEmi();
  }

  void _calculateEmi() {
    final double monthlyRate = _interestRate / (12 * 100);
    final int totalMonths = (_tenureYears * 12).toInt();

    if (monthlyRate == 0) {
      _monthlyEmi = _loanAmount / totalMonths;
    } else {
      final double numerator =
          _loanAmount * monthlyRate * pow(1 + monthlyRate, totalMonths);
      final double denominator = pow(1 + monthlyRate, totalMonths) - 1;
      _monthlyEmi = numerator / denominator;
    }

    _totalAmount = _monthlyEmi * totalMonths;
    _totalInterest = _totalAmount - _loanAmount;

    setState(() {});
  }

  void _resetCalculator() {
    HapticFeedback.lightImpact();
    setState(() {
      _loanAmount = 2500000;
      _interestRate = 8.5;
      _tenureYears = 20;
    });
    _calculateEmi();
  }

  void _shareEmiDetails() {
    HapticFeedback.selectionClick();
    final String shareText =
        '''
EMI Calculator Results:

Loan Amount: ₹${_formatAmount(_loanAmount)}
Interest Rate: ${_interestRate.toStringAsFixed(1)}%
Tenure: ${_tenureYears.toInt()} years

Monthly EMI: ₹${_formatAmount(_monthlyEmi)}
Total Amount: ₹${_formatAmount(_totalAmount)}
Total Interest: ₹${_formatAmount(_totalInterest)}

Calculated on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}
    ''';

    // In a real app, you would use share_plus package
    // Share.share(shareText);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('EMI details copied to clipboard'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.backgroundGradientDark,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'EMI Calculator',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _shareEmiDetails,
              icon: CustomIconWidget(
                iconName: 'share',
                color: Colors.white,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: _resetCalculator,
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Loan Amount Slider
                LoanAmountSliderWidget(
                  value: _loanAmount,
                  min: 100000,
                  max: 10000000,
                  onChanged: (value) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _loanAmount = value;
                    });
                    _calculateEmi();
                  },
                ),

                SizedBox(height: 2.h),

                // Interest Rate Slider
                InterestRateSliderWidget(
                  value: _interestRate,
                  min: 1.0,
                  max: 20.0,
                  onChanged: (value) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _interestRate = value;
                    });
                    _calculateEmi();
                  },
                ),

                SizedBox(height: 2.h),

                // Tenure Slider
                TenureSliderWidget(
                  value: _tenureYears,
                  min: 1,
                  max: 30,
                  onChanged: (value) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _tenureYears = value;
                    });
                    _calculateEmi();
                  },
                ),

                SizedBox(height: 3.h),

                // EMI Result Card
                EmiResultCardWidget(
                  emiAmount: _monthlyEmi,
                  totalAmount: _totalAmount,
                  totalInterest: _totalInterest,
                ),

                SizedBox(height: 3.h),

                // Pie Chart
                EmiPieChartWidget(
                  principalAmount: _loanAmount,
                  interestAmount: _totalInterest,
                ),

                SizedBox(height: 3.h),

                // Breakdown Table
                EmiBreakdownTableWidget(
                  monthlyEmi: _monthlyEmi,
                  yearlyEmi: _monthlyEmi * 12,
                  totalAmount: _totalAmount,
                  principalAmount: _loanAmount,
                  interestAmount: _totalInterest,
                  tenureYears: _tenureYears.toInt(),
                ),

                SizedBox(height: 2.h),

                // Additional Information
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.tertiaryContainer
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.tertiary
                          .withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'lightbulb_outline',
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            size: 20,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Quick Tips',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        '• Lower interest rates significantly reduce your total payment\n'
                        '• Shorter tenure means higher EMI but lower total interest\n'
                        '• Consider prepayment options to reduce interest burden\n'
                        '• EMI should not exceed 40% of your monthly income',
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(
                              color: AppTheme
                                  .lightTheme
                                  .colorScheme
                                  .onSurfaceVariant,
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SharedBottomNavbar(
          currentIndex: 3,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, AppRoutes.properties);
                break;
              case 1:
                Navigator.pushReplacementNamed(context, AppRoutes.webStories);
                break;
              case 2:
                Navigator.pushReplacementNamed(context, AppRoutes.blog);
                break;
              case 3:
                // Already on EMI screen
                break;
              case 4:
                Navigator.pushReplacementNamed(context, AppRoutes.profile);
                break;
            }
          },
        ),
      ), // <-- This parenthesis closes Scaffold
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
