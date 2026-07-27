

import 'package:flutter/material.dart';
import 'package:kora_rh/views/conges_view.dart';
import 'package:kora_rh/views/home_view.dart';
import 'package:kora_rh/views/notifications_view.dart';
import 'package:kora_rh/views/profil_view.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/langue_provider.dart';
import '../utils/theme_provider.dart';
import '../viewmodels/notifications_viewmodel.dart';

class AcceuilView extends StatefulWidget {
  const AcceuilView({super.key});

  @override
  State<AcceuilView> createState() => _AcceuilViewState();
}

class _AcceuilViewState extends State<AcceuilView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Affiche la page dans un BottomSheet dès l’ouverture
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _showGarderLeControleBottomSheet();
    });
  }

  // void _showGarderLeControleBottomSheet() {
  //   showResponsiveBottomSheet(context, MessageAcceuil());
  // }

  // Les différentes pages correspondant à chaque onglet
  final List<Widget> _pages = [
    const HomeView(),
    const CongesView(),
    const NotificationsView(),
    const ProfilView(),
    // const MenuView(),
    // const TransactionsView(),
  ];
  // final List<String> _appBarTitles = [
  //   "Accueil",
  //   "Services",
  //   "Clients",
  //   "Compte",
  // ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langueProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = langueProvider.locale.languageCode == 'fr';

    final viewModel = Provider.of<NotificationsViewModel>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(_appBarTitles[_currentIndex]),
      //   backgroundColor: AppColors.primaryColor,
      //   foregroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: isDarkMode ?  AppColors.red : Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 0),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 0 ? AppColors.indigo900.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: _currentIndex == 0 ? AppColors.indigo900 : Colors.grey.shade500,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isFrench ? "Accueil" : "Home",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 0 ? AppColors.indigo900 : Colors.grey.shade600,
                          fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 1 ? AppColors.indigo900.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.beach_access,
                        color: _currentIndex == 1 ? AppColors.indigo900 : Colors.grey.shade500,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isFrench ? "Congés" : "Holidays",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 1 ? AppColors.indigo900 : Colors.grey.shade600,
                          fontWeight: _currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 2),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 2 ? AppColors.indigo900.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications,
                        color: _currentIndex == 2 ? AppColors.indigo900 : Colors.grey.shade500,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isFrench ? "Notifications" : "Notifications",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 2 ? AppColors.indigo900 : Colors.grey.shade600,
                          fontWeight: _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 3),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 3 ? AppColors.indigo900.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        color: _currentIndex == 3 ? AppColors.indigo900 : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isFrench ? "Profile" : "Profil",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 3 ? AppColors.indigo900 : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                          fontWeight: _currentIndex == 3 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () => setState(() => _currentIndex = 4),
              //   behavior: HitTestBehavior.opaque,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: _currentIndex == 4 ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
              //     ),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Icon(
              //           Icons.menu,
              //           color: _currentIndex == 4 ? AppColors.primaryColor : Colors.grey.shade500,
              //           size: 24,
              //         ),
              //         const SizedBox(height: 4),
              //         Text(
              //           "Menu",
              //           style: Theme.of(context).textTheme.labelSmall?.copyWith(
              //             color: _currentIndex == 4 ? AppColors.primaryColor : Colors.grey.shade600,
              //             fontWeight: _currentIndex == 4 ? FontWeight.w600 : FontWeight.normal,
              //             fontSize: 11,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(12),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(30),
      //       child: BackdropFilter(
      //         filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
      //         child: Container(
      //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      //           decoration: BoxDecoration(
      //             color: Colors.transparent.withOpacity(0.12),
      //             borderRadius: BorderRadius.circular(30),
      //             border: Border.all(
      //               color: Colors.transparent.withOpacity(0.25),
      //               width: 1,
      //             ),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.black.withOpacity(0.05),
      //                 blurRadius: 20,
      //                 spreadRadius: 2,
      //               )
      //             ],
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //
      //               /// ACCUEIL
      //               GestureDetector(
      //                 onTap: () => setState(() => _currentIndex = 0),
      //                 behavior: HitTestBehavior.opaque,
      //                 child: AnimatedContainer(
      //                   duration: const Duration(milliseconds: 250),
      //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(20),
      //                     color: _currentIndex == 0
      //                         ? AppColors.primaryColor.withOpacity(0.18)
      //                         : Colors.transparent,
      //                   ),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       Icon(
      //                         Icons.home_outlined,
      //                         color: _currentIndex == 0
      //                             ? AppColors.primaryColor
      //                             : Colors.grey.shade500,
      //                         size: 24,
      //                       ),
      //                       const SizedBox(height: 4),
      //                       Text(
      //                         "Accueil",
      //                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
      //                           color: _currentIndex == 0
      //                               ? AppColors.primaryColor
      //                               : Colors.grey.shade600,
      //                           fontWeight: _currentIndex == 0
      //                               ? FontWeight.w600
      //                               : FontWeight.normal,
      //                           fontSize: 11,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //
      //               /// SERVICES
      //               GestureDetector(
      //                 onTap: () => setState(() => _currentIndex = 1),
      //                 behavior: HitTestBehavior.opaque,
      //                 child: AnimatedContainer(
      //                   duration: const Duration(milliseconds: 250),
      //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(20),
      //                     color: _currentIndex == 1
      //                         ? AppColors.primaryColor.withOpacity(0.18)
      //                         : Colors.transparent,
      //                   ),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       Icon(
      //                         Icons.grid_view_outlined,
      //                         color: _currentIndex == 1
      //                             ? AppColors.primaryColor
      //                             : Colors.grey.shade500,
      //                         size: 24,
      //                       ),
      //                       const SizedBox(height: 4),
      //                       Text(
      //                         "Services",
      //                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
      //                           color: _currentIndex == 1
      //                               ? AppColors.primaryColor
      //                               : Colors.grey.shade600,
      //                           fontWeight: _currentIndex == 1
      //                               ? FontWeight.w600
      //                               : FontWeight.normal,
      //                           fontSize: 11,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //
      //               /// WALLETS
      //               GestureDetector(
      //                 onTap: () => setState(() => _currentIndex = 2),
      //                 behavior: HitTestBehavior.opaque,
      //                 child: AnimatedContainer(
      //                   duration: const Duration(milliseconds: 250),
      //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(20),
      //                     color: _currentIndex == 2
      //                         ? AppColors.primaryColor.withOpacity(0.18)
      //                         : Colors.transparent,
      //                   ),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       Icon(
      //                         Icons.wallet,
      //                         color: _currentIndex == 2
      //                             ? AppColors.primaryColor
      //                             : Colors.grey.shade500,
      //                         size: 24,
      //                       ),
      //                       const SizedBox(height: 4),
      //                       Text(
      //                         "Wallets",
      //                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
      //                           color: _currentIndex == 2
      //                               ? AppColors.primaryColor
      //                               : Colors.grey.shade600,
      //                           fontWeight: _currentIndex == 2
      //                               ? FontWeight.w600
      //                               : FontWeight.normal,
      //                           fontSize: 11,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //
      //               /// MENU
      //               GestureDetector(
      //                 onTap: () => setState(() => _currentIndex = 3),
      //                 behavior: HitTestBehavior.opaque,
      //                 child: AnimatedContainer(
      //                   duration: const Duration(milliseconds: 250),
      //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(20),
      //                     color: _currentIndex == 3
      //                         ? AppColors.primaryColor.withOpacity(0.18)
      //                         : Colors.transparent,
      //                   ),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       Icon(
      //                         Icons.menu,
      //                         color: _currentIndex == 3
      //                             ? AppColors.primaryColor
      //                             : Colors.grey.shade500,
      //                         size: 24,
      //                       ),
      //                       const SizedBox(height: 4),
      //                       Text(
      //                         "Menu",
      //                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
      //                           color: _currentIndex == 3
      //                               ? AppColors.primaryColor
      //                               : Colors.grey.shade600,
      //                           fontWeight: _currentIndex == 3
      //                               ? FontWeight.w600
      //                               : FontWeight.normal,
      //                           fontSize: 11,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

    );
  }
}
