import { ConfigurationConstant, UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

export default class EntryAbility extends UIAbility {
  onCreate(): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
    } catch (error) {
      hilog.warn(0x0000, 'CourseTabs', 'color mode unchanged: %{public}s', JSON.stringify(error));
    }
  }

  onWindowStageCreate(stage: window.WindowStage): void {
    stage.loadContent('pages/Index', (error) => {
      if (error.code) {
        hilog.error(0x0000, 'CourseTabs', 'load failed code=%{public}d', error.code);
      } else {
        hilog.info(0x0000, 'CourseTabs', 'page ready defaultIndex=3 title=精彩活动');
      }
    });
  }
}
