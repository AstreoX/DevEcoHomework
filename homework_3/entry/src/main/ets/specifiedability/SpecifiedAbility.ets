import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { logLifecycle } from '../utils/LifecycleLog';

let nextInstanceId: number = 0;

export default class SpecifiedAbility extends UIAbility {
  private instanceId: string = `S${++nextInstanceId}`;
  private instanceKey: string = 'A';
  private receiveCount: number = 0;
  // 每个 Ability 有自己的 LocalStorage，不使用应用级 AppStorage 混存实例数据。
  private storage: LocalStorage = new LocalStorage();

  private record(event: string): void {
    const detail = `key=${this.instanceKey}, instance=${this.instanceId}, receives=${this.receiveCount}`;
    logLifecycle('SpecifiedAbility', event, detail);
    const previous = this.storage.get<string>('events') ?? '';
    this.storage.setOrCreate('events', previous + (previous ? '\n' : '') + event);
  }

  private acceptWant(want: Want): void {
    this.instanceKey = typeof want.parameters?.instanceKey === 'string' ? want.parameters.instanceKey : 'A';
    this.receiveCount++;
    this.storage.setOrCreate('instanceKey', this.instanceKey);
    this.storage.setOrCreate('instanceId', this.instanceId);
    this.storage.setOrCreate('receiveCount', this.receiveCount);
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.acceptWant(want);
    this.record('onCreate');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    this.record('onWindowStageCreate');
    windowStage.loadContent('pages/SpecifiedPage', this.storage, (error) => {
      if (error.code) {
        logLifecycle('SpecifiedAbility', 'loadContent failed', `${error.code}: ${error.message}`);
        return;
      }
      this.record('loadContent succeeded');
    });
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.acceptWant(want);
    this.record('onNewWant');
  }

  onForeground(): void { this.record('onForeground'); }
  onBackground(): void { this.record('onBackground'); }
  onWindowStageDestroy(): void { this.record('onWindowStageDestroy'); }
  onDestroy(): void { this.record('onDestroy'); }
}
