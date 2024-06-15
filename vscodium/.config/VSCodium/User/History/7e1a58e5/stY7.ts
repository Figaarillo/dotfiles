import IBaseEntity from "@shared/domain/entities/base.interface";
import IUserPayload from "../payloads/user.payload";

interface IUserEntity extends IBaseEntity, IUserPayload {} 