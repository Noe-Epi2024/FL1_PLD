import { Model, Schema, model } from "mongoose";

interface refreshToken {
    user_id: string;
    refreshToken: string[];
    created_at: Date;
}

interface UserMethods { }

type RefreshTokenModel = Model<refreshToken, {}, UserMethods>;

const schema = new Schema<refreshToken, RefreshTokenModel, UserMethods>({
    user_id: { type: String, required: true },
    refreshToken: { type: [String], required: true },
    created_at: { type: Date, default: Date.now },
});

export const RefreshTokenSchema = model<refreshToken, RefreshTokenModel>("token", schema);