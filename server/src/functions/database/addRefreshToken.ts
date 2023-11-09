import { RefreshTokenSchema } from "../../database/schema/refreshToken";

export default async function addRefreshToken(Token: string, newToken: string): Promise<boolean> {
    try {
        const refreshToken = await RefreshTokenSchema.findOne({ refreshToken: Token });
        if (!refreshToken) {
            return false; // Token not found, return false
        }

        const updateResult = await RefreshTokenSchema.updateOne(
            { refreshToken: Token },
            { $push: { refreshToken: newToken } }
        );

        if (updateResult.modifiedCount === 1) {
            return true; // Successfully added the new token
        } else {
            return false; // Update didn't occur, possibly due to token not found
        }
    } catch (error) {
        console.log(error);
        return false; // Handle any potential errors during the update
    }
}