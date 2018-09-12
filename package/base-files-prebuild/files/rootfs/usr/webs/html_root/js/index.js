var VK_LEFT = 37;
var VK_UP = 38;
var VK_RIGHT = 39;
var VK_DOWN = 40;
var VK_OK = 13;

var _offsetY = 80;
var _factor = 70;

var links = new Array();
var numLinks = 0;
var lastLink;

var mainMenu = {
    _vmenu: null,
    _hmenu: null,
    _highlight: null,
    mooflows: null,
    focusIndex: 0,

    run: function () {
        this._highlight = document.createElement('highlightElem');
        this._highlight.className = 'highlight';
        this._vmenu = document.getElementById('panel-left');
        this._vmenu.appendChild(this._highlight);
        this._hmenu = document.getElementById('panel-bottom');
        this.attachEvents();
        this.show();
    },
    show: function () {
        var self = this;
        this._vmenu.addEventListener('webkitTransitionEnd', function () {
            this.removeEventListener('webkitTransitionEnd', arguments.callee, false);
            self.setItemFocus(self.focusIndex);
        }, false);
        this.setItemFocus(this.focusIndex);
        this._vmenu.className = 'vmenu';
    },
    hide: function () {
        this._vmenu.className = 'vmenu hidden';
    },
    moveUp: function () {
        var prevIndex = this.focusIndex - 1;
        if (prevIndex < 0)
            prevIndex = this._vmenu.children.length - 2;
        this.setItemFocus(prevIndex);
    },
    moveDown: function () {
        var nextIndex = this.focusIndex + 1;
        if (nextIndex >= this._vmenu.children.length - 1)
            nextIndex = 0;
        this.setItemFocus(nextIndex);
    },
    moveLeft: function () {
        this.mooflows[this.focusIndex].prev();
    },
    moveRight: function () {
        this.mooflows[this.focusIndex].next();
    },
    setItemFocus: function (index) {
        var focusedItem = this._vmenu.children[this.focusIndex];
        focusedItem.className = 'item';
        var item = this._vmenu.children[index];
        this.focusIndex = index;
        var self = this;
        this._highlight.addEventListener('webkitTransitionEnd', function () {
            this.removeEventListener('webkitTransitionEnd', arguments.callee, false);
            self.onItemFocused();
        }, false);
        this._highlight.style.top = item.offsetTop;
        this._highlight.style.height = item.offsetHeight;
    },
    onItemFocused: function () {
        var item = this._vmenu.children[this.focusIndex];
        item.className = 'item focused';
    },
    selectFocusItem: function () {
        var mediaPlayer = document.getElementById("videoPlayer");
        mediaPlayer.setAttribute('src', links[this.focusIndex]);
        mediaPlayer.load();
		setTimeout('document.getElementById("videoPlayer").play()', 300);

    },
    attachEvents: function () {
        var self = this;
        var keyDown = function (evt) {
            switch (evt.keyCode) {
                case VK_UP:
                    self.moveUp();
                    break;
                case VK_DOWN:
                    self.moveDown();
                    break;
                case VK_LEFT:
                    self.moveLeft();
                    break;
                case VK_RIGHT:
                    self.moveRight();
                    break;
                case VK_OK:
                    self.selectFocusItem();
                    break;
                default:
                    return true;
            }
            return false;
        }
        document.onkeydown = function (evt) {
            return keyDown(evt);
        };
    }
};

function addlink(video, title) {
    links[numLinks] = video;
    var linkToAdd = document.createElement('a');
    linkToAdd.setAttribute('href', '#');
    linkToAdd.className = "item";
    linkToAdd.innerHTML = title;
    var value = numLinks;
    linkToAdd.onclick = function () { click(value); };
    document.getElementById("panel-left").appendChild(linkToAdd);
    //document.getElementById("panel-left").appendChild(document.createElement('BR'));
   
    numLinks++;

}
