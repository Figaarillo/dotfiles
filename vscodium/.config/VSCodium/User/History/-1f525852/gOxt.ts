interface vehiculo {
  puertas: number
  color: string
  funcionando: boolean
  arrancar(): void
}

class Vehiculo implements Vehiculo {
  private readonly puertas: number
  private readonly color: string
  private readonly funcionando: boolean

  constructor(puertas: number, color: string, funcionando: boolean) {
    this.puertas = puertas
    this.color = color
    this.funcionando = funcionando
  }
}