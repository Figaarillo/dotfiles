/*
En el archivo tarea2.js podemos encontrar un código de un supermercado que vende productos.
El código contiene 
    - una clase Producto que representa un producto que vende el super
    - una clase Carrito que representa el carrito de compras de un cliente
    - una clase ProductoEnCarrito que representa un producto que se agrego al carrito
    - una función findProductBySku que simula una base de datos y busca un producto por su sku
El código tiene errores y varias cosas para mejorar / agregar
​
Ejercicios
1) Arreglar errores existentes en el código
    a) Al ejecutar agregarProducto 2 veces con los mismos valores debería agregar 1 solo producto con la suma de las cantidades.    
    b) Al ejecutar agregarProducto debería actualizar la lista de categorías solamente si la categoría no estaba en la lista.
    c) Si intento agregar un producto que no existe debería mostrar un mensaje de error.
​
2) Agregar la función eliminarProducto a la clase Carrito
    a) La función eliminarProducto recibe un sku y una cantidad (debe devolver una promesa)
    b) Si la cantidad es menor a la cantidad de ese producto en el carrito, se debe restar esa cantidad al producto
    c) Si la cantidad es mayor o igual a la cantidad de ese producto en el carrito, se debe eliminar el producto del carrito
    d) Si el producto no existe en el carrito, se debe mostrar un mensaje de error
    e) La función debe retornar una promesa
​
3) Utilizar la función eliminarProducto utilizando .then() y .catch()
​
*/

// Cada producto que vende el super es creado con esta clase
class Producto {
  sku; // Identificador único del producto
  nombre; // Su nombre
  categoria; // Categoría a la que pertenece este producto
  precio; // Su precio
  stock; // Cantidad disponible en stock

  constructor(sku, nombre, precio, categoria, stock) {
    this.sku = sku;
    this.nombre = nombre;
    this.categoria = categoria;
    this.precio = precio;

    // Si no me definen stock, pongo 10 por default
    if (stock) {
      this.stock = stock;
    } else {
      this.stock = 10;
    }
  }
}

// Creo todos los productos que vende mi super
const queso = new Producto('KS944RUR', 'Queso', 10, 'lacteos', 4);
const gaseosa = new Producto('FN312PPE', 'Gaseosa', 5, 'bebidas');
const cerveza = new Producto('PV332MJ', 'Cerveza', 20, 'bebidas');
const arroz = new Producto('XX92LKI', 'Arroz', 7, 'alimentos', 20);
const fideos = new Producto('UI999TY', 'Fideos', 5, 'alimentos');
const lavandina = new Producto('RT324GD', 'Lavandina', 9, 'limpieza');
const shampoo = new Producto('OL883YE', 'Shampoo', 3, 'higiene', 50);
const jabon = new Producto('WE328NJ', 'Jabon', 4, 'higiene', 3);

// Genero un listado de productos. Simulando base de datos
const productosDelSuper = [
  queso,
  gaseosa,
  cerveza,
  arroz,
  fideos,
  lavandina,
  shampoo,
  jabon,
];

// Cada cliente que venga a mi super va a crear un carrito
class Carrito {
  productos; // Lista de productos agregados
  categorias; // Lista de las diferentes categorías de los productos en el carrito
  precioTotal; // Lo que voy a pagar al finalizar mi compra

  // Al crear un carrito, empieza vació
  constructor() {
    this.precioTotal = 0;
    this.productos = [];
    this.categorias = [];
  }

  /**
   * función que agrega @{cantidad} de productos con @{sku} al carrito
   */
  async agregarProducto(sku, cantidad) {
    Logger.show(
      `Agregando ${cantidad} ${
        cantidad < 2 ? 'unidad' : 'unidades'
      } de ${sku}...`
    );

    try {
      // Busco el producto en la "base de datos"
      Logger.show('Buscando producto en la base de datos...');
      const producto = await findProductBySku(sku);
      Logger.show('Producto encontrado');
      console.log({ producto });

      if (producto.stock < cantidad) {
        cantidad = producto.stock;
        Logger.show(
          `No existen suficientes productos en el stock del supermercado, por lo tanto solo podra llevar ${cantidad} de unidades`
        );
      }

      // Saca los productos del stock del supermercado
      this.#deceaseStockQuantity(sku, cantidad);

      // Verifica si el producto ya a sido agregado antes
      if (!this.#checkIfProductWasAdded(sku)) {
        Logger.show('Agregando el producto al carrito...');
        this.#addProducToCart(sku, producto.nombre, cantidad);
      } else {
        this.#increaseProductQuantity(sku, cantidad);
      }

      // Verifica que la categoria no se haya agregado antes
      if (!this.#checkIfCategoryAlredyExists(producto.categoria)) {
        Logger.show('Actualzando las categorías del carrito....');
        this.categorias.push(producto.categoria);
      }

      // Actualizar el precio
      this.precioTotal = this.precioTotal + producto.precio * cantidad;
      Logger.show('El producto fue agregado');
    } catch (error) {
      Logger.error(`Error! ${error}`);
    }
  }

