# ***BK LAB Manager*** - an app for Bách Khoa's LABs management

## 1. Getting Started
An app for small and medium organizations (SME) manager, with NFC-tag, e-tag and QR code features supported. ADMIN right can create and manager user accounts, user not logged in shall stay guest user. Main features:
- Agency in-out gate control with QR code and e-tag
- User info sharing with personal QR code
## 2. Updates and releases!!!
For all release features and publised product UI, check out [release page](https://github.com/SontranBK/nfc_mobile_app/releases)
* 【Sep 16, 2022】 version 0.2.0-alpha (pre-released version)
* 【Sep 22, 2022】 first version release
## 3. Reproducing process
<details>
<summary> 3.1. Support plaftforms</summary>

- We support iOS, Android, Windows mobile, tablet platform
- Tested on iphone XS Max, Redmi 9A and other iOS, Android devices.
</details>

<details>
<summary> 3.2. Reproduce steps on Android:</summary>

- Reproduce steps on physical devices: 
    1. Enable Developer Options on Android device setting (USB debug, install via USB). 
    2. Install Android Studio and plug your device into your computer.
    3. Open Android Studio and run app with Android Studio.
    4. If error return, run with following commands: flutter run --no-sound-null-safety
- Reproduce steps on virtual devices:
    1. Install Android Studio, create a virtual device on Android Studio
    2. Run app with Android Studio on virtual device
</details>

<details>
<summary> 3.3. Reproduce steps on iOS (physical device):</summary>

1. MacOS required, install XCode on MacOS device, connect your device to MacOS
2. In Terminal, navigate to this folder, type in:
```shell
open ios/Runner.xcworkspace
```
3. In XCode, "Product" -> "Build for" -> "Profiling"
4. In XCode, "Product" -> "Perform Actions" -> "Profile Without Building"
5. In iOS device, open Setting, "Trust this developer"
</details>

<details>
<summary>  3.3. Reproduce steps using Command line:</summary>

- You can also build apk and install app without using Android Studio, by using Terminal Command Line. 
- Command line for build Android apk:
```shell
flutter build apk --release --no-sound-null-safety
```
- Command line for build iOS:
```shell
flutter build ios --no-sound-null-safety                          
```
- Command line for run app on Android, iOS:
```shell
flutter run --no-sound-null-safety
```
</details>

## 4. Developer guide
<details>
<summary> 4.1. Language and framework:</summary>

- This product is written in Dart language, Flutter framework

- A few resources to get you started if this is your first Flutter project:
    - [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
    - [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


- For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
</details>

<details>
<summary> 4.2. Deps and source code architecture:</summary>

- Check out deps used in [pubspec file](pubspec.yaml)
</details>

## 5. Authors and credits:
In research and development process, all credits go to ***Son Tran BK (1st author), Duc Anh BK (2nd author) and CTARG LAB members***, in EEE, HUST (Hanoi University of Science and Technology), Ha Noi, Viet Nam

