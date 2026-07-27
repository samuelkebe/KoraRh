import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../composants/card_document.dart';
import '../utils/app_colors.dart';
import '../viewmodels/profil_viewmodel.dart';
import '../utils/app_route_name.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20, 40, 20, 48),
                            color: AppColors.indigo900,
                            child: Column(
                              children: [
                                // Avatar
                                Container(
                                  width: 96,
                                  height: 96,
                                  margin: const EdgeInsets.only(bottom: 24),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.gold100,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.white, width: 4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 16,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'TB',
                                    style: TextStyle(
                                      fontFamily: 'Fraunces',
                                      fontSize: 30,
                                      color: AppColors.textDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                // Name
                                const Text(
                                  'Thomas Bernard',
                                  style: TextStyle(
                                    fontFamily: 'Fraunces',
                                    fontSize: 26,
                                    height: 32 / 26,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Role
                                Text(
                                  'Développeur',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.gold500.withOpacity(0.9),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Team badge
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: Colors.white.withOpacity(0.10)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.groups, size: 14, color: AppColors.gold700),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Équipe Développement',
                                        style: TextStyle(
                                          fontSize: 11,
                                          letterSpacing: 0.2,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Decorative blurred circle
                          Positioned(
                            top: -96,
                            right: -96,
                            child: Container(
                              width: 256,
                              height: 256,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.indigo900.withOpacity(0.10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )    ,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Transform.translate(
                        offset: const Offset(0, -32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Info card
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.textMuted.withOpacity(0.05),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.supervisor_account,
                                                size: 20,
                                                color: AppColors.textMuted),
                                            const SizedBox(width: 16),
                                            Text(
                                              "Manager",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Sophie Laurent",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.border.withOpacity(0.30),
                                  ),
                                  const Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today,
                                                size: 20,
                                                color: AppColors.textMuted),
                                            const SizedBox(width: 16),
                                            Text(
                                              "Arrivée",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "12 Mai 2021",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.border.withOpacity(0.30),
                                  ),
                                  const Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.mail,
                                                size: 20,
                                                color: AppColors.textMuted),
                                            const SizedBox(width: 16),
                                            Text(
                                              "Email",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "t.bernard@kora.io",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 32),
                            // // Documents section title
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 4),
                            //   child: Text(
                            //     'Mes Documents',
                            //     style: TextStyle(
                            //       fontSize: 20,
                            //       height: 28 / 20,
                            //       fontWeight: FontWeight.w700,
                            //       color: AppColors.textDark,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 16),
                            // CardDocument(
                            //   icon: Icons.payments,
                            //   iconBg: AppColors.gold100.withOpacity(0.30),
                            //   iconColor: AppColors.indigo900,
                            //   title: 'Fiche de paie',
                            //   subtitle: 'Octobre 2023 • PDF',
                            // ),
                            // const SizedBox(height: 16),
                            // CardDocument(
                            //   icon: Icons.description,
                            //   iconBg: AppColors.gold100.withOpacity(0.30),
                            //   iconColor: AppColors.gold500,
                            //   title: 'Contrat de travail',
                            //   subtitle: 'Signé le 10 Mai 2021',
                            // ),
                            const SizedBox(height: 32),
                            // // Logout button
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await context
                                      .read<ProfilViewModel>()
                                      .seDeconnecter();
                                  if (context.mounted) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      AppRouteName.login,
                                      (route) => false,
                                    );
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  side: BorderSide(
                                      color: AppColors.red.withOpacity(0.20),
                                      width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout,
                                        size: 20, color: AppColors.red),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Se déconnecter',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: Text(
                                'Version 2.4.1 (Build 108)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textMuted.withOpacity(0.60),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

