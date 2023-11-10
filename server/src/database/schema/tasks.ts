import { Model, Schema, model } from "mongoose";

import { Task } from "../../types/tasks";

interface UserMethods { }

type TaskModel = Model<Task, {}, UserMethods>;

const schema = new Schema<Task, TaskModel, UserMethods>({
    name: { type: String, required: true },
    ownerId: { type: String, required: true },
    description: { type: String, required: false },
    startDate: { type: Date, required: false, default: new Date()},
    endDate: { type: Date, required: false},
    subtasks: { type: [String], required: false},
});

export const TaskSchema = model<Task, TaskModel>("Tasks", schema);