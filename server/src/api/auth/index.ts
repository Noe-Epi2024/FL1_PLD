import { UserSchema } from "../../database/schema/users";
import { CredentialSchema } from "../../database/schema/credentials";
import { User, Credential } from "../../types/users";
import { pbkdf2Sync, randomBytes } from "crypto";
import { generateAccessToken } from "../../functions/token/generate";
import { Request, Response } from 'express';
import * as dotenv from "dotenv";
dotenv.config();


async function userRegister(req: Request, res: Response) {
    try {
        const userData: User = req.body;
        const userCredentials: Credential = req.body;

        // Get user input
        if (!(userCredentials.name && userCredentials.password )) {
            res.status(400).send("All input with red asterix are required");
        }

        // check if user already exist
        const oldUser = await UserSchema.findOne({ name: userCredentials.name.toLowerCase() });

        if (oldUser) {
            return res.status(409).send("User Already Exist. Please Login");
        }

        // Generate a random salt
        const salt = randomBytes(16).toString('hex');

        // Create a hash using the salt and password
        const hash = pbkdf2Sync(userCredentials.password, salt, 10000, 64, 'sha256').toString('hex');

        // Merge the salt and hash together
        const storedPassword = `${salt}:${hash}`;

        // Create user in our database
        const user = await UserSchema.create({
            name: userData.name.toLowerCase(),
            photo: "default",
        });

        // Create credentials in our database
        const Credentials = await CredentialSchema.create({
            name: userCredentials.name.toLowerCase(),
            password: storedPassword,
        });

        const token = generateAccessToken(user)

        res.status(200).send({ accessToken: token });
    } catch (err) {
        console.log(err);
    }
};

async function userLogin(req: Request, res: Response) {
    try {
        const userCredentials: Credential = req.body;

        if (!(userCredentials.name && userCredentials.password)) {
            res.status(400).send("All input with red asterix are required");
        }

        const oldCredential = await CredentialSchema.findOne({ name: userCredentials.name.toLowerCase() });
        const oldUser = await UserSchema.findOne({ name: userCredentials.name.toLowerCase() });

        if (!oldCredential || !oldUser) {
            return res.status(409).send("User doesn't Exist. Please Register");
        }

        // Extract the stored salt and hash from the stored password
        const [storedSalt, storedHash] = oldCredential.password.split(':');

        // Compute the hash of the input password with the stored salt
        const inputHash = pbkdf2Sync(userCredentials.password, storedSalt, 10000, 64, 'sha256',);

        // Compare the computed hash with the stored hash
        const password = inputHash.toString('hex') === storedHash;

        if (!password) {
            return res.status(400).send("Invalid Credentials");
        }

        const token = generateAccessToken(oldUser)

        res.status(200).send({ accessToken: token });
    } catch (err) {
        console.log(err);
    }
}

export {
    userRegister,
    userLogin,
}