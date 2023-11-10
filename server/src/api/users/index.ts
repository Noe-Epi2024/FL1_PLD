import { UserSchema } from "../../database/schema/users";
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

        const user = await UserSchema.findById(accessToken.user_id);

        if (!user) {
            return res.status(400).send({ success: false, message: "No user found" });
        }

        res.status(200).send({ success: true, name: user.name, photo: user.photo });
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

        const filter = accessToken.user_id;
        const update = req.body;

        const user = await UserSchema.findOne({ _id: filter });

        if (!user) {
            return res.status(409).send("User not found");
        }

        const response = await UserSchema.updateOne({ _id: filter }, update);

        if (!response || !response.acknowledged) {
            return res.status(400).send("Can't update user, data invalid");
        }

        res.status(200).send({ success: true, message: "Value successfully modified" });
    } catch (err) {
        console.log(err);
    }
}

export { getMe, patchMe };