function decode(message) {
  const stack = [];
  let current = "";

  for (const char of message) {
    if (char === "(") {
      // Guarda el contenido actual en la pila
      stack.push(current);
      current = "";
    } else if (char === ")") {
      // Invierte el contenido dentro de los paréntesis
      current = [...current].reverse().join("");
      // Extrae el último contenido de la pila y concaténalo
      if (stack.length > 0) {
        const last = stack.pop();
        current = last + current;
      }
    } else {
      // Añade el carácter al contenido actual
      current += char;
    }
  }

  return current;
}

const a = decode("hola (odnum)");
console.log(a); // hola mundo

const b = decode("(olleh) (dlrow)!");
console.log(b); // hello world!

const c = decode("sa(u(cla)atn)s");
console.log(c); // santaclaus
