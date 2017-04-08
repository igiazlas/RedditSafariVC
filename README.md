# Reddit Safari VC

## Description
This is a tweak for the [official Reddit iOS app](https://itunes.apple.com/us/app/reddit-the-official-app/id1064216828?mt=8). It replaces the custom WebView broswer that they use with the native [SFSafariViewController](https://developer.apple.com/reference/safariservices/sfsafariviewcontroller)

## Motivation
While there's nothing wrong with the WebView browser that the app uses I prefer the native browser. SFSafariViewControllers are as close as it gets to the native Safari.app. They use all the extensions that you've installed (e.g. AdBlockers) and they also include the Reader View. Also open in links work better.

## Build instructions
1. Install [Theos](https://github.com/theos/theos/wiki/Installation)
2. Clone the repo to a directory of your choosing
3. Navigate to that directory and run `make package`
4. Install the produced deb from the packages directory

If you want to package and install with one move  

0. Make sure you have SSH installed on the device
1. type `export THEOS_DEVICE_IP=your_iphones_ip_address`
2. type `export THEOS_DEVICE_PORT=your_iphones_ssh_port` if necessary (if the ssh client on our iPhone does not use the standard port 22)
3. type `make package install`

## Licence
[MIT licence](https://opensource.org/licenses/MIT)
