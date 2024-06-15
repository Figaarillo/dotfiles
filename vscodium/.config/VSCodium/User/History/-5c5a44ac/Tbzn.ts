function main() {
  const input: string[] = "hello world".split("");
  const result = reverseString(input);

  console.log(result);
}

function reverseString(str: string[]): string[] {
  let j: number = 0
  console.log(str.length);
    for (let i = str.length - 1; i >= 0; i--, j++) {
      str[j] = str[i];
    }
  return str;
}

main();
