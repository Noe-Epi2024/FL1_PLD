import { ProjectModel } from "../../database/schema/projects";
import { UserModel } from "../../database/schema/users";
import { Token } from "../../types/token";
import { Request, Response } from 'express';
import { decodeAccessToken } from "../../functions/token/decode";
import { Member } from "../../types/members";

async function getMembers(req: Request, res: Response) {
    try {
        const token = req.headers.authorization;

        var id = req.params.id;

        if (!token || !id) {
            return res.status(400).send({ success: false, message: "No access token or Id provided" });
        }

        const userId = decodeAccessToken(token) as Token;

        const projects = await ProjectModel.findOne({ "_id": id })

        if (projects === null) {
            return res.status(409).send({ success: false, message: "Project not found" });
        }

        const MemberInProject = projects.members.find(member => String(member.userId) === userId.userId);

        if (!MemberInProject) {
            return res.status(409).send({ success: false, message: "Member not found in project" });
        }

        const response: Member[] = await Promise.all(projects.members.map(async (member) => {
            try {
                const user = await UserModel.findById(member.userId);
                if (user) {
                    return {
                        userId: member.userId,
                        role: member.role,
                        name: user.name
                    };
                } else {
                    throw new Error(`Member not found for member with ID: ${member.userId}`);
                }
            } catch (error) {
                console.error('Error fetching Member details:', error);
                return {
                    userId: member.userId,
                    role: member.role,
                    name: 'Unknown'
                };
            }
        }));

        return res.status(200).send({ success: true, message: "members list found", data: { members: response } });
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function postMember(req: Request, res: Response) {
    try {
        const token = req.headers.authorization;
        var id = req.params.id;

        if (!token || !id) {
            return res.status(400).send({ success: false, message: "No access token or Id provided" });
        }

        if (!req.body.userId || !req.body.role) {
            return res.status(400).send({ success: false, message: "No userId or role provided" });
        }

        const userId = decodeAccessToken(token) as Token;

        const projects = await ProjectModel.findOne({ "_id": id })

        if (projects === null) {
            return res.status(409).send({ success: false, message: "Project not found" });
        }

        const MemberInProject = projects.members.find(member => String(member.userId) === userId.userId);

        if (!MemberInProject) {
            return res.status(409).send({ success: false, message: "Member not found in project" });
        }

        if (MemberInProject.role !== "owner") {
            return res.status(409).send({ success: false, message: "Member not owner in project" });
        }

        const userExists = await UserModel.findOne({ _id: req.body.userId });

        if (!userExists) {
            return res.status(409).send({ success: false, message: "Member can not be added because it does not exist" });
        }

        const MemberAlreadyInProject = projects.members.find(member => String(member.userId) === req.body.userId);

        if (MemberAlreadyInProject) {
            return res.status(409).send({ success: false, message: "Member already in project" });
        }

        const newMember = {
            userId: req.body.userId,
            role: req.body.role
        };

        const newMembers = await ProjectModel.updateOne({ "_id": id }, { $push: { members: newMember } });

        return res.status(200).send({ success: true, message: "members added to the project" });
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function patchMember(req: Request, res: Response) {
    try {
        const token = req.headers.authorization;
        var id = req.params.id;

        if (!token || !id) {
            return res.status(400).send({ success: false, message: "No access token or Id provided" });
        }

        if (!req.body.userId || !req.body.role) {
            return res.status(400).send({ success: false, message: "No userId or role provided" });
        }

        const userId = decodeAccessToken(token) as Token;

        const projects = await ProjectModel.findOne({ "_id": id })

        if (projects === null) {
            return res.status(409).send({ success: false, message: "Project not found" });
        }

        const MemberInProject = projects.members.find(member => String(member.userId) === userId.userId);

        if (!MemberInProject) {
            return res.status(409).send({ success: false, message: "Member not found in project" });
        }

        if (MemberInProject.role !== "owner") {
            return res.status(409).send({ success: false, message: "Member not owner in project" });
        }

        const userExists = await UserModel.findOne({ _id: req.body.userId });

        if (!userExists) {
            return res.status(409).send({ success: false, message: "Member can't be added because it does not exist" });
        }

        const newMemberAlreadyInProject = projects.members.find(member => String(member.userId) === req.body.userId);

        if (!newMemberAlreadyInProject) {
            return res.status(409).send({ success: false, message: "Member not in project" });
        }

        const newMembers = await ProjectModel.updateOne({ "_id": id, "members.userId": req.body.userId }, { $set: { "members.$.role": req.body.role } });

        if (!newMembers || !newMembers.modifiedCount) {
            return res.status(400).send({ success: false, message: "Can't update member role" });
        }

        return res.status(200).send({ success: true, message: "member role has be changed" });
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

async function deleteMember(req: Request, res: Response) {
    try {
        const token = req.headers.authorization;
        var id = req.params.id;

        if (!token || !id) {
            return res.status(400).send({ success: false, message: "No access token or Id provided" });
        }

        if (!req.body.userId) {
            return res.status(400).send({ success: false, message: "No userId provided" });
        }

        const userId = decodeAccessToken(token) as Token;

        const projects = await ProjectModel.findOne({ "_id": id })

        if (projects === null) {
            return res.status(409).send({ success: false, message: "Project not found" });
        }

        const MemberInProject = projects.members.find(member => String(member.userId) === userId.userId);

        if (!MemberInProject) {
            return res.status(409).send({ success: false, message: "Member not found in project" });
        }

        if (MemberInProject.role !== "owner") {
            return res.status(409).send({ success: false, message: "Member not owner in project" });
        }

        const userExists = await UserModel.findOne({ _id: req.body.userId });

        if (!userExists) {
            return res.status(409).send({ success: false, message: "Member can not be deleted because it does not exist" });
        }

        const memberAlreadyInProject = projects.members.find(member => String(member.userId) === req.body.userId);

        if (!memberAlreadyInProject) {
            return res.status(409).send({ success: false, message: "Member not in project" });
        }

        const response = await ProjectModel.updateOne({ "_id": id }, { $pull: { members: { userId: req.body.userId } } });

        if (!response || !response.modifiedCount) {
            return res.status(400).send({ success: false, message: "Can't delete project" });
        }

        return res.status(200).send({ success: true, message: `Member removed` })
    }
    catch (error) {
        return res.status(409).send({ success: false, message: "Internal Server Error" });
    }
}

export { getMembers, postMember, patchMember, deleteMember }