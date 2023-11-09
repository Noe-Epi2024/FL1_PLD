import { Model, Schema, model } from "mongoose";

interface User {
    email: string;
    role: "utilisateur" | "admin";
    name: string;
    surname: string;
    birthDate: string;
    phoneNumber: string;
    photo: string;
    validated: boolean;
}

interface UserMethods { }

type UserModel = Model<User, {}, UserMethods>;

const schema = new Schema<User, UserModel, UserMethods>({
    email: { type: String, required: true },
    name: { type: String, required: true },
    surname: { type: String, required: true },
    birthDate: { type: String, required: true },
    phoneNumber: { type: String, required: true },
    role: { type: String, required: true, default: "utilisateur" },
    photo: {
        type: String,
        required: false,
        default: "default",
    },
    validated: { type: Boolean, required: true, default: false },
});

export const UserSchema = model<User, UserModel>("users", schema);