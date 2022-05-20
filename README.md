## Exercice Technique Seifallah Selmi
### Développement Front Paris Sportifs
#
#
##### Informations
- Pattern MVP.
- Appel API et manipulation à l'aide de Async/Await.
- Exemples de tests unitaires sont intégrés.
- Deployment Target est 15.4
- Xcode Version 13.3.1
- 0 Memory Leaks détecté à l'aide de l'outil Xcode Instruments

## Librairies utilisées

| Librairie | Lien Github | Utilité |
| ------ | ------ | ------ |
| SDWebImage | https://github.com/SDWebImage/SDWebImage/ | Téléchargement et cache des images |
| SearchTextField | https://github.com/apasccon/SearchTextField | Intégration de la fonctionnalité "Autocomplete"|

### Remarques
- L'API Key utilisé dans l'application est 2, d'après la documentation de l'API.
- L'API de la récupération du détail d'équipe ne fonctionne plus pour les "free users", du coup, j'ai fait l'envoi des informations de l'équipe à travers une variable globale.


