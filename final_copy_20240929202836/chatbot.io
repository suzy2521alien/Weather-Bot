#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <WebServer.h>

const char* ssid = “Hotspot”;  // Replace with your WiFi SSID
const char* password = "PASS";  // Replace with your WiFi password
const char* Gemini_Token = "AIzaSyD_B-WPmvOleqXOHNwx4qgc5X3wVyYirho";  // Your API token
const char* Gemini_Max_Tokens = "100”;  // Maximum tokens for the API
String res = "";

WebServer server(80);  // Create a web server on port 80

void handleRoot() {
  // Serve the HTML form with Flexbox and enhanced CSS styling
  String html = "<html><head>";
  html += "<style>";
  
  // Import Font Awesome for icons
  html += "@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css');";

  // General styles
  html += "body { font-family: 'Arial', sans-serif; background-color: #48A678; color: #333; text-align: center; margin: 0; padding: 0; }";
  html += "h1 { color: #FFD700; font-size: 40px; font-weight: bold; margin-bottom: 20px; }";
  
  // Flexbox container styles
  html += ".flex-container { display: flex; justify-content: center; align-items: center; height: 100vh; position: relative; }";
  html += ".card { background-color: #fff; border-radius: 12px; padding: 20px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); width: 300px; text-align: left; transition: transform 0.3s ease; }";
  html += ".card:hover { transform: scale(1.05); }";
  
  // Card header and content
  html += ".card h2 { font-size: 24px; color: #FFAC42; margin-bottom: 10px; }";
  html += ".card input[type='text'] { width: 100%; padding: 10px; font-size: 16px; margin-bottom: 20px; border-radius: 8px; border: 1px solid #ccc; }";
  
  // Button styles
  html += ".button { background-color: #FF6B6B; border: none; color: white; padding: 12px 24px; text-align: center; text-decoration: none; display: block; font-size: 16px; margin: 0 auto; border-radius: 12px; transition: background-color 0.3s ease; cursor: pointer; }";
  html += ".button:hover { background-color: #FF4B4B; }";

  // Icon styles
  html += ".icon { font-size: 40px; color: #FFD700; position: absolute; }";
  html += ".icon.wifi { top: 10px; right: 20px; }";
  html += ".icon.question { top: 10px; left: 20px; }";
  html += ".icon.ai { bottom: 10px; left: 20px; }";
  html += ".icon.chatbot { bottom: 10px; right: 20px; }";

  // Additional icons for aesthetics
  html += ".icon.lightbulb { top: 50px; left: 50px; }";
  html += ".icon.user { top: 50px; right: 50px; }";
  html += ".icon.brain { bottom: 50px; right: 50px; }";
  html += ".icon.robot { bottom: 50px; left: 50px; }";

  html += "</style></head>";
  html += "<body>";
  
  // Page title
  html += "<h1>Ask your Question</h1>";
  
  // Flex container for the form
  html += "<div class='flex-container'>";
  
  // Icons around the form
  html += "<i class='fas fa-wifi icon wifi'></i>";
  html += "<i class='fas fa-question-circle icon question'></i>";
  html += "<i class='fas fa-robot icon ai'></i>";
  html += "<i class='fas fa-comments icon chatbot'></i>";

  // More icons for aesthetics
  html += "<i class='fas fa-lightbulb icon lightbulb'></i>";
  html += "<i class='fas fa-user icon user'></i>";
  html += "<i class='fas fa-brain icon brain'></i>";
  html += "<i class='fas fa-robot icon robot'></i>";

  // Single card for the input field and button
  html += "<div class='card'><h2>Enter your Question</h2>";
  html += "<form action='/submit' method='get'>";
  html += "<input type='text' name='question' placeholder='Enter your question'><br>";
  html += "<input type='submit' value='Submit' class='button'>";
  html += "</form></div>";
  
  html += "</div>";  // End of Flex container
  html += "</body></html>";
  
  server.send(200, "text/html", html);
}

void handleSubmit() {
  // Get the question from the URL
  String question = server.arg("question");

  if (question != "") {
    question = "\"" + question + "\"";  // Add quotes for JSON formatting
    HTTPClient https;

    if (https.begin("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + String(Gemini_Token))) {
      https.addHeader("Content-Type", "application/json");
      String payload = "{\"contents\": [{\"parts\":[{\"text\":" + question + "}]}],\"generationConfig\": {\"maxOutputTokens\": " + String(Gemini_Max_Tokens) + "}}";
      int httpCode = https.POST(payload);

      if (httpCode == HTTP_CODE_OK || HTTP_CODE_MOVED_PERMANENTLY) {
        String response = https.getString();
        DynamicJsonDocument doc(1024);
        deserializeJson(doc, response);
        String answer = doc["candidates"][0]["content"]["parts"][0]["text"];

        // Display the answer on the webpage with a styled container
        String html = "<html><head>";
        html += "<style>";
        html += "body { font-family: 'Arial', sans-serif; text-align: center; background-color: #48A678; color: #333; }";
        html += "h1 { color: #FFD700; }";
        html += "p { font-size: 18px; color: #555; margin-top: 1.6em; }";
        html += "a { text-decoration: none; color: #FF6B6B; }";
        html += "</style></head>";
        html += "<body>";
        html += "<h1>Here is your Answer:</h1>";
        html += "<p>" + answer + "</p>";
        html += "<a href='/'>Ask another question</a>";
        html += "</body></html>";

        server.send(200, "text/html", html);
      } else {
        server.send(500, "text/html", "Error in API request");
      }
      https.end();
    }
  } else {
    server.send(400, "text/html", "Question cannot be empty");
  }
}

void setup() {
  Serial.begin(115200);

  WiFi.mode(WIFI_STA);
  WiFi.disconnect();

  WiFi.begin(ssid, password);
  Serial.print("Connecting to ");
  Serial.println(ssid);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  // Setup web server routes
  server.on("/", handleRoot);
  server.on("/submit", handleSubmit);
  server.begin();  // Start the server
}

void loop() {
  server.handleClient();  // Handle client requests
}
