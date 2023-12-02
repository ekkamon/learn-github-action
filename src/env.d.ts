declare global {
  namespace NodeJS {
    interface ProcessEnv {
      KEY_NAME: string;
    }
  }
}

export {};
