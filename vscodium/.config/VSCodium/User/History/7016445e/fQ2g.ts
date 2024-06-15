const palindromo = (word: string): boolean => {
  const reverseWord = word.split('').reverse().join('')
  
  return word === reverseWord
}

const words: string[] = [
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

words.forEach(word => console.log(palindromo(word)));
