# Swolemates

Implements a state management approach using the Provider package.

lib/main.dart
Here the app sets up objects it needs to track state: a catalog and a shopping cart. It builds a MultiProvider to provide both objects at once to widgets further down the tree.

lib/models/*
This directory contains the model classes that are provided in main.dart. These classes represent the app state.

lib/screens/*
This directory contains widgets used to construct the screens of the app: the matches, profile, and chat page. These widgets have access to the current state of both the user data via ChangeNotifierProvider
