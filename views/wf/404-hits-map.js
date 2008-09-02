function(doc) {
  //include-lib
  for (var i in doc.lines) {
    var bits = parseLine(doc.lines[i]);
    if (bits && bits.status == '404') emit(bits.uri, bits.bytes);
  }
};