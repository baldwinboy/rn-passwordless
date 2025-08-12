import { Platform } from 'react-native';
import RNPasswordless, {
  type IPasswordlessOptions,
  type IPasswordlessResponse,
} from './NativeRNPasswordless';

export function configure(options: IPasswordlessOptions): void {
  return RNPasswordless.configure(options);
}

export async function register(
  token: string,
  nickname?: string
): Promise<IPasswordlessResponse> {
  return RNPasswordless.register(token, nickname);
}

export async function signIn(alias?: string): Promise<IPasswordlessResponse> {
  return RNPasswordless.signIn(alias);
}

export async function signInWithAutofill(): Promise<IPasswordlessResponse> {
  if (Platform.OS !== 'ios' || !RNPasswordless.signInWithAutofill) {
    throw new Error('This function is only available on iOS');
  }

  return RNPasswordless.signInWithAutofill();
}