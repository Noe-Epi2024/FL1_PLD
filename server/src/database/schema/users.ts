import { Model, Schema, model } from "mongoose";

interface User {
    name: string;
    photo: string;
}

interface UserMethods { }

type UserModel = Model<User, {}, UserMethods>;

const schema = new Schema<User, UserModel, UserMethods>({
    name: { type: String, required: true },
    photo: {
        type: String,
        required: false,
        default: "default",
    },
});

export const UserSchema = model<User, UserModel>("users", schema);