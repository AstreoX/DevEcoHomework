import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { openEntry, openSpecified } from '../utils/AbilityLauncher';
import { logLifecycle } from '../utils/LifecycleLog';

@Entry({ useSharedStorage: true })
@Component
struct SpecifiedPage {
  @LocalStorageLink('instanceKey') instanceKey: string = '';
  @LocalStorageLink('instanceId') instanceId: string = '';
  @LocalStorageLink('receiveCount') receiveCount: number = 0;
  @LocalStorageLink('retainedCount') retainedCount: number = 0;
  @LocalStorageLink('events') events: string = '';
  @State errorText: string = '';

  private context(): common.UIAbilityContext {
    return this.getUIContext().getHostContext() as common.UIAbilityContext;
  }

  private pageEvent(event: string): void {
    logLifecycle('Page(Specified)', event, `key=${this.instanceKey}, instance=${this.instanceId}`);
  }

  aboutToAppear(): void { this.pageEvent('aboutToAppear'); }
  onPageShow(): void { this.pageEvent('onPageShow'); }
  onPageHide(): void { this.pageEvent('onPageHide'); }
  aboutToDisappear(): void { this.pageEvent('aboutToDisappear'); }
  onBackPress(): boolean { this.pageEvent('onBackPress'); return false; }

  private launch(key: string): void {
    openSpecified(this.context(), key).catch((error: BusinessError) => {
      this.errorText = `${error.code}: ${error.message}`;
    });
  }

  build() {
    Scroll() {
      Column({ space: 14 }) {
        Text('SpecifiedAbility').fontSize(15).fontColor('#52647B')
        Text(`实例 ${this.instanceKey}`).id('instanceTitle').fontSize(34)
          .fontWeight(FontWeight.Bold).fontColor('#152A43')
        Text(`系统匹配标识  Specified_${this.instanceKey}`).fontSize(14).fontColor('#52647B')
        Row() {
          Column({ space: 5 }) {
            Text(this.instanceId).id('instanceId').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2463C4')
            Text('实例编号').fontSize(13).fontColor('#52647B')
          }.layoutWeight(1)
          Column({ space: 5 }) {
            Text(`${this.receiveCount}`).id('receiveCount').fontSize(28)
              .fontWeight(FontWeight.Bold).fontColor('#2463C4')
            Text('接收 Want 次数').fontSize(13).fontColor('#52647B')
          }.layoutWeight(1)
          Column({ space: 5 }) {
            Text(`${this.retainedCount}`).id('retainedCount').fontSize(28)
              .fontWeight(FontWeight.Bold).fontColor('#2463C4')
            Text('保留计数').fontSize(13).fontColor('#52647B')
          }.layoutWeight(1)
        }.width('100%').padding(18).backgroundColor(Color.White).borderRadius(16)
        Button('保留计数 +1').id('increment').width('100%').height(44)
          .backgroundColor('#E2EAF6').fontColor('#2463C4').onClick(() => { this.retainedCount++; })
        Row({ space: 10 }) {
          Button(`再次打开 ${this.instanceKey}`).id('reopen').layoutWeight(1).height(46)
            .backgroundColor('#2463C4').onClick(() => { this.launch(this.instanceKey); })
          Button(`切换到 ${this.instanceKey === 'A' ? 'B' : 'A'}`).id('switchKey').layoutWeight(1).height(46)
            .backgroundColor('#152A43').onClick(() => { this.launch(this.instanceKey === 'A' ? 'B' : 'A'); })
        }.width('100%')
        Button('回到入口（保留实例）').id('returnEntry').width('100%').height(42)
          .backgroundColor('#E2EAF6').fontColor('#2463C4').onClick(() => {
            openEntry(this.context()).catch((error: BusinessError) => { this.errorText = `${error.code}`; });
          })
        Column({ space: 8 }) {
          Text('当前实例的实际回调').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#152A43')
          Text(this.events).id('lifecycleEvents').fontSize(13).lineHeight(20)
            .fontFamily('monospace').fontColor('#354A65').width('100%')
        }.width('100%').alignItems(HorizontalAlign.Start).padding(16)
          .backgroundColor(Color.White).borderRadius(16)
        Text('编号不变且触发 onNewWant，表示复用了原实例。')
          .fontSize(12).fontColor('#52647B').width('100%')
        if (this.errorText) { Text(this.errorText).fontSize(13).fontColor('#B3261E') }
        Button('结束此实例').id('terminate').fontSize(13).backgroundColor('#F2E7E7').fontColor('#A53C3C')
          .onClick(() => { this.context().terminateSelf(); })
      }.width('100%').padding({ left: 22, right: 22, top: 30, bottom: 24 })
    }.width('100%').height('100%').backgroundColor('#F2F5FA')
  }
}
