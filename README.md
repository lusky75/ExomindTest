# ExomindTest

Projet réalisé en Swift version 5.1. Xcode Version 15.3 (SwiftUI / Combine)

Demo :


https://github.com/user-attachments/assets/ee1d1a69-c14a-41e0-ad64-08d064312f8a

------------------------------------------------------------------------------------

Exemple d'API:

        https://api.openweathermap.org/data/2.5/weather?q=Paris,FR&units=metric&APPID=25d26e4ea04643ed454d780bab182377

Exemple d'image de météo:

        https://openweathermap.org/img/wn/10d.png

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


https://github.com/user-attachments/assets/cf65df24-0170-4dc6-b35a-36f26ef46c03



