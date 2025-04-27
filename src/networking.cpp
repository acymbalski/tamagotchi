#include "networking.h"
#include "WiFi.h"
#include "HTTPClient.h"

const char* ssid = "SSID";
const char* password = "PASSWORD";
const char* hostname = "tamagotchi";

String serverName = "https://jsonplaceholder.typicode.com/todos/1";

void initWifi()
{
    HTTPClient http;

    WiFi.mode(WIFI_STA);
    WiFi.config(INADDR_NONE, INADDR_NONE, INADDR_NONE, INADDR_NONE);
    WiFi.setHostname(hostname); //define hostname
    WiFi.begin(ssid, password);
    Serial.print("Connecting to WiFi ..");
    while (WiFi.status() != WL_CONNECTED) {
      Serial.print('.');
      delay(1000);
    }
    Serial.println(WiFi.localIP());
    
    // Your Domain name with URL path or IP address with path
    http.begin(serverName.c_str());
    
    // If you need Node-RED/server authentication, insert user and password below
    //http.setAuthorization("REPLACE_WITH_SERVER_USERNAME", "REPLACE_WITH_SERVER_PASSWORD");

    // Send HTTP GET request
    int httpResponseCode = http.GET();

    if (httpResponseCode>0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    String payload = http.getString();
    Serial.println(payload);
    }
    else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
    }
    // Free resources
    http.end();
}