const sequenceOfValues = (limit: number): void => {
  const numberList = Array.from(new Array(limit), () => Math.round(Math.random()*10))

  console.log(numberList)
}

sequenceOfValues(10)