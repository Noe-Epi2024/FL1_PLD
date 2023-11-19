import { ProjectModel } from "../../database/schema/projects";
import { Token } from "../../types/token";
import { Request, Response } from 'express';
import { decodeAccessToken } from "../../functions/token/decode";
import tokenToEmail from "../../functions/token/tokenToEmail";
import { Project } from "../../types/projects";

async function getProject(req: Request, res: Response) {
    try {
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function getProjects(req: Request, res: Response) {
    try {
        const token = req.headers.authorization;

        if (!token) {
            return res.status(400).send({ success: false, message: "No access token sent" });
        }

        const userId = decodeAccessToken(token) as Token;

        const projects = await ProjectModel.find({ "members.userId": userId.userId })

        return res.status(200).send({ success: true, message: "Projects found", projects: projects });
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function postProject(req: Request, res: Response) {
    try {
        const token = req.headers.authorization;
        const name = req.body.name;

        if (!token) {
            return res.status(400).send({ success: false, message: "No access token sent" });
        }

        const userId = decodeAccessToken(token) as Token;

        const existingProject = await ProjectModel.findOne({ "name": name, "members.userId": userId.userId })

        console.log(existingProject);

        if (existingProject) {
            return res.status(409).send({ success: false, message: "Project already exists" });
        }

        const projects = await ProjectModel.create({
            name: name,
            members: [
                { userId: userId.userId, role: 'owner' }
            ],
            tasks: []
        });

        return res.status(200).send({ success: true, message: `Project '${name}' created` });
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function patchProject(req: Request, res: Response) {
    try {
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function deleteProject(req: Request, res: Response) {
    try {
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

export {
    getProject,
    getProjects,
    postProject,
    patchProject,
    deleteProject,
}