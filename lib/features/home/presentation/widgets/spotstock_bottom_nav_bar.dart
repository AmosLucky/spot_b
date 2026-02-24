import 'package:flutter/material.dart';

import '../../../../core/constants/durations/spotstock_durations.dart';
import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';

const double _shadowBlurRadius = 12;
const double _shadowOffset = -4;
const int _shadowOpacity = 64;
const int _unselectedIconAlpha = 128;

const int _homeIndex = 0;
const int _productsIndex = 1;
const int _paymentsIndex = 2;
const int _transfersIndex = 3;
const int _profilesIndex = 4;

class SpotstockBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const SpotstockBottomNavBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottomNotchHeight = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(
        SpotstockSizes.s22,
        SpotstockSizes.s14,
        SpotstockSizes.s22,
        SpotstockSizes.s0,
      ),
      height: SpotstockSizes.s98,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(_shadowOpacity),
            blurRadius: _shadowBlurRadius,
            offset: Offset(_shadowOffset, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpotstockBottomNavBarItem(
                icon: Icons.home,
                label: SpotstockStrings.home,
                isSelected: selectedIndex == _homeIndex,
                onTap: () => onTap(_homeIndex),
              ),
              SpotstockBottomNavBarItem(
                icon: Icons.history,
                label: SpotstockStrings.history,
                isSelected: selectedIndex == _productsIndex,
                onTap: () => onTap(_productsIndex),
              ),
              SpotstockBottomNavBarItem(
                icon: Icons.sync,
                label: SpotstockStrings.sync,
                isSelected: selectedIndex == _paymentsIndex,
                onTap: () => onTap(_paymentsIndex),
              ),
              SpotstockBottomNavBarItem(
                icon: Icons.shopping_cart,
                label: SpotstockStrings.summary,
                isSelected: selectedIndex == _transfersIndex,
                onTap: () => onTap(_transfersIndex),
              ),
              SpotstockBottomNavBarItem(
                icon: Icons.person,
                label: SpotstockStrings.profile,
                isSelected: selectedIndex == _profilesIndex,
                onTap: () => onTap(_profilesIndex),
              ),
            ],
          ),
          SizedBox(height: bottomNotchHeight),
        ],
      ),
    );
  }
}

class SpotstockBottomNavBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Function() onTap;
  const SpotstockBottomNavBarItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            shape: CircleBorder(),
            child: InkWell(
              onTap: onTap,
              customBorder: CircleBorder(),
              child: Padding(
                padding: EdgeInsetsGeometry.all(SpotstockSizes.s5),
                child: AnimatedContainer(
                  duration: SpotstockDurations.bottomNavBarAnimationDuration,
                  curve: Curves.easeInOut,
                  width: SpotstockSizes.s24,
                  height: SpotstockSizes.s24,
                  child: Icon(
                    icon,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimary.withAlpha(_unselectedIconAlpha),
                    size: isSelected ? SpotstockSizes.s24 : SpotstockSizes.s20,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: SpotstockDurations.bottomNavBarAnimationDuration,
            curve: Curves.easeInOut,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isSelected ? SpotstockSizes.s11 : SpotstockSizes.s10,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimary.withAlpha(_unselectedIconAlpha),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
