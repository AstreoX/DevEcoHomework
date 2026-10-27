import { logLifecycle } from '../utils/LifecycleLog';

const THEME_COLOR: string = '#FF9500';
const TRACK_COLOR: string = '#E3E5E8';
const PAGE_COLOR: string = '#F0F2F5';
const TEXT_MAIN: string = '#1C1C1E';
const TEXT_SUB: string = '#8A8A8E';
const TEMP_MIN: number = 16;
const TEMP_MAX: number = 30;

@Entry
@Component
struct Index {
  @State lampOn: boolean = true;
  @State lampLevel: number = 50;
  @State acOn: boolean = false;
  @State targetTemp: number = 26;
  @State doorOn: boolean = false;

  // 页面生命周期
  aboutToAppear(): void {
    logLifecycle('Page(Index)', 'aboutToAppear');
  }

  onPageShow(): void {
    logLifecycle('Page(Index)', 'onPageShow');
  }

  // 返回键：返回 false 交由系统处理（退出应用/返回上一页）
  onBackPress(): boolean {
    logLifecycle('Page(Index)', 'onBackPress');
    return false;
  }

  onPageHide(): void {
    logLifecycle('Page(Index)', 'onPageHide');
  }

  aboutToDisappear(): void {
    logLifecycle('Page(Index)', 'aboutToDisappear');
  }

  build() {
    Column({ space: 14 }) {
      this.LampCard()
      this.AcCard()
      this.DoorCard()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.Center)
    .backgroundColor(PAGE_COLOR)
  }

  // 通用标题栏：设备名称、开关、右侧图标
  @Builder
  DeviceTitle(name: string, checked: boolean, emoji: string, handler: (isOn: boolean) => void) {
    Row() {
      Text(name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_MAIN)
      Toggle({ type: ToggleType.Switch, isOn: checked })
        .selectedColor(THEME_COLOR)
        .switchPointColor(Color.White)
        .margin({ left: 12 })
        .onChange(handler)
      Blank()
      Text(emoji).fontSize(40)
    }
    .width('100%')
  }

  @Builder
  LampCard() {
    Column({ space: 12 }) {
      this.DeviceTitle('客厅主灯', this.lampOn, '💡', (isOn: boolean): void => {
        this.lampOn = isOn;
      })
      Text(this.lampOn ? `亮度${this.lampLevel}%` : '已关闭')
        .fontSize(15)
        .fontColor(TEXT_SUB)
        .width('100%')
      Row({ space: 12 }) {
        Text('🔅').fontSize(22)
        Slider({
          value: this.lampLevel,
          min: 0,
          max: 100,
          style: SliderStyle.OutSet
        })
          .layoutWeight(1)
          .selectedColor(THEME_COLOR)
          .trackColor(TRACK_COLOR)
          .trackThickness(4)
          .onChange((value: number): void => {
            this.lampLevel = Math.round(value);
          })
        Text('🔆').fontSize(22)
      }
      .width('100%')
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(22)
  }

  @Builder
  AcCard() {
    Column({ space: 12 }) {
      this.DeviceTitle('卧室空调', this.acOn, '❄️', (isOn: boolean): void => {
        this.acOn = isOn;
      })
      Text(this.acOn ? '制冷运行中' : '已关闭')
        .fontSize(15)
        .fontColor(TEXT_SUB)
        .width('100%')
      Row({ space: 24 }) {
        this.CircleButton('−', (): void => {
          if (this.targetTemp > TEMP_MIN) {
            this.targetTemp -= 1;
          }
        })
        Text(`${this.targetTemp}°C`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT_MAIN)
        this.CircleButton('+', (): void => {
          if (this.targetTemp < TEMP_MAX) {
            this.targetTemp += 1;
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(22)
  }

  @Builder
  DoorCard() {
    Column({ space: 12 }) {
      this.DeviceTitle('入户门锁', this.doorOn, '🚪', (isOn: boolean): void => {
        this.doorOn = isOn;
      })
      Text(this.doorOn ? '已开启' : '已关闭')
        .fontSize(15)
        .fontColor(TEXT_SUB)
        .width('100%')
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(22)
  }

  @Builder
  CircleButton(symbol: string, onTap: () => void) {
    Text(symbol)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(TEXT_MAIN)
      .width(48)
      .height(48)
      .textAlign(TextAlign.Center)
      .backgroundColor(PAGE_COLOR)
      .borderRadius(24)
      .onClick(onTap)
  }
}
