# DSNightVersion
A light weight framework adds night version to your app.

[![Build Status](https://travis-ci.org/Draveness/DKNightVersion.png)](https://travis-ci.org/Draveness/DKNightVersion)
# Installation with CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like DKNightVersion in your projects.

## Podfile

Add this line of code to your pod file.

```
pod "AFNetworking", "~> 0.3.0"
```

Run `pod install`, and just wait.

# Usage

This framework is based on a property `nightColor`, such as `nightBackgroundColor` `nightTextColor`...

Import `DKNightVersion` with:

```
#import "DKNightVersion.h"
```

Assign the night version color you want to the `UIKit` component:

```
self.view.nightBackgroundColor = [UIColor blackColor];
self.label.nightTextColor = [UIColor whiteColor];
```

And then use `DKNightManager` sets the `themeVersion`.

```
[[DKNightVersionManager sharedNightVersionManager] setThemeVersion:DKThemeVersionNight];
```

If you want to back to normal theme version, use `DKThemeVersionNormal` instead.

# Contact

- [Draveness](http://github.com/draveness)

# License

DKNightVersion is available under the MIT license. See the LICENSE file for more info.