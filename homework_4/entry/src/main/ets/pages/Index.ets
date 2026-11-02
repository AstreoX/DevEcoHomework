import { CommonModifier } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct Index {
  private readonly categories: string[] = [
    '热门课程', '最新课程', 'HarmonyOS', '精彩活动', '开发者说', '后端开发', '前端开发'
  ];
  @State selectedIndex: number = 3;
  private barLayout: CommonModifier = new CommonModifier().align(Alignment.TopStart);

  @Builder
  categoryTab(title: string, index: number) {
    Column() {
      Text(title)
        .id(`tabLabel_${index}`)
        .fontSize(14)
        .fontColor(this.selectedIndex === index ? '#333333' : '#969D99')
        .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Medium)
        .maxLines(1)
    }
    .id(`tab_${index}`)
    .width('100%')
    .height(52)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.selectedIndex === index ? '#FFFFFF' : '#F1F5F2')
    .accessibilityText(`${title}${this.selectedIndex === index ? '，已选中' : '，未选中'}`)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        Column().width('27%').height('100%').backgroundColor('#F1F5F2')
        Blank()
      }.width('100%').height('100%')
      Tabs({ barPosition: BarPosition.Start, index: this.selectedIndex, barModifier: this.barLayout }) {
        ForEach(this.categories, (title: string, index: number) => {
          TabContent() {
            Column() {
              Text(title).id(`content_${index}`).fontSize(28).fontColor('#333333')
            }
            .width('100%').height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#FFFFFF')
          }.tabBar(this.categoryTab(title, index))
        }, (title: string) => title)
      }
      .id('courseTabs')
      .vertical(true)
      .barMode(BarMode.Scrollable)
      .barWidth('27%')
      .barHeight('100%')
      .animationDuration(0)
      .scrollable(true)
      .onChange((index: number) => {
        this.selectedIndex = index;
        hilog.info(0x0000, 'CourseTabs', 'select index=%{public}d title=%{public}s', index, this.categories[index]);
      })
      .width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}
