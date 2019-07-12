# WTTextField

[![Version](https://img.shields.io/cocoapods/v/WTTextField.svg?style=flat)](https://cocoapods.org/pods/WTTextField)
[![Platform](https://img.shields.io/cocoapods/p/WTTextField.svg?style=flat)](https://cocoapods.org/pods/WTTextField)

## Description
WTTextField is a customizable text field which provides the functionality of both floating placehodler and inline error.
 - It has so many customizable properties so that you can change it according to your app theme.
 - you can add your own textField in it if you have any default one for your project.

![demo-video](https://github.com/WasiAtFolio3/WTTextField/blob/master/WTTextField-demo.gif)

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
![Adding-from-storyboard](https://github.com/WasiAtFolio3/WTTextField/blob/master/adding-from-storyboard.png)

Or you can simply initialize the WTTextField instance by initWithFrame initializer:
        
        let customTextfield = WTTextField(frame: .zero)
        self.view.addSubview(customTextfield)
        
     
## Customization
You can customize following properties of WTTextField:

    - placeHolder 
    - placeHolderColor
    - placeHolderFont
    - placeHolderFloatFont
    - textColor
    - textFieldFont
    - textFieldBackgroundColor
    - TextFieldBorderwidth
    - errorText
    - errorFont
    - errorColor
    - animationDuration

## Setting the Error
To set the textfield in showing error state , you just have to set the errorText property, and it will let textfield to show the error. yes its that simple :)
```
  customTextfield.errorText = "Invalid Email"
```
 to hide the error , just set the same property to nil.
 
 ```
 customTextfield.errorText = nil
 ```

## Have your own project TextField?
Have your own custom textfield of the project? No Problem , you can add your custom TextField to WTTextField to extend your textfield's fuctionality to showing floating placeholder and inline error.
```
customTextfield.setTextfield(yourProjectTextField)
```
That's all for now.
Happy Coding :)

## Author

WasiAtFolio3, mwasi@folio3.com

## License

WTTextField is available under the MIT license. See the LICENSE file for more info.
