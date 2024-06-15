const fibonacci = (limit: number): Array<number> => {
  const arr: number[] = [0, 1]

  for (let i = 1; i < limit; i++) {
    arr.push(arr[i-1]+ arr[i])
  }

  return arr
}

console.log(fibonacci(19))


const fibonacci02 = (limit: number): number[] => [0,1].reduce((acc, curr, i) => (acc = acc + curr[i-1] + curr[i]), 0)