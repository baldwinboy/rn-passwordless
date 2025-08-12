import { type TurboModule, TurboModuleRegistry } from 'react-native';

export interface IPasswordlessOptions {
  // Passwordless.dev public API key
  apiKey: string;
  // Identifier for your server, for example 'example.com' if your backend is hosted at https://example.com.
  rpId: string;
  // Android only: Where your backend is hosted
  backendUrl?: string;
  // Passwordless.dev server, change for self-hosting
  apiUrl?: string;
}

export interface IPasswordlessResponse {
  success: boolean;
  result?: unknown;
  error?: string;
}

export interface Spec extends TurboModule {
  // Setup
  configure(options: IPasswordlessOptions): void;

  // Registration
  register(token: string, nickname?: string): Promise<IPasswordlessResponse>;

  // Sign In (Alias)
  signIn(alias?: string): Promise<IPasswordlessResponse>;

  // iOS only: Sign In with AutoFill
  signInWithAutofill?(): Promise<IPasswordlessResponse>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('RNPasswordless');
