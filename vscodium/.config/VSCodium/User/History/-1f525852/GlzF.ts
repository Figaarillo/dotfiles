interface vehiculo {
  puertas: number
  color: string
  funcionando: boolean
  arrancar(): void
}

class Vehiculo implements Vehiculo {
  private readonly _puertas: number
  private readonly _color: string
  private readonly _funcionando: boolean

  constructor(puertas: number, color: string, funcionando: boolean) {
    this._puertas = puertas
    this._color = color
    this._funcionando = funcionando
  }

  get puertas(): number {
    return this._puertas
  }

  get color(): string {
    return this._color
  }

  get funcionando(): boolean {
    return this._funcionando
  }

  
}