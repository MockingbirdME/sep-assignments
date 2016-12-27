def fib(n)
  fib_0 = 0
  fib_1 = 1
  if n >= 1
    puts fib_0
  end
  if n >= 2
    puts fib_1
  end
  n -= 2
  while n > 0
    fib_2 = fib_0 + fib_1
    puts fib_2
    fib_0 = fib_1
    fib_1 = fib_2
    n -= 1
  end
end
