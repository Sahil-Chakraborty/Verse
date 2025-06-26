import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verse/sevices/navigation_service.dart';

class Home extends StatelessWidget {
   Home({super.key});
  final NavigationService navigationService= Get.put(NavigationService());
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationService.currentIndex.value,
          onDestinationSelected: (value) => navigationService.updateIndex(value),
          destinations: const<Widget> [
          NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            label: "home",
            selectedIcon: Icon(Icons.home),
            
            ),

            NavigationDestination(
            icon: Icon(Icons.search_outlined), 
            label: "search",
            selectedIcon: Icon(Icons.search_rounded),
            
            ),

            NavigationDestination(
            icon: Icon(Icons.add_outlined), 
            label: "add",
            selectedIcon: Icon(Icons.add),
            
            ),

            NavigationDestination(
            icon: Icon(Icons.favorite_outline), 
            label: "notifications",
            selectedIcon: Icon(Icons.favorite),
            
            ),
            NavigationDestination(
            icon: Icon(Icons.person_2_outlined), 
            label: "profile",
            selectedIcon: Icon(Icons.person_2),
            
            ),

          ],
          ),
          body: AnimatedSwitcher
          (
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.easeInOut,
            child: navigationService.pages()[navigationService.currentIndex.value],
          ),
      ),
    );
  }
}