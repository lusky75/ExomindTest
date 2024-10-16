# ExomindTest

Projet réalisé en Swift version 5.1. Xcode Version 15.3 (SwiftUI / Combine)

Demo :


https://github.com/user-attachments/assets/ee1d1a69-c14a-41e0-ad64-08d064312f8a

------------------------------------------------------------------------------------

Pour réaliser la démo plus rapidement, j'ai modifié dans /Presentation/Page/WeatherViewModel ->
dans la méthode startTimer(), l'interval de relance:
        
        TimerQuery.shared.registerTimer(id: "updateMessage", interval: 2, repeats: true, block: displayMessage)

        
        TimerQuery.shared.registerTimer(id: "loadWeather", interval: 3, repeats: true, block: getWeather)

------------------------------------------------------------------------------------

Cas de test pour gérer les erreurs d'API :

- Dans le fichier /App/Config: Changer les valeurs de BASE_URL, BASE_API_URL, API_KEY

  exemple: 

      - "openweathermap.org" à "openweathermap.orggg" (URL pour les images)

      - "api.openweathermap.org à "api.openweathermap.orgg" (URL pour les API)

- Dans le fichier /Mock/getCities: Mettre des noms de ville inexistant
  
       - exemple: ("Rennessss", "Parisss" ... etc)

