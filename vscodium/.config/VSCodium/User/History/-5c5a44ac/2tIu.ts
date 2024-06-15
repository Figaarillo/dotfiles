function main() {
  const input: string[] = "hello world".split("");
  const result = reverseString(input);

  console.log(result);
}

function reverseString(str: string[]): string[] {
  console.log(str.length);
  str.map((_, j) => {
    console.log(";lkasdfjl;aksjrfawlk");
    for (let i = str.length-1; i >= 0;i-=1) {
      console.log(str[i]);
      console.log(i);
      console.log(str[i]);
      return (str[j] = str[i]);
    }
  });
  return str;
}

main();
