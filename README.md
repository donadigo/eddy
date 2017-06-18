# Eddy

### Simple debian package installer for elementary OS
[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.donadigo.eddy)

![screenshot](Screenshot.png)

Install, update, uninstall and view information about debian packages with easy to use graphical interface.

Eddy can also support other packaging formats such as .rpm thanks to it's PackageKit backend, although it's primary focus is managing debian packages and being designed for elementary OS. 

## Installation
If you are on elementary OS you can just click this button and it will redirect you to an AppCenter page!
[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.donadigo.eddy)

### Dependencies
These dependencies must be present before building
 - `valac`
 - `gtk+-3.0`
 - `granite`
 - `packagekit-glib2`
 - `unity`
 
 You can install these on a Ubuntu-based system by executing this command:
 
 `sudo apt install valac libgranite-dev libpackagekit-glib2-dev libunity-dev`

### Building
```
mkdir build
cd build
cmake ..
make
```

### Installing & executing
```
sudo make install
com.github.donadigo.eddy
```
