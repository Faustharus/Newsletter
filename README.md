# Newsletter
iOS App using NewsAPI API for International and French retrieval informations

Les Tests Unitaires Logique & UI n'ont pas encore été intégrées (Je commence tout juste à apprendre comment il faut procéder pour les intégrer)

J'ai mis en place une TabView afin de permettre la récupération d'information des 2 manières différentes avec la première page (Générale) qui recupère toute info peu importe la langue et l'onglet Gros-Titres permet la récupération d'info en Français par catégorie disponible sur l'API

Pour l'affichage des informations grâce au lien fourni pour chaque article, j'ai laissé la mise en place de l'affichage par une redirection sur Safari lors du clic.

J'avais initialement mis cette affichage par le biais d'une WebView en utilisant une WebWiew grâce à UIKit, cependant il semblerait que cela produise un conflit avec la récupération des données car une erreur "Invalid Data" s'affiche au moment du refresh

J'ai pû également identifer que de sous-diviser ma VueModel en mettant en place un Service serait grandement utile, il me resterait également à pouvoir appliquer des Tests Unitaires (comme indiqué plus haut) et enfin stylisé le tout afin de le rendre plus agréable visuellement

Par contre, NewsAPI avec un compte gratuit limite grandement l'affichage des données par jour

