import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { logLifecycle } from './LifecycleLog';

export async function openSpecified(context: common.UIAbilityContext, key: string): Promise<void> {
  const want: Want = {
    bundleName: context.abilityInfo.bundleName,
    moduleName: 'entry',
    abilityName: 'SpecifiedAbility',
    parameters: { instanceKey: key }
  };
  logLifecycle('Launcher', 'startAbility', `key=${key}`);
  try {
    await context.startAbility(want);
  } catch (error) {
    const failure = error as BusinessError;
    logLifecycle('Launcher', 'startAbility failed', `code=${failure.code}, message=${failure.message}`);
    return Promise.reject(failure);
  }
}

export async function openEntry(context: common.UIAbilityContext): Promise<void> {
  try {
    await context.startAbility({
      bundleName: context.abilityInfo.bundleName,
      moduleName: 'entry',
      abilityName: 'EntryAbility'
    });
  } catch (error) {
    return Promise.reject(error as BusinessError);
  }
}
