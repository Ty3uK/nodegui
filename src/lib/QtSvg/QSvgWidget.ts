import addon from '../utils/addon';
import { NativeElement } from '../core/Component';
import { NodeWidget } from '../QtWidgets/QWidget';

export class QSvgWidget extends NodeWidget {
    native: NativeElement;
    constructor(fileOrContent?: string | Buffer, parent?: NodeWidget) {
        let native;
        if (fileOrContent && parent) {
            native = new addon.QSvgWidget(fileOrContent, parent.native);
        } else if (parent) {
            native = new addon.QSvgWidget(parent.native);
        } else {
            throw new Error('Wrong number of arguments');
        }
        super(native);
        this.native = native;
        this.nodeParent = parent;
    }
    load(fileOrContent: Buffer | string): void {
        this.native.load(fileOrContent);
    }
}
