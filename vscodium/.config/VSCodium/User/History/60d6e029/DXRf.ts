import { type Request, type Response } from 'express'
import PurchaseController from './controllers/purchase.controller'
import BaseRouter from '../shared/router/router'
import PurchaseMiddleware from './middlewares/purchase.middleware'

class PurchaseRouter extends BaseRouter<
  PurchaseController,
  PurchaseMiddleware
> {
  constructor() {
    super(PurchaseController, PurchaseMiddleware)
  }

  routes(): void {
    this.router.get('/purchases', (req: Request, res: Response) => {
      this.controller.getPurchases(req, res)
    })

    this.router.get('/purchases/:id', (req: Request, res: Response) => {
      this.controller.getPurchaseById(req, res)
    })

    this.router.post(
      '/purchases',
      (req, res, next) => {
        this.middleware.purchaseValidator(req, res, next)
      },
      (req: Request, res: Response) => {
        this.controller.createPurchase(req, res)
      }
    )

    this.router.put('/purchases/:id', (req: Request, res: Response) => {
      this.controller.updatePurchase(req, res)
    })

    this.router.delete('/purchases/:id', (req: Request, res: Response) => {
      this.controller.deletePurchase(req, res)
    })
  }
}

export default PurchaseRouter
