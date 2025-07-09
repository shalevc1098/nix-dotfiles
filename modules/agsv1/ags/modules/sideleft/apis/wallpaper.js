const { Gdk, GdkPixbuf, Gio, GLib, Gtk } = imports.gi;
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { Box, Button, EventBox, Label, Overlay, Revealer, Scrollable, Stack } = Widget;
const { execAsync, exec } = Utils;
import { fileExists } from '../../.miscutils/files.js';
import { MaterialIcon } from '../../.commonwidgets/materialicon.js';
import { MarginRevealer } from '../../.widgethacks/advancedrevealers.js';
import { setupCursorHover, setupCursorHoverInfo } from '../../.widgetutils/cursorhover.js';
import { SystemMessage } from './ai_chatmessage.js';
import wallhaven from '../../../services/wallhaven.js';
import wallpaper from '../../../services/wallpaper.js';
import { getString } from '../../../i18n/i18n.js';

const IMAGE_REVEAL_DELAY = 13; // Some wait for inits n other weird stuff
const USER_CACHE_DIR = GLib.get_user_cache_dir();

// Create cache folder and clear pics from previous session
Utils.exec(`bash -c 'mkdir -p ${USER_CACHE_DIR}/ags/media/wallpapers'`);
Utils.exec(`bash -c 'rm ${USER_CACHE_DIR}/ags/media/wallpapers/*'`);

const CommandButton = (command) => Button({
    className: 'sidebar-chat-chip sidebar-chat-chip-action txt txt-small',
    onClicked: () => sendMessage(command),
    setup: setupCursorHover,
    label: command,
});

export const wallpaperTabIcon = Box({
    hpack: 'center',
    homogeneous: true,
    children: [
        MaterialIcon('wallpaper', 'norm'),
    ]
});

const WallpaperInfo = () => {
    const wallpaperLogo = Label({
        hpack: 'center',
        className: 'sidebar-chat-welcome-logo',
        label: 'wallpaper',
    })
    return Box({
        vertical: true,
        vexpand: true,
        className: 'spacing-v-15',
        children: [
            wallpaperLogo,
            Label({
                className: 'txt txt-title-small sidebar-chat-welcome-txt',
                wrap: true,
                justify: Gtk.Justification.CENTER,
                label: 'Wallpapers',
            }),
            Box({
                className: 'spacing-h-5',
                hpack: 'center',
                children: [
                    Label({
                        className: 'txt-smallie txt-subtext',
                        wrap: true,
                        justify: Gtk.Justification.CENTER,
                        label: getString('Powered by Wallhaven'),
                    }),
                    Button({
                        className: 'txt-subtext txt-norm icon-material',
                        label: 'info',
                        tooltipText: getString('High-quality wallpaper search.\nBrowse and set beautiful wallpapers\nfrom the Wallhaven collection.'),
                        setup: setupCursorHoverInfo,
                    }),
                ]
            }),
        ]
    });
}

const wallpaperWelcome = Box({
    vexpand: true,
    homogeneous: true,
    child: Box({
        className: 'spacing-v-15 margin-top-15 margin-bottom-15',
        vpack: 'center',
        vertical: true,
        children: [
            WallpaperInfo(),
        ]
    })
});

const wallpaperContent = Box({
    className: 'spacing-v-5',
    vertical: true,
    attribute: {
        'map': new Map(),
    },
    setup: (self) => self
        .hook(wallhaven, (box, messageId) => {
            if (messageId === undefined) return;
            console.log(`[WALLPAPER] New response initiated: ${messageId}`);
            
            const query = wallhaven.queries[messageId];
            if (query) {
                // Create tags array for display like booru
                const tags = query.realQuery.length > 0 ? query.realQuery : ['*'];
                const taglist = [...tags, `${query.page}`];
                const newPage = WallpaperPage(taglist, query.query || taglist.slice(0, -1).join(' '), 'Wallhaven');
                box.add(newPage);
                box.show_all();
                box.attribute.map.set(messageId, newPage);
            }
        }, 'newResponse')
        .hook(wallhaven, (box, messageId) => {
            if (messageId === undefined) return;
            console.log(`[WALLPAPER] Response updated: ${messageId}`);
            
            const response = wallhaven.responses[messageId];
            if (response) {
                box.attribute.map.get(messageId)?.attribute.update(response);
            }
        }, 'updateResponse')
        .hook(wallhaven, (box) => {
            console.log('[WALLPAPER] Wallhaven service cleared');
            clearChat();
        }, 'clear')
    ,
});

