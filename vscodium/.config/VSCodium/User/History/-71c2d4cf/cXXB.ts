class Pedido {
  private estado: Estado;

  constructor(estado: Estado) {
    this.estado = estado;
  }

  crearDetalle() {
    this.estado.sayState();
  }
}

abstract class Estado {
  abstract sayState(): void;
}

class Confirmado extends Estado {
  sayState(): void {
    console.log("Confirmado");
  }
}

class Cancelado extends Estado {
  sayState(): void {
    console.log("Cancelado");
  }
}

const pedido = new Pedido(new Cancelado());
const pedido1 = new Pedido(new Confirmado());

pedido.crearDetalle();
pedido1.crearDetalle();

// -------------------------

class Estudiante {
  id: number;

  constructor(
    private nombre: string,
    private estado?: number,
  ) {
    this.id = Math.random();
  }
}

const estudiante = new Estudiante("jose");
const estudiante2 = new Estudiante("jose", 123);

console.log(estudiante);
console.log(estudiante2);

// -------------------------
interface IPersistencia {
  materializar(): void;
  dematerializar(): void;
}

class Alumno {
  constructor(private persistencia: IPersistencia) {}

  save(): void {
    this.persistencia.materializar();
  }

  delete(): void {
    this.persistencia.dematerializar();
  }
}

class Persistencia implements IPersistencia {
  materializar(): void {
    console.log("Materializado");
  }

  dematerializar(): void {
    console.log("Dematerializado");
  }
}

class PersistenciaAlternativa implements IPersistencia {
  materializar(): void {
    console.log("Materializado");
  }

  dematerializar(): void {
    console.log("Dematerializado");
  }
}

const persistencia = new Persistencia();
const persistencia2 = new PersistenciaAlternativa();

// class Alumno2 {
//   constructor(private persistencia) {}
//
//   save(): void {
//     this.persistencia.materializar();
//   }
//
//   delete(): void {
//     this.persistencia.dematerializar();
//   }
// }
//
// class Persistencia2 implements IPersistencia {
//   materializar(): void {
//     console.log("Materializado");
//   }
//
//   dematerializar(): void {
//     console.log("Dematerializado");
//   }
// }

// ----------------------------------------

// MAL
// class Equipo {
//   agregarJugador(jugador: any); // ???
// }

// BIEN
class Equipo {
  agregarJugador(jugador: Atleta) {
    console.log(jugador);
  }
}

interface Atleta {
  getDeporte(): string;
  jugar(): void;
}

class JugadorFutbol implements Atleta {
  getDeporte(): string {
    return "futbol";
  }
  jugar(): void {
    console.log("Jugando al futbol");
  }
}

class JugadorTenis implements Atleta {
  getDeporte(): string {
    return "tenis";
  }
  jugar(): void {
    console.log("Jugando al tenis");
  }
}
 
class JugadorBasquet implements Atleta {
  getDeporte(): string {
    return "basquet";
  }
  jugar(): void {
    console.log("Jugando al basquet");
  }
}

const fubolista = new JugadorFutbol();
const tenista = new JugadorTenis();
const basquetista = new JugadorBasquet();

const equipo = new Equipo();
equipo.agregarJugador(fubolista);
equipo.agregarJugador(tenista);
equipo.agregarJugador(basquetista);


// ------------

/** Hacer esto */
interface Report {
  genearateContent(): string
}

class ReportContent implements Report {
  genearateContent(): string {
    return "Reporte";
  }
}

class ReportPrinter {
  printReport(report: Report) {
    console.log(report.genearateContent());
  }
}

