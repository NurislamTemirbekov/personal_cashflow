import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';
import 'package:cash_flow/core/utils/category_icons.dart';
import 'package:cash_flow/core/utils/expense_calculator.dart';

class ExpenseRadarChart extends StatefulWidget {
  final List<Transaction> transactions;
  final List<Category> categories;
  final DateTime month;

  const ExpenseRadarChart({
    super.key,
    required this.transactions,
    required this.categories,
    required this.month,
  });

  @override
  State<ExpenseRadarChart> createState() => _ExpenseRadarChartState();
}

class _ExpenseRadarChartState extends State<ExpenseRadarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Map<String, double> get _categoryBreakdown {
    final monthStart = DateTime(widget.month.year, widget.month.month, 1);
    final monthEnd = DateTime(widget.month.year, widget.month.month + 1, 0);
    
    return ExpenseCalculator.calculateCategoryBreakdown(
      transactions: widget.transactions,
      monthStart: monthStart,
      monthEnd: monthEnd,
    );
  }

  List<CategoryExpense> _getExpenseData() {
    final breakdown = _categoryBreakdown;
    final monthStart = DateTime(widget.month.year, widget.month.month, 1);
    final monthEnd = DateTime(widget.month.year, widget.month.month + 1, 0);
    
    return ExpenseCalculator.getCategoryExpenses(
      breakdown: breakdown,
      categories: widget.categories,
      type: TransactionType.expense,
    );
  }

  List<Color> _getCategoryColors() {
    return [
      const Color.fromARGB(255, 240, 97, 97),
      const Color.fromARGB(255, 68, 206, 224),
      const Color.fromARGB(255, 220, 220, 220),
      const Color.fromARGB(255, 231, 184, 45),
      const Color.fromARGB(255, 99, 244, 104),
      const Color.fromARGB(255, 203, 104, 221),
      const Color.fromARGB(255, 72, 158, 228),
      const Color.fromARGB(255, 239, 102, 61),
      const Color.fromARGB(255, 104, 237, 224),
      const Color.fromARGB(255, 247, 63, 125),
    ];
  }

  Color _getCategoryColor(int index) {
    final colors = _getCategoryColors();
    return colors[index % colors.length];
  }

  String _formatCompactCurrency(double amount) {
    if (amount >= 1000) {
      if (amount >= 1000000) {
        final millions = amount / 1000000;
        if (millions % 1 == 0) {
          return '\$${millions.toInt()}M';
        }
        return '\$${millions.toStringAsFixed(1)}M';
      }
      final thousands = amount / 1000;
      if (thousands % 1 == 0) {
        return '\$${thousands.toInt()}K';
      }
      return '\$${thousands.toStringAsFixed(1)}K';
    }
    if (amount % 1 == 0) {
      return '\$${amount.toInt()}';
    }
    return '\$${amount.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final expenseData = _getExpenseData();
    
    if (expenseData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.pie_chart,
                size: 64,
                color: AppColors.textHint.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No expense data to display',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    final totalExpenses = ExpenseCalculator.calculateTotalExpenses(expenseData);
    final categoryColors = _getCategoryColors();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animationValue = _animation.value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: animationValue,
          child: Opacity(
            opacity: animationValue,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expense Distribution',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                      Text(
                        DateFormatter.formatMonthYear(widget.month),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 50,
                                sections: expenseData.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final data = entry.value;
                                  final percentage = (data.amount / totalExpenses * 100);
                                  final color = categoryColors[index % categoryColors.length];
                                  
                                  return PieChartSectionData(
                                    value: data.amount,
                                    title: percentage >= 8
                                        ? '${percentage.toStringAsFixed(0)}%'
                                        : '',
                                    color: color,
                                    radius: 55,
                                    titleStyle: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    badgeWidget: percentage < 8 && percentage >= 3
                                        ? Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: color.withValues(alpha: 0.5),
                                                  blurRadius: 4,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              '${percentage.toStringAsFixed(0)}%',
                                              style: const TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : null,
                                    badgePositionPercentageOffset: 1.3,
                                    gradient: LinearGradient(
                                      colors: [
                                        color,
                                        color.withValues(alpha: 0.7),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  );
                                }).toList(),
                                pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              constraints: const BoxConstraints(maxWidth: 100),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.15),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                          fontSize: 11,
                                          height: 1.0,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      _formatCompactCurrency(totalExpenses),
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.expense,
                                            fontSize: 15,
                                            letterSpacing: -0.2,
                                            height: 1.1,
                                          ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.border.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: expenseData.asMap().entries.map((entry) {
                                final index = entry.key;
                                final data = entry.value;
                                final percentage = (data.amount / totalExpenses * 100);
                                final color = categoryColors[index % categoryColors.length];
                                
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        color.withValues(alpha: 0.12),
                                        color.withValues(alpha: 0.06),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: color.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [color, color.withValues(alpha: 0.7)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: color.withValues(alpha: 0.3),
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(
                                            CategoryIcons.getIconData(data.category.icon),
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              data.category.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10,
                                                  ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                value: (percentage / 100).clamp(0.0, 1.0),
                                                minHeight: 3,
                                                backgroundColor:
                                                    color.withValues(alpha: 0.2),
                                                valueColor: AlwaysStoppedAnimation<Color>(color),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '\$${data.amount.toStringAsFixed(2)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: AppColors.expense,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                          ),
                                          Text(
                                            '${percentage.toStringAsFixed(1)}%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: AppColors.textSecondary,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

