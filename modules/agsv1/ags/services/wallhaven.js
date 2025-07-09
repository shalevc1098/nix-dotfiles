import Service from 'resource:///com/github/Aylur/ags/service.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

class WallhavenService extends Service {
    _baseUrl = 'https://wallhaven.cc/api/v1/search';
    _responses = [];
    _queries = [];

    static {
        Service.register(this, {
            'initialized': [],
            'clear': [],
            'newResponse': ['int'],
            'updateResponse': ['int'],
        });
    }
    _defaultParams = {
        categories: '110',      // anime + general
        purity: '100',         // sfw only
        sorting: 'relevance',
        order: 'desc',
        ai_art_filter: '1',
        ratios: '16x9',
        page: '1'
    };

    constructor() {
        super();
        this.emit('initialized');
    }

    clear() {
        this._responses = [];
        this._queries = [];
        this.emit('clear');
    }

    get queries() { return this._queries }
    get responses() { return this._responses }

 
    
    search(query, options = {}) {
        // Parse query for page number, similar to booru
        const userArgs = query.split(/\s+/);
        let realQuery = [];
        let page = 1;
        
        // Extract page number from query args
        for (let i = 0; i < userArgs.length; i++) {
            const thisArg = userArgs[i].trim();
            if (thisArg.length == 0 || thisArg == '.') continue;
            else if (!isNaN(thisArg)) page = parseInt(thisArg);
            else realQuery.push(thisArg);
        }
        
        const newMessageId = this._queries.length;
        this._queries.push({
            query: realQuery.join(' '),
            realQuery: realQuery,
            page: page,
            options: options,
        });
        this.emit('newResponse', newMessageId);

        const params = { 
            q: realQuery.join(' '), 
            ...this._defaultParams, 
            page: page.toString(),
            ...options 
        };
        
        // Use curl directly since Utils.fetch has issues with this API
        const encodedQuery = encodeURIComponent(realQuery.join(' '));
        const otherParams = Object.entries(params)
            .filter(([key]) => key !== 'q')
            .map(([key, value]) => `${key}=${value}`)
            .join('&');
        
        const url = `${this._baseUrl}?q=${encodedQuery}&${otherParams}`;
        
        print(`[Wallhaven] Searching: ${url}`);
        
        return Utils.execAsync(`curl -s "${url}"`)
            .then((dataString) => {
                print(`[Wallhaven] Response data length: ${dataString.length}`);
                if (dataString.length === 0) {
                    print('[Wallhaven] Empty response received');
                    const errorData = { data: [], meta: { error: 'Empty response' } };
                    this._responses[newMessageId] = errorData;
                    this.emit('updateResponse', newMessageId);
                    return errorData;
                }
                
                const parsedData = JSON.parse(dataString);
                print(`[Wallhaven] Found ${parsedData.data?.length || 0} wallpapers`);
                
                this._responses[newMessageId] = parsedData;
                this.emit('updateResponse', newMessageId);
                return parsedData;
            })
            .catch(error => {
                print(`[Wallhaven] Search error: ${error}`);
                const errorData = { data: [], meta: { error: error.message || error.toString() } };
                this._responses[newMessageId] = errorData;
                this.emit('updateResponse', newMessageId);
                return errorData;
            });
    }

    async downloadWallpaper(wallpaper, downloadPath) {
        try {
            const fileName = `wallhaven-${wallpaper.id}.${wallpaper.file_type.split('/')[1]}`;
            const fullPath = `${downloadPath}/${fileName}`;
            
            console.log(`[Wallhaven] Downloading: ${wallpaper.path} -> ${fullPath}`);
            
            await Utils.execAsync(`curl -L "${wallpaper.path}" -o "${fullPath}"`);
            return fullPath;
        } catch (error) {
            console.error('[Wallhaven] Download error:', error);
            throw error;
        }
    }
}

// instance
const service = new WallhavenService();
// make it global for easy use with cli
globalThis['wallhaven'] = service;
export default service;