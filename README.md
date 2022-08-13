# github_activity_monitor

A flutter app for monitoring user push events!

## Prerequisites

Please, Make sure you have [flutter](https://docs.flutter.dev/get-started/install) installed and added to your path variable.


## Getting Started

This is the instructions for starting the app in development mode.

1. Open your terminal and `cd` to the root of this project
2. Get dependencies by running 
    >`flutter pub get`
3. Run 
    >`flutter run --dart-define=GITHUB_TOKEN=<YOUR_TOKEN> --dart-define=API_TYPE=<TYPE> -d chrome` 

    Where `<TYPE>` can be any of `[REST, DUMMY, GRAPH_QL]` (*GraphQL implementation is incomplete*)
4. It will take a while for the application to spin up and the chrome to open. After the Google Chrome window opened, copy the address with the dynamic port from the address bar. *Ex. http://localhost:45921/* 

    **You will need this in step 6!**

5. Run
    >`google-chrome --disable-web-security --user-data-dir=<a temp directory>`

    Or
    >`chromium-browser --disable-web-security --user-data-dir=<a temp directory>`
6. Open the address you just copied in the newly opened browser and follow the on screen instructions.