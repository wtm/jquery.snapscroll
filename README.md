[jquery.SnapScroll](http://wtm.github.com/jquery.snapscroll/)
=================

Scrolling for single page websites.

[Check out a demo here.](http://wtm.github.com/jquery.snapscroll/)

## Snaps to Containers

When a container approaches the scroll position it will snap to the top of the window.

## Moves with Arrow Keys

Navigation between containers is easy, use either the scroll, arrow, space, or page keys.

## For Single Page Websites

Navigation between containers is easy, use either the scroll, arrow, space, or page keys.

## Credits

A big thanks to all of our [contributors](https://github.com/wtm/jquery.snapscroll/graphs/contributors)!

![we the media](http://wtmworldwide.com/wtm.png)

SnapScroll is maintained by [We The Media, inc.](http://wtmworldwide.com/)

## Sites Using SnapScroll

Got a project that you are using SnapScroll on? Let us know and we will happily throw a link to your page here!

## Getting Started

### Dependencies

Shapeshift requires the latest version of jQuery, and the [scroll_to](http://flesler.blogspot.com/2007/10/jqueryscrollto.html) jquery plugin by Ariel Flesler which is included in the core folder.

### Setting Up

There isn't much more to SnapScroll other than to make sure the CSS is set correctly. SnapScroll is called on an element that containers many child elements, each considered one "page" within the single page website. Because of the nature of SnapScroll, all child elements must be the same height as 100% of the window height so that they take up the entire screen when snapped to.

After that, simply call snapscroll on the container and you are good to go!

```javascript
$('.container').snapscroll();
```
