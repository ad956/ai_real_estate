import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  Dimensions,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import Svg, { Circle, Path, G, Text as SvgText } from 'react-native-svg';

const { width } = Dimensions.get('window');

interface EMICalculation {
  emi: number;
  totalInterest: number;
  totalAmount: number;
  breakdown: MonthlyBreakdown[];
}

interface MonthlyBreakdown {
  month: string;
  beginningBalance: number;
  emi: number;
  principal: number;
  interest: number;
  outstandingBalance: number;
}

export default function EMICalculatorScreen() {
  const [loanAmount, setLoanAmount] = useState('1000000');
  const [interestRate, setInterestRate] = useState('8.5');
  const [loanTenure, setLoanTenure] = useState('5');
  const [calculation, setCalculation] = useState<EMICalculation | null>(null);

  useEffect(() => {
    calculateEMI();
  }, [loanAmount, interestRate, loanTenure]);

  const calculateEMI = () => {
    const P = parseFloat(loanAmount) || 0;
    const r = (parseFloat(interestRate) || 0) / 12 / 100;
    const n = (parseFloat(loanTenure) || 0) * 12;

    if (P <= 0 || r <= 0 || n <= 0) {
      setCalculation(null);
      return;
    }

    const emi = (P * r * Math.pow(1 + r, n)) / (Math.pow(1 + r, n) - 1);
    const totalAmount = emi * n;
    const totalInterest = totalAmount - P;

    // Generate monthly breakdown
    const breakdown: MonthlyBreakdown[] = [];
    let balance = P;

    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    for (let i = 0; i < n; i++) {
      const interestForMonth = balance * r;
      const principalForMonth = emi - interestForMonth;
      const newBalance = balance - principalForMonth;

      breakdown.push({
        month: months[i % 12],
        beginningBalance: balance,
        emi: emi,
        principal: principalForMonth,
        interest: interestForMonth,
        outstandingBalance: newBalance > 0 ? newBalance : 0,
      });

      balance = newBalance;
    }

    setCalculation({
      emi,
      totalInterest,
      totalAmount,
      breakdown: breakdown.slice(0, 12), // Show first 12 months
    });
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-IN', {
      style: 'currency',
      currency: 'INR',
      maximumFractionDigits: 0,
    }).format(amount);
  };

  const PieChart = () => {
    if (!calculation) return null;

    const total = calculation.totalAmount;
    const principal = parseFloat(loanAmount);
    const interest = calculation.totalInterest;
    
    const principalPercentage = (principal / total) * 100;
    const interestPercentage = (interest / total) * 100;

    const radius = 80;
    const centerX = 100;
    const centerY = 100;
    
    const principalAngle = (principalPercentage / 100) * 2 * Math.PI;
    
    const principalEndX = centerX + radius * Math.cos(principalAngle - Math.PI / 2);
    const principalEndY = centerY + radius * Math.sin(principalAngle - Math.PI / 2);
    
    const largeArc = principalPercentage > 50 ? 1 : 0;

    return (
      <View style={styles.chartContainer}>
        <Svg width="200" height="200">
          <G>
            {/* Principal Arc */}
            <Path
              d={`M ${centerX} ${centerY - radius} A ${radius} ${radius} 0 ${largeArc} 1 ${principalEndX} ${principalEndY} L ${centerX} ${centerY} Z`}
              fill="#00ff88"
            />
            {/* Interest Arc */}
            <Path
              d={`M ${principalEndX} ${principalEndY} A ${radius} ${radius} 0 ${1 - largeArc} 1 ${centerX} ${centerY - radius} L ${centerX} ${centerY} Z`}
              fill="#ff6b9d"
            />
          </G>
        </Svg>
        <View style={styles.chartLegend}>
          <View style={styles.legendItem}>
            <View style={[styles.legendColor, { backgroundColor: '#00ff88' }]} />
            <Text style={styles.legendText}>Principal {principalPercentage.toFixed(0)}%</Text>
          </View>
          <View style={styles.legendItem}>
            <View style={[styles.legendColor, { backgroundColor: '#ff6b9d' }]} />
            <Text style={styles.legendText}>Interest {interestPercentage.toFixed(0)}%</Text>
          </View>
        </View>
      </View>
    );
  };

  return (
    <View style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Header */}
        <View style={styles.headerSection}>
          <Text style={styles.headerTitle}>EMI Calculator</Text>
        </View>
        {/* Input Section */}
        <View style={styles.inputSection}>
          {/* Loan Amount */}
          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Loan amount</Text>
            <View style={styles.inputRow}>
              <TextInput
                style={styles.textInput}
                value={loanAmount}
                onChangeText={setLoanAmount}
                keyboardType="numeric"
                placeholder="1000000"
                placeholderTextColor="#a0a9ff"
              />
              <Text style={styles.inputSuffix}>₹ {formatCurrency(parseFloat(loanAmount) || 0)}</Text>
            </View>
            <View style={styles.slider}>
              <View style={[styles.sliderTrack, { width: '60%' }]} />
              <View style={styles.sliderThumb} />
            </View>
          </View>

          {/* Interest Rate */}
          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Rate of interest (p.a)</Text>
            <View style={styles.inputRow}>
              <TextInput
                style={styles.textInput}
                value={interestRate}
                onChangeText={setInterestRate}
                keyboardType="numeric"
                placeholder="8.5"
                placeholderTextColor="#a0a9ff"
              />
              <Text style={styles.inputSuffix}>{interestRate}%</Text>
            </View>
            <View style={styles.slider}>
              <View style={[styles.sliderTrack, { width: '40%' }]} />
              <View style={styles.sliderThumb} />
            </View>
          </View>

          {/* Loan Tenure */}
          <View style={styles.inputGroup}>
            <Text style={styles.inputLabel}>Loan tenure</Text>
            <View style={styles.inputRow}>
              <TextInput
                style={styles.textInput}
                value={loanTenure}
                onChangeText={setLoanTenure}
                keyboardType="numeric"
                placeholder="5"
                placeholderTextColor="#a0a9ff"
              />
              <Text style={styles.inputSuffix}>{loanTenure} Yr</Text>
            </View>
            <View style={styles.slider}>
              <View style={[styles.sliderTrack, { width: '25%' }]} />
              <View style={styles.sliderThumb} />
            </View>
          </View>
        </View>

        {/* Results Section */}
        {calculation && (
          <>
            <View style={styles.resultsSection}>
              <View style={styles.resultRow}>
                <Text style={styles.resultLabel}>Monthly EMI:</Text>
                <Text style={styles.resultValue}>₹{Math.round(calculation.emi).toLocaleString('en-IN')}</Text>
              </View>
              <View style={styles.resultRow}>
                <Text style={styles.resultLabel}>Principal amount:</Text>
                <Text style={styles.resultValue}>₹{parseFloat(loanAmount).toLocaleString('en-IN')}</Text>
              </View>
              <View style={styles.resultRow}>
                <Text style={styles.resultLabel}>Total Interest:</Text>
                <Text style={styles.resultValue}>₹{Math.round(calculation.totalInterest).toLocaleString('en-IN')}</Text>
              </View>
              <View style={styles.resultRow}>
                <Text style={styles.resultLabel}>Total amount:</Text>
                <Text style={styles.resultValue}>₹{Math.round(calculation.totalAmount).toLocaleString('en-IN')}</Text>
              </View>
            </View>

            {/* Pie Chart */}
            <View style={styles.chartSection}>
              <PieChart />
            </View>

            {/* Monthly Breakdown Table */}
            <View style={styles.tableSection}>
              <View style={styles.tableHeader}>
                <Text style={[styles.tableHeaderText, { flex: 1 }]}>Month</Text>
                <Text style={[styles.tableHeaderText, { flex: 1.5 }]}>Beginning Balance</Text>
                <Text style={[styles.tableHeaderText, { flex: 1 }]}>EMI</Text>
                <Text style={[styles.tableHeaderText, { flex: 1 }]}>Principal</Text>
                <Text style={[styles.tableHeaderText, { flex: 1 }]}>Interest</Text>
                <Text style={[styles.tableHeaderText, { flex: 1.5 }]}>Outstanding Balance</Text>
              </View>
              
              {calculation.breakdown.map((row, index) => (
                <View key={index} style={styles.tableRow}>
                  <Text style={[styles.tableCellText, { flex: 1 }]}>{row.month}</Text>
                  <Text style={[styles.tableCellText, { flex: 1.5 }]}>
                    ₹ {Math.round(row.beginningBalance).toLocaleString('en-IN')}
                  </Text>
                  <Text style={[styles.tableCellText, { flex: 1 }]}>
                    ₹ {Math.round(row.emi).toLocaleString('en-IN')}
                  </Text>
                  <Text style={[styles.tableCellText, { flex: 1, color: '#00ff88' }]}>
                    ₹ {Math.round(row.principal).toLocaleString('en-IN')}
                  </Text>
                  <Text style={[styles.tableCellText, { flex: 1, color: '#ff6b9d' }]}>
                    ₹ {Math.round(row.interest).toLocaleString('en-IN')}
                  </Text>
                  <Text style={[styles.tableCellText, { flex: 1.5 }]}>
                    ₹ {Math.round(row.outstandingBalance).toLocaleString('en-IN')}
                  </Text>
                </View>
              ))}
            </View>
          </>
        )}
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
    textShadowColor: 'rgba(116, 185, 255, 0.3)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  inputSection: {
    paddingHorizontal: 20,
    marginBottom: 30,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
    marginHorizontal: 20,
    borderRadius: 20,
    padding: 25,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    elevation: 8,
  },
  inputGroup: {
    marginBottom: 30,
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: '#ffffff',
    marginBottom: 10,
  },
  inputRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 15,
  },
  textInput: {
    backgroundColor: '#74b9ff',
    color: '#ffffff',
    paddingHorizontal: 18,
    paddingVertical: 12,
    borderRadius: 15,
    fontSize: 16,
    fontWeight: '700',
    minWidth: 120,
    textAlign: 'center',
    shadowColor: '#74b9ff',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 4,
  },
  inputSuffix: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: 'bold',
    marginLeft: 15,
  },
  slider: {
    height: 6,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    borderRadius: 3,
    position: 'relative',
  },
  sliderTrack: {
    height: '100%',
    backgroundColor: '#74b9ff',
    borderRadius: 3,
  },
  sliderThumb: {
    position: 'absolute',
    top: -3,
    right: 0,
    width: 12,
    height: 12,
    backgroundColor: '#74b9ff',
    borderRadius: 6,
  },
  resultsSection: {
    paddingHorizontal: 20,
    marginBottom: 30,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
    marginHorizontal: 20,
    borderRadius: 20,
    padding: 25,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    elevation: 8,
  },
  resultRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255, 255, 255, 0.1)',
  },
  resultLabel: {
    fontSize: 16,
    color: '#a0a9ff',
  },
  resultValue: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#ffffff',
  },
  chartSection: {
    alignItems: 'center',
    marginBottom: 30,
  },
  chartContainer: {
    alignItems: 'center',
  },
  chartLegend: {
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 30,
    marginTop: 20,
  },
  legendItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  legendColor: {
    width: 12,
    height: 12,
    borderRadius: 6,
  },
  legendText: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '600',
  },
  tableSection: {
    marginHorizontal: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
    borderRadius: 15,
    overflow: 'hidden',
    marginBottom: 30,
  },
  tableHeader: {
    flexDirection: 'row',
    backgroundColor: '#6c5ce7',
    paddingVertical: 15,
    paddingHorizontal: 10,
  },
  tableHeaderText: {
    color: '#ffffff',
    fontWeight: 'bold',
    fontSize: 12,
    textAlign: 'center',
  },
  tableRow: {
    flexDirection: 'row',
    paddingVertical: 12,
    paddingHorizontal: 10,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255, 255, 255, 0.1)',
  },
  tableCellText: {
    color: '#ffffff',
    fontSize: 11,
    textAlign: 'center',
  },
});