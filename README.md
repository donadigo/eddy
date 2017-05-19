# eddy

### Simple debian package installer for elementary OS

![screenshot](Screenshot.png)

Install, uninstall and view information about debian packages with easy to use graphical interface.

Eddy can also support other packaging formats such as .rpm thanks to it's PackageKit backend, although it's primary focus is still managing debian packages and elementary OS. 

## Installation

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

### Installing
`sudo make install`
