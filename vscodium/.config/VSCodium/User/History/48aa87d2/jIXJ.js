class Product {
  constructor(sku, name, price, category, stock = 10) {
    this.sku = sku;
    this.name = name;
    this.price = price;
    this.category = category;
    this.stock = stock;
  }
}

const queso = new Product('KS944RUR', 'Queso', 10, 'lacteos', 4);
const gaseosa = new Product('FN312PPE', 'Gaseosa', 5, 'bebidas');
const cerveza = new Product('PV332MJ', 'Cerveza', 20, 'bebidas');
const arroz = new Product('XX92LKI', 'Arroz', 7, 'alimentos', 20);
const fideos = new Product('UI999TY', 'Fideos', 5, 'alimentos');
const lavandina = new Product('RT324GD', 'Lavandina', 9, 'limpieza');
const shampoo = new Product('OL883YE', 'Shampoo', 3, 'higiene', 50);
const jabon = new Product('WE328NJ', 'Jabon', 4, 'higiene', 3);

const supermarketProducts = [
  queso,
  gaseosa,
  cerveza,
  arroz,
  fideos,
  lavandina,
  shampoo,
  jabon,
];

class Cart {
  constructor() {
    this.totalPrice = 0;
    this.products = [];
    this.categories = new Set();
  }

  async addProduct(sku, quantity) {
    Logger.show(
      `Agregando ${quantity} ${
        quantity < 2 ? 'unidad' : 'unidades'
      } de ${sku}...`
    );
    try {
      Logger.show('Buscando producto en la base de datos...');
      const product = await this.findProductBySku(sku);

      Logger.show('Producto encontrado');
      console.log({ product });

      if (product.stock < quantity) {
        quantity = product.stock;
        Logger.show(
          `No hay suficiente stock disponible. Se va a agregar ${quantity} ${
            quantity < 2 ? 'unidad' : 'unidades'
          }.`
        );
      }

      this.decreaseStockQuantity(sku, quantity);

      const productInCart = this.products.find(p => p.sku === sku);
      if (productInCart) {
        productInCart.quantity += quantity;
      } else {
        this.products.push(new ProductInCart(sku, product.name, quantity));
      }

      this.categories.add(product.category);

      this.totalPrice += product.price * quantity;
      Logger.show('El producto ha sido agregado al carrito.');
    } catch (error) {
      Logger.error(`Error! ${error}`);
    }
  }

  deleteProduct(sku, quantity) {
    return new Promise(async (resolve, reject) => {
      try {
        Logger.show(
          `Eliminando ${quantity} ${
            quantity < 2 ? 'unidad' : 'unidades'
          } de ${sku}...`
        );
        Logger.show('Buscando producto en la base de datos...');
        const product = await this.findProductBySku(sku);

        Logger.show('Producto encontrado');
        console.log({ product });

        const currentQuanity = this.getQuantityOfProductInCart(sku);
        if (currentQuanity < quantity) {
          quantity = currentQuanity;
          Logger.show(
            `No hay suficientes unidades en el carrito. Se eliminarán ${quantity} unidades.`
          );
        }

        this.decreaseProductQuantity(sku, quantity);
        this.inreaseStockQuantity(sku, quantity);

        this.products = this.products.filter(p => p.quantity !== 0);

        this.cleanCategories();

        resolve(this.products);
      } catch (error) {
        reject(error);
      }
    });
  }

  findProductBySku(sku) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const foundProduct = supermarketProducts.find(
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

  decreaseStockQuantity(sku, quantity) {
    const productToModify = supermarketProducts.find(
      product => product.sku === sku
    );
    productToModify.stock -= quantity;
  }

  inreaseStockQuantity(sku, quantity) {
    const productToModify = supermarketProducts.find(
      product => product.sku === sku
    );
    productToModify.stock += quantity;
  }

  decreaseProductQuantity(sku, quantity) {
    const product = this.products.find(product => product.sku === sku);
    product.quantity += quantity;
  }

  getQuantityOfProductInCart(sku) {
    console.log(this.products);
    const product = this.products.find(product => product.sku === sku);
    return product.quantity;
  }

  cleanCategories() {
    const skusToRemove = this.products
      .filter(product => product.quantity === 0)
      .map(product => product.sku);
    this.categorias = new Set(
      [...this.categories].filter(category => !skusToRemove.includes(category))
    );
  }

  showCurrentCart() {
    console.log(`
-----------------------------
| Estado actual del carrito |
-----------------------------
  Productos:${this.products.map(
    product => `\n\t* ${product.name} x ${product.quantity}`
  )}
|                           |
  Categorías:${[...this.categories].map(category => `\n\t* ${category}`)}
|                           |
-----------------------------
| Total: \t\t\t\t\t\t\t\t$${this.totalPrice} |
-----------------------------
    `);
  }
}

class ProductInCart {
  constructor(sku, name, quantity) {
    this.sku = sku;
    this.name = name;
    this.quantity = quantity;
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

(async () => {
  const cart = new Cart();
  await cart.addProduct('WE328NJ', 2);
  await cart.addProduct('WE328NJ', 2);
  await cart.addProduct('FN312PPE', 3);
  await cart.addProduct('FN312PPE', 3);
  await cart.addProduct('KS944RUR', 1);
  await cart.addProduct('KS944RUR', 1);
  await cart.addProduct('KS944RUR', 3);
  cart
    .deleteProduct('WE328NJ', 3)
    .then(() => cart.showCurrentCart())
    .catch(error => console.log(error));
  cart.showCurrentCart();
})();
