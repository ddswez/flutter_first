
void main() {
  selectSort();
  countdown(4);
}

selectSort() {
  var list = [1,4,5,6,2,8,9,0];

  var temp;
  for (var i = 0; i< list.length - 1; i++) {
    var k = i;
    for(var j = k + 1; j< list.length; j++) {
      if (list[j] < list[k]) {
        k = j;
      }
    }

    if (i != k) {
      temp = list[i];
      list[i] = list[k];
      list[k] = temp;
    }
  }
  print(list);
}

countdown(int i) {
  if (i < 0) return;
  print(i);
  countdown(i-1);
}