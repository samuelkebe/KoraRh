# Kora RH

Application mobile de gestion RH pour PME, développée en **Flutter/Dart**
selon une architecture **MVVM** (Model – View – ViewModel).

Kora permet aux personnel d'une entreprise de gérer leur présence et leurs congés depuis leur
téléphone, avec un espace back-office dédié aux RH et managers pour le
pilotage et la validation.

## Fonctionnalités principales

- **Pointage** — entrée/sortie avec vérification de géolocalisation en
  temps réel, mode hors-ligne avec synchronisation automatique, détection
  d'oubli de sortie et régularisation.
- **Congés** — demande en quelques clics, suivi du statut (en attente /
  validé / refusé), solde de jours toujours à jour.
- **Notifications** — alertes instantanées (validation de congé, rappel
  de pointage, annonces de l'entreprise).
- **Authentification** — connexion classique ou biométrique (empreinte
  digitale / Face ID selon la plateforme).
- **Profil** — informations personnelles et accès aux documents RH
  (bulletins de paie, contrat).

## Architecture
lib/
├── core/services/ → géolocalisation, connectivité, notifications, biométrie
├── data/models/ → entités métier (Employee, Pointage, DemandeConge...)
├── data/repositories/ → accès aux données, à connecter à l'API backend
├── viewmodels/ → état et logique de chaque écran (ChangeNotifier)
└── views/ → widgets Flutter, sans logique métier
