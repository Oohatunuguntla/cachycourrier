# CachyCourier

# Enterprise Application Development


An online Application which helps customers to transport their couriers to other parts of the City.


## Prerequisites

- Flutter git Repository 
- Android SDK installed on computer for android build
- Android emulator or a developer options enabled android device for android build
- IOS emulator or IOS device for IOS build
- NPM
- Mongo DB

## How to run Backend (NodeJS)

- First Please clone our project repository.
- Once you have cloned or downloaded the master branch repository go to back_end folder which contains all the app related files of backend server and in terminal run `npm install` to get all the npm plugins installed to your repository required to run
- Once that is done run command `npm start` to run the server and start listening for requests in localhost with your specified port number in .env file

## How to run Frontend (Flutter)

- Once you have cloned or downloaded the master branch repository go to cachycourier folder which contains all the app related files of the user and in terminal run `flutter packages get` to get all the flutter plugins to your repository required to run .Then Again go to deliveryguy folder which contains all the related files with Delivery Executive.
- Once it is completed run attach a android or IOS device or emulater.
- Now run command flutter run in the folder where pubspec.yaml is present.
- It builds the android build and install apk in the connected device
- Press 'r' to hot-reload the app and updating the modifications into the installed build apk in the device
- Press 'R' to restart the app

## .env Parameters
- We Have Stored IP address and Mongo DB key in the .env file which separately needs to be created by the member and included into the application .
