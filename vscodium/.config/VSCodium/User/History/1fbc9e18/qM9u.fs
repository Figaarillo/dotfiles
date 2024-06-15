open System

let sum a b = a + b

let sayHello name = $"Hello {name}"

[<EntryPoint>]
let main argv =
  printfn "%i" (sum 2 3)

  let result =  (sayHello "Axel")
  printfn $"{result}"

  let languages = ["C#"; "Java"; "Python"; "Golang"]
  for l in languages do
    printfn "%s" l

  Languages
  |> List.map sayHello
  |> List.iter (fun l -> printfn "%s" l)
  
  0 // return and integer to exit code
