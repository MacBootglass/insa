#define VAL 10

int inc (int a) {
  return a+1;
}

int main() {
  int i = VAL;
  i = inc(i);
  printf("Bonjour, la valeur de i est %d\n", i);
  return i;
}
