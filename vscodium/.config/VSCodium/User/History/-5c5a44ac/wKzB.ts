function main() {
  const input: string[] = "hello world".split("");
  const result = reverseString(input);

  console.log(result);
}

function reverseString(str: string[]): string[] {
  console.log(str.length);
    for (let i = str.length - 1; i >= 0; i--) {
      str[i] = str[i];
    }
  return str;
}

main();
