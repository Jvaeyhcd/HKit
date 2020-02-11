# HcdKit
[![Version](https://img.shields.io/cocoapods/v/HcdKit.svg?style=flat)](http://cocoapods.org/pods/HcdKit)
[![Top](https://img.shields.io/github/languages/top/Jvaeyhcd/HKit)](http://cocoapods.org/pods/HcdKit)
[![Platform](https://img.shields.io/cocoapods/p/HcdKit.svg)](http://cocoapods.org/pods/HcdKit)
[![License](https://img.shields.io/cocoapods/l/HcdKit.svg)](http://cocoapods.org/pods/HcdKit)
[![Author](https://img.shields.io/badge/author-Jvaeyhcd-f07c3d.svg)](http://blog.jvaeyhcd.wang)

A UI collection by myself.

## Installation

### Manual Install
All you need to do is drop `HKit` files into your project.

### CocoaPods
The recommended approach for installating `HKit` is via the CocoaPods package manager, as it provides flexible dependency management and dead simple installation. For best results, it is recommended that you install via CocoaPods >= 0.28.0 using Git >= 1.8.0 installed via Homebrew.

Install CocoaPods if not already available:
```
$ [sudo] gem install cocoapods
$ pod setup
```
Change to the directory of your Xcode project:
```
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```
Edit your Podfile and add `HKit`:
```
platform :ios, '8.0'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
target 'MyProject' do
  pod 'HKit'

end
```
Install into your Xcode project:
```
$ pod install
```
Open your project in Xcode from the .xcworkspace file (not the usual project file)
```
$ open MyProject.xcworkspace
```