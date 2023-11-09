import express from 'express';

import { userRegister, userLogin, userLogout } from '../api/auth';
const router = express.Router();

router.post('/register', (req, res) => {
    userRegister(req, res)
})

router.post('/login', (req, res) => {
    userLogin(req, res)
})

router.post('/logout', (req, res) => {
    userLogout(req, res)
})

router.get('/', (req, res) => {
    res.send('test')
})

export default router;