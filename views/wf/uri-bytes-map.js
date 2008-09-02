function(doc) {
  //include-lib
  for (var i in doc.lines) {
    var bits = parseLine(doc.lines[i]);
    bits && emit(bits.uri, bits.bytes);
  }
};