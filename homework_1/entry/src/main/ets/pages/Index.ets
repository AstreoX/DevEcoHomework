// ===== 已提供：枚举、接口、日志函数类型 =====

enum DeviceState {
  Offline = 'Offline',
  Online = 'Online',
  Error = 'Error'
}

interface Startable {
  start(): void;
}

type Logger = (message: string) => void;


// ===== 任务一：设备基类 =====

class Device implements Startable {
  private _state: DeviceState = DeviceState.Offline;
  public name: string;
  protected logger: Logger;

  constructor(name: string, logger: Logger) {
    this.name = name;
    this.logger = logger;
  }

  get state(): DeviceState {
    return this._state;
  }

  set state(value: DeviceState) {
    // TODO 1：状态转换验证
    if (this._state === DeviceState.Error && value === DeviceState.Online) {
      throw new Error(`${this.name} 故障未修复，不能上线`);
    }
    this._state = value;
  }

  start(): void {
    // TODO 2：设置在线状态并输出日志
    this.state = DeviceState.Online;
    this.logger(`[设备] ${this.name} 已启动`);
  }

  status(): string {
    // TODO 3：返回设备状态字符串
    return `${this.name}：${this.state}`;
  }
}


// ===== 任务二：继承与方法重写 =====

class SmartLight extends Device {
  public brightness: number;

  constructor(
    name: string,
    logger: Logger,
    brightness: number = 100
  ) {
    super(name, logger);
    this.brightness = brightness;
  }

  start(): void {
    // TODO 4：调用父类启动并输出亮度信息
    super.start();
    this.logger(`[灯] 亮度调整为 ${this.brightness}%`);
  }
}

class Fan extends Device {
  public speed: number;

  constructor(
    name: string,
    logger: Logger,
    speed: number = 1
  ) {
    super(name, logger);
    this.speed = speed;
  }

  start(): void {
    // TODO 5：调用父类启动并输出风速信息
    super.start();
    this.logger(`[风扇] 风速 ${this.speed} 档`);
  }
}


// ===== 任务三：数组、循环、查询与异常处理 =====

class DeviceManager {
  private devices: Device[] = [];
  private logger: Logger;

  constructor(logger: Logger) {
    this.logger = logger;
  }

  add(device: Device): void {
    // TODO 6：添加设备到数组
    this.devices.push(device);
    this.logger(`已添加设备：${device.name}`);
  }

  startAll(): void {
    this.logger('--- 启动所有设备 ---');
    
    // TODO 7：遍历启动设备，异常处理
    for (const device of this.devices) {
      try {
        device.start();
      } catch (error) {
        this.logger(`[启动失败] ${(error as Error).message}`);
      }
    }
  }

  find(name: string): Device | null {
    // TODO 8：按名称查询设备
    for (const device of this.devices) {
      if (device.name === name) {
        return device;
      }
    }
    return null;
  }
}


// ===== 测试流程 =====

function runAssignment(logger: Logger): void {
  const manager = new DeviceManager(logger);

  const light = new SmartLight('台灯', logger, 80);
  const fan = new Fan('落地扇', logger, 3);

  manager.add(light);
  manager.add(fan);
  manager.startAll();

  const found = manager.find('台灯');
  if (found !== null) {
    logger(`找到设备：${found.status()}`);
  } else {
    logger('查询失败：未找到台灯');
  }

  const missing = manager.find('空调');
  if (missing === null) {
    logger('未找到设备：空调');
  }

  logger('--- 模拟台灯故障 ---');
  light.state = DeviceState.Error;
  manager.startAll();
  logger(light.status());

  logger('--- 台灯修复后重新启动 ---');
  light.state = DeviceState.Offline;
  light.start();
  logger(light.status());
}


// ===== 页面展示 =====

@Entry
@Component
struct Index {
  @State output: string = '';

  aboutToAppear(): void {
    this.output = '';
    const logger: Logger = (message: string): void => {
      console.info(message);
      this.output += message + '\n';
    };
    runAssignment(logger);
  }

  build() {
    Column({ space: 12 }) {
      Text('ArkTS 基础语法作业')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
      Scroll() {
        Text(this.output).fontSize(16).width('100%')
      }
      .layoutWeight(1)
      .width('100%')
    }
    .padding(20)
    .width('100%')
    .height('100%')
  }
}
