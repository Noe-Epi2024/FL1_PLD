import { Model, Schema, model } from "mongoose";

import { Project } from "../../types/projects";
import { Member } from "../../types/members";

const memberSchema = new Schema<Member>({
    userId: { type: Schema.Types.ObjectId, required: true },
    role: { type: String, required: true },
});

type ProjectSchema = Model<Project>;

const schema = new Schema<Project, ProjectSchema>({
    name: { type: String, required: true },
    members: { type: [memberSchema], required: true },
    tasks: { type: [Schema.Types.ObjectId], required: true },
});

export const ProjectModel = model<Project, ProjectSchema>("projects", schema);