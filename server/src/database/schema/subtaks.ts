import { Model, Schema, model } from "mongoose";

interface Subtask {
    name: string;
    isDone: boolean;
}

interface UserMethods { }

type SubtaskModel = Model<Subtask, {}, UserMethods>;

const schema = new Schema<Subtask, SubtaskModel, UserMethods>({
    name: { type: String, required: true },
    isDone: { type: Boolean, required: false, default: false },
});

export const SubtaskSchema = model<Subtask, SubtaskModel>("Subtasks", schema);