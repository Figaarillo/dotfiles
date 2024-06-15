import { Column, Entity } from 'typeorm'
import BaseEntity from '../config/base.entity'

@Entity({ name: 'user' })
class UserEntity extends BaseEntity {
  @Column()
  username!: string

  @Column()
  name!: string

  @Column()
  lastname!: string

  @Column({ nullable: true })
  jobPosition!: string

  @Column()
  numberPhone!: number
}

export default UserEntity
