import express from 'express';

import { getMe, patchMe } from '../api/users';
const router = express.Router();

router.get('/me', (req, res) => {
    getMe(req, res)
})

router.patch('/me', (req, res) => {
    patchMe(req, res)
})

export default router;