import express from 'express';
import accessToken from '../middleware/accessToken';
import isUserExist from '../middleware/isUserExist';

import { getProject, getProjects, postProject, patchProject, deleteProject } from '../api/project';
const router = express.Router();

router.get('/project/{id}', accessToken, isUserExist, (req, res) => {
    getProject(req, res)
})

router.get('/projects', accessToken, isUserExist, (req, res) => {
    getProjects(req, res)
})

router.post('/project', accessToken, isUserExist, (req, res) => {
    postProject(req, res)
})

router.patch('/project/{id}', accessToken, isUserExist, (req, res) => {
    patchProject(req, res)
})

router.delete('/project/{id}', accessToken, isUserExist, (req, res) => {
    deleteProject(req, res)
})

export default router;