import { AbilityConstant, Configuration, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { logLifecycle } from '../utils/LifecycleLog';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  // 1. 创建：ability 实例被创建，launchReason 说明启动原因
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    logLifecycle('UIAbility', 'onCreate', `launchReason=${launchParam.launchReason}`);
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'AppLifecycle', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
  }

  // 2. 窗口创建：加载页面内容
  onWindowStageCreate(windowStage: window.WindowStage): void {
    logLifecycle('UIAbility', 'onWindowStageCreate');

    windowStage.loadContent('pages/LaunchPage', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'AppLifecycle', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      logLifecycle('UIAbility', 'loadContent succeeded', 'pages/LaunchPage');
    });
  }

  // 3. 进入前台
  onForeground(): void {
    logLifecycle('UIAbility', 'onForeground');
  }

  // 4. 再次拉起（singleton 模式下已存在实例时，接收新的 Want）
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    logLifecycle('UIAbility', 'onNewWant', `launchReason=${launchParam.launchReason}`);
  }

  // 5. 配置变化，例如深浅色模式切换、语言变化
  onConfigurationUpdate(newConfig: Configuration): void {
    logLifecycle('UIAbility', 'onConfigurationUpdate', `colorMode=${newConfig.colorMode}`);
  }

  // 6. 内存告警
  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    logLifecycle('UIAbility', 'onMemoryLevel', `level=${level}`);
  }

  // 7. 进入后台
  onBackground(): void {
    logLifecycle('UIAbility', 'onBackground');
  }

  // 8. 窗口即将销毁
  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    logLifecycle('UIAbility', 'onWindowStageWillDestroy');
  }

  // 9. 窗口已销毁：释放 UI 相关资源
  onWindowStageDestroy(): void {
    logLifecycle('UIAbility', 'onWindowStageDestroy');
  }

  // 10. 应用即将被终止，返回 false 表示允许终止
  onPrepareToTerminate(): boolean {
    logLifecycle('UIAbility', 'onPrepareToTerminate');
    return false;
  }

  // 11. ability 实例销毁
  onDestroy(): void {
    logLifecycle('UIAbility', 'onDestroy');
  }
}
