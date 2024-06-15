import {
  CreateDateColumn,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm'

abstract class BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string // al agregar !, se está indicando a TS que 'confie' en que el valor va a ser un string

  @CreateDateColumn({
    name: 'created_at',
    type: 'timestamp',
  })
  createdAt!: Date

  @UpdateDateColumn({
    name: 'updated_ad',
    type: 'timestamp',
  })
  updatedAt!: Date
}

export default BaseEntity
