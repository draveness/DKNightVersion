# DSNightVersion
A light weight framework adds night version to your app.

[![Build Status](https://travis-ci.org/Draveness/DKNightVersion.png)](https://travis-ci.org/Draveness/DKNightVersion)

# Installation with CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like DKNightVersion in your projects. See the [Get Started section](https://cocoapods.org/#get_started) for more details.

## Podfile

```
pod "AFNetworking", "~> 0.3.1"
```

## Usage

```
#import "DKNightVersion.h"
```

----

# How to use

API documentation is not available now.

## Using night color

This framework is based on a property `nightColor`, such as `nightBackgroundColor` `nightTextColor`...

Assign the night version color you want to the `UIKit` component:

```
self.view.nightBackgroundColor = [UIColor blackColor];
self.label.nightTextColor = [UIColor whiteColor];
```

## Using DKNightVersionManager change theme

Use `DKNightVersionManager` sets the `themeVersion`.

```
[[DKNightVersionManager sharedNightVersionManager] setThemeVersion:DKThemeVersionNight];
```

If you want to back to normal theme version, use `DKThemeVersionNormal` instead.

## Using property table generate color

`property_table.yaml` is a file which saves the night color you need, if the exising colors is not enough for you, add the `class` and `property` in it.

```
UIView:
  properies:
    - backgroundColor
UILabel:
  superclass: UIView
  properies:
    - textColor
```

Notice the superclass property is needed if it has a superclass.

```
ruby objc_generator.rb
```

Run this command in `Classes/Generator` folder, this will dynamically generate Objective-C code in `Classes/UIKit` folder. 

Drag them in your workspace. And then everything works fine.

# Contact

- [Draveness](http://github.com/draveness)
- Personal website [DeltaX](http://deltax.me)

# License

DKNightVersion is available under the MIT license. See the LICENSE file for more info.