const palindromo = (word: string): boolean => {
  const reverseWord = word.split('').reverse().join('')
  
  return word === reverseWord
}

const palabras: string[] = [
  "oso",
  "reconocer",
  "radar",
  "somos",
  "salas",
  "anita",
  "ana",
  "luzazul",
  "rotor",
  "cívico"
];

console.log(palindromo('axel'))
console.log(palindromo('neuquen'))