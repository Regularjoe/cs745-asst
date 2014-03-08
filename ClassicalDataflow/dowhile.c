int sum (int a, int b)
{
  int x = 0;
  do
  {
    int c = -2; // should stay in the loop
    int d = a + b; // should move out of the loop
    x += c;
    x += d;
    if (x < 0 || c < 8)
      c++;
  }
  while (x < 42);
  return x;
}
