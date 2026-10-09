const ACCENT_COLOR: string = '#FF8A00';
const OFF_COLOR: string = '#E5E5EA';
const MIN_TEMP: number = 16;
const MAX_TEMP: number = 30;

@Entry
@Component
struct Index {
  @State lightOn: boolean = true;
  @State brightness: number = 50;
  @State acOn: boolean = false;
  @State temperature: number = 26;
  @State lockOn: boolean = false;

  build() {
    Column({ space: 16 }) {
      this.LightCard()
      this.AirConditionerCard()
      this.DoorLockCard()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F1F3F5')
  }

  // 卡片标题行：设备名称 + 开关 + 右侧图标
  @Builder
  CardHeader(title: string, isOn: boolean, icon: string, onToggle: (value: boolean) => void) {
    Row() {
      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1A1A1A')
      Toggle({ type: ToggleType.Switch, isOn: isOn })
        .selectedColor(ACCENT_COLOR)
        .switchPointColor(Color.White)
        .margin({ left: 12 })
        .onChange(onToggle)
      Blank()
      Text(icon).fontSize(40)
    }
    .width('100%')
  }

  @Builder
  LightCard() {
    Column({ space: 12 }) {
      this.CardHeader('客厅主灯', this.lightOn, '💡', (value: boolean): void => {
        this.lightOn = value;
      })
      Text(this.lightOn ? `亮度${this.brightness}%` : '已关闭')
        .fontSize(15)
        .fontColor('#8E8E93')
        .width('100%')
      Row({ space: 12 }) {
        Text('🔅').fontSize(22)
        Slider({
          value: this.brightness,
          min: 0,
          max: 100,
          style: SliderStyle.OutSet
        })
          .layoutWeight(1)
          .selectedColor(ACCENT_COLOR)
          .trackColor(OFF_COLOR)
          .trackThickness(4)
          .onChange((value: number): void => {
            this.brightness = Math.round(value);
          })
        Text('🔆').fontSize(22)
      }
      .width('100%')
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(24)
  }

  @Builder
  AirConditionerCard() {
    Column({ space: 12 }) {
      this.CardHeader('卧室空调', this.acOn, '❄️', (value: boolean): void => {
        this.acOn = value;
      })
      Text(this.acOn ? '制冷中' : '已关闭')
        .fontSize(15)
        .fontColor('#8E8E93')
        .width('100%')
      Row({ space: 24 }) {
        this.RoundButton('−', (): void => {
          if (this.temperature > MIN_TEMP) {
            this.temperature--;
          }
        })
        Text(`${this.temperature}°C`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        this.RoundButton('+', (): void => {
          if (this.temperature < MAX_TEMP) {
            this.temperature++;
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(24)
  }

  @Builder
  DoorLockCard() {
    Column({ space: 12 }) {
      this.CardHeader('入户门锁', this.lockOn, '🚪', (value: boolean): void => {
        this.lockOn = value;
      })
      Text(this.lockOn ? '已开启' : '已关闭')
        .fontSize(15)
        .fontColor('#8E8E93')
        .width('100%')
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(24)
  }

  @Builder
  RoundButton(label: string, onTap: () => void) {
    Text(label)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor('#1A1A1A')
      .width(48)
      .height(48)
      .textAlign(TextAlign.Center)
      .backgroundColor('#F1F3F5')
      .borderRadius(24)
      .onClick(onTap)
  }
}
