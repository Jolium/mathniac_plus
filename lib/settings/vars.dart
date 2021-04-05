/// Level vars
int vMagicLevel = 1; // 1..4...8...12..15

/// Goal level value
int vGoalValue = 10; // 10...14...18...22...25

/// Chosen nickname
String vNickname = '';

/// Selected values/numbers during game
List<int> vListOfSelectedValues = [];

/// Timer vars
int vStartCountdownValue = 300; // 450 is equal to 45 seconds
int vPointsToWinSecond = 25;

/// Settings: Sound
bool vPlaySound = true;

/// Settings: Background
bool vBackground = true;

/// Internet connectivity
bool vInternetConnection = false;

/// Upload score after high score with no internet connectivity
bool vUploadScore = false;
int vLeaderboardScore = 0;

/// Ads - only watch new ad after play once
bool vWatchAds = true;
