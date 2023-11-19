import { UserModel } from "../../database/schema/users";
import { Token } from "../../types/token";
import { Request, Response } from 'express';
import { decodeAccessToken } from "../../functions/token/decode";

async function getMe(req: Request, res: Response) {
    try {
        const userId = req.headers.authorization;

        if (!userId) {
            return res.status(400).send({ success: false, message: "No access token sent" });
        }

        const accessToken = decodeAccessToken(userId) as Token;

        if (!accessToken) {
            return res.status(400).send({ success: false, message: "Invalid access token" });
        }

        const user = await UserModel.findById(accessToken.userId);

        if (!user) {
            return res.status(409).send({ success: false, message: "No user found" });
        }

        res.status(200).send({ success: true, email: user.email, name: user.name, photo: user.photo });
    } catch (err) {
        console.log(err);
    }
}

async function patchMe(req: Request, res: Response) {
    try {
        const userId = req.headers.authorization;

        if (!userId) {
            return res.status(400).send({ success: false, message: "No access token sent" });
        }

        const accessToken = decodeAccessToken(userId) as Token;

        if (!accessToken) {
            return res.status(400).send({ success: false, message: "Invalid access token" });
        }

        const filter = accessToken.userId;
        const update = req.body;

        const user = await UserModel.findOne({ _id: filter });

        if (!user) {
            return res.status(409).send({success: false, message: "User not found"});
        }

        const response = await UserModel.updateOne({ _id: filter }, update);

        if (!response || !response.acknowledged) {
            return res.status(400).send({success: false, message: "Can't update user, data invalid"});
        }

        res.status(200).send({ success: true, message: "Value successfully modified" });
    } catch (err) {
        console.log(err);
    }
}

export { getMe, patchMe };