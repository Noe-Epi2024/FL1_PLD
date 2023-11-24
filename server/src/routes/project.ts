import express from 'express';
import accessToken from '../middleware/accessToken';
import isUserExist from '../middleware/isUserExist';

import { getProject, getProjects, postProject, patchProject, deleteProject } from '../api/project';
import { getMembers, postMember, deleteMember, patchMember } from '../api/member';
const router = express.Router();

router.get('/project/:id', accessToken, isUserExist, (req, res) => {
    getProject(req, res)
})

router.get('/projects', accessToken, isUserExist, (req, res) => {
    getProjects(req, res)
})

router.post('/project', accessToken, isUserExist, (req, res) => {
    postProject(req, res)
})

router.patch('/project/:id', accessToken, isUserExist, (req, res) => {
    patchProject(req, res)
})

router.delete('/project/:id', accessToken, isUserExist, (req, res) => {
    deleteProject(req, res)
})

router.get('/project/:id/member', accessToken, isUserExist, (req, res) => {
    getMembers(req, res)
})

router.post('/project/:id/member', accessToken, isUserExist, (req, res) => {
    postMember(req, res)
})

router.delete('/project/:id/member', accessToken, isUserExist, (req, res) => {
    deleteMember(req, res)
})

router.patch('/project/:id/member', accessToken, isUserExist, (req, res) => {
    patchMember(req, res)
})

export default router;