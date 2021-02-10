# MNCapps 📱
| ![Screenshoot](https://firebasestorage.googleapis.com/v0/b/mnc-apps-libs.appspot.com/o/assets%2FSimulator%20Screen%20Shot%20-%20iPhone%20X%20-%202021-02-10%20at%2011.18.11.jpg?alt=media) | SDK to help you discover, and manage all MNC Apps to display it on your application |
|--|--|

## Feature 
Dashboard Feature
-   Manage Apps
-   Customize Layout
-   Customize Apps Order
-   Manage Click Behaviour

Flutter SDK
-  Show All MNC Apps 
-  Managed Button Click Behaviour
-  InApp WebView

**Available in Android, IOS.**

Test Status :

-   Android ✅ Done
-   iOS ✅ Done

##  How To Use 
This lib currently using material theme, if you flutter app using cuppertino app. it may break

### [](#1-add-dependency)1. Add dependency

	mncsso:
	    git: https://mnc-repo.mncdigital.com/mobiledevadmin/mnc-ssosdk-flutter
		
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
### [](#3-init)3. Import and Initialize it

	import  'package:mncapps/mncapps.dart';
	
	MNCapps.init(userID:  'YourUSERID');

### [](#4-init)4. Use it
#### Navigate to MNCApps Screen/Page

    Navigator.push(context,MaterialPageRoute( builder: (context)=>MNCAppsScreen()));

or
#### Use the body 
	child: MNCAppsBody()