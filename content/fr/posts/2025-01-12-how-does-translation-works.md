---
title: Où sont les traductions ?
date: 2025-01-12
authors:
- jibec
license: CC-BY SA 4.0
categories:
- Régionalisation
---

Après avoir expliqué qu'une grande partie de la planète [ne parle pas anglais]({{< relref "2020-06-12-80-percent.md" >}}), puis [expliqué comment contribuer à la distribution Fedora]({{< relref "2020-07-03-contribute-to-fedora.md" >}}), regardons où sont les traductions d'un logiciel.

## Les traductions font partie intégrante du code

Les traductions sont des fichiers faisant intégralement partie du code source nécessaire à l'exécution du programme.
Le format du fichier contenant les traductions varie selon les outils utilisés par l'équipe de développement.
Pour se faire une idée des formats de fichiers principaux, la [liste des formats pris en charge par la plateforme de traduction Weblate](https://docs.weblate.org/en/latest/formats.html) est intéressante.
D'une façon générale, le format Gettext est le plus utilisé pour les logiciels compilés/de bureau, et les formats Json pour les logiciels web.
Chaque fichier possède ses avantages et inconvénients, cela entre le domaine de l'internationalisation des logiciels, souvent abrégé `i18n`.

## La conséquence sur le travail de traduction

Comme les traductions font partie du code source, les traducteurs doivent fournir leur travail en temps et en heure pour que chaque changement apporté sur la version en cours soit traduit.
Le moindre changement, même d'une lettre ou d'un caractère, nécessite que chaque traduction soit vérifiée pour savoir si le changement impacte le sens ou la structure de la phrase, les changements coûtent cher pour les traducteurs.

Le plus souvent, et c'est normal, les développeurs et développeuses ne savent pas adapter les traductions lors de leurs changements.
Il est donc nécessaire d'avoir des traducteurs et traductrices suivant de près le développement du projet pour être réactif, et éviter que la nouvelle version du projet parvienne aux utilisateurs avec une chaîne affichée en anglais au milieu d'un logiciel déjà partiellement traduit.

C'est ici que cela se complique, des projets de logiciel libre, il en existe à minima des milliers, si ce n'est des centaines de milliers.
Des langues, il en existe des milliers, peut-on avoir suffisamment de traducteurs et traductrices dans chaque langue pour suivre tous ces projets ?
Certainement pas.

## Processus d'intégration des traductions

Prenons maintenant quelques exemples de projet pour voir comment est organisée l'interaction entre les processus de développement logiciel et de traduction.

### Traduisible... mais archaïque !

Jitsi Meet est un logiciel de visioconférence en ligne, dans son code source, un dossier [lang](https://github.com/jitsi/jitsi-meet/tree/master/lang) contient un fichier json par langue.

Chaque traduction doit faire l'œuvre d'une demande d'intégration, c'est compliqué et chronophage.

En quelques minutes, je trouve un cas extrême, [cette demande qui attend depuis plus de 8 mois](https://github.com/jitsi/jitsi-meet/pull/14754).
Or, entre temps, le fichier contenant les chaînes à traduire du logiciel [a déjà changé 19 fois](https://github.com/jitsi/jitsi-meet/commits/master/lang/main.json) et il y a eu [8 versions publiées](https://github.com/jitsi/jitsi-meet/releases) !

Il n'y a pas dans le [readme](https://github.com/jitsi/jitsi-meet/blob/master/README.md) d'information sur comment traduire, ni dans le [guide de contribution](https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-contributing/).

Les communautés linguistiques avec beaucoup de monde arriveront peut-être à dépenser le temps nécessaire grâce au nombre de contributeurs (et encore...), toutes les autres seront laissées de côté et le logiciel ne proposera des traductions à jour que des langues déjà surreprésentées.
Pour suivre les changements, il faut probablement s'abonner aux changements du projet github.

On s'interrogera sur l'efficience de cette façon de travailler, si on peut saluer l'effort de permettre la traduction du logiciel, je regrette le manque de considération pour ce type de contribution.
Je n'ai pas engagé la discussion avec les équipes de Jitsi Meet, cela n'a pas toujours été comme ça, une plateforme de traduction a déjà été utilisée par le passé.

### Clair... mais très spécifique GNOME

Le projet GNOME utilise une version similaire, mais focalisée sur le besoin des équipes de traduction.
Pour envoyer une traduction dans le logiciel final, il est obligatoire d'utiliser git.
Cependant, un [outil est à disposition](https://l10n.gnome.org) des traducteurs et traductrices, leur permettant de savoir précisément ce qui est à traduire, et de collaborer.
De plus, une longue liste de logiciels de l'écosystème GNOME suivent le même rythme de nouvelles versions et les mêmes processus de travail.
Le processus est donc imparfait, manuel, mais l'outillage permet de réduire fortement le coût de gestion pour les contributeurs et contributrices.

### Efficace... mais très spécifique Mozilla

Le projet Mozilla considère la traduction comme un sujet clef dans son activité, si vous voulez y contribuer vous pouvez vous rendre sur la [plateforme de traduction Pontoon](https://pontoon.mozilla.org/projects/firefox/) (le projet est organisé en [équipes de traduction](https://mozilla-l10n.github.io/localizer-documentation/tools/pontoon/teams_projects.html)).

Savoir ce qui est traduisible est facile, et y trouver des contacts pour répondre aux questions l'est également.

Ce projet est énorme, vous aurez quelques difficultés à comprendre les étapes entre la plateforme de traduction et les sorties du logiciel, mais est-ce grave ?
Cela fonctionne bien, les dates de sorties logicielles sont connues, les priorités sont définies.
Vous perdrez un peu de temps à mettre en place une équipe et des processus de relecture, tout l'outillage est spécifique aux projets de Mozilla, mais globalement, c'est plutôt efficace.

### Automatisé et générique, la modernité émancipatrice

Il est possible de fournir un outil dédié aux activités de traduction, permettant de s'abonner en cas de changements, de travailler à plusieurs, d'avoir des détections d'anomalies.

Et, bonus ultime, d'avoir une synchronisation automatique avec le code source du logiciel.

Un excellent exemple : la plateforme de traduction Weblate montre l'exemple à suivre, tout est connecté et automatisé. Les [modifications de traductions](https://github.com/WeblateOrg/weblate/commits/main/?author=weblate) sont nombreuses, et les [changements impactant les traductions](https://hosted.weblate.org/changes/browse/weblate/?action=13&action=30&user=&period=) sont faciles à trouver.

De nombreux projets utilisent Weblate, c'est le choix que vous devriez faire, quel que soit votre contexte. Dans l'écosystème des plateformes de traduction, Weblate est devenu aussi évident et efficient que git pour la gestion du code source pour le développement logiciel.

Si votre projet fourni cette plateforme, alors vous fournissez du pouvoir d'action pour les contributions linguistiques, et en soignant la relation avec cette large communauté, vous aurez de bonnes chances d'obtenir un outil traduit en de nombreuses langues. 

## Conclusion

L'articulation entre la vie technique du projet et les traductions est cruciale pour l'efficacité des processus de traduction.

Des outils remplis de fonctionnalités intéressantes et d'automatisation existent pour faciliter la vie de tout le monde.

Il ne tient qu'aux équipes de développement de s'en emparer pour que les logiciels contiennent toujours plus de traductions et qu'un nombre croissant de langues soient prises en charge. 

Mais que se passe-t-il quand le projet ne fait pas de nouvelles versions ?
Comment faire pour compenser un projet endormi ? Cela sera l'objet d'un futur article.