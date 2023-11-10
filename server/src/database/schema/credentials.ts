import { Model, Schema, model } from "mongoose";

interface Credential {
    name: string;
    password: string;
}

interface UserMethods { }

type CredentialModel = Model<Credential, {}, UserMethods>;

const schema = new Schema<Credential, CredentialModel, UserMethods>({
    name: { type: String, required: true },
    password: { type: String, required: true },
});

export const CredentialSchema = model<Credential, CredentialModel>("credentials", schema);