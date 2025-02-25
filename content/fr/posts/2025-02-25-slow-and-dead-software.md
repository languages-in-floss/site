---
title: Que faire pour les logiciels avec peu ou pas de nouvelles versions ?
date: 2025-02-25
authors:
- jibec
license: CC-BY SA 4.0
categories:
- Régionalisation
---

Dans les articles précédents, on a vu que les traductions sont des fichiers publiés en même temps que le logiciel.

Imaginons le scénario suivant : vous venez de découvrir un logiciel, vous l’aimez bien, il répond à votre besoin.
Cependant, des problèmes de traduction vous gênent, certains menus ne sont pas traduits.

Après avoir deviné où se trouvait ce projet sur les internets, vous vous rendez compte que ce logiciel ne sort au mieux qu’une version par an.

Cela signifie qu’au mieux, si le projet est encore vivant et que vos modifications sont fusionnées, il faudra probablement attendre plusieurs mois avant que votre travail ne soit mis à la disposition des autres utilisateurices.
Dont vous-même !
Car oui, traduire ne nécessite que deux choses : comprendre la langue d’origine et maîtriser la langue de destination, la vôtre.
Tout le reste n’est qu’une barrière à l’entrée limitant le nombre de personnes pouvant apporter leur aide.

Et il n’y a rien que vous puissiez faire à la vitesse de sortie d’un logiciel.
Quelque-soit sa nature, sortir une nouvelle version demande beaucoup d’efforts, de réflexions, de tests, de coordination, de communication.
À moins que le projet ne soit assez mature et considère la traduction avec beaucoup d’attention, il ne sera pas bienvenu de demander une sortie plus rapide pour compléter ou corriger une traduction.

Parfois, cette énergie est telle qu’il n’y a qu’une sortie logicielle par an.
D’autres fois, cette énergie a consumé l’auteur ou l’autrice du projet, et le projet que vous aimez n’a pas vu de nouvelles versions depuis plusieurs années.

Même si ce logiciel fonctionne peut-être correctement, vous êtes dans une impasse…
Sauf si… votre distribution Linux permet de surcharger les traductions !

C’est exactement ce que fait le projet Ubuntu.

Ubuntu permet de traduire des tas de logiciels via sa plateforme https://translations.launchpad.net/
C’est plutôt une grosse plateforme : 3 151 497 chaînes dans 63 017 fichiers, 386 langues, 88 145 traducteurs et traductrices, 50 groupes de traduction…
Impressionnant ? Anecdotique ? Je vous en parlerai dans un futur article.

Comment ça fonctionne ?

Comme une distribution est une immense mécanique pour distribuer/livrer des logiciels aux utilisateurs, les traductions sont livrées via un chemin dissocié du logiciel.
Techniquement, sur l’ordinateur de l’utilisateurice, ça ne change rien, chaque logiciel a ses traductions.
Mais en termes de mises à jour, les traductions peuvent être mises à jour sans mettre à jour le logiciel.
Ça permet de diffuser de nouvelles traductions aux utilisateurices d’Ubuntu, sans avoir à attendre une nouvelle version du logiciel.

Super ! Objectif atteint ! Je peux traduire le logiciel que j’aime, sans avoir besoin de savoir s’il est vivant, dynamique, ni même chercher où et comment ce projet souhaite me contribuer ! Pour rappel, exiger l’usage de git est une barrière immense pour beaucoup.

Sauf que ce n’est que pour Ubuntu.
Les autres distributions Linux n’en bénéficient pas.
Le projet en question, même si lent ou inactif n’en bénéficie pas.

Pire, parfois, c’est un travail en doublon, à l’intérieur du projet Ubuntu, on peut écraser le travail d’autres projets.
En quelques minutes, je trouve un projet qui fait partie du périmètre de GNOME ([gnome-remote-desktop sur Launchpad](https://translations.launchpad.net/ubuntu/plucky/+source/gnome-remote-desktop/+pots/gnome-remote-desktop/fr/+translate?show=untranslated) et [gnome-remote-desktop sur gitlab](https://gitlab.gnome.org/GNOME/gnome-remote-desktop/-/blob/master/po/fr.po?ref_type=heads)).
Sur gitlab, on voit une contribution qui n’est pas sur Launchpad, donc c’est qu’il est possible de traduire en dehors de Launchpad.
Eh oui, via [l10n.gnome.org…](https://l10n.gnome.org/vertimus/gnome-remote-desktop/master/po/fr/level1/).
Ce projet ne devrait à priori pas être sur Launchpad, pourquoi y est-il ?
Sans connaître les relations entre les communautés Ubuntu et GNOME, qui sont potentiellement excellentes, je vois ici un risque de conflit.

Enfin, Launchpad est un logiciel énorme, qui joue de nombreux rôles dans la communauté Ubuntu, et pas seulement la traduction.
J’ignore si Launchpad fait bien son travail pour aider la communauté Ubuntu, mais en tant que plateforme de traduction, c’est un outil très limité et archaïque.
Et c’est normal, une plateforme de traduction coûte cher en connaissances et en compétences.
Si la traduction était une priorité de l’entreprise Ubuntu, iels auraient créé un outil du même niveau de qualité que Pontoon ou Weblate.

Il y a du bon dans ce que fait Ubuntu, merci à eux de démontrer que c’est possible.