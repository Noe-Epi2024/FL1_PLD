import jwt from 'jsonwebtoken';

interface User {
    _id: object;
}

function generateAccessToken(User: User) {
    const payload = { user_id: User._id, };

    const token = jwt.sign(
        payload,
        process.env.ACCESS_TOKEN_SECRET!,
        {
            expiresIn: "5m",
        }
    );

    return token;
}

function generateRefreshToken(User: User) {
    const payload = { user_id: User._id };

    const refreshToken = jwt.sign(
        payload,
        process.env.REFRESH_TOKEN_SECRET!,
        {
            expiresIn: "5d"
        }
    );

    return refreshToken;
}

export {
    generateAccessToken,
    generateRefreshToken,
}