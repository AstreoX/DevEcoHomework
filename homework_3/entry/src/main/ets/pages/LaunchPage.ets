import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { openSpecified } from '../utils/AbilityLauncher';
import { logLifecycle } from '../utils/LifecycleLog';

@Entry
@Component
struct LaunchPage {
  @State status: string = '选择标识，启动 SpecifiedAbility';

  aboutToAppear(): void { logLifecycle('Page(Launch)', 'aboutToAppear'); }
  onPageShow(): void { logLifecycle('Page(Launch)', 'onPageShow'); }
  onPageHide(): void { logLifecycle('Page(Launch)', 'onPageHide'); }
  aboutToDisappear(): void { logLifecycle('Page(Launch)', 'aboutToDisappear'); }

  private launch(key: string): void {
    const context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    openSpecified(context, key).then(() => {
      this.status = `已发送标识 ${key}，由系统匹配实例`;
    }).catch((error: BusinessError) => {
      this.status = `启动失败：${error.code} ${error.message}`;
    });
  }

  build() {
    Scroll() {
      Column({ space: 18 }) {
        Text('UIAbility 启动模式').fontSize(14).fontColor('#52647B')
        Text('Specified').fontSize(38).fontWeight(FontWeight.Bold).fontColor('#152A43')
        Text('指定实例跳转与生命周期实验').fontSize(19).fontColor('#152A43')
        Text('同一个标识复用实例\n不同标识创建新实例')
          .fontSize(17).lineHeight(28).fontColor('#52647B').textAlign(TextAlign.Center)
        Button('打开实例 A').id('openA').width('100%').height(52)
          .backgroundColor('#2463C4').onClick(() => { this.launch('A'); })
        Button('打开实例 B').id('openB').width('100%').height(52)
          .backgroundColor('#152A43').onClick(() => { this.launch('B'); })
        Text(this.status).fontSize(13).fontColor('#52647B').textAlign(TextAlign.Center)
        Column({ space: 10 }) {
          Text('建议实验顺序').fontSize(17).fontWeight(FontWeight.Bold).fontColor('#152A43')
          Text('1  打开 A，记录实例编号\n2  增加保留计数，再次打开 A\n3  切换到 B，观察新的实例编号\n4  从 B 返回 A，验证状态仍然保留')
            .fontSize(15).lineHeight(27).fontColor('#52647B')
        }.alignItems(HorizontalAlign.Start).padding(20).width('100%')
          .backgroundColor(Color.White).borderRadius(16)
        Text('HiLog：AppLifecycle  ·  Info').fontSize(13).fontColor('#52647B')
        Button('查看之前的智能家居作业').fontSize(13).backgroundColor('#E2EAF6').fontColor('#2463C4')
          .onClick(() => { this.getUIContext().getRouter().pushUrl({ url: 'pages/Index' }); })
      }.width('100%').padding({ left: 24, right: 24, top: 38, bottom: 30 })
    }.width('100%').height('100%').backgroundColor('#F2F5FA')
  }
}
