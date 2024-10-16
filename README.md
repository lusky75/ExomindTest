# ExomindTest

Cas de test pour gérer les erreurs d'API :

- Dans le fichier /App/Config: Changer les valeurs de BASE_URL, BASE_API_URL, API_KEY

  exemple: 

      - "openweathermap.org" à "openweathermap.orggg" (URL pour les images)

      - "api.openweathermap.org à "api.openweathermap.orgg" (URL pour les API)

- Dans le fichier /Mock/getCities: Mettre des noms de ville inexistant
  
       - exemple: ("Rennessss", "Parisss" ... etc)
