# ***BK LAB Manager*** - an app for group management

## 1. Getting Started
An app for small and medium organizations (SME) manager, with NFC-tag, e-tag and QR code features supported. ADMIN right can create and manager user accounts, user not logged in shall stay guest user. Main features:
- Agency in-out gate control with QR code and e-tag
- User info sharing with personal QR code
- Display and stats for users' status (online, offline)
- Authiencation log-in and sign-in
## 2. Updates and releases!!!
For all release features and publised product UI, check out [release page](https://github.com/SontranBK/nfc_mobile_app/releases)
* 【Sep 16, 2022】 version 0.2.0-alpha (pre-released version)
* 【Sep 22, 2022】 version 1.0.0, first version release 
* 【Oct 08, 2022】 version 1.1.0, minor improved from first version

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

<details>
<summary> 4.3. Implementation process:</summary>

- Step 1: Installation and configuration environment:
    - Install Android studio: https://developer.android.com/studio 
    - Setup emulator: https://developer.android.com/studio/run/managing-avd
    - Install Flutter framework and Dart language: https://docs.flutter.dev/development/tools/android-studio.
    
    After finishing above step you will have the below screen.
    <p align="center">
    <img src="https://user-images.githubusercontent.com/97107855/193439217-1e0781cb-028f-417f-ae9e-da4c8a86f95a.png" width="250">
- Step 2: Open and run project:
    - Clone source code via git: git clone git@github.com:SontranBK/nfc_mobile_app.git
    - Open source code via Android Studio then setup framework
</details>

## 5. Testing methods and materials:

<details>
<summary> 5.1. Scanning QR for checking-in test:</summary>

- Please perform QR scanning QR codes below for checking in CTARG 618 Ta Quang Buu Library, then click Update Status:
<p align="center">
<img src="https://user-images.githubusercontent.com/97107855/193439066-653f6725-927d-4dc3-9c98-5974405f0fea.png" width="200">
<img src="https://user-images.githubusercontent.com/97107855/193439071-547fce75-5d06-4426-b988-8da2ead99a5d.png" width="200">
<img src="https://user-images.githubusercontent.com/97107855/193439080-1fc1572d-dccd-4b7d-b0cd-a31abf350047.png" width="200">
</p>

- Also, QR scanning codes below for checking in 410 C9 Building, then click Update Status:

<p align="center">
<img src="https://user-images.githubusercontent.com/97107855/193439217-1e0781cb-028f-417f-ae9e-da4c8a86f95a.png" width="200">

<img src="https://user-images.githubusercontent.com/58517115/197675993-bdd14b9f-39da-463a-9b0f-afd06e36b94e.png" width="200">
    
<img src="https://user-images.githubusercontent.com/97107855/193439239-b89867c9-bc59-4674-8bae-42fabb986d30.png" width="200">
          

</p>

- ***NOTE:*** user can only check in and update status as ONLINE between 8 a.m and 6 p.m everyday, including Saturday and Sunday. Outside these time range, "Update Status" button will return error dialog and user's status remains OFFLINE

</details>

<details>
<summary> 5.2. Scanning QR for info exchange:</summary>

- Please perform QR scanning QR codes below for info exchange, then click Open Contact From QR:

<p align="center">
<img src="https://user-images.githubusercontent.com/97107855/193439663-61dd0ac3-4367-4853-bc0d-1c134adb6a47.png" width="200">
<img src="https://user-images.githubusercontent.com/97107855/193439665-8d353306-2d6b-4d66-95bb-37d77e0f7d3b.png" width="200">
<img src="https://user-images.githubusercontent.com/97107855/193439667-d64fdb47-aae8-4552-96c3-c2ef22c30ac1.png" width="200">
</p>

- ***NOTE:*** These QR Codes above contain facebook and instagram link of Marc Zuckerberg (CEO of Meta), CR7 (a famous footballer) and Chelsea Football Club. The phone number and MS Teams account is random.

</details>


<details>
<summary> 5.2. Test case when scanning random QR code:</summary>

- Check out below random QR Codes, scan them with our app:

<p align="center">
<img src="https://user-images.githubusercontent.com/97107855/193439821-6d8c5e9c-2371-4b0c-b15e-6acc6c92e5ba.png" width="250">

<img src="https://user-images.githubusercontent.com/97107855/193439818-4d4df195-70ff-4651-be34-2e3b3d761745.png" width="250">
</p>


</details>

<details>
<summary> 5.3. Accounts used for testing, logging-in (starting from version 1.1.0):</summary>

- Please contact authors if you need accounts for testing, logging-in via email: son.tt2460M@sis.hust.edu.vn
- Members of CTARG and MAP will be provided with an account

</details>


## 6. Authors and credits:
In research and development process, all credits go to ***Son Tran BK (1st author), Duc Anh BK (2nd author) and CTARG LAB members***, in EEE, HUST (Hanoi University of Science and Technology), Ha Noi, Viet Nam


