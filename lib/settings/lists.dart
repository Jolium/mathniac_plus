/// List of randoms number to each button (max = 18 buttons)
List<int> listOfRandoms = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
];

/// List of selected buttons (true if selected (max = 18 buttons))
List<bool> listIsSelected = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

/// List of unlocked levels (14 levels + 1)
List<bool> listGotLevel = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

/// List of points for each level
List<int> listOfScorePoints = [
  130,
  150,
  170,
  200,
  230,
  260,
  290,
  330,
  370,
  410,
  450,
  500,
  550,
  600,
  0,
];

// List<int> listOfScorePoints = [
//   120,//130
//   140,//150
//   160,//170
//
//   200,//200
//   225,//230
//   250,//260
//   275,//290
//
//   300,//330
//   330,//370
//   360,//410
//   390,//450
//
//   420,//500
//   455,//550
//   490,//600
//   0,
// ];
// List<int> listOfScorePoints = [
//   500,
//   750,
//   1000,
//   2000,
//   2500,
//   3000,
//   3500,
//   5250,
//   6000,
//   6750,
//   7500,
//   10000,
//   11000,
//   12000,
//   0,
// ];

/// List of seconds for each level (milliseconds)
List<int> listOfSeconds = [
  300,
  350,
  400,
  400,
  450,
  500,
  550,
  500,
  550,
  600,
  650,
  600,
  650,
  700,
  750,
];

// List<int> listOfSeconds = [
//   300,
//   300,
//   300,
//   400,
//   400,
//   400,
//   400,
//   500,
//   500,
//   500,
//   500,
//   600,
//   600,
//   600,
//   750,
// ];

/// Firebase
List<dynamic> listOfAllNames = [];
List<dynamic> listOfScores = [];
