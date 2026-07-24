import zh from './zh';
import en from './en';

export const messages = { zh, en } as const;
export type Locale = keyof typeof messages;
export type Messages = typeof zh;
