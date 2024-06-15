function main() {
  const input: string[] = "hello world".split("");
  const result = reverseString(input);

  console.log(result);
}

function reverseString(str: string[]): string[] {
  console.log(str.length);
    for (let i = str.length - 1, j=0; i >= 0; i--, j++) {
      str[j] = str[i];
    }
  return str;
}

main();
