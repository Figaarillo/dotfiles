import {
  CreateDateColumn,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm'

abstract class BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  // eslint-disable-next-line indent
  id!: string // al agregar !, se está indicando a TS que 'confie' en que el valor va a ser un string

  @CreateDateColumn({
    name: 'created_at',
    type: 'timestamp',
  })
  // eslint-disable-next-line indent
  createdAt!: Date

  @UpdateDateColumn({
    name: 'updated_ad',
    type: 'timestamp',
  })
  // eslint-disable-next-line indent
  updatedAt!: Date
}

export default BaseEntity
