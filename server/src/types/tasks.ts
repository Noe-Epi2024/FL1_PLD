import { Subtask } from './subtasks';

export interface Task {
    ownerId: string;
    description: string;
    name: string;
    startDate: Date;
    endDate: Date;
    subtasks: Subtask[];
}