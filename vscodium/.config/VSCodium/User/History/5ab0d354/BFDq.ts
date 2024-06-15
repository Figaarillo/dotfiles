const numberList: number[] = Array.from(new Array(100), () => Math.round(Math.random() * 10))

const sequenceOfValues = (numberList: Array<number>): void => {

  const min = Math.min(...numberList)
  const max = Math.max(...numberList)
  const average = Math.
}

sequenceOfValues(numberList)