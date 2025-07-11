import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Brightness from '../../../services/brightness.js';
import Indicator from '../../../services/indicator.js';
import { distance } from '../../.miscutils/mathfuncs.js';

const OSD_DISMISS_DISTANCE = 10;

const WindowTitle = async () => {
    try {
        const Hyprland = (await import('resource:///com/github/Aylur/ags/service/hyprland.js')).default;
        return Widget.Scrollable({
            hexpand: true, vexpand: true,
            hscroll: 'automatic', vscroll: 'never',
            child: Widget.Box({
                vertical: true,
                children: [
                    Widget.Label({
                        xalign: 0,
                        truncate: 'end',
                        maxWidthChars: 1, // Doesn't matter, just needs to be non negative
                        className: 'txt-smaller bar-wintitle-topdesc txt',
                        setup: (self) => self.hook(Hyprland.active.client, label => { // Hyprland.active.client
                            label.label = Hyprland.active.client.class.length === 0 ? 'Desktop' : Hyprland.active.client.class;
                        }),
                    }),
                    Widget.Label({
                        xalign: 0,
                        truncate: 'end',
                        maxWidthChars: 1, // Doesn't matter, just needs to be non negative
                        className: 'txt-smallie bar-wintitle-txt',
                        setup: (self) => self.hook(Hyprland.active.client, label => { // Hyprland.active.client
                            label.label = Hyprland.active.client.title.length === 0 ? `Workspace ${Hyprland.active.workspace.id}` : Hyprland.active.client.title;
                        }),
                    })
                ]
            })
        });
    } catch {
        return null;
    }
}


export default async (monitor = 0) => {
    const optionalWindowTitleInstance = await WindowTitle();
    let scrollCursorX, scrollCursorY;
    return Widget.EventBox({
        onScrollUp: (self, event) => {
            let _;
            [_, scrollCursorX, scrollCursorY] = event.get_coords();
            Indicator.popup(1); // Since the brightness and speaker are both on the same window
            Brightness[monitor].screen_value += 0.05;
        },
        onScrollDown: (self, event) => {
            let _;
            [_, scrollCursorX, scrollCursorY] = event.get_coords();
            Indicator.popup(1); // Since the brightness and speaker are both on the same window
            Brightness[monitor].screen_value -= 0.05;
        },
        onPrimaryClick: () => {
            App.toggleWindow('sideleft');
        },
        setup: (self) => self.on('motion-notify-event', (self, event) => {
            const [_, cursorX, cursorY] = event.get_coords();
            if (distance(cursorX, cursorY, scrollCursorX, scrollCursorY) >= OSD_DISMISS_DISTANCE)
                Indicator.popup(-1);
        }),
        child: Widget.Box({
            homogeneous: false,
            children: [
                Widget.Box({ className: 'bar-corner-spacing' }),
                Widget.Overlay({
                    overlays: [
                        Widget.Box({ hexpand: true }),
                        Widget.Box({
                            className: 'bar-sidemodule',
                            hexpand: true,
                            children: [Widget.Box({
                                vertical: true,
                                className: 'bar-space-button',
                                children: [
                                    optionalWindowTitleInstance,
                                ]
                            })]
                        }),
                    ]
                })
            ]
        })
    });
}
