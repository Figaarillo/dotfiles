import DomainFormatExeption from './domain-format.exeption'

class InvalidIdFormatException extends DomainFormatExeption {
  constructor() {
    super('Invalid Id Format')
  }
}

export default InvalidIdFormatException
