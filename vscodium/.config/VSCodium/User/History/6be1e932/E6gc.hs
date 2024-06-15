module Main where

import Data.List (intercalate)

-- Función para calcular la suma de los cuadrados de una lista de números
sumaCuadrados :: [Int] -> Int
sumaCuadrados = sum . map (^2)

-- Función para convertir una lista de cadenas en una cadena separada por comas
concatenarConComas :: [String] -> String
concatenarConComas = intercalate ", "

-- Función principal que realiza algunas operaciones y muestra los resultados
main :: IO ()
main = do
  let numeros = [1, 2, 3, 4, 5]
      suma = sum numeros
      sumaCuad = sumaCuadrados numeros

  putStrLn "¡Estética de Haskell!"
  putStrLn $ "Números: " ++ show numeros
  putStrLn $ "Suma: " ++ show suma
  putStrLn $ "Suma de cuadrados: " ++ show sumaCuad
