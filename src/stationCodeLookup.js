
var knownStationCodes = require('./knownStationCodes');

module.exports = function(stationCode) {
  /*if (stationCode === 'ace') {
    return 'A.C.E.!';
  }*/
  const name = knownStationCodes[stationCode.toUpperCase()];
  if (name === undefined) {
    return `Sorry, '${stationCode}' is not known as a British Rail station code`;
  }

  return `'${stationCode}' is the British Rail station code for
  '${name}'`;
};
