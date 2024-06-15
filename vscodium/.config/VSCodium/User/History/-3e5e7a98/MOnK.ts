const fibonacci = (limit: number): Array<number> => {
  const arr: number[] = []

  for (let i = 0; i < limit; i++) {
    arr.push(arr[i] + i)
  }

  return arr
}

console.log(fibonacci(5))