import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class EmiPieChartWidget extends StatefulWidget {
  final double principalAmount;
  final double interestAmount;

  const EmiPieChartWidget({
    Key? key,
    required this.principalAmount,
    required this.interestAmount,
  }) : super(key: key);

  @override
  State<EmiPieChartWidget> createState() => _EmiPieChartWidgetState();
}

class _EmiPieChartWidgetState extends State<EmiPieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final double totalAmount = widget.principalAmount + widget.interestAmount;
    final double principalPercentage =
        (widget.principalAmount / totalAmount) * 100;
    final double interestPercentage =
        (widget.interestAmount / totalAmount) * 100;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'EMI Breakdown',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 35.h,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 4,
                      centerSpaceRadius: 8.w,
                      sections: _buildPieChartSections(
                        principalPercentage,
                        interestPercentage,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(
                        'Principal',
                        '₹${_formatAmount(widget.principalAmount)}',
                        '${principalPercentage.toStringAsFixed(1)}%',
                        AppTheme.lightTheme.colorScheme.primary,
                      ),
                      SizedBox(height: 2.h),
                      _buildLegendItem(
                        'Interest',
                        '₹${_formatAmount(widget.interestAmount)}',
                        '${interestPercentage.toStringAsFixed(1)}%',
                        AppTheme.lightTheme.colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    double principalPercentage,
    double interestPercentage,
  ) {
    return [
      PieChartSectionData(
        color: AppTheme.lightTheme.colorScheme.primary,
        value: principalPercentage,
        title: touchedIndex == 0
            ? '${principalPercentage.toStringAsFixed(1)}%'
            : '',
        radius: touchedIndex == 0 ? 12.w : 10.w,
        titleStyle: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      PieChartSectionData(
        color: AppTheme.lightTheme.colorScheme.secondary,
        value: interestPercentage,
        title: touchedIndex == 1
            ? '${interestPercentage.toStringAsFixed(1)}%'
            : '',
        radius: touchedIndex == 1 ? 12.w : 10.w,
        titleStyle: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }

  Widget _buildLegendItem(
    String title,
    String amount,
    String percentage,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3.w,
              height: 3.w,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                percentage,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
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
