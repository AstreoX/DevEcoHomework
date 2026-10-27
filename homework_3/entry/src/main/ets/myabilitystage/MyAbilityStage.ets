import { AbilityConstant, AbilityStage, Configuration, UIAbility, Want } from '@kit.AbilityKit';
import { logLifecycle } from '../utils/LifecycleLog';

// 应用级生命周期入口：AbilityStage 在任一 UIAbility 创建之前执行
export default class MyAbilityStage extends AbilityStage {
  onCreate(): void {
    logLifecycle('AbilityStage', 'onCreate');

    // 监听所有 UIAbility 的生命周期（包括 EntryAbility）
    this.context.getApplicationContext().on('abilityLifecycle', {
      onAbilityCreate(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onAbilityCreate');
      },
      onWindowStageCreate(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onWindowStageCreate');
      },
      onWindowStageActive(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onWindowStageActive');
      },
      onWindowStageInactive(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onWindowStageInactive');
      },
      onWindowStageDestroy(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onWindowStageDestroy');
      },
      onAbilityForeground(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onAbilityForeground');
      },
      onAbilityBackground(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onAbilityBackground');
      },
      onAbilityContinue(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onAbilityContinue');
      },
      onAbilityDestroy(ability: UIAbility): void {
        logLifecycle('AbilityCallback', 'onAbilityDestroy');
      }
    });

    // 监听系统环境变化：配置更新、内存告警
    this.context.getApplicationContext().on('environment', {
      onConfigurationUpdated(config: Configuration): void {
        logLifecycle('Environment', 'onConfigurationUpdated', `colorMode=${config.colorMode}`);
      },
      onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
        logLifecycle('Environment', 'onMemoryLevel', `level=${level}`);
      }
    });
  }

  // specified 模式每次启动前调用；同一 key 返回同一标识，交由系统匹配实例。
  onAcceptWant(want: Want): string {
    if (want.abilityName === 'SpecifiedAbility') {
      const key = typeof want.parameters?.instanceKey === 'string' ? want.parameters.instanceKey : 'A';
      const flag = `Specified_${key}`;
      logLifecycle('AbilityStage', 'onAcceptWant', `key=${key}, flag=${flag}`);
      return flag;
    }
    return `${want.bundleName}_${want.abilityName}`;
  }
}
