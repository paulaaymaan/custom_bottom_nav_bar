
TODO: A highly customizable Flutter bottom navigation bar package with five beautiful, modern styles inspired by Figma designs. Supports light and dark themes, animated selection, and unique notched/diamond/pill/indicator effects.

## Features

Features
5 unique navigation bar styles:
Center notch with floating FAB
Center diamond notch with floating diamond FAB
Center highlight (scan) style
Left highlight style
Bottom indicator style
Light and dark mode support
Customizable colors, icons, and labels
Smooth animations for selection and indicators
Easy integration and flexible API



## ScreenShots for the 5 shapes for the custom navigation bar
![image](https://github.com/user-attachments/assets/3f667ba9-b506-4307-b988-9f536b32319c)
![image](https://github.com/user-attachments/assets/cdbd57d8-2021-46fd-ac0d-d5aa29474405)
![image](https://github.com/user-attachments/assets/b84f7883-5c7b-49ea-8e60-af20dd7e42b5)
![image](https://github.com/user-attachments/assets/9ed8724a-84e5-49b4-8a17-1be62d0caa5c)
![image](https://github.com/user-attachments/assets/7311d702-cc98-4eee-90dc-3af2b79763a6)
![image](https://github.com/user-attachments/assets/2d45979a-3b3d-4341-9b08-586be6d0a2b5)
![image](https://github.com/user-attachments/assets/9de16e8d-3c02-475d-8cf3-5610056c62c1)
![image](https://github.com/user-attachments/assets/445fe5c1-644d-41f5-83b1-d8a1b97e5953)
![image](https://github.com/user-attachments/assets/e9b3878a-2d40-4ef0-abec-b53eb5a411ed)
![image](https://github.com/user-attachments/assets/e8b990ce-240c-4945-bf4a-266f2d41e476)


## Usage

import 'package:flutter/material.dart';
import 'package:custom_bottom_nav_bar/custom_bottom_nav_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  NavBarStyle _style = NavBarStyle.centerNotch;

  final List<BottomNavItem> _items = [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.shopping_cart, label: 'Cart'),
    BottomNavItem(icon: Icons.qr_code_scanner, label: 'Scan'),
    BottomNavItem(icon: Icons.category, label: 'Categories'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Your content here')),
        bottomNavigationBar: CustomBottomNavBar(
          style: _style,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: _items,
          backgroundColor: Colors.white,
          activeColor: Colors.purple,
          inactiveColor: Color(0xFFBDBDBD),
        ),
      ),
    );
  }
}

## Additional information

NavBarStyle (enum)
centerNotch – Center notch with floating FAB and underline for selected icon
centerDiamondNotch – Center diamond notch with floating diamond FAB
centerHighlight – Center icon always highlighted, others bold/black when selected
leftHighlight – Selected icon/label colored and bold, others gray
bottomIndicator – Selected icon/label in pill with underline, only selected shows label

**CustomBottomNavBar
![image](https://github.com/user-attachments/assets/031c5667-f2b4-4f16-9e47-217dd0b086be)
**BottomNavItem
![image](https://github.com/user-attachments/assets/c918ce73-4cfd-4205-8b5c-f1354d27517b)


