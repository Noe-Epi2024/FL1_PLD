import { Request, Response } from 'express';
import crypto from 'crypto';
import { uploadFileToS3, getSignedUrlFromS3, s3BucketName } from '../../database/s3';

export async function addPicture(req: Request, res: Response) {
    try {
        const name = crypto.randomBytes(32).toString('hex');

        if (!req.file) {
            return res.status(400).send('No file uploaded.');
        }

        await uploadFileToS3(req.file.buffer, name, req.file.mimetype);

        const url = await getSignedUrlFromS3(name);
        res.status(200).send({ url, name });
    } catch (error) {
        console.error("Error adding picture:", error);
        res.status(500).send('Internal Server Error');
    }
}

export async function getPicture(req: Request, res: Response) {
    try {
        const name = req.query.name as string;

        if (!name) {
            return res.status(400).send('Missing file name.');
        }

        const url = await getSignedUrlFromS3(name);
        res.status(200).send({ data: { url: url, name: name } });
    } catch (error) {
        console.error("Error getting picture:", error);
        res.status(500).send('Internal Server Error');
    }
}
