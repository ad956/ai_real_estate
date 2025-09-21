import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmiBreakdownTableWidget extends StatelessWidget {
  final double monthlyEmi;
  final double yearlyEmi;
  final double totalAmount;
  final double principalAmount;
  final double interestAmount;
  final int tenureYears;

  const EmiBreakdownTableWidget({
    Key? key,
    required this.monthlyEmi,
    required this.yearlyEmi,
    required this.totalAmount,
    required this.principalAmount,
    required this.interestAmount,
    required this.tenureYears,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Breakdown',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          _buildBreakdownRow(
            'Monthly EMI',
            '₹${_formatAmount(monthlyEmi)}',
            true,
          ),
          _buildDivider(),
          _buildBreakdownRow(
            'Yearly Payment',
            '₹${_formatAmount(yearlyEmi)}',
            false,
          ),
          _buildDivider(),
          _buildBreakdownRow(
            'Total Principal',
            '₹${_formatAmount(principalAmount)}',
            false,
          ),
          _buildDivider(),
          _buildBreakdownRow(
            'Total Interest',
            '₹${_formatAmount(interestAmount)}',
            false,
          ),
          _buildDivider(),
          _buildBreakdownRow(
            'Total Amount',
            '₹${_formatAmount(totalAmount)}',
            true,
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primaryContainer
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.primary.withValues(
                  alpha: 0.2,
                ),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                CustomIconWidget(
                  iconName: 'info_outline',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Loan Duration: $tenureYears ${tenureYears == 1 ? 'Year' : 'Years'} (${tenureYears * 12} months)',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, bool isHighlighted) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: isHighlighted
                  ? AppTheme.lightTheme.colorScheme.onSurface
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: isHighlighted
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
      thickness: 1,
      height: 1,
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
