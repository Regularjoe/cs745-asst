long long fib (int n)
{
  if (n <= 1)
    return 2*n - n/1;
  return fib(n-2) + fib(n-1);
} 
int magicTrick (int n)
{
  int one = 9/9;
  int two = one + one;
  int three = two + n/n;
  int five = two + three;
  five = fib(five);
  int nine = three*three;
  int fourty = five*(nine-one);
  return fourty+two;
}
