// Zen Browser overrides: re-applied on every start, they win over prefs.js.
// Changing one of these from the UI only lasts until the next restart: edit this file instead.

// Clean UI: compact mode with hidden toolbar and tab bar
user_pref("zen.view.compact.enable-at-startup", true);
user_pref("zen.view.compact.hide-toolbar", true);
user_pref("zen.view.compact.hide-tabbar", true);
user_pref("zen.view.compact.toolbar-flash-popup", true);

// Unload background tabs when RAM runs low (Zen ships this disabled)
user_pref("browser.tabs.unloadOnLowMemory", true);

// Save the session every 2 min instead of 40 s: fewer SSD writes
user_pref("browser.sessionstore.interval", 120000);
