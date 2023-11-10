import { Member } from './members';

export interface Project {
    name: string;
    members: Member[];
    tasks: string[];
}