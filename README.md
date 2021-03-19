# MNCapps 📱

| ![Screenshoot](https://firebasestorage.googleapis.com/v0/b/mnc-apps-libs.appspot.com/o/assets%2FSimulator%20Screen%20Shot%20-%20iPhone%20X%20-%202021-02-10%20at%2011.18.11.jpg?alt=media) | SDK to help you discover, and manage all MNC Apps to display it on your application |
|--|--|

## Feature

Dashboard Feature

- Manage Apps

- Customize Layout
- Customize Apps Order
- Manage Click Behaviour

Flutter SDK

- ShowAll MNC Apps

- Managed Button Click Behaviour

- InApp WebView

**Available in Android, IOS.**

Test Status :

- Android ✅ Done

- iOS ✅ Done

## How To Use

This lib currently using material theme, if you flutter app using cuppertino app. it may break

### [](#1-add-dependency)1. Add dependency

    mncapps: ^2.0.0

### [](#1-platform-spec)2. Platform specific

#### iOS

add this to ios/runner/info.plist

    <key>LSApplicationQueriesSchemes</key>
    <array>
    <string>okezonecom</string>
    <string>inewsapp</string>
    <string>sindonews</string>
    <string>thefthing</string>
    </array>   
These lines added for check  if the app installed or not, and open it.
The Schemes may **change** or will be **added** more.

#### Android

Good to go, nothing to add.

### [](#3-import)3. Import it

    import  'package:mncapps/mncapps.dart';

### [](#4-init)4. Use it

#### Use the body

    child: MNCAppsBody(userID: 'Your UserID'),

#### Navigate to MNCApps Screen/Page

    Navigator.push(context,MaterialPageRoute( builder: (context)=>MNCAppsScreen(userID: 'Your UserID')));

#### Optionaly add cache to it

    MNCAppsBody(
        userID: "YOUR USER ID",
        cachingStrategy: CachingStrategy.Weekly,
      )