  eliminarProducto(sku, quantity) {
    return new Promise((resolve, reject) => {
      Logger.show(
        `Eliminando ${quantity} ${
          quantity < 2 ? 'unidad' : 'unidades'
        } de ${sku}...`
      );

      Logger.show('Buscando producto en la base de datos...');
      findProductBySku(sku)
        .then(product => {
          Logger.show('Producto encontrado');
          console.log({ product });

          const currentProductQuantity = this.#quantityOfProductsInCart(sku);

          if (currentProductQuantity < quantity) {
            quantity = currentProductQuantity;
            Logger.show(
              `No existen suficientes productos agregador en el carrito del supermercado, por lo tanto solo podra llevar ${quantity} de unidades`
            );
          }

          // Saca los productos del stock del supermercado
          this.#decreaseProductQuantity(sku, quantity);

          this.#increaseStockQuantity(sku, quantity);

          this.productos = this.#checkAndRemoveDepletedProducts();

          resolve(this.productos);

          // Limpiar categorias
          // this.categorias = this.#cleanCategories()
        })
        .catch(error => reject(error));
    });
  }

  #checkIfProductWasAdded(sku) {
    return this.productos.find(product => product.sku === sku);
  }

  #addProducToCart(sku, name, quantity) {
    const nuevoProducto = new ProductoEnCarrito(sku, name, quantity);
    this.productos.push(nuevoProducto);
  }

  #checkIfCategoryAlredyExists(categoryToFind) {
    return this.categorias.find(category => category === categoryToFind);
  }

  #increaseProductQuantity(sku, quantity) {
    if (quantity) {
      const product = this.productos.find(product => product.sku === sku);
      product.cantidad += quantity;
    }
  }

  #decreaseProductQuantity(sku, quantity) {
    if (quantity) {
      const product = this.productos.find(product => product.sku === sku);
      product.cantidad -= quantity;
    }
  }

  #quantityOfProductsInCart(sku) {
    const product = this.productos.find(product => product.sku === sku);

    return product.cantidad;
  }

  showCurrenCar() {
    console.log(`
 Estado actual del carrito
---------------------------
productos:${this.productos.map(
      producto => `\n\t* ${producto.nombre} x ${producto.cantidad}`
    )}

categorias:${this.categorias.map(categoria => `\n\t* ${categoria}`)}

---------------------------
total: \t\t\t$${this.precioTotal}
    `);
  }

  #deceaseStockQuantity(sku, quantity) {
    const productToModify = productosDelSuper.find(
      product => product.sku === sku
    );
    productToModify.stock -= quantity;
    productosDelSuper.push(productToModify);
  }

  #increaseStockQuantity(sku, quantity) {
    const productToModify = productosDelSuper.find(
      product => product.sku === sku
    );
    productToModify.stock += quantity;
    productosDelSuper.push(productToModify);
  }

  #checkAndRemoveDepletedProducts() {
    const depletedProducts = this.productos.filter(
      product => product.cantidad === 0
    );

    this.#cleanCategories(depletedProducts);

    return this.productos.filter(product => product.cantidad !== 0);
  }

  #cleanCategories(products) {
    console.log(products)
    const categoriesBySku = productosDelSuper.filter(product => {
      console.log(`product sku: ${product.sku} | skus:${products} | includes?: ${products.includes(product.sku)} `)
      if (products.includes(product.sku)) {
        return product
      }
    });
    console.log(categoriesBySku);

    // const ctegoryBySku = productosDelSuper.filter(product => {
    //   if (product.sku === availableSku) {
    //   }
    // });

    // const categories = availableSku.map(
    //   ({ sku }) => productosDelSuper.find(p => p.sku === sku).categoria
    // );
  }
}

// Cada producto que se agrega al carrito es creado con esta clase
class ProductoEnCarrito {
  sku; // Identificador único del producto
  nombre; // Su nombre
  cantidad; // Cantidad de este producto en el carrito

  constructor(sku, nombre, cantidad) {
    this.sku = sku;
    this.nombre = nombre;
    this.cantidad = cantidad;
  }
}

class Logger {
  static show(message, long) {
    const length = long ? long + 2 : message.length + 2;
    console.log(`
+${'-'.repeat(length)}+
| ${message} |
+${'-'.repeat(length)}+`);
  }
  static error(message, long) {
    const length = long ? long + 2 : message.length + 2;
    console.error(`
${'#'.repeat(length)}
${message}
${'#'.repeat(length)}`);
  }
}

// Función que busca un producto por su sku en "la base de datos"
function findProductBySku(sku) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const foundProduct = productosDelSuper.find(
        product => product.sku === sku
      );
      if (foundProduct) {
        resolve(foundProduct);
      } else {
        reject(`Product ${sku} not found`);
      }
    }, 1500);
  });
}

(async () => {
  const carrito = new Carrito();
  await carrito.agregarProducto('WE328NJ', 2);
  // await carrito.agregarProducto('WE328NJ', 2);
  await carrito.agregarProducto('FN312PPE', 3);
  // await carrito.agregarProducto('FN312PPE', 3);
  // await carrito.agregarProducto('KS944RUR', 1);
  // await carrito.agregarProducto('KS944RUR', 1);
  // await carrito.agregarProducto('KS944RUR', 3);
  carrito
    .eliminarProducto('WE328NJ', 3)
    .then(result => console.log({ result }))
    .catch(error => console.log(error));
  // carrito.showCurrenCar();
})();
