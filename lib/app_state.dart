enum AppState {
  /// -1 => When state cannot recognised
  unknown,

  /// 0 => When app is running or active. The app is fully visible and interactive.
  foreground,

  /// 1 => When app is background. The app is in the background and is not visible on the screen.
  background,

  /// 2 => The app is visible but not interactive. You might use this state to pause ongoing tasks that do not need to run when the app is not interactive.
  /// Only for iOS
  inactive,

  /// 3 => When app is in kill state.
  killState
}
