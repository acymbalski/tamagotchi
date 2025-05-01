#include "networking.h"
#include "WiFi.h"
#include "Arduino.h"

const char* ssid = "SSID";
const char* password = "PASSWORD";
const char* hostname = "tamagotchi";

const char* ntpServer = "pool.ntp.org";
const long gmtOffset_sec = -14400; // -4 hours for EST, adjust as needed
const int daylightOffset_sec = 0;

void printLocalTime();

void initWifi()
{
    WiFi.mode(WIFI_STA);
    WiFi.config(INADDR_NONE, INADDR_NONE, INADDR_NONE, INADDR_NONE);
    WiFi.setHostname(hostname); //define hostname
    WiFi.begin(ssid, password);
    Serial.print("Connecting to WiFi ..");

    uint32_t startTime = millis();
    uint8_t timeout_s = 10;

    while (WiFi.status() != WL_CONNECTED )
    {
        Serial.print('.');
        delay(1000);

        if (millis() - startTime > timeout_s * 1000)
        {
            Serial.println("Connection timed out.");
            return; // exit if connection times out
        }
    }
    Serial.println(WiFi.localIP());

    // printLocalTime();
}

tm getTime()
{
    struct tm timeinfo;

    // refresh time from NTP
    // if not connected, connect
    if (WiFi.status() != WL_CONNECTED) {
        Serial.println("WiFi not connected, attempting to connect...");
        initWifi();
    }
    if (WiFi.status() == WL_CONNECTED)
    {
        // get time from NTP server
        configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
    }
    else
    {
        Serial.println("Failed to retrieve updated time from NTP, WiFi not connected.");
    }

    printLocalTime();
    if(!getLocalTime(&timeinfo)){
      Serial.println("Failed to obtain time");
      return timeinfo;
    }
    return timeinfo;
}

void printLocalTime()
{
    struct tm timeinfo;
    if(!getLocalTime(&timeinfo)){
      Serial.println("Failed to obtain time");
      return;
    }
    Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");
    Serial.print("Day of week: ");
    Serial.println(&timeinfo, "%A");
    Serial.print("Month: ");
    Serial.println(&timeinfo, "%B");
    Serial.print("Day of Month: ");
    Serial.println(&timeinfo, "%d");
    Serial.print("Year: ");
    Serial.println(&timeinfo, "%Y");
    Serial.print("Hour: ");
    Serial.println(&timeinfo, "%H");
    Serial.print("Hour (12 hour format): ");
    Serial.println(&timeinfo, "%I");
    Serial.print("Minute: ");
    Serial.println(&timeinfo, "%M");
    Serial.print("Second: ");
    Serial.println(&timeinfo, "%S");
  
    Serial.println("Time variables");
    char timeHour[3];
    strftime(timeHour,3, "%H", &timeinfo);
    Serial.println(timeHour);
    char timeWeekDay[10];
    strftime(timeWeekDay,10, "%A", &timeinfo);
    Serial.println(timeWeekDay);
    Serial.println();
}
