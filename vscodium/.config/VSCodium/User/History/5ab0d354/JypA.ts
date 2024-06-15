const sequenceOfValues = (limit: number): void => {
  const numberList = Array.from(new Array(limit), () => Math.random())

  console.log(numberList)
}