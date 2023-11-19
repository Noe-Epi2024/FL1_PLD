import { Model, Schema, model } from "mongoose";

interface Subtask {
    name: string;
    isDone: boolean;
}

type SubtaskSchema = Model<Subtask>;

const schema = new Schema<Subtask, SubtaskSchema>({
    name: { type: String, required: true },
    isDone: { type: Boolean, required: false, default: false },
});

export const SubtaskModel = model<Subtask, SubtaskSchema>("subtasks", schema);