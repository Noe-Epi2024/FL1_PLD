import { Model, Schema, model } from "mongoose";

import { Project } from "../../types/projects";
import { Member } from "../../types/members";

const memberSchema = new Schema<Member>({
    userId: { type: String, required: true },
    role: { type: String, required: true },
});

interface UserMethods { }

type ProjectModel = Model<Project, {}, UserMethods>;

const schema = new Schema<Project, ProjectModel, UserMethods>({
    name: { type: String, required: true },
    members: { type: [memberSchema], required: true },
    tasks: { type: [String], required: true },
});

export const ProjectSchema = model<Project, ProjectModel>("Projects", schema);