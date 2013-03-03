ADNKit
======

ADNKit is a Objective-C framework for building App.net iOS and OS X applications. The guiding design principles are:
* Simple and easy to understand API
* Very quick to get started and past App.net Auth
* 100% ADN API support
* Useful convenience methods and objects
* AFNetworking should be the only dependency

# Current State
ADNKit is very much a work in progress right now, and 100% of the ADN API has not yet been reached.

# Getting Started
### Installation
ADNKit makes use of submodules for its dependencies. After cloning the repo, make sure to run `git submodule update --init --recursive` from the top level before trying to build the code. There is also a Releases folder containing stable binary releases.

**It's also important to note that AFNetworking is compiled in as part of the library and does not need to be added to your project.**

### Your First App.net App
(very easy tutorial showing how brilliantly easy auth is, and also showing how to get the current user, fetch the user's stream, and make a post)

# Dependencies
ADNKit uses the following dependencies:
* AFNetworking

The following built-in frameworks are used:
* Core Location
* SystemConfiguration
* MobileCoreServices (iOS only)
