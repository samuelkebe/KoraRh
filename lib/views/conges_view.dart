import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../composants/primary_button.dart';
import '../data/models/conge_request.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_text.dart';
import '../viewmodels/conges_viewmodel.dart';

class CongesView extends StatefulWidget {
  const CongesView({super.key});

  @override
  State<CongesView> createState() => _CongesViewState();
}

class _CongesViewState extends State<CongesView> {
  TypeConge _type = TypeConge.paye;
  DateTime? _debut;
  DateTime? _fin;
  final _commentaireController = TextEditingController();
  bool _ongletHistorique = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CongesViewModel>().charger();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CongesViewModel>();

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ---- Balance card (.balance-card) ----
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
                            Text('${vm.soldeJoursRestants}', style: AppText.balanceNum),
                            const SizedBox(height: 2),
                          ],
                        ),                        // Name

                        const SizedBox(height: 4),
                        Text('jours restants en 2026',
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
              ), 
            const SizedBox(height: 18),
            // ---- Tab toggle (.tab-toggle) ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E5D9),
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
                child: Row(
                  children: [
                    Expanded(child: _tabBouton('Nouvelle demande', !_ongletHistorique, () => setState(() => _ongletHistorique = false))),
                    Expanded(child: _tabBouton('Mes demandes', _ongletHistorique, () => setState(() => _ongletHistorique = true))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: !_ongletHistorique ? _formulaire(vm) : _historique(vm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBouton(String label, bool actif, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: actif ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppText.tabLabel.copyWith(color: actif ? AppColors.indigo900 : AppColors.textMuted),
        ),
      ),
    );
  }

  Widget _formulaire(CongesViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type de congé', style: AppText.fieldLabel.copyWith(color: AppColors.textDark)),
        const SizedBox(height: 6),
        DropdownButtonFormField<TypeConge>(
          value: _type,
          style: AppText.listTitle.copyWith(fontWeight: FontWeight.w400),
          decoration: _decorationChamp(),
          items: TypeConge.values.map((t) => DropdownMenuItem(value: t, child: Text(t.label))).toList(),
          onChanged: (v) => setState(() => _type = v!),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _selecteurDate('Date début', _debut, (d) => setState(() => _debut = d))),
            const SizedBox(width: 10),
            Expanded(child: _selecteurDate('Date fin', _fin, (d) => setState(() => _fin = d))),
          ],
        ),
        const SizedBox(height: 14),
        Text('Commentaire (optionnel)', style: AppText.fieldLabel.copyWith(color: AppColors.textDark)),
        const SizedBox(height: 6),
        TextField(
          controller: _commentaireController,
          maxLines: 3,
          style: AppText.listTitle.copyWith(fontWeight: FontWeight.w400),
          decoration: _decorationChamp(hint: 'Précisez si besoin...'),
        ),
        const SizedBox(height: 18),
        if (vm.erreur != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(vm.erreur!, style: AppText.listSub.copyWith(color: AppColors.red)),
          ),
        PrimaryButton(
          title: 'Envoyer la demande',
          onPressed: vm.soumissionEnCours ? null : () => _envoyer(vm),
        ),
      ],
    );
  }

  InputDecoration _decorationChamp({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppText.listSub,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.field),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.field),
        borderSide: const BorderSide(color: AppColors.border),
      ),
    );
  }

  Widget _selecteurDate(String label, DateTime? valeur, ValueChanged<DateTime> onSelect) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2030),
        );
        if (date != null) onSelect(date);
      },
      child: InputDecorator(
        decoration: _decorationChamp(),
        child: Text(
          valeur == null ? label : '${valeur.day}/${valeur.month}/${valeur.year}',
          style: AppText.listTitle.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _historique(CongesViewModel vm) {
    if (vm.historique.isEmpty) {
      return Center(child: Text('Aucune demande pour le moment.', style: AppText.listSub));
    }
    return Column(children: vm.historique.map(_congeCard).toList());
  }

  Widget _congeCard(DemandeConge d) {
    final (bg, text) = switch (d.statut) {
      StatutConge.enAttente => (AppBadgeColors.pendingBg, AppBadgeColors.pendingText),
      StatutConge.valide => (AppBadgeColors.approvedBg, AppBadgeColors.approvedText),
      StatutConge.refuse => (AppBadgeColors.refusedBg, AppBadgeColors.refusedText),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.cardXs),
        boxShadow: AppShadows.listItem,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.type.label, style: AppText.congeType),
                  const SizedBox(height: 2),
                  Text(
                    '${d.dateDebut.day}/${d.dateDebut.month} — ${d.dateFin.day}/${d.dateFin.month}/${d.dateFin.year}',
                    style: AppText.congeDates,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppRadius.pill)),
                child: Text(d.statut.label, style: AppText.badge.copyWith(color: text)),
              ),
            ],
          ),
          if (d.commentaire != null) ...[
            const SizedBox(height: 8),
            Text(
              d.commentaire!,
              style: AppText.congeDates.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _envoyer(CongesViewModel vm) async {
    if (_debut == null || _fin == null) return;
    final ok = await vm.soumettreDemande(
      type: _type,
      dateDebut: _debut!,
      dateFin: _fin!,
      commentaire: _commentaireController.text.isEmpty ? null : _commentaireController.text,
    );
    if (ok) setState(() => _ongletHistorique = true);
  }
}
