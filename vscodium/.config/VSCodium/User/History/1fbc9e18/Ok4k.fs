open System

let sum a b = a + b

[<EntryPoint>]
let main argv =
  printfn "%i" (sum 2 3)
  0 // return and integer to exit code

// --

let sayHello str = ${}
