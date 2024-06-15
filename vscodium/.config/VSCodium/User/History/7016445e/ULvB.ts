const palindromo = (word: string): boolean => {
  const reverseWord = word.split('').reverse().join('')
  
  return word === reverseWord
}

console.log(palindromo('axel'))
console.log(palindromo('neuquen'))