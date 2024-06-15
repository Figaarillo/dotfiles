export class FirstName {
  readonly _value: string

  constructor(value: string) {
    this._value = value
  }
}

export class LastName {
	readonly _value: string

	constructor(value: string) {
		this.newMethod(value)
	}

	private newMethod(value: string) {
		this._value = value
	}
}