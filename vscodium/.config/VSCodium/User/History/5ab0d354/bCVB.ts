type response = {
  min: number,
  max: number,
  average: number
}
const numberList: number[] = Array.from(new Array(100), () => Math.round(Math.random() * 10))

const sequenceOfValues = (numberList: Array<number>): response => {

  const min: number = Math.min(...numberList)
  const max: number = Math.max(...numberList)

  const total: number = numberList.reduce((acc, number) => (acc + number), 0)
  const average: number = total / numberList.length

  return { min, max, average
  }
}

sequenceOfValues(numberList)