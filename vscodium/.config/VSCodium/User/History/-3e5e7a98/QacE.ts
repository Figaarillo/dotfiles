const fibonacci = (limit: number): number => {
  const arr: number[] = [0]

  for (let i = 0; i < limit; i++) {
    arr.push(arr[i] + i)
  }

  return arr
}

console.log(fibonacci(3))