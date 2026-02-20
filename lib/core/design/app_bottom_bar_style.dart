import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppBottomBarStyle {
  static const elevation = 8.0;

  static const selectedColor = AppColors.primary;
  static const unselectedColor = AppColors.textSecondary;

  static const backgroundColor = AppColors.background;

  static const selectedLabelStyle = AppTextStyles.bottomLabel;
  static const unselectedLabelStyle = AppTextStyles.bottomLabel;
}
