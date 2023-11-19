import { Types } from 'mongoose';
import { Member } from './members';

export interface Project {
    name: string;
    members: Member[];
    tasks: Types.ObjectId[];
}