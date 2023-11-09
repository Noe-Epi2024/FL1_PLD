import { UserSchema } from "../../database/schema/users";
import { CredentialSchema } from "../../database/schema/credentials";
import { RefreshTokenSchema } from "../../database/schema/refreshToken";
import { User, Credential } from "../../types/users";
import { pbkdf2Sync, randomBytes } from "crypto";
import { generateAccessToken, generateRefreshToken } from "../../functions/token/generate";
import deleteRefreshTokenDocument from "../../functions/database/deleteRefreshToken"
import { Request, Response } from 'express';
import * as dotenv from "dotenv";
dotenv.config();


async function userRegister(req: Request, res: Response) {
    try {
        const userData: User = req.body;
        const userCredentials: Credential = req.body;

        // Get user input
        if (!(userCredentials.email && userCredentials.password && userData.name && userData.surname && userData.birthDate && userData.phoneNumber)) {
            res.status(400).send("All input with red asterix are required");
        }

        // check if user already exist
        const oldUser = await UserSchema.findOne({ email: userCredentials.email.toLowerCase() });

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
            email: userData.email.toLowerCase(),
            name: userData.name,
            surname: userData.surname,
            birthDate: userData.birthDate,
            phoneNumber: userData.phoneNumber,
            role: "utilisateur",
            photo: "default",
            validated: false,
        });

        // Create credentials in our database
        const Credentials = await CredentialSchema.create({
            email: userCredentials.email.toLowerCase(),
            password: storedPassword,
        });

        // Create token
        const refreshToken = await RefreshTokenSchema.create({
            refreshToken: generateRefreshToken(user),
            user_id: user._id,
        });

        const token = generateAccessToken(user)

        res.status(200).send({ refreshToken: refreshToken.refreshToken[0], accessToken: token });
    } catch (err) {
        console.log(err);
    }
};

async function userLogin(req: Request, res: Response) {
    try {
        const userCredentials: Credential = req.body;

        if (!(userCredentials.email && userCredentials.password)) {
            res.status(400).send("All input with red asterix are required");
        }

        const oldCredential = await CredentialSchema.findOne({ email: userCredentials.email.toLowerCase() });
        const oldUser = await UserSchema.findOne({ email: userCredentials.email.toLowerCase() });

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

        const refreshToken = await RefreshTokenSchema.create({
            refreshToken: generateRefreshToken(oldUser),
            user_id: oldUser._id,
        });

        const token = generateAccessToken(oldUser)

        res.status(200).send({ refreshToken: refreshToken.refreshToken[0], accessToken: token });
    } catch (err) {
        console.log(err);
    }
}

async function userLogout(req: Request, res: Response) {
    try {
        const refreshToken = req.headers.refreshtoken as string;

        if (!refreshToken) {
            return res.status(400).send("No token provided");
        }

        const userToken = await RefreshTokenSchema.findOne({ refreshToken: refreshToken });

        if (!userToken) {
            return res.status(409).send("Refresh token not found");
        }

        const response = await deleteRefreshTokenDocument(refreshToken);

        if (!response) {
            return res.status(409).send("Can't delete refresh token");
        }

        return res.status(200).send('User successfully logged out');
    } catch (error) {
        console.log(error);
    }

}

export {
    userRegister,
    userLogin,
    userLogout,
}