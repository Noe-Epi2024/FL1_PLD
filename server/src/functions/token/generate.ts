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
            expiresIn: "120d",
        }
    );

    return token;
}

export {
    generateAccessToken,
}