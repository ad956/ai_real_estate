import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../widgets/shared_bottom_navbar.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  double _loanAmount = 1000000; // Default ₹10 Lakh
  double _interestRate = 6.5; // Default 6.5%
  double _tenureYears = 5; // Default 5 years

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
      _loanAmount = 1000000;
      _interestRate = 6.5;
      _tenureYears = 5;
    });
    _calculateEmi();
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
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _resetCalculator,
              icon: Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLoanAmountSection(),
              SizedBox(height: 3.h),
              _buildInterestRateSection(),
              SizedBox(height: 3.h),
              _buildTenureSection(),
              SizedBox(height: 4.h),
              _buildResultsSection(),
              SizedBox(height: 3.h),
              _buildPieChart(),
              SizedBox(height: 3.h),
              _buildRepaymentTable(),
            ],
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
      ),
    );
  }

  Widget _buildLoanAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan amount',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _formatAmount(_loanAmount),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '₹${_formatAmountFull(_loanAmount)}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xFF4ECDC4),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
            thumbColor: Color(0xFF4ECDC4),
            overlayColor: Color(0xFF4ECDC4).withValues(alpha: 0.2),
            trackHeight: 6,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: _loanAmount,
            min: 100000,
            max: 10000000,
            divisions: 100,
            onChanged: (value) {
              setState(() {
                _loanAmount = value;
              });
              _calculateEmi();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInterestRateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate of interest (p.a)',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _interestRate.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_interestRate.toStringAsFixed(1)} %',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xFF4ECDC4),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
            thumbColor: Color(0xFF4ECDC4),
            overlayColor: Color(0xFF4ECDC4).withValues(alpha: 0.2),
            trackHeight: 6,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: _interestRate,
            min: 1.0,
            max: 20.0,
            divisions: 190,
            onChanged: (value) {
              setState(() {
                _interestRate = value;
              });
              _calculateEmi();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTenureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan tenure',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _tenureYears.toInt().toString(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_tenureYears.toInt()} Yr',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xFF4ECDC4),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
            thumbColor: Color(0xFF4ECDC4),
            overlayColor: Color(0xFF4ECDC4).withValues(alpha: 0.2),
            trackHeight: 6,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: _tenureYears,
            min: 1,
            max: 30,
            divisions: 29,
            onChanged: (value) {
              setState(() {
                _tenureYears = value;
              });
              _calculateEmi();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultsSection() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildResultRow('Monthly EMI:', '₹${_formatAmountFull(_monthlyEmi)}', true),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          _buildResultRow('Principal amount:', '₹${_formatAmountFull(_loanAmount)}', false),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          _buildResultRow('Total interest:', '₹${_formatAmountFull(_totalInterest)}', false),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          _buildResultRow('Total amount:', '₹${_formatAmountFull(_totalAmount)}', false),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value, bool isHighlighted) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: isHighlighted ? Color(0xFF4ECDC4) : Colors.white,
              fontSize: isHighlighted ? 16 : 14,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    final double principalPercentage = (_loanAmount / _totalAmount) * 100;
    final double interestPercentage = (_totalInterest / _totalAmount) * 100;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 30.w,
              child: CustomPaint(
                painter: PieChartPainter(
                  principalPercentage: principalPercentage,
                  interestPercentage: interestPercentage,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: Color(0xFF4ECDC4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Principal',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Interest',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'Principal ${principalPercentage.toStringAsFixed(0)}%',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF4ECDC4),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Interest ${interestPercentage.toStringAsFixed(0)}%',
                  style: GoogleFonts.poppins(
                    color: Color(0xFFFF6B6B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepaymentTable() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your Repayment Details',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildYearTab('2025', true),
              _buildYearTab('2026', false),
              _buildYearTab('2027', false),
              _buildYearTab('2028', false),
              _buildYearTab('2029', false),
            ],
          ),
          SizedBox(height: 3.h),
          _buildTableHeader(),
          SizedBox(height: 1.h),
          ..._buildTableRows(),
        ],
      ),
    );
  }

  Widget _buildYearTab(String year, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF4ECDC4) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Color(0xFF4ECDC4) : Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        year,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Color(0xFF4ECDC4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(child: _buildHeaderCell('Month')),
          Expanded(child: _buildHeaderCell('Beginning Balance')),
          Expanded(child: _buildHeaderCell('EMI')),
          Expanded(child: _buildHeaderCell('Principal')),
          Expanded(child: _buildHeaderCell('Interest')),
          Expanded(child: _buildHeaderCell('Outstanding Balance')),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  List<Widget> _buildTableRows() {
    List<Widget> rows = [];
    double balance = _loanAmount;
    double monthlyRate = _interestRate / (12 * 100);
    
    for (int i = 1; i <= 12 && i <= (_tenureYears * 12); i++) {
      double interestPayment = balance * monthlyRate;
      double principalPayment = _monthlyEmi - interestPayment;
      double newBalance = balance - principalPayment;
      
      rows.add(_buildTableRow(
        _getMonthName(i),
        '₹ ${_formatAmountShort(balance)}',
        '₹ ${_formatAmountShort(_monthlyEmi)}',
        '₹ ${_formatAmountShort(principalPayment)}',
        '₹ ${_formatAmountShort(interestPayment)}',
        '₹ ${_formatAmountShort(newBalance)}',
        i % 2 == 0,
      ));
      
      balance = newBalance;
    }
    
    return rows;
  }

  Widget _buildTableRow(String month, String beginBalance, String emi, 
      String principal, String interest, String outBalance, bool isEven) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: isEven ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTableCell(month)),
          Expanded(child: _buildTableCell(beginBalance)),
          Expanded(child: _buildTableCell(emi)),
          Expanded(child: _buildTableCell(principal, Color(0xFF4ECDC4))),
          Expanded(child: _buildTableCell(interest, Color(0xFFFF6B6B))),
          Expanded(child: _buildTableCell(outBalance)),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, [Color? color]) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color ?? Colors.white.withValues(alpha: 0.8),
        fontSize: 9,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(0)}00000';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(0)}00000';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  String _formatAmountFull(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String _formatAmountShort(double amount) {
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

class PieChartPainter extends CustomPainter {
  final double principalPercentage;
  final double interestPercentage;

  PieChartPainter({
    required this.principalPercentage,
    required this.interestPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final principalPaint = Paint()
      ..color = Color(0xFF4ECDC4)
      ..style = PaintingStyle.fill;

    final interestPaint = Paint()
      ..color = Color(0xFFFF6B6B)
      ..style = PaintingStyle.fill;

    final principalAngle = (principalPercentage / 100) * 2 * pi;
    final interestAngle = (interestPercentage / 100) * 2 * pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      principalAngle,
      true,
      principalPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + principalAngle,
      interestAngle,
      true,
      interestPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}