import IBaseEntity from "@shared/domain/entities/base.interface";
import IUserPayload from "../payloads/user.payload";

type NewType = IBaseEntity;

interface IUserEntity extends NewType, IUserPayload {} 