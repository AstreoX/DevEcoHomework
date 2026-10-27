import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN: number = 0x0000;
// 日志过滤时使用该 TAG 即可只看生命周期输出
const TAG: string = 'AppLifecycle';
let seq: number = 0;

// 统一输出生命周期日志，序号可直观看出各回调的先后顺序
export function logLifecycle(scope: string, event: string, detail?: string): void {
  seq++;
  const msg: string = `[${seq}] [${scope}] ${event}` + (detail ? ` | ${detail}` : '');
  hilog.info(DOMAIN, TAG, '%{public}s', msg);
}