export const WallpaperView = (chatEntry) => Scrollable({
    className: 'sidebar-chat-viewport',
    vexpand: true,
    child: Box({
        vertical: true,
        children: [
            wallpaperWelcome,
            wallpaperContent,
        ]
    }),
    setup: (scrolledWindow) => {
        // Show scrollbar
        scrolledWindow.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC);
        const vScrollbar = scrolledWindow.get_vscrollbar();
        vScrollbar.get_style_context().add_class('sidebar-scrollbar');
        // Avoid click-to-scroll-widget-to-view behavior
        Utils.timeout(1, () => {
            const viewport = scrolledWindow.child;
            viewport.set_focus_vadjustment(new Gtk.Adjustment(undefined));
        })
        // Scroll to bottom with new content
        const adjustment = scrolledWindow.get_vadjustment();
        adjustment.connect("changed", () => {
            adjustment.set_value(adjustment.get_upper() - adjustment.get_page_size());
        })
    }
});

export const wallpaperCommands = Box({
    className: 'spacing-h-5',
    setup: (self) => {
        self.pack_end(CommandButton('/clear'), false, false, 0);
        self.pack_end(CommandButton('+'), false, false, 0);
        self.pack_start(CommandButton('anime'), false, false, 0);
        self.pack_start(CommandButton('landscape'), false, false, 0);
        self.pack_start(CommandButton('nature'), false, false, 0);
        self.pack_start(CommandButton('frieren'), false, false, 0);
        self.pack_start(CommandButton('4k'), false, false, 0);
        self.pack_start(CommandButton('minimalist'), false, false, 0);
    }
});

const clearChat = () => {
    wallpaperContent.attribute.map.forEach((value, key, map) => {
        value.destroy();
        value = null;
    });
    wallpaperContent.attribute.map.clear();
}

function getDomainName(url) {
    try {
        const match = url.match(/^(?:https?:\/\/)?(?:www\.)?([^\/]+)/i);
        if (!match) return null;
        const domainParts = match[1].split('.');
        if (domainParts.length > 2) {
            return domainParts.slice(-2).join('.');
        }
        return match[1];
    } catch (error) {
        print(`Invalid URL: ${url}`);
        return null;
    }
}

