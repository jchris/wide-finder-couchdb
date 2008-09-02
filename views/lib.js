function parseLine(line) {
  var p = line.split(/\s+/);
  if (p[5] != '"GET') return null;
  return {
    client : p[0],
    uri : p[6],
    status : p[8],
    bytes : parseInt(p[9]),
    ref : p[10]
  }
};