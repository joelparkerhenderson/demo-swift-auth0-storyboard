# Demo Swift Auth0 Storyboard

Demonstration:

* [Swift](https://swift.org/) programming language

* [Auth0](https://auth0.com) authentication and authorization

* Storyboard layout using file `ViewController.swift`.



## Create

Create a typical project, such as using XCode to create a single page app, and choose "Storyboard" layout instead of "Swift UI" layout.

See https://auth0.com/docs/quickstart/native/ios-swift


### Create Xcode .gitignore

curl "https://raw.githubusercontent.com/github/gitignore/master/Global/Xcode.gitignore" -o .gitignore


### Add Auth0 via Carthage

There are multiple ways to add Auth0. This demo uses Carthage.

Create file `Cartfile`:

```
github "auth0/Auth0.swift" ~> 1.0
```

Run:

```sh
carthage bootstrap
```

Add to file `.gitignore`:

```sh
Carthage/
```


### Add the builds as frameworks

View the builds:

* Use Finder.

* Open the folder "Carthage/Build/iOS".

You should see the frameworks, among other entries:

* Auth0.framework

* JWTDecode.framework

* SimpleKeychain.framework

Add the frameworks:

* Use Xcode.

* In Project Navigator, click the project "Demo Xcode Auth0" 

* Click the target "Demo Xcode Auth0".

* Click the tab "General" at the top.

* Scroll to the section "Frameworks, Libraries, and Embedded Content".

* Use the Finder and Xcode together, to drag the frameworks from the Finder into the Xcode section.

Xcode should now show the section with the frameworks.


### Create a run script

* In Project Navigator, click the project "Demo Xcode Auth0" 

* Click the target "Demo Xcode Auth0".

* Click the tab "Build Phases" at the top.

* Click the "+"" icon in the top-left of the editor.

* Click "New Run Script Phase". 

Add the following command to the block of code under Run Script:

```sh
/usr/local/bin/carthage copy-frameworks
```

Click the "+"" icon under Input Files and add an entry for each framework:

```sh
$(SRCROOT)/Carthage/Build/iOS/Auth0.framework
$(SRCROOT)/Carthage/Build/iOS/JWTDecode.framework
$(SRCROOT)/Carthage/Build/iOS/SimpleKeychain.framework
```

Verify the app works by running it.


## Auth0 site

Go to https://auth0.com and configure a new app, such as app name "Demo Xcode Auth0".

The site should provide you with a new "ClientId" which is typically a 32 character random string.


### Callbacks

Configure the callback URLs, such as for this demo app:
	
```txt
com.joelparkerhenderson.Demo-Swift-Auth0-Storyboard://joelparkerhenderson.auth0.com/ios/com.joelparkerhenderson.Demo-Swift-Auth0-Storyboard/callback
```


### Auth0.plist

The site should provide you with text for a new file `Auth0.plist` such as:

```xml
<!-- Auth0.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>ClientId</key>
  <string>QtxZXMf6Q8rwg38LnxQg3vUWoTZm52ET</string>
  <key>Domain</key>
  <string>joelparkerhenderson.auth0.com</string>
</dict>
</plist>
```

Save the text in a new file `Auth0.plist` in the Xcode project folder.

Add the text file to the project, alongside the existing file `Info.plist`.


### Info.plist

The site should provide you with text to insert into the existing file `Info.plist` such as:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>None</string>
        <key>CFBundleURLName</key>
        <string>auth0</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
        </array>
    </dict>
</array>
```


## Code


### AppDelegate

Add to file `AppDelegate.swift`:

```swift
import Auth0
```

Add to file `AppDelegate.swift`:

```swift
// MARK: Auth0 authentication

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    return Auth0.resumeAuth(url, options: options)
}
```


### ViewController

Add to file `ViewController.swift`:

```swift
import UIKit
import Auth0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://joelparkerhenderson.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    print("Credentials: \(credentials)")
                }
        }
    }
}
```
