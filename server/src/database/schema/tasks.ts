import { Model, Schema, model } from "mongoose";

import { Task } from "../../types/tasks";
import { SubtaskModel } from "./subtaks";

type TaskSchema = Model<Task>;

const schema = new Schema<Task, TaskSchema>({
    name: { type: String, required: true },
    ownerId: { type: String, required: true },
    description: { type: String, required: false, default: "" },
    startDate: { type: Date, required: false, default: new Date() },
    endDate: { type: Date, required: false },
    subtasks: { type: [SubtaskModel], required: false, default: [] },
});

export const TaskModel = model<Task, TaskSchema>("tasks", schema);