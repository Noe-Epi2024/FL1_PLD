import { Model, Schema, model } from "mongoose";

import { Task } from "../../types/tasks";
import { SubtasksSchema } from "./subtaks";

type TaskSchema = Model<Task>;

const TasksSchema = new Schema<Task, TaskSchema>({
    name: { type: String, required: true },
    ownerId: { type: String, required: true },
    description: { type: String, required: false, default: "" },
    startDate: { type: Date, required: false, default: new Date() },
    endDate: { type: Date, required: false },
    subtasks: { type: [SubtasksSchema], required: false, default: [] },
});

const TaskModel = model<Task, TaskSchema>("tasks", TasksSchema);

export { TaskModel, TasksSchema };