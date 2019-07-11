# WTTextField

[![Version](https://img.shields.io/cocoapods/v/WTTextField.svg?style=flat)](https://cocoapods.org/pods/WTTextField)
[![Platform](https://img.shields.io/cocoapods/p/WTTextField.svg?style=flat)](https://cocoapods.org/pods/WTTextField)

## Description
WTTextField is a customizable text field which provides the functionality of both floating placehodler and inline error.
 - It has so many customizable properties so that you can change it according to your app theme.
 - you can add your iwn textField in it if you have any default one for your project.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
WTTextField requires iOS 9.0 or later

## Installation

WTTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WTTextField'
```

## Usage 
You can add WTTextField through your storyboard by subclassing your View and edit its properties right through from storyboard.


Or you can simply initialize the WTTextField instance by initWithFrame initializer:
        
        let customTextfield = WTTextField(frame: .zero)
        self.view.addSubview(customTextfield)
        
        

## Author

WasiAtFolio3, mwasi@folio3.com

## License

WTTextField is available under the MIT license. See the LICENSE file for more info.
