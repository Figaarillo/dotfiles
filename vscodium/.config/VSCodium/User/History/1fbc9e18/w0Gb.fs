open System

let sum a b = a + b

let sayHello name = $"Hello {name}"

[<EntryPoint>]
let main argv =
  printfn "%i" (sum 2 3)
  let result =  (sayHello "Axel")
  printfn "%i" (result)
  0 // return and integer to exit code
