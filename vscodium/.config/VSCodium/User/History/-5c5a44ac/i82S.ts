function main() {
  const input: string[] = "hello world".split("");
  const result = reverseString(input);
  const result2 = input.reverse();

  console.log(result);
  console.log(result2);
}

const reverseString = (str: string[]): string[] => {
  for (let i = str.length - 1, j = 0; i >= 0; i--, j++) {
    str[j] = str[i];
  }
  return str;
}

main();