import 'package:flutter/material.dart';
import 'package:kora_rh/utils/date.formater.dart';
import 'package:provider/provider.dart';


import '../data/models/pointage.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_text.dart';
import '../viewmodels/home_viewmodel.dart';
import '../web_services/connectivity_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().chargerHistorique();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ---- Header indigo (.home-header) ----
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.fromLTRB(22, 20, 22, 26),
            //   color: AppColors.indigo900,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _banniereReseau(vm.reseau),
            //       const SizedBox(height: 10),
            //       Text('MARDI 15 JUILLET', style: AppText.greetingSmall),
            //       const SizedBox(height: 2),
            //       Text('Bonjour, Awa', style: AppText.greetingName),
            //       const SizedBox(height: 4),
            //       Text('Équipe commerciale — site Abidjan', style: AppText.greetingDate),
            //     ],
            //   ),
            // ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Bonjour, Awa', style: AppText.balanceNum),
                            const SizedBox(height: 2),
                          ],
                        ),                         // Name

                        const SizedBox(height: 4),
                        Text(formatDate(DateTime.now()),
                          style: TextStyle(
                            fontFamily: 'Fraunces',
                            fontSize: 26,
                            height: 32 / 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                  // Decorative blurred circle
                  // Positioned(
                  //   top: -96,
                  //   right: -96,
                  //   child: Container(
                  //     width: 256,
                  //     height: 256,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: AppColors.indigo900.withOpacity(0.10),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // ---- Punch card (.punch-card) ----
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: AppShadows.card,
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(36),
                            elevation: 0,
                            backgroundColor: vm.pointeActuellement
                                ? AppColors.gold500
                                : AppColors.green,
                          ),
                          onPressed: vm.enCours ? null : () => vm.pointer(),
                          child: vm.enCours
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: vm.pointeActuellement
                                        ? AppColors.indigo900
                                        : AppColors.white,
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.fingerprint,
                                      size: 26,
                                      color: vm.pointeActuellement
                                          ? AppColors.indigo900
                                          : AppColors.white,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      vm.pointeActuellement ? "Pointer la sortie" : "Pointer l'entrée",
                                      textAlign: TextAlign.center,
                                      style: AppText.buttonText.copyWith(
                                        fontSize: 13,
                                        color: vm.pointeActuellement
                                            ? AppColors.indigo900
                                            : AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 14),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppText.listSub,
                            children: [
                              const TextSpan(text: 'Dernier pointage : '),
                              TextSpan(
                                text: vm.historique.isEmpty
                                    ? 'Hier, 18:02 (sortie)'
                                    : _libellePointage(vm.historique.first),
                                style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        if (vm.messageErreur != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            vm.messageErreur!,
                            textAlign: TextAlign.center,
                            style: AppText.listSub.copyWith(color: AppColors.red),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ---- Summary row (.summary-row) ----
                  Row(
                    children: [
                      Expanded(child: _summaryCard('AUJOURD\'HUI', '0h 00')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _summaryCard('STATUT', "À l'heure", valueColor: AppColors.green, valueSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text('Historique récent', style: AppText.sectionTitle),
                  const SizedBox(height: 10),
                  if (vm.historique.isEmpty) ...[
                    _ligneHistoriqueStatic(estEntree: false, label: 'Sortie', sousTitre: 'Hier, 18:02 — Bureau Abidjan'),
                    _ligneHistoriqueStatic(estEntree: true, label: 'Entrée', sousTitre: 'Hier, 8:57 — Bureau Abidjan'),
                    _ligneHistoriqueStatic(estEntree: false, label: 'Sortie', sousTitre: 'Lundi, 17:48 — Bureau Abidjan'),
                  ] else
                    ...vm.historique.map(_ligneHistorique),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _libellePointage(Pointage p) {
    final h = p.heure.hour.toString().padLeft(2, '0');
    final m = p.heure.minute.toString().padLeft(2, '0');
    final type = p.type == TypePointage.entree ? 'entrée' : 'sortie';
    return "Aujourd'hui, $h:$m ($type)";
  }

  Widget _banniereReseau(NetworkStatus status) {
    final label = switch (status) {
      NetworkStatus.wifi => 'Connecté en WiFi',
      NetworkStatus.mobile => 'Connecté en données mobiles',
      NetworkStatus.offline => 'Hors-ligne — synchronisation différée',
    };
    final color = status == NetworkStatus.offline ? AppColors.gold500 : AppColors.green;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: AppText.listSub.copyWith(color: AppColors.indigoMuted, fontSize: 11)),
      ],
    );
  }

  Widget _summaryCard(String label, String value, {Color? valueColor, double? valueSize}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.cardMd),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.summaryLabel),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppText.summaryValue.copyWith(
              color: valueColor ?? AppColors.textDark,
              fontSize: valueSize ?? 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ligneHistorique(Pointage p) {
    final estEntree = p.type == TypePointage.entree;
    final h = p.heure.hour.toString().padLeft(2, '0');
    final m = p.heure.minute.toString().padLeft(2, '0');
    return _ligneHistoriqueStatic(
      estEntree: estEntree,
      label: estEntree ? 'Entrée' : 'Sortie',
      sousTitre: '$h:$m — Bureau Abidjan${p.synchronise ? '' : ' (en attente de synchro)'}',
    );
  }

  Widget _ligneHistoriqueStatic({
    required bool estEntree,
    required String label,
    required String sousTitre,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.cardSm),
        boxShadow: AppShadows.listItem,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: estEntree ? AppColors.green100 : AppColors.gold100,
              borderRadius: BorderRadius.circular(AppRadius.iconBox),
            ),
            child: Icon(
              estEntree ? Icons.login : Icons.logout,
              size: 15,
              color: estEntree ? AppColors.green : AppColors.gold700,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppText.listTitle),
              const SizedBox(height: 2),
              Text(sousTitre, style: AppText.listSub),
            ],
          ),
        ],
      ),
    );
  }
}
