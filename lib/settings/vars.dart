/// Level vars
int vMagicLevel = 1; // 1..4...8...12..15

int vGoalValue = 10; // 10...14...18...22...25

String vNickname = '';

int vActualScoreValue = 0; // 0

List<int> vListOfSelectedValues = [];

/// Timer vars
bool vIsTimerTicking = false;
bool vStartTimer = false;
int vStartCountdownValue = 300; // 450 is equal to 45 seconds
int vCountdownValue = vStartCountdownValue;
double vExtraTime = 0.0;
int vPointsToWinSecond = 25;

bool vPlayLevelUp = true;

String vButtonText = ' Start ';
bool vButtonGradient = true;

/// Sound
bool vPlaySound = true;

/// Background
bool vBackground = true;

/// Internet connectivity
bool vInternetConnection = false;

/// Upload score after high score with no internet connectivity
bool vUploadScore = false;
int vLeaderboardScore = 0;

/// Ads
bool vWatchAds = true;
