# Practice comppass and jade 

### Frontend Frameworks

**Sass**

* Sass is the most mature, stable, and powerful professional grade CSS extension language in the world.
* [Homepage](http://sass-lang.com/)


**Compass**

* Compass is an open-source CSS Authoring Framework.
* [Homepage](http://compass-style.org/)


**jQuery**

* jQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler with an easy-to-use API that works across a multitude of browsers.
* [Homepage](http://jquery.com/)


## Development Setup

### Step 1: Clone code

* Clone code from gitlab, run commandline:
* $ git clone gitlab.asoft-python.com/g-hanhtran/html-css-training/tree/feature/practice-comp-jade
* [Homepage](https://gitlab.asoft-python.com/g-hanhtran/html-css-training/tree/feature/practice-comp-jade)


### Step 2: Setup and install frontend framework

**Install npm**

* To install node modules, run commandline:
* $ npm install

### Step 3: Run webpage

**To build webapp first time, run commandline:**

* $ docpad run


**Open browsers and run localhost port 8888 is default**

* Open link on browsers: http://locahost:8888

**src**
## Make docpad project with jade and sass
> Font

- 'Lato', sans-serif;

> Folder

```
├── feature/practice-comp-jade/
│   ├── docpad.coffee
│   ├── node_modules/
│   ├── out/
│   ├── package.json
│   ├── README.md
│   └── src/
│     ├── layouts/
│     │   ├── default.html.jade
│     ├── partials 
│     │   ├── header.html.jade
│     │   ├── slider.html.jade
│     │   ├── feature-product.html.jade
│     │   ├── mobile-device.html.jade
│     │   ├── new.html.jade
│     │   ├── about-us.html.jade
│     │   └── difference.html.jade
│     ├── render 
│     │   ├── index.html.jade
│     │   └──css/
│     │      ├── abstracts
│     │      │   ├── _all.scss
│     │      │   ├── _mixin.scss
│     │      │   └── _placeholder.scss
│     │      ├── base/
│     │      │   ├── _base.scss
│     │      │   └── _reset.scss
│     │      ├── components/
│     │      │   ├── _all.scss
│     │      │   └── _button.scss
│     │      ├── layouts/
│     │      │   ├── _all.scss
│     │      │   ├── _header.scss
│     │      │   ├── _navbar.scss
│     │      │   ├── _slider.scss
│     │      │   ├── _feature-product.scss
│     │      │   ├── _mobile-device.scss
│     │      │   ├── _new.scss
│     │      │   ├── _about-us.scss
│     │      │   ├── _difference.scss
│     │      │   └── _footer.scss
│     │      ├── variables/
│     │      │   ├── _all.scss
│     │      │   ├── _color.scss
│     │      │   ├── _font.scss
│     │      │   └── _metric.scss
│     │      ├── vendor
│     │	     │   ├── sass/
│     │      │   │   ├── styles.scss
│     │      │   │   └── _bootstrap-variables.scss
│     │	     │   ├── stylesheets
│     │      │   │   └── bootstrap/
│     │      │   │      └── mixins/
│     │      │   ├── config.rb
│     │      │   ├── _style.scss
│     │      │   └── _variables.scss
│     │      ├── core.css.scss 
│     │      └── main.css.scss
│     └── static/
│         ├── fonts
│         ├── icon-font
│         ├── js
│         └── images
└── README.md
```






