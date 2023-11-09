import { RefreshTokenSchema } from "../../database/schema/refreshToken";

export default async function deleteRefreshTokenDocument(Token: string): Promise<boolean> {
    try {
        const refreshToken = await RefreshTokenSchema.findOne({ refreshToken: Token });
        if (!refreshToken) {
            return false; // Token not found, return false
        }
        const deletionResult = await RefreshTokenSchema.deleteOne({ refreshToken: Token });
        if (deletionResult.deletedCount === 1) {
            return true; // Successfully deleted the document
        } else {
            return false; // Deletion didn't occur, possibly due to token not found
        }
    } catch (error) {
        console.error('Error in deleteRefreshTokenDocument:', error);
        return false; // Handle any potential errors during the delete operation
    }
}