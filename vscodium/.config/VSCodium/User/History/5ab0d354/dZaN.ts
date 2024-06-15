const numberList: Array<number> = Array.from(new Array(100), () => Math.round(Math.random() * 10))

const sequenceOfValues = (): void => {

  console.log(numberList)
}

sequenceOfValues(10)