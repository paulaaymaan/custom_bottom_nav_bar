import 'package:flutter/material.dart';
import 'models/bottom_nav_item.dart';
import 'models/nav_bar_style.dart';
import 'painters/nav_bar_painter.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final NavBarStyle style;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final double itemPadding;

  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.style = NavBarStyle.centerNotch,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.itemPadding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case NavBarStyle.centerNotch:
        return _buildCenterNotchBar(context);
      case NavBarStyle.centerDiamondNotch:
        return _buildCenterDiamondNotchBar(context);
      case NavBarStyle.centerHighlight:
        return _buildCenterHighlightBar();
      case NavBarStyle.leftHighlight:
        return _buildLeftHighlightBar();
      case NavBarStyle.bottomIndicator:
        return _buildBottomIndicatorBar();
    }
  }

  Widget _buildCenterNotchBar(BuildContext context) {
    final double fabSize = 56.0;
    final double barHeight = 65.0;
    final double marginH = 24.0;
    final double marginV = 16.0;
    final double width = MediaQuery.of(context).size.width - marginH * 2;
    final int notchIndex = (items.length / 2).floor();

    return Container(
      height: barHeight + fabSize / 2,
      margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Bar background (pill shape with large corner radius)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(width, barHeight),
              painter: CenterNotchNavBarPainter(
                color: backgroundColor,
                notchRadius: fabSize / 2,
                notchCenterX: width / 2,
                cornerRadius: 18,
              ),
            ),
          ),
          // Floating FAB
          Positioned(
            top: -18, // Move up a bit more for Figma match
            child: Container(
              width: fabSize,
              height: fabSize,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap(notchIndex),
                  customBorder: const CircleBorder(),
                  child: Icon(items[notchIndex].icon, color: Colors.white),
                ),
              ),
            ),
          ),
          // Bar items
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: barHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  if (index == notchIndex) {
                    return const Expanded(child: SizedBox());
                  }
                  final bool isActive = index == currentIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            items[index].icon,
                            color: inactiveColor,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 3,
                            width: isActive ? 18 : 0,
                            decoration: BoxDecoration(
                              color:
                                  isActive ? activeColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterDiamondNotchBar(BuildContext context) {
    final double diamondSize = 28.0;
    final double barHeight = 65.0;
    final double marginH = 24.0;
    final double marginV = 16.0;
    final double width = MediaQuery.of(context).size.width - marginH * 2;
    final int notchIndex = (items.length / 2).floor();

    return Container(
      height: barHeight + diamondSize * 1.2,
      margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // Bar background with diamond notch
          Positioned(
            top: diamondSize * 0.7,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(width, barHeight),
              painter: CenterDiamondNotchNavBarPainter(
                color: backgroundColor,
                notchSize: diamondSize,
                notchCenterX: width / 2,
                cornerRadius: 18,
              ),
            ),
          ),
          // Floating diamond FAB (scan icon)
          Positioned(
            top: 0,
            child: Transform.rotate(
              angle: 0.785398, // 45 degrees
              child: GestureDetector(
                onTap: () => onTap(notchIndex),
                child: Container(
                  width: diamondSize * 2,
                  height: diamondSize * 2,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.785398, // Rotate icon upright
                      child: Icon(
                        Icons.qr_code_scanner, // Always scan icon
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bar items
          Positioned(
            top: diamondSize * 0.7,
            left: 0,
            right: 0,
            child: SizedBox(
              height: barHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  if (index == notchIndex) {
                    return const Expanded(child: SizedBox());
                  }
                  final isActive = index == currentIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            items[index].icon,
                            color:
                                index == currentIndex
                                    ? activeColor
                                    : inactiveColor,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            items[index].label,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  index == currentIndex
                                      ? activeColor
                                      : inactiveColor,
                              fontWeight:
                                  index == currentIndex
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterHighlightBar() {
    final int centerIndex = (items.length / 2).floor();
    final bool isDark = backgroundColor.computeLuminance() < 0.5;
    final Color selected = isDark ? Colors.white : Colors.black;
    final Color unselected = isDark ? Color(0xFFBDBDBD) : Color(0xFFBDBDBD);

    return Container(
      height: 65.0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomPaint(
        painter: RoundedRectNavBarPainter(
          color: backgroundColor,
          cornerRadius: 18,
        ),
        child: SizedBox(
          height: 65.0,
          child: Row(
            children: List.generate(items.length, (index) {
              final bool isCenter = index == centerIndex;
              final bool isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration:
                            isCenter
                                ? BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                )
                                : null,
                        child: Icon(
                          items[index].icon,
                          color:
                              isCenter
                                  ? Colors.white
                                  : (isActive ? selected : unselected),
                        ),
                      ),
                      if (!isCenter) ...[
                        const SizedBox(height: 4),
                        Text(
                          items[index].label,
                          style: TextStyle(
                            color: isActive ? selected : unselected,
                            fontSize: 12,
                            fontWeight:
                                isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftHighlightBar() {
    return Container(
      height: 65.0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomPaint(
        painter: RoundedRectNavBarPainter(
          color: backgroundColor,
          cornerRadius: 18,
        ),
        child: SizedBox(
          height: 65.0,
          child: Row(
            children: List.generate(items.length, (index) {
              final bool isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[index].icon,
                        color: isActive ? activeColor : inactiveColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].label,
                        style: TextStyle(
                          color: isActive ? activeColor : inactiveColor,
                          fontSize: 12,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomIndicatorBar() {
    final bool isPurple = backgroundColor.computeLuminance() < 0.5;
    final Color selected = Colors.purple;
    final Color unselected = isPurple ? Colors.white70 : Color(0xFFBDBDBD);

    return Container(
      height: 65.0,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomPaint(
        painter: RoundedRectNavBarPainter(
          color: backgroundColor,
          cornerRadius: 18,
        ),
        child: SizedBox(
          height: 65.0,
          child: Row(
            children: List.generate(items.length, (index) {
              final bool isActive = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding:
                            isActive
                                ? const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                )
                                : EdgeInsets.zero,
                        decoration:
                            isActive
                                ? BoxDecoration(
                                  color: Colors.purple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                )
                                : null,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                items[index].icon,
                                color: isActive ? selected : unselected,
                              ),
                              if (isActive) ...[
                                const SizedBox(width: 4),
                                Text(
                                  items[index].label,
                                  style: TextStyle(
                                    color: selected,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 4,
                        width: isActive ? 24 : 0,
                        decoration: BoxDecoration(
                          color: isActive ? Colors.purple : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
