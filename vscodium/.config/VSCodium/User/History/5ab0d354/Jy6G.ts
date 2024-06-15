type response = {
  
}
const numberList: number[] = Array.from(new Array(100), () => Math.round(Math.random() * 10))

const sequenceOfValues = (numberList: Array<number>): void => {

  const min: number = Math.min(...numberList)
  const max: number = Math.max(...numberList)

  const total: number = numberList.reduce((acc, number) => (acc + number), 0)
  const average: number = total / numberList.length

}

sequenceOfValues(numberList)