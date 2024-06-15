export class UserFirstName {
  private readonly _value: string

  constructor(value: string) {
    this._value = value
  }

  get value(): string {
    return this._value
  }
}

export class UserLastName {
  private readonly _value: string

  constructor(value: string) {
    this._value = value
  }

  get value(): string {
    return this._value
  }
}

export class UserPhoneNumber {
  private readonly _value: number

  constructor(value: number) {
    this._value = value
  }

  get value(): number {
    return this._value
  }
}

export class UserBirthday {
	private readonly _value: string

	constructor(value: string) {
		this._value = value
	}

	get value(): string {
		return this._value
	}
}
