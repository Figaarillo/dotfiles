const fibonacci = (limit: number): Array<number> => {
  const arr: number[] = [0]

  for (let i = 1; i < limit; i++) {
    arr.push(arr[i-1] + i)
  }

  return arr
}

console.log(fibonacci(5))