const WallpaperPage = (query, serviceName = 'Wallhaven') => {
    const PageState = (icon, name) => Box({
        className: 'spacing-h-5 txt margin-right-5',
        children: [
            Label({
                className: 'sidebar-waifu-txt txt-smallie',
                xalign: 0,
                label: name,
            }),
            MaterialIcon(icon, 'norm'),
        ]
    });

    const ImageAction = ({ name, icon, action }) => Button({
        className: 'sidebar-waifu-image-action txt-norm icon-material',
        tooltipText: name,
        label: icon,
        onClicked: action,
        setup: setupCursorHover,
    });

    const PreviewWallpaper = (data, delay = 0) => {
        const imageArea = Widget.DrawingArea({
            className: 'sidebar-booru-image-drawingarea',
        });
        const imageBox = Box({
            className: 'sidebar-booru-image',
            attribute: {
                'update': (self, data, force = false) => {
                    const imagePath = `${USER_CACHE_DIR}/ags/media/wallpapers/${data.id}.jpg`;
                    const widgetWidth = Math.floor(wallpaperContent.get_allocated_width() * 0.9 / userOptions.sidebar.image.columns);
                    const aspectRatio = data.dimension_x / data.dimension_y;
                    const widgetHeight = widgetWidth / aspectRatio;
                    imageArea.set_size_request(widgetWidth, widgetHeight);
                    
                    const showImage = () => {
                        const pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(imagePath, widgetWidth, widgetHeight, false);
                        imageArea.connect("draw", (widget, cr) => {
                            const borderRadius = widget.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);

                            // Draw a rounded rectangle
                            cr.arc(borderRadius, borderRadius, borderRadius, Math.PI, 1.5 * Math.PI);
                            cr.arc(widgetWidth - borderRadius, borderRadius, borderRadius, 1.5 * Math.PI, 2 * Math.PI);
                            cr.arc(widgetWidth - borderRadius, widgetHeight - borderRadius, borderRadius, 0, 0.5 * Math.PI);
                            cr.arc(borderRadius, widgetHeight - borderRadius, borderRadius, 0.5 * Math.PI, Math.PI);
                            cr.closePath();
                            cr.clip();

                            // Paint image as bg
                            Gdk.cairo_set_source_pixbuf(cr, pixbuf, (widgetWidth - widgetWidth) / 2, (widgetHeight - widgetHeight) / 2);
                            cr.paint();
                        });
                        self.queue_draw();
                        imageRevealer.revealChild = true;
                    }
                    
                    const downloadCommand = `curl -L -o '${imagePath}' '${data.thumbs.large}'`;
                    if (!force && fileExists(imagePath)) showImage();
                    else Utils.timeout(delay, () => Utils.execAsync(['bash', '-c', downloadCommand])
                        .then(showImage)
                        .catch(print)
                    );
                },
            },
            child: imageArea,
            setup: (self) => {
                Utils.timeout(1000, () => self.attribute.update(self, data));
            }
        });

        const imageActions = Revealer({
            transition: 'crossfade',
            transitionDuration: userOptions.animations.durationLarge,
            child: Box({
                vpack: 'start',
                className: 'sidebar-booru-image-actions spacing-h-3',
                children: [
                    Box({ hexpand: true }),
                    ImageAction({
                        name: `${getString('Go to page')} (${getDomainName(data.url)})`,
                        icon: 'file_open',
                        action: () => execAsync(['xdg-open', data.url]).catch(print),
                    }),
                    ImageAction({
                        name: `${getString('View full size')}`,
                        icon: 'open_in_new',
                        action: () => execAsync(['xdg-open', data.path]).catch(print),
                    }),
                    ImageAction({
                        name: getString('Save wallpaper'),
                        icon: 'save',
                        action: async (self) => {
                            try {
                                const downloadPath = `${GLib.get_home_dir()}/Pictures/Wallpapers`;
                                Utils.exec(`mkdir -p "${downloadPath}"`);
                                const filePath = await wallhaven.downloadWallpaper(data, downloadPath);
                                self.label = 'done';
                            } catch (error) {
                                print('Save failed:', error);
                                self.label = 'error';
                            }
                        },
                    }),
                    ImageAction({
                        name: getString('Set as wallpaper'),
                        icon: 'wallpaper',
                        action: (self) => {
                            const fileName = `wallhaven-${data.id}.${data.file_type.split('/')[1]}`;
                            const saveCommand = `mkdir -p "$(xdg-user-dir PICTURES)/Wallpapers" && curl -L -o "$(xdg-user-dir PICTURES)/Wallpapers/${fileName}" '${data.path}'`;
                            const setWallpaperCommand = `${App.configDir}/scripts/color_generation/switchwall.sh "$(xdg-user-dir PICTURES)/Wallpapers/${fileName}"`;
                            execAsync(['bash', '-c', `${saveCommand} && ${setWallpaperCommand}`])
                                .then(() => self.label = 'done')
                                .catch((error) => {
                                    print('Set wallpaper failed:', error);
                                    self.label = 'error';
                                });
                        },
                    }),
                ]
            })
        });

        const imageOverlay = Overlay({
            passThrough: true,
            child: imageBox,
            overlays: [imageActions]
        });

        const imageRevealer = Revealer({
            transition: 'slide_down',
            transitionDuration: userOptions.animations.durationLarge,
            child: EventBox({
                onHover: () => { imageActions.revealChild = true },
                onHoverLost: () => { imageActions.revealChild = false },
                child: imageOverlay,
            })
        });

        return imageRevealer;
    };

    const downloadState = Stack({
        homogeneous: false,
        transition: 'slide_up_down',
        transitionDuration: userOptions.animations.durationSmall,
        children: {
            'api': PageState('search', getString('Searching wallpapers')),
            'done': PageState('done', getString('Finished!')),
            'error': PageState('error', getString('Error')),
        },
    });

    const downloadIndicator = MarginRevealer({
        vpack: 'center',
        transition: 'slide_left',
        revealChild: true,
        child: downloadState,
    });

    const pageHeading = Box({
        vertical: true,
        children: [
            Box({
                children: [
                    Label({
                        hpack: 'start',
                        className: `sidebar-booru-provider`,
                        label: `${serviceName}`,
                        truncate: 'end',
                        maxWidthChars: 20,
                    }),
                    Box({ hexpand: true }),
                    downloadIndicator,
                ]
            }),
            Box({
                className: 'margin-5',
                children: [
                    Scrollable({
                        hexpand: true,
                        vscroll: 'never',
                        hscroll: 'automatic',
                        child: Box({
                            hpack: 'fill',
                            className: 'spacing-h-5',
                            children: [
                                Label({
                                    className: 'sidebar-chat-chip txt txt-small',
                                    label: `"${query}"`,
                                }),
                                Box({ hexpand: true }),
                            ]
                        })
                    }),
                ]
            })
        ]
    });

    const pageImages = Box({
        hpack: 'start',
        homogeneous: true,
        className: 'sidebar-booru-imagegrid',
    });

    const pageTip = Revealer({
        transition: 'slide_down',
        transitionDuration: 0,
        revealChild: false,
        child: Box({
            className: 'txt-subtext margin-5',
            children: [
                Box({
                    homogeneous: true,
                    className: 'sidebar-booru-tip-icon',
                    children: [MaterialIcon('lightbulb', 'larger')]
                }),
                Label({
                    label: getString("No wallpapers found for your search."),
                    className: 'txt-smallie',
                    wrap: true,
                    xalign: 0,
                })
            ]
        })
    });

    const pageContentRevealer = Revealer({
        transition: 'slide_down',
        transitionDuration: userOptions.animations.durationLarge,
        revealChild: false,
        child: Box({
            vertical: true,
            children: [
                pageImages,
                pageTip,
            ]
        }),
    });

    const thisPage = Box({
        homogeneous: true,
        className: 'sidebar-chat-message',
        attribute: {
            'showContent': () => {
                Utils.timeout(IMAGE_REVEAL_DELAY,
                    () => pageContentRevealer.revealChild = true
                );
            },
            'update': (data, force = false) => {
                downloadState.shown = 'done';
                
                if (!data.data || data.data.length === 0) {
                    pageTip.revealChild = true;
                    downloadState.shown = 'error';
                    thisPage.attribute.showContent();
                    return;
                }

                // Sort by aspect ratio like BooruPage
                const wallpapers = data.data.sort((a, b) => {
                    const aspectA = a.dimension_x / a.dimension_y;
                    const aspectB = b.dimension_x / b.dimension_y;
                    return aspectA - aspectB;
                });

                const imageColumns = userOptions.sidebar.image.columns || 2;
                
                // Init columns
                pageImages.children = Array.from(
                    { length: imageColumns },
                    (_, i) => Box({
                        attribute: { height: 0 },
                        vertical: true,
                    })
                );

                // Greedy add algorithm like BooruPage
                for (let i = 0; i < wallpapers.length; i++) {
                    // Find column with lowest height
                    let minHeight = Infinity;
                    let minIndex = -1;
                    for (let j = 0; j < imageColumns; j++) {
                        const height = pageImages.children[j].attribute.height;
                        if (height < minHeight) {
                            minHeight = height;
                            minIndex = j;
                        }
                    }
                    // Add wallpaper to it
                    const aspectRatio = wallpapers[i].dimension_x / wallpapers[i].dimension_y;
                    pageImages.children[minIndex].pack_start(PreviewWallpaper(wallpapers[i], minIndex), false, false, 0);
                    pageImages.children[minIndex].attribute.height += 1 / aspectRatio; // we want height/width
                }
                
                pageImages.show_all();
                thisPage.attribute.showContent();
                downloadIndicator.attribute.hide();
            },
        },
        children: [Box({
            vertical: true,
            children: [
                pageHeading,
                Box({
                    vertical: true,
                    children: [pageContentRevealer],
                })
            ]
        })],
    });
    return thisPage;
};

export function sendMessage(command) {
    // Commands
    if (command.startsWith('+')) { // Next page
        const lastQuery = wallhaven.queries.at(-1);
        if (lastQuery) {
            wallhaven.search(`${lastQuery.realQuery.join(' ')} ${lastQuery.page + 1}`, lastQuery.options);
        }
        return;
    }
    else if (command.startsWith('/')) {
        if (command.startsWith('/clear')) {
            clearChat();
            wallhaven.clear(); // Also clear the wallhaven service
            return;
        }
    }

    console.log(`[WALLPAPER] Searching for: ${command}`);
    
    // Search for wallpapers - the hooks will handle the response
    wallhaven.search(command).catch(error => {
        console.error('[WALLPAPER] Search failed:', error);
        // Error handling is already done in the service and will be reflected in the response
    });
}
