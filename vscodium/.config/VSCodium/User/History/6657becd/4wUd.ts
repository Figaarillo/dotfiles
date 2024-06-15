class UserGetterUseCase {
	#some: string
	constructor() {
		this.#some = ''
	}
	
	get some(): string {
		return this.#some
	}
}